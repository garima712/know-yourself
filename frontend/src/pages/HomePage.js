import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import apiService from '../services/apiService';
import { useLanguage, LANGUAGE_GROUPS } from '../context/LanguageContext';

// Multiple animated images per quiz type (emoji art sequences)
const QUIZ_HOVER_IMAGES = {
    default: ['🌟', '✨', '💫', '🌈', '🎯', '🔮', '🎪', '🦋'],
    personality: ['🧠', '💭', '🌟', '🎭', '🔮', '💡', '🌀', '✨'],
    love: ['❤️', '💕', '💖', '💗', '💝', '🌹', '💞', '🫀'],
    career: ['🚀', '💼', '🏆', '⚡', '🎯', '📈', '🌟', '💪'],
    creativity: ['🎨', '🖌️', '🎭', '🌈', '✏️', '🎪', '🎠', '🌸'],
    mindset: ['🧘', '🌿', '☮️', '🌙', '⭐', '🦋', '🌺', '💫'],
    social: ['🤝', '👥', '🎉', '🌍', '💬', '🎊', '🌻', '🥳'],
    stress: ['🌊', '🧘', '🌿', '🕊️', '🌙', '💆', '🌸', '☁️'],
};

function getImagesForQuiz(quiz) {
    const key = quiz.quizKey?.toLowerCase() || '';
    for (const type of Object.keys(QUIZ_HOVER_IMAGES)) {
        if (key.includes(type)) return QUIZ_HOVER_IMAGES[type];
    }
    // fallback: use icon emoji repeated with flourishes
    return QUIZ_HOVER_IMAGES.default;
}

function QuizCard({ quiz, onStart, t }) {
    const [hovered, setHovered] = useState(false);
    const [imgIndex, setImgIndex] = useState(0);
    const intervalRef = useRef(null);
    const images = getImagesForQuiz(quiz);

    const handleMouseEnter = () => {
        setHovered(true);
        intervalRef.current = setInterval(() => {
            setImgIndex(i => (i + 1) % images.length);
        }, 600);
    };

    const handleMouseLeave = () => {
        setHovered(false);
        clearInterval(intervalRef.current);
        setImgIndex(0);
    };

    return (
        <div
            className={`quiz-card${hovered ? ' quiz-card-hovered' : ''}`}
            onClick={() => onStart(quiz.quizKey)}
            onMouseEnter={handleMouseEnter}
            onMouseLeave={handleMouseLeave}
        >
            <div className="quiz-card-image-area">
                <span className={`quiz-card-big-icon${hovered ? ' quiz-card-big-icon-anim' : ''}`}>
                    {hovered ? images[imgIndex] : quiz.iconEmoji}
                </span>
            </div>
            <h2 className="quiz-card-title">{quiz.title}</h2>
            <p className="quiz-card-tagline">{quiz.tagline}</p>
            <p style={{ color: '#888', fontSize: '0.9rem', marginBottom: '10px' }}>{quiz.hook}</p>
            <div className="quiz-promise-box">{quiz.promise}</div>
            <div className="quiz-card-info">
                <span className="quiz-duration">⏱️ {quiz.durationSeconds} {t.seconds}</span>
            </div>
            <button className="start-button" style={{ width: '100%', marginTop: '15px' }}>
                {t.startQuiz}
            </button>
        </div>
    );
}

function LangPicker() {
    const { language, setLanguage, t, translations } = useLanguage();
    const [open, setOpen] = useState(false);
    const [tab, setTab] = useState(0);
    const ref = useRef(null);

    useEffect(() => {
        const handler = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
        document.addEventListener('mousedown', handler);
        return () => document.removeEventListener('mousedown', handler);
    }, []);

    const cur = translations[language];
    return (
        <div className="lang-picker" ref={ref}>
            <button className="lang-picker-btn" onClick={() => setOpen(o => !o)} aria-label="Select language">
                🌐 <span className="lang-picker-cur">{cur?.flag} {cur?.name}</span> <span className="lang-picker-arrow">{open ? '▲' : '▼'}</span>
            </button>
            {open && (
                <div className="lang-dropdown">
                    <div className="lang-tabs">
                        {LANGUAGE_GROUPS.map((g, i) => (
                            <button key={i} className={`lang-tab${tab === i ? ' lang-tab-active' : ''}`} onClick={() => setTab(i)}>{g.label}</button>
                        ))}
                    </div>
                    <div className="lang-options-grid">
                        {LANGUAGE_GROUPS[tab].langs.map(code => {
                            const v = translations[code];
                            if (!v) return null;
                            return (
                                <button
                                    key={code}
                                    className={`lang-option${language === code ? ' lang-option-active' : ''}`}
                                    onClick={() => { setLanguage(code); setOpen(false); }}
                                    title={v.name}
                                >
                                    <span className="lang-option-flag">{v.flag}</span>
                                    <span className="lang-option-name">{v.name}</span>
                                </button>
                            );
                        })}
                    </div>
                </div>
            )}
        </div>
    );
}

const HomePage = () => {
    const [quizSets, setQuizSets] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const navigate = useNavigate();
    const { t } = useLanguage();

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
                setError('failedToLoadQuizzes');
            }
        } catch (err) {
            setError('failedToLoadQuizzes');
        } finally {
            setLoading(false);
        }
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
                    <h2>❌ {t[error] || error}</h2>
                    <button className="button-primary" onClick={loadQuizSets} style={{ marginTop: '20px' }}>
                        {t.tryAgain}
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="page-home">
            {/* Compact language picker — top right */}
            <div className="lang-picker-bar">
                <LangPicker />
            </div>

            <div className="hero-section">
                <h1>✨ {t.tagline}</h1>
                <p className="subtitle">{t.subtitle}</p>
                <p className="tagline">{t.heroTagline}</p>
            </div>

            <div className="container">
                <div className="quiz-grid">
                    {quizSets.map((quiz) => (
                        <QuizCard
                            key={quiz.id}
                            quiz={quiz}
                            onStart={(key) => navigate(`/quiz/${key}`)}
                            t={t}
                        />
                    ))}
                </div>

                <div style={{ textAlign: 'center', marginTop: '60px', paddingBottom: '40px' }}>
                    <button
                        className="admin-link-btn"
                        onClick={() => navigate('/admin')}
                    >
                        {t.adminLogin}
                    </button>
                </div>
            </div>
        </div>
    );
};

export default HomePage;
