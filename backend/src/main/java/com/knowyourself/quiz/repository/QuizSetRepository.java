package com.knowyourself.quiz.repository;

import com.knowyourself.quiz.entity.QuizSet;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface QuizSetRepository extends JpaRepository<QuizSet, Long> {
    Optional<QuizSet> findByQuizKey(String quizKey);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT q FROM QuizSet q WHERE q.quizKey = :quizKey")
    Optional<QuizSet> findByQuizKeyForUpdate(String quizKey);

    List<QuizSet> findByIsActiveTrueOrderByDisplayOrderAsc();
    boolean existsByQuizKey(String quizKey);
}
