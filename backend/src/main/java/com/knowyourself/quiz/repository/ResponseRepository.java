package com.knowyourself.quiz.repository;

import com.knowyourself.quiz.entity.Response;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ResponseRepository extends JpaRepository<Response, Long> {
    List<Response> findBySessionIdOrderByQuestionOrderAsc(Long sessionId);
    
    boolean existsBySessionIdAndQuestionId(Long sessionId, Long questionId);

       long countByQuestionId(Long questionId);

       long countByQuestionIdAndOptionId(Long questionId, Long optionId);
    
    @Query("SELECT o.insightCategory AS category, COUNT(r) AS count FROM Response r " +
           "JOIN r.option o WHERE r.session.quizSet.id = :quizSetId AND r.session.isCompleted = true " +
           "GROUP BY o.insightCategory ORDER BY count DESC")
    List<Map<String, Object>> countInsightCategoriesByQuizSet(@Param("quizSetId") Long quizSetId);
    
    @Query("SELECT o.optionText AS optionText, COUNT(r) AS count FROM Response r " +
           "JOIN r.option o WHERE r.question.id = :questionId GROUP BY o.optionText ORDER BY count DESC")
    List<Map<String, Object>> countOptionsByQuestion(@Param("questionId") Long questionId);
}
