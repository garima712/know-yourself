package com.knowyourself.quiz.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "options")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Option {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    
    @Column(name = "option_order", nullable = false)
    private Integer optionOrder;
    
    @Column(name = "option_text", nullable = false, columnDefinition = "TEXT")
    private String optionText;
    
    @Column(name = "option_emoji", nullable = false, length = 10)
    private String optionEmoji;
    
    @Column(name = "option_key", nullable = false, length = 100)
    private String optionKey;
    
    @Column(name = "personality_trait", nullable = false, length = 100)
    private String personalityTrait;
    
    @Column(name = "personality_description", nullable = false, columnDefinition = "TEXT")
    private String personalityDescription;
    
    @Column(name = "personality_rarity_percent", nullable = false)
    private Integer personalityRarityPercent;
    
    @Column(name = "empowerment_message", nullable = false, columnDefinition = "TEXT")
    private String empowermentMessage;
    
    @Column(name = "insight_category", nullable = false, length = 100)
    private String insightCategory;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @OneToMany(mappedBy = "option", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Response> responses;
}
