package com.knowyourself.quiz.controller;

import com.knowyourself.quiz.dto.AnalyticsDTO;
import com.knowyourself.quiz.dto.ApiResponse;
import com.knowyourself.quiz.service.AnalyticsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/analytics")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class AnalyticsController {
    
    private final AnalyticsService analyticsService;
    
    @GetMapping("/all")
    public ResponseEntity<ApiResponse<List<AnalyticsDTO>>> getAllAnalytics() {
        log.info("GET /analytics/all - Fetching analytics for all quizzes");
        List<AnalyticsDTO> analytics = analyticsService.getAllQuizAnalytics();
        return ResponseEntity.ok(ApiResponse.success("Analytics retrieved successfully", analytics));
    }
    
    @GetMapping("/quiz/{quizKey}")
    public ResponseEntity<ApiResponse<AnalyticsDTO>> getQuizAnalytics(@PathVariable String quizKey) {
        log.info("GET /analytics/quiz/{} - Fetching analytics", quizKey);
        AnalyticsDTO analytics = analyticsService.getQuizAnalyticsByKey(quizKey);
        return ResponseEntity.ok(ApiResponse.success("Analytics retrieved successfully", analytics));
    }
    
    @GetMapping("/overview")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getOverallStatistics() {
        log.info("GET /analytics/overview - Fetching overall statistics");
        Map<String, Object> stats = analyticsService.getOverallStatistics();
        return ResponseEntity.ok(ApiResponse.success("Overall statistics retrieved successfully", stats));
    }
}
