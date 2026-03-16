package com.knowyourself.quiz.controller;

import com.knowyourself.quiz.dto.*;
import com.knowyourself.quiz.service.QuizService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/quiz")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class QuizController {
    
    private final QuizService quizService;
    
    @GetMapping("/sets")
    public ResponseEntity<ApiResponse<List<QuizSetDTO>>> getAllQuizSets() {
        log.info("GET /quiz/sets - Fetching all quiz sets");
        List<QuizSetDTO> quizSets = quizService.getAllActiveQuizSets();
        return ResponseEntity.ok(ApiResponse.success("Quiz sets retrieved successfully", quizSets));
    }
    
    @GetMapping("/sets/{quizKey}")
    public ResponseEntity<ApiResponse<QuizSetDTO>> getQuizSetByKey(@PathVariable String quizKey) {
        log.info("GET /quiz/sets/{} - Fetching quiz set", quizKey);
        QuizSetDTO quizSet = quizService.getQuizSetByKey(quizKey);
        return ResponseEntity.ok(ApiResponse.success("Quiz set retrieved successfully", quizSet));
    }
    
    @PostMapping("/start")
    public ResponseEntity<ApiResponse<SessionDTO>> startQuiz(
            @Valid @RequestBody StartQuizRequest request,
            HttpServletRequest httpRequest) {
        log.info("POST /quiz/start - Starting quiz: {}", request.getQuizKey());
        String ipAddress = getClientIpAddress(httpRequest);
        SessionDTO session = quizService.startQuiz(request, ipAddress);
        return ResponseEntity.ok(ApiResponse.success("Quiz started successfully", session));
    }
    
    @PostMapping("/answer")
    public ResponseEntity<ApiResponse<AnswerResponseDTO>> submitAnswer(
            @Valid @RequestBody SubmitAnswerRequest request) {
        log.info("POST /quiz/answer - Submitting answer for session: {}", request.getSessionUuid());
        AnswerResponseDTO response = quizService.submitAnswer(request);
        return ResponseEntity.ok(ApiResponse.success("Answer submitted successfully", response));
    }
    
    @GetMapping("/session/{sessionUuid}")
    public ResponseEntity<ApiResponse<SessionDTO>> getSessionStatus(@PathVariable String sessionUuid) {
        log.info("GET /quiz/session/{} - Fetching session status", sessionUuid);
        SessionDTO session = quizService.getSessionStatus(sessionUuid);
        return ResponseEntity.ok(ApiResponse.success("Session retrieved successfully", session));
    }
    
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedForHeader = request.getHeader("X-Forwarded-For");
        if (xForwardedForHeader != null && !xForwardedForHeader.isEmpty()) {
            return xForwardedForHeader.split(",")[0];
        }
        return request.getRemoteAddr();
    }
}
