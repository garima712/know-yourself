import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import apiService from '../services/apiService';

const QuizPage = () => {
    const { quizKey } = useParams();
    const navigate = useNavigate();
    
    const [session, setSession] = useState(null);
    const [currentQuestion, setCurrentQuestion] = useState(null);
    const [selectedOption, setSelectedOption] = useState(null);
    const [feedback, setFeedback] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [showFeedback, setShowFeedback] = useState(false);
    const [questionStartTime, setQuestionStartTime] = useState(null);
    const [isCompleted, setIsCompleted] = useState(false);

    useEffect(() => {
        startQuiz();
    }, [quizKey]);

    const startQuiz = async () => {
        try {
            setLoading(true);
            const response = await apiService.startQuiz(quizKey);
            if (response.success) {
                setSession(response.data);
                setCurrentQuestion(response.data.nextQuestion);
                setQuestionStartTime(Date.now());
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to start quiz. Please try again.');
            console.error('Error starting quiz:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleOptionSelect = (option) => {
        if (showFeedback) return; // Prevent changing answer after submission
        setSelectedOption(option);
    };

    const handleSubmitAnswer = async () => {
        if (!selectedOption || showFeedback) return;

        try {
            const responseTime = (Date.now() - questionStartTime) / 1000;
            const response = await apiService.submitAnswer(
                session.sessionUuid,
                currentQuestion.id,
                selectedOption.id,
                responseTime
            );

            if (response.success) {
                setFeedback(response.data);
                setShowFeedback(true);

                // Auto-advance after showing feedback
                setTimeout(() => {
                    if (response.data.isCompleted) {
                        setIsCompleted(true);
                    } else {
                        setCurrentQuestion(response.data.nextQuestion);
                        setSelectedOption(null);
                        setShowFeedback(false);
                        setFeedback(null);
                        setQuestionStartTime(Date.now());
                        setSession(prev => ({
                            ...prev,
                            currentQuestion: response.data.currentQuestion
                        }));
                    }
                }, 4000);
            }
        } catch (err) {
            setError('Failed to submit answer. Please try again.');
            console.error('Error submitting answer:', err);
        }
    };

    const handleGoHome = () => {
        navigate('/');
    };

    const handleTryAnotherQuiz = () => {
        navigate('/');
    };

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="container">
                <div className="error-message">
                    <h2>❌ {error}</h2>
                    <button className="button-primary" onClick={handleGoHome} style={{marginTop: '20px'}}>
                        Go Home
                    </button>
                </div>
            </div>
        );
    }

    if (isCompleted) {
        return (
            <div className="completion-screen">
                <div className="completion-icon">🎉</div>
                <h1 className="completion-title">Amazing! You Did It!</h1>
                <p className="completion-message">
                    You've completed the quiz and discovered something special about yourself.
                </p>
                <div className="action-buttons">
                    <button className="button-primary" onClick={handleTryAnotherQuiz}>
                        Try Another Quiz
                    </button>
                    <button className="button-secondary" onClick={() => navigate('/analytics')}>
                        📊 View Analytics
                    </button>
                </div>
            </div>
        );
    }

    if (!session || !currentQuestion) {
        return null;
    }

    const progress = ((session.currentQuestion - 1) / session.totalQuestions) * 100;

    return (
        <div className="quiz-container">
            <div className="quiz-header">
                <h2>{session.quizTitle}</h2>
            </div>

            <div className="progress-container">
                <div className="progress-bar-wrapper">
                    <div 
                        className="progress-bar-fill" 
                        style={{width: `${progress}%`}}
                    ></div>
                </div>
                <div className="progress-text">
                    Question {session.currentQuestion} of {session.totalQuestions}
                </div>
            </div>

            <div className="question-card">
                <div className="question-number">
                    Question {currentQuestion.questionOrder}
                </div>
                <h3 className="question-text">{currentQuestion.questionText}</h3>

                <div className="options-container">
                    {currentQuestion.options.map((option) => (
                        <div
                            key={option.id}
                            className={`option-button ${selectedOption?.id === option.id ? 'selected' : ''}`}
                            onClick={() => handleOptionSelect(option)}
                        >
                            <span className="option-emoji">{option.optionEmoji}</span>
                            <span className="option-text">{option.optionText}</span>
                        </div>
                    ))}
                </div>

                {selectedOption && !showFeedback && (
                    <button 
                        className="start-button" 
                        style={{width: '100%', marginTop: '25px'}}
                        onClick={handleSubmitAnswer}
                    >
                        Submit Answer →
                    </button>
                )}
            </div>

            {showFeedback && feedback && (
                <div className="feedback-card">
                    <div className="feedback-badge">✨</div>
                    <h3 className="feedback-title">{feedback.personalityTrait}</h3>
                    <p className="feedback-rarity">
                        Only {feedback.personalityRarityPercent}% of people have this trait!
                    </p>
                    <p className="feedback-description">{feedback.personalityDescription}</p>
                    <div className="feedback-message">
                        💫 {feedback.empowermentMessage}
                    </div>
                </div>
            )}
        </div>
    );
};

export default QuizPage;
