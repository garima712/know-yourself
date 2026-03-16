package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizSetDTO {
    private Long id;
    private String quizKey;
    private String title;
    private String tagline;
    private String hook;
    private Integer durationSeconds;
    private String promise;
    private String iconEmoji;
    private Integer displayOrder;
    private Boolean isActive;
    private Integer totalCompletions;
    private Integer totalStarts;
    private Double completionRate;
}
