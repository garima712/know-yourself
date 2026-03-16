package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsDTO {
    private String quizKey;
    private String quizTitle;
    private Integer totalStarts;
    private Integer totalCompletions;
    private Double completionRate;
    private Double avgCompletionTimeSeconds;
    private Map<String, Integer> popularOptions;
    private Map<String, Integer> insightCategories;
}
