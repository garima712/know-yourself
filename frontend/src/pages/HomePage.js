import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import apiService from '../services/apiService';

const HomePage = () => {
    const [quizSets, setQuizSets] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        loadQuizSets();
    }, []);

    const loadQuizSets = async () => {
        try {
            setLoading(true);
            const response = await apiService.getAllQuizSets();
            if (response.success) {
                setQuizSets(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load quizzes. Please try again later.');
            console.error('Error loading quiz sets:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleStartQuiz = (quizKey) => {
        navigate(`/quiz/${quizKey}`);
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
                    <button className="button-primary" onClick={loadQuizSets} style={{marginTop: '20px'}}>
                        Try Again
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div>
            <div className="hero-section">
                <h1>✨ Discover Something Amazing About Yourself</h1>
                <p className="subtitle">In Just 60 Seconds</p>
                <p className="tagline">Each quiz reveals a different aspect of your personality</p>
            </div>

            <div className="container">
                <div className="quiz-grid">
                    {quizSets.map((quiz) => (
                        <div 
                            key={quiz.id} 
                            className="quiz-card"
                            onClick={() => handleStartQuiz(quiz.quizKey)}
                        >
                            <div className="quiz-card-icon">{quiz.iconEmoji}</div>
                            <h2 className="quiz-card-title">{quiz.title}</h2>
                            <p className="quiz-card-tagline">{quiz.tagline}</p>
                            <p style={{color: '#888', fontSize: '0.9rem', marginBottom: '10px'}}>
                                {quiz.hook}
                            </p>
                            <div style={{
                                background: 'linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%)',
                                padding: '12px',
                                borderRadius: '10px',
                                marginBottom: '15px',
                                fontSize: '0.95rem',
                                color: '#667eea',
                                fontWeight: '600'
                            }}>
                                {quiz.promise}
                            </div>
                            <div className="quiz-card-info">
                                <span className="quiz-duration">⏱️ {quiz.durationSeconds} seconds</span>
                                <span className="quiz-completions">
                                    👥 {quiz.totalCompletions.toLocaleString()} completed
                                </span>
                            </div>
                            <button className="start-button" style={{width: '100%', marginTop: '15px'}}>
                                Start Quiz →
                            </button>
                        </div>
                    ))}
                </div>

                <div style={{textAlign: 'center', marginTop: '60px', paddingBottom: '40px'}}>
                    <button 
                        className="button-secondary" 
                        onClick={() => navigate('/analytics')}
                        style={{padding: '12px 30px'}}
                    >
                        📊 View Analytics Dashboard
                    </button>
                </div>
            </div>
        </div>
    );
};

export default HomePage;
