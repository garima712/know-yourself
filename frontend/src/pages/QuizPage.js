import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import confetti from 'canvas-confetti';
import apiService from '../services/apiService';
import { useLanguage } from '../context/LanguageContext';
import { translateQuestion, translateFeedback } from '../services/translateService';

// Unique feedback themes per question index (cycles).
// badge is resolved at render time using t.feedbackBadges[i] so it follows language.
const FEEDBACK_THEMES = [
    { bg: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', icon: '🌟', shape: 'circle' },
    { bg: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', icon: '💡', shape: 'star' },
    { bg: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', icon: '🧠', shape: 'diamond' },
    { bg: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)', icon: '🌿', shape: 'hexagon' },
    { bg: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)', icon: '🎯', shape: 'burst' },
    { bg: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)', icon: '🦋', shape: 'flower' },
    { bg: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)', icon: '🔥', shape: 'lightning', darkText: true },
    { bg: 'linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%)', icon: '🌙', shape: 'moon', darkText: true },
];

// Quiz-type → CSS background class
function getQuizBgClass(quizKey) {
    const k = (quizKey || '').toLowerCase();
    if (k.includes('love') || k.includes('romance')) return 'page-quiz page-quiz-love';
    if (k.includes('career') || k.includes('work'))  return 'page-quiz page-quiz-career';
    if (k.includes('creativ') || k.includes('art'))  return 'page-quiz page-quiz-creativity';
    if (k.includes('mindset') || k.includes('zen'))  return 'page-quiz page-quiz-mindset';
    if (k.includes('social') || k.includes('friend'))return 'page-quiz page-quiz-social';
    if (k.includes('stress') || k.includes('calm'))  return 'page-quiz page-quiz-stress';
    if (k.includes('future') || k.includes('blueprint')) return 'page-quiz page-quiz-future';
    if (k.includes('persona') || k.includes('self')) return 'page-quiz page-quiz-personality';
    return 'page-quiz page-quiz-default';
}

const QuizPage = () => {
    const { quizKey } = useParams();
    const navigate = useNavigate();
    const { t, language } = useLanguage();
    
    const [session, setSession] = useState(null);
    const [currentQuestion, setCurrentQuestion] = useState(null);
    const [selectedOptions, setSelectedOptions] = useState([]); // MCQ: array
    const [feedback, setFeedback] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [showFeedback, setShowFeedback] = useState(false);
    const [questionStartTime, setQuestionStartTime] = useState(null);
    const [isCompleted, setIsCompleted] = useState(false);
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [personalityTraits, setPersonalityTraits] = useState([]); // collect all traits
    const [questionIndex, setQuestionIndex] = useState(0); // for theme cycling
    const [isTranslating, setIsTranslating] = useState(false);
    const confettiInterval = useRef(null);
    // Keep a stable ref to the current language for use inside callbacks
    const languageRef = useRef(language);
    useEffect(() => { languageRef.current = language; }, [language]);

    useEffect(() => {
        let cancelled = false;

        const doStart = async () => {
            try {
                setLoading(true);
                setError(null);
                const response = await apiService.startQuiz(quizKey);
                if (cancelled) return;
                if (response.success) {
                    setSession(response.data);
                    const q = await translateQuestion(response.data.nextQuestion, languageRef.current);
                    if (!cancelled) {
                        setCurrentQuestion(q);
                        setQuestionStartTime(Date.now());
                    }
                } else {
                    setError('failedToStartQuiz');
                }
            } catch (err) {
                if (!cancelled) setError('failedToStartQuiz');
            } finally {
                if (!cancelled) setLoading(false);
            }
        };

        doStart();
        return () => { cancelled = true; };
    }, [quizKey]);

    // Retry handler for the error screen
    const startQuiz = useCallback(() => {
        setError(null);
        setLoading(true);
        setSession(null);
        setCurrentQuestion(null);
        apiService.startQuiz(quizKey).then(async response => {
            if (response.success) {
                setSession(response.data);
                const q = await translateQuestion(response.data.nextQuestion, languageRef.current);
                setCurrentQuestion(q);
                setQuestionStartTime(Date.now());
            } else {
                setError('failedToStartQuiz');
            }
        }).catch(() => {
            setError('failedToStartQuiz');
        }).finally(() => {
            setLoading(false);
        });
    }, [quizKey]);

    // MCQ: toggle selection
    const handleOptionSelect = (option) => {
        if (showFeedback) return;
        setSelectedOptions(prev => {
            const exists = prev.find(o => o.id === option.id);
            if (exists) return prev.filter(o => o.id !== option.id);
            return [...prev, option];
        });
    };

    // Launch patakha confetti
    const launchPatakha = useCallback(() => {
        const duration = 4000;
        const end = Date.now() + duration;
        const colors = ['#ff6b6b', '#ffd93d', '#6bcb77', '#4d96ff', '#c77dff', '#ff9f43'];

        // Firework bursts
        const frame = () => {
            confetti({
                particleCount: 6,
                angle: 60,
                spread: 55,
                origin: { x: 0 },
                colors,
            });
            confetti({
                particleCount: 6,
                angle: 120,
                spread: 55,
                origin: { x: 1 },
                colors,
            });
            confetti({
                particleCount: 4,
                angle: 90,
                spread: 70,
                origin: { x: 0.5, y: 0.3 },
                colors,
                shapes: ['star'],
            });
            if (Date.now() < end) {
                confettiInterval.current = requestAnimationFrame(frame);
            }
        };
        // Initial big burst
        confetti({
            particleCount: 120,
            spread: 100,
            origin: { y: 0.5 },
            colors,
        });
        confetti({
            particleCount: 80,
            spread: 80,
            origin: { y: 0.5 },
            shapes: ['star'],
            colors,
        });
        setTimeout(frame, 200);
    }, []);

    const handleSubmitAnswer = async () => {
        if (!selectedOptions.length || showFeedback) return;

        try {
            setIsSubmitting(true);
            const responseTime = (Date.now() - questionStartTime) / 1000;
            const response = await apiService.submitAnswer(
                session.sessionUuid,
                currentQuestion.id,
                selectedOptions[0].id,
                responseTime
            );

            if (response.success) {
                setIsSubmitting(false);
                setIsTranslating(true);
                const translated = await translateFeedback(response.data, languageRef.current);
                setIsTranslating(false);
                setFeedback(translated);
                setShowFeedback(true);
                // Collect personality traits for report (use translated values)
                if (translated.personalityTrait) {
                    const themeIdx = questionIndex % FEEDBACK_THEMES.length;
                    setPersonalityTraits(prev => [
                        ...prev,
                        {
                            trait: translated.personalityTrait,
                            description: translated.personalityDescription,
                            message: translated.empowermentMessage,
                            theme: FEEDBACK_THEMES[themeIdx],
                            themeIdx,
                        }
                    ]);
                }
                return; // skip outer finally setIsSubmitting
            }
        } catch (err) {
            setError('failedToSubmitAnswer');
            setIsTranslating(false);
        } finally {
            setIsSubmitting(false);
        }
    };

    const handleProceedAfterFeedback = () => {
        if (!feedback) return;

        if (feedback.isCompleted) {
            launchPatakha();
            setIsCompleted(true);
            return;
        }

        setCurrentQuestion(feedback.nextQuestion);
        setSelectedOptions([]);
        setShowFeedback(false);
        setFeedback(null);
        setQuestionStartTime(Date.now());
        setQuestionIndex(i => i + 1);
        setSession((prev) => ({
            ...prev,
            currentQuestion: feedback.currentQuestion
        }));
    };

    const handleGoHome = () => {
        navigate('/');
    };

    const handleTryAnotherQuiz = () => {
        navigate('/');
    };

    if (loading) {
        return (
            <div className={getQuizBgClass(quizKey)}>
                <div className="loading">
                    <div className="spinner"></div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className={getQuizBgClass(quizKey)}>
                <div className="container">
                    <div className="error-message">
                        <h2>❌ {t[error] || error}</h2>
                        <button className="button-primary" onClick={startQuiz} style={{marginTop: '20px'}}>
                            {t.tryAgain}
                        </button>
                        <button className="button-secondary" onClick={handleGoHome} style={{marginTop: '12px', marginLeft: '12px'}}>
                            {t.goHome}
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    if (isCompleted) {
        return (
            <div className={getQuizBgClass(quizKey)}>
                <div className="completion-screen">
                <div className="completion-icon">🎉</div>
                <h1 className="completion-title">{t.completed}</h1>
                <p className="completion-message">{t.completedMsg}</p>

                {/* Personality Report */}
                <div className="personality-report">
                    <h2 className="report-title">{t.yourPersonality}</h2>
                    <p className="report-subtitle">{t.quizInsights}</p>
                    <div className="report-traits-grid">
                        {personalityTraits.map((item, idx) => (
                            <div
                                key={idx}
                                className="report-trait-card"
                                style={{ background: item.theme.bg, color: item.theme.darkText ? '#333' : 'white' }}
                            >
                                <div className="report-trait-icon">{item.theme.icon}</div>
                                <div className="report-badge">{(t.feedbackBadges && t.feedbackBadges[item.themeIdx]) || item.theme.icon}</div>
                                <div className="report-trait-name">{item.trait}</div>
                                <div className="report-trait-desc">{item.description}</div>
                                {item.message && (
                                    <div className="report-empower">💫 {item.message}</div>
                                )}
                            </div>
                        ))}
                    </div>
                </div>

                <div className="action-buttons" style={{ marginTop: '40px' }}>
                    <button className="button-primary" onClick={handleTryAnotherQuiz}>
                        {t.tryAnotherQuiz}
                    </button>
                    <button className="button-secondary" onClick={() => {
                        const text = personalityTraits.map(p => `${p.trait}: ${p.description}`).join('\n');
                        navigator.clipboard?.writeText(text).catch(() => {});
                        alert(t.copiedToClipboard);
                    }}>
                        {t.shareResult}
                    </button>
                </div>
            </div>
            </div>
        );
    }

    if (!session || !currentQuestion) {
        return null;
    }

    const progress = ((session.currentQuestion - 1) / session.totalQuestions) * 100;
    const currentTheme = FEEDBACK_THEMES[questionIndex % FEEDBACK_THEMES.length];
    const isMultiSelect = currentQuestion.options && currentQuestion.options.length > 3;

    return (
        <div className={getQuizBgClass(quizKey)}>
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
                    {t.question} {session.currentQuestion} {t.of} {session.totalQuestions}
                </div>
            </div>

            <div className="question-card">
                <div className="question-number">
                    {t.question} {currentQuestion.questionOrder}
                </div>
                {/* Graphic/image area for question */}
                <div className="question-graphic">
                    <span className="question-graphic-emoji" style={{ background: currentTheme.bg }}>
                        {currentTheme.icon}
                    </span>
                </div>
                <h3 className="question-text">{currentQuestion.questionText}</h3>

                {/* MCQ hint */}
                <div className="mcq-hint">
                    {isMultiSelect ? `🔲 ${t.chooseOneOrMore}` : `🔘 ${t.chooseOne}`}
                </div>

                <div className="options-container">
                    {currentQuestion.options.map((option, idx) => {
                        const isSelected = selectedOptions.find(o => o.id === option.id);
                        return (
                            <div
                                key={option.id}
                                className={`option-button ${isSelected ? 'selected' : ''}`}
                                onClick={() => handleOptionSelect(option)}
                            >
                                <span className="option-letter">{String.fromCharCode(65 + idx)}</span>
                                <span className="option-emoji">{option.optionEmoji}</span>
                                <span className="option-text">{option.optionText}</span>
                                {isSelected && <span className="option-check">✓</span>}
                            </div>
                        );
                    })}
                </div>

                {selectedOptions.length > 0 && !showFeedback && (
                    <button
                        className="start-button"
                        style={{width: '100%', marginTop: '25px'}}
                        onClick={handleSubmitAnswer}
                        disabled={isSubmitting || isTranslating}
                    >
                        {isTranslating ? t.translating : isSubmitting ? t.submitting : t.submitAnswer}
                    </button>
                )}

                {selectedOptions.length === 0 && !showFeedback && (
                    <p className="pace-note">{t.takeYourTime}</p>
                )}
            </div>

            {showFeedback && feedback && (() => {
                const themeIdx = questionIndex % FEEDBACK_THEMES.length;
                const theme = FEEDBACK_THEMES[themeIdx];
                const badge = (t.feedbackBadges && t.feedbackBadges[themeIdx]) || theme.icon;
                return (
                    <div
                        className="feedback-card"
                        style={{ background: theme.bg, color: theme.darkText ? '#333' : 'white' }}
                    >
                        <div className="feedback-theme-badge">{badge}</div>
                        <div className="feedback-icon-big">{theme.icon}</div>
                        <h3 className="feedback-title" style={{ color: theme.darkText ? '#222' : 'white' }}>
                            {feedback.personalityTrait}
                        </h3>
                        <p className="feedback-description" style={{ color: theme.darkText ? '#444' : 'rgba(255,255,255,0.95)' }}>
                            {feedback.personalityDescription}
                        </p>
                        <div className="feedback-message" style={{
                            background: theme.darkText ? 'rgba(0,0,0,0.08)' : 'rgba(255,255,255,0.2)',
                            color: theme.darkText ? '#333' : 'white'
                        }}>
                            💫 {feedback.empowermentMessage}
                        </div>
                        <button className="feedback-next-button" style={{ color: theme.darkText ? '#333' : '#5a3e9f' }} onClick={handleProceedAfterFeedback}>
                            {feedback.isCompleted ? t.finishQuiz : t.nextQuestion}
                        </button>
                    </div>
                );
            })()}
        </div>
        </div>
    );
};

export default QuizPage;
