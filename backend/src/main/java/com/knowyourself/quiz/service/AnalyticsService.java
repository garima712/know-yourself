package com.knowyourself.quiz.service;

import com.knowyourself.quiz.dto.AnalyticsDTO;
import com.knowyourself.quiz.entity.QuizSet;
import com.knowyourself.quiz.entity.Session;
import com.knowyourself.quiz.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AnalyticsService {
    
    private final QuizSetRepository quizSetRepository;
    private final SessionRepository sessionRepository;
    private final ResponseRepository responseRepository;
    
    public List<AnalyticsDTO> getAllQuizAnalytics() {
        return quizSetRepository.findAll().stream()
                .map(this::getQuizAnalytics)
                .collect(Collectors.toList());
    }
    
    public AnalyticsDTO getQuizAnalyticsByKey(String quizKey) {
        QuizSet quizSet = quizSetRepository.findByQuizKey(quizKey)
                .orElseThrow(() -> new RuntimeException("Quiz not found: " + quizKey));
        return getQuizAnalytics(quizSet);
    }
    
    private AnalyticsDTO getQuizAnalytics(QuizSet quizSet) {
        AnalyticsDTO analytics = new AnalyticsDTO();
        analytics.setQuizKey(quizSet.getQuizKey());
        analytics.setQuizTitle(quizSet.getTitle());
        analytics.setTotalStarts(quizSet.getTotalStarts());
        analytics.setTotalCompletions(quizSet.getTotalCompletions());
        
        // Calculate completion rate
        double completionRate = quizSet.getTotalStarts() > 0 ? 
                (double) quizSet.getTotalCompletions() / quizSet.getTotalStarts() * 100 : 0.0;
        analytics.setCompletionRate(completionRate);
        
        // Calculate average completion time
        List<Session> completedSessions = sessionRepository.findByQuizSetIdAndIsCompletedTrue(quizSet.getId());
        if (!completedSessions.isEmpty()) {
            double avgSeconds = completedSessions.stream()
                    .filter(s -> s.getCompletedAt() != null && s.getStartedAt() != null)
                    .mapToLong(s -> Duration.between(s.getStartedAt(), s.getCompletedAt()).getSeconds())
                    .average()
                    .orElse(0.0);
            analytics.setAvgCompletionTimeSeconds(avgSeconds);
        } else {
            analytics.setAvgCompletionTimeSeconds(0.0);
        }
        
        // Get popular options
        List<Map<String, Object>> optionCounts = responseRepository.countInsightCategoriesByQuizSet(quizSet.getId());
        Map<String, Integer> popularOptions = new HashMap<>();
        for (Map<String, Object> entry : optionCounts) {
            String category = (String) entry.get("category");
            Long count = (Long) entry.get("count");
            popularOptions.put(category, count.intValue());
        }
        analytics.setPopularOptions(popularOptions);
        
        // Get insight categories distribution
        analytics.setInsightCategories(popularOptions);
        
        return analytics;
    }
    
    public Map<String, Object> getOverallStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        List<QuizSet> allQuizzes = quizSetRepository.findAll();
        
        int totalQuizzes = allQuizzes.size();
        int totalStarts = allQuizzes.stream().mapToInt(QuizSet::getTotalStarts).sum();
        int totalCompletions = allQuizzes.stream().mapToInt(QuizSet::getTotalCompletions).sum();
        double overallCompletionRate = totalStarts > 0 ? (double) totalCompletions / totalStarts * 100 : 0.0;
        
        stats.put("totalQuizzes", totalQuizzes);
        stats.put("totalStarts", totalStarts);
        stats.put("totalCompletions", totalCompletions);
        stats.put("overallCompletionRate", overallCompletionRate);
        
        return stats;
    }
}
