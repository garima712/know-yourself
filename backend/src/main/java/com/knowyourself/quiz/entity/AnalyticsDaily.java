package com.knowyourself.quiz.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "analytics_daily")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsDaily {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "quiz_set_id", nullable = false)
    private QuizSet quizSet;
    
    @Column(name = "analytics_date", nullable = false)
    private LocalDate analyticsDate;
    
    @Column(name = "page_views", nullable = false)
    private Integer pageViews = 0;
    
    @Column(name = "quiz_starts", nullable = false)
    private Integer quizStarts = 0;
    
    @Column(name = "quiz_completions", nullable = false)
    private Integer quizCompletions = 0;
    
    @Column(name = "avg_completion_time_seconds", precision = 8, scale = 2)
    private BigDecimal avgCompletionTimeSeconds;
    
    @Column(name = "completion_rate", precision = 5, scale = 2)
    private BigDecimal completionRate;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
