package com.knowyourself.quiz.repository;

import com.knowyourself.quiz.entity.QuizSet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface QuizSetRepository extends JpaRepository<QuizSet, Long> {
    Optional<QuizSet> findByQuizKey(String quizKey);
    List<QuizSet> findByIsActiveTrueOrderByDisplayOrderAsc();
    boolean existsByQuizKey(String quizKey);
}
