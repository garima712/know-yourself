package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StartQuizRequest {
    private String quizKey;
    private String userAgent;
    private String deviceType;
    private String referrerUrl;
}
