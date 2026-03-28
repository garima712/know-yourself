package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnswerResponseDTO {
    private String sessionUuid;
    private Integer currentQuestion;
    private Integer totalQuestions;
    private Boolean isCompleted;
    private String personalityTrait;
    private String personalityDescription;
    private Integer personalityRarityPercent;
    private Integer responseSampleSize;
    private String empowermentMessage;
    private String insightCategory;
    private QuestionDTO nextQuestion;
}
