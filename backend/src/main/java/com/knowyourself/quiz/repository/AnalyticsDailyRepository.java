package com.knowyourself.quiz.repository;

import com.knowyourself.quiz.entity.AnalyticsDaily;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AnalyticsDailyRepository extends JpaRepository<AnalyticsDaily, Long> {
    Optional<AnalyticsDaily> findByQuizSetIdAndAnalyticsDate(Long quizSetId, LocalDate analyticsDate);
    
    List<AnalyticsDaily> findByQuizSetIdOrderByAnalyticsDateDesc(Long quizSetId);
    
    List<AnalyticsDaily> findByAnalyticsDateBetweenOrderByAnalyticsDateDesc(LocalDate startDate, LocalDate endDate);
}
