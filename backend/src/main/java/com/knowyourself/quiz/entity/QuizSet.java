package com.knowyourself.quiz.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "quiz_sets")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizSet {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "quiz_key", unique = true, nullable = false, length = 50)
    private String quizKey;
    
    @Column(nullable = false, length = 200)
    private String title;
    
    @Column(nullable = false, length = 300)
    private String tagline;
    
    @Column(nullable = false, length = 300)
    private String hook;
    
    @Column(name = "duration_seconds", nullable = false)
    private Integer durationSeconds;
    
    @Column(nullable = false, length = 300)
    private String promise;
    
    @Column(name = "icon_emoji", nullable = false, length = 10)
    private String iconEmoji;
    
    @Column(name = "display_order", nullable = false)
    private Integer displayOrder;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
    
    @Column(name = "total_completions", nullable = false)
    private Integer totalCompletions = 0;
    
    @Column(name = "total_starts", nullable = false)
    private Integer totalStarts = 0;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "quizSet", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Question> questions;
    
    @OneToMany(mappedBy = "quizSet", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Session> sessions;
}
