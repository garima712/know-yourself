package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SessionDTO {
    private String sessionUuid;
    private String quizKey;
    private String quizTitle;
    private Integer currentQuestion;
    private Integer totalQuestions;
    private Boolean isCompleted;
    private QuestionDTO nextQuestion;
}
