package com.knowyourself.quiz.service;

import com.knowyourself.quiz.dto.*;
import com.knowyourself.quiz.entity.*;
import com.knowyourself.quiz.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class QuizService {
    
    private final QuizSetRepository quizSetRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;
    private final SessionRepository sessionRepository;
    private final ResponseRepository responseRepository;
    
    public List<QuizSetDTO> getAllActiveQuizSets() {
        return quizSetRepository.findByIsActiveTrueOrderByDisplayOrderAsc()
                .stream()
                .map(this::convertToQuizSetDTO)
                .collect(Collectors.toList());
    }
    
    public QuizSetDTO getQuizSetByKey(String quizKey) {
        QuizSet quizSet = quizSetRepository.findByQuizKey(quizKey)
                .orElseThrow(() -> new RuntimeException("Quiz not found: " + quizKey));
        return convertToQuizSetDTO(quizSet);
    }
    
    @Transactional
    public SessionDTO startQuiz(StartQuizRequest request, String ipAddress) {
        QuizSet quizSet = quizSetRepository.findByQuizKeyForUpdate(request.getQuizKey())
                .orElseThrow(() -> new RuntimeException("Quiz not found: " + request.getQuizKey()));
        
        // Create new session
        Session session = new Session();
        session.setSessionUuid(UUID.randomUUID().toString());
        session.setQuizSet(quizSet);
        session.setCurrentQuestion(1);
        session.setIsCompleted(false);
        session.setUserAgent(request.getUserAgent());
        session.setIpAddress(ipAddress);
        session.setDeviceType(request.getDeviceType());
        session.setReferrerUrl(request.getReferrerUrl());
        
        session = sessionRepository.save(session);
        
        // Update quiz set starts count
        quizSet.setTotalStarts(quizSet.getTotalStarts() + 1);
        quizSetRepository.save(quizSet);
        
        // Get first question
        Question firstQuestion = questionRepository.findByQuizSetIdAndQuestionOrder(quizSet.getId(), 1)
                .orElseThrow(() -> new RuntimeException("First question not found"));
        
        SessionDTO sessionDTO = new SessionDTO();
        sessionDTO.setSessionUuid(session.getSessionUuid());
        sessionDTO.setQuizKey(quizSet.getQuizKey());
        sessionDTO.setQuizTitle(quizSet.getTitle());
        sessionDTO.setCurrentQuestion(1);
        sessionDTO.setTotalQuestions(questionRepository.countByQuizSetId(quizSet.getId()).intValue());
        sessionDTO.setIsCompleted(false);
        sessionDTO.setNextQuestion(convertToQuestionDTO(firstQuestion));
        
        log.info("Started quiz session: {} for quiz: {}", session.getSessionUuid(), quizSet.getQuizKey());
        return sessionDTO;
    }
    
    @Transactional
    public AnswerResponseDTO submitAnswer(SubmitAnswerRequest request) {
        Session session = sessionRepository.findBySessionUuid(request.getSessionUuid())
                .orElseThrow(() -> new RuntimeException("Session not found"));
        
        if (session.getIsCompleted()) {
            throw new RuntimeException("Session already completed");
        }
        
        Question question = questionRepository.findById(request.getQuestionId())
                .orElseThrow(() -> new RuntimeException("Question not found"));
        
        Option selectedOption = optionRepository.findById(request.getOptionId())
                .orElseThrow(() -> new RuntimeException("Option not found"));
        
        // Check if already answered
        if (responseRepository.existsBySessionIdAndQuestionId(session.getId(), question.getId())) {
            throw new RuntimeException("Question already answered");
        }
        
        // Save response
        Response response = new Response();
        response.setSession(session);
        response.setQuestion(question);
        response.setOption(selectedOption);
        response.setQuestionOrder(question.getQuestionOrder());
        response.setResponseTimeSeconds(request.getResponseTimeSeconds() != null ? 
                BigDecimal.valueOf(request.getResponseTimeSeconds()) : null);
        responseRepository.save(response);

        long totalResponsesForQuestion = responseRepository.countByQuestionId(question.getId());
        long selectedOptionResponses = responseRepository.countByQuestionIdAndOptionId(
            question.getId(), selectedOption.getId());
        int selectedOptionPercent = totalResponsesForQuestion > 0
            ? (int) Math.round((selectedOptionResponses * 100.0) / totalResponsesForQuestion)
            : selectedOption.getPersonalityRarityPercent();
        
        // Calculate next question
        int nextQuestionOrder = question.getQuestionOrder() + 1;
        Long totalQuestions = questionRepository.countByQuizSetId(session.getQuizSet().getId());
        boolean isCompleted = nextQuestionOrder > totalQuestions;
        
        // Update session
        session.setCurrentQuestion(nextQuestionOrder);
        if (isCompleted) {
            session.setIsCompleted(true);
            session.setCompletedAt(LocalDateTime.now());
            
            // Update quiz set completions count
            QuizSet quizSet = session.getQuizSet();
            quizSet.setTotalCompletions(quizSet.getTotalCompletions() + 1);
            quizSetRepository.save(quizSet);
        }
        sessionRepository.save(session);
        
        // Build response
        AnswerResponseDTO answerResponse = new AnswerResponseDTO();
        answerResponse.setSessionUuid(session.getSessionUuid());
        answerResponse.setCurrentQuestion(session.getCurrentQuestion());
        answerResponse.setTotalQuestions(totalQuestions.intValue());
        answerResponse.setIsCompleted(isCompleted);
        answerResponse.setPersonalityTrait(selectedOption.getPersonalityTrait());
        answerResponse.setPersonalityDescription(selectedOption.getPersonalityDescription());
        answerResponse.setPersonalityRarityPercent(selectedOptionPercent);
        answerResponse.setResponseSampleSize((int) totalResponsesForQuestion);
        answerResponse.setEmpowermentMessage(selectedOption.getEmpowermentMessage());
        answerResponse.setInsightCategory(selectedOption.getInsightCategory());
        
        if (!isCompleted) {
            Question nextQuestion = questionRepository.findByQuizSetIdAndQuestionOrder(
                    session.getQuizSet().getId(), nextQuestionOrder)
                    .orElseThrow(() -> new RuntimeException("Next question not found"));
            answerResponse.setNextQuestion(convertToQuestionDTO(nextQuestion));
        }
        
        log.info("Answer submitted for session: {}, question: {}", session.getSessionUuid(), question.getId());
        return answerResponse;
    }
    
    public SessionDTO getSessionStatus(String sessionUuid) {
        Session session = sessionRepository.findBySessionUuid(sessionUuid)
                .orElseThrow(() -> new RuntimeException("Session not found"));
        
        SessionDTO sessionDTO = new SessionDTO();
        sessionDTO.setSessionUuid(session.getSessionUuid());
        sessionDTO.setQuizKey(session.getQuizSet().getQuizKey());
        sessionDTO.setQuizTitle(session.getQuizSet().getTitle());
        sessionDTO.setCurrentQuestion(session.getCurrentQuestion());
        sessionDTO.setTotalQuestions(questionRepository.countByQuizSetId(session.getQuizSet().getId()).intValue());
        sessionDTO.setIsCompleted(session.getIsCompleted());
        
        if (!session.getIsCompleted()) {
            Question currentQuestion = questionRepository.findByQuizSetIdAndQuestionOrder(
                    session.getQuizSet().getId(), session.getCurrentQuestion())
                    .orElse(null);
            if (currentQuestion != null) {
                sessionDTO.setNextQuestion(convertToQuestionDTO(currentQuestion));
            }
        }
        
        return sessionDTO;
    }
    
    private QuizSetDTO convertToQuizSetDTO(QuizSet quizSet) {
        QuizSetDTO dto = new QuizSetDTO();
        dto.setId(quizSet.getId());
        dto.setQuizKey(quizSet.getQuizKey());
        dto.setTitle(quizSet.getTitle());
        dto.setTagline(quizSet.getTagline());
        dto.setHook(quizSet.getHook());
        dto.setDurationSeconds(quizSet.getDurationSeconds());
        dto.setPromise(quizSet.getPromise());
        dto.setIconEmoji(quizSet.getIconEmoji());
        dto.setDisplayOrder(quizSet.getDisplayOrder());
        dto.setIsActive(quizSet.getIsActive());
        dto.setTotalCompletions(quizSet.getTotalCompletions());
        dto.setTotalStarts(quizSet.getTotalStarts());
        
        if (quizSet.getTotalStarts() > 0) {
            dto.setCompletionRate((double) quizSet.getTotalCompletions() / quizSet.getTotalStarts() * 100);
        } else {
            dto.setCompletionRate(0.0);
        }
        
        return dto;
    }
    
    private QuestionDTO convertToQuestionDTO(Question question) {
        QuestionDTO dto = new QuestionDTO();
        dto.setId(question.getId());
        dto.setQuestionOrder(question.getQuestionOrder());
        dto.setQuestionText(question.getQuestionText());
        dto.setQuestionKey(question.getQuestionKey());
        
        List<Option> options = optionRepository.findByQuestionIdOrderByOptionOrderAsc(question.getId());
        dto.setOptions(options.stream().map(this::convertToOptionDTO).collect(Collectors.toList()));
        
        return dto;
    }
    
    private OptionDTO convertToOptionDTO(Option option) {
        OptionDTO dto = new OptionDTO();
        dto.setId(option.getId());
        dto.setOptionOrder(option.getOptionOrder());
        dto.setOptionText(option.getOptionText());
        dto.setOptionEmoji(option.getOptionEmoji());
        dto.setOptionKey(option.getOptionKey());
        dto.setPersonalityTrait(option.getPersonalityTrait());
        dto.setPersonalityDescription(option.getPersonalityDescription());
        dto.setPersonalityRarityPercent(option.getPersonalityRarityPercent());
        dto.setEmpowermentMessage(option.getEmpowermentMessage());
        dto.setInsightCategory(option.getInsightCategory());
        return dto;
    }
}
