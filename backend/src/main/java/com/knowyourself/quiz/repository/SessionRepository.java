package com.knowyourself.quiz.repository;

import com.knowyourself.quiz.entity.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface SessionRepository extends JpaRepository<Session, Long> {
    Optional<Session> findBySessionUuid(String sessionUuid);
    
    List<Session> findByQuizSetIdAndIsCompletedTrue(Long quizSetId);
    
    @Query("SELECT COUNT(s) FROM Session s WHERE s.quizSet.id = :quizSetId AND s.startedAt >= :startDate")
    Long countStartedSessionsSince(@Param("quizSetId") Long quizSetId, @Param("startDate") LocalDateTime startDate);
    
    @Query("SELECT COUNT(s) FROM Session s WHERE s.quizSet.id = :quizSetId AND s.isCompleted = true AND s.completedAt >= :completedDate")
    Long countCompletedSessionsSince(@Param("quizSetId") Long quizSetId, @Param("completedDate") LocalDateTime completedDate);
}
