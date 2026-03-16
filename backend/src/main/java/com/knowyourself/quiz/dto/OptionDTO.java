package com.knowyourself.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OptionDTO {
    private Long id;
    private Integer optionOrder;
    private String optionText;
    private String optionEmoji;
    private String optionKey;
    private String personalityTrait;
    private String personalityDescription;
    private Integer personalityRarityPercent;
    private String empowermentMessage;
    private String insightCategory;
}
