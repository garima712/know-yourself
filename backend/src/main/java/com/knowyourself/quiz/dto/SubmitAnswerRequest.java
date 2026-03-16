package com.knowyourself.quiz.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SubmitAnswerRequest {
    @NotNull(message = "Session UUID is required")
    private String sessionUuid;
    
    @NotNull(message = "Question ID is required")
    private Long questionId;
    
    @NotNull(message = "Option ID is required")
    private Long optionId;
    
    private Double responseTimeSeconds;
}
