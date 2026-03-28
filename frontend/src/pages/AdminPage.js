import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import apiService from '../services/apiService';
import { useLanguage } from '../context/LanguageContext';

const AdminPage = () => {
    const { t } = useLanguage();
    const navigate = useNavigate();
    const [isAuthenticated, setIsAuthenticated] = useState(
        () => !!sessionStorage.getItem('adminKey')
    );
    const [passwordInput, setPasswordInput] = useState('');
    const [passwordError, setPasswordError] = useState('');
    const [analyticsData, setAnalyticsData] = useState([]);
    const [overallStats, setOverallStats] = useState(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    useEffect(() => {
        if (isAuthenticated) loadAnalytics();
    }, [isAuthenticated]);

    const loadAnalytics = async () => {
        try {
            setLoading(true);
            const [analyticsResponse, statsResponse] = await Promise.all([
                apiService.getAllAnalytics(),
                apiService.getOverallStatistics()
            ]);
            if (analyticsResponse.success) setAnalyticsData(analyticsResponse.data);
            if (statsResponse.success) setOverallStats(statsResponse.data);
        } catch (err) {
            setError('Failed to load analytics data.');
        } finally {
            setLoading(false);
        }
    };

    const handleLogin = async (e) => {
        e.preventDefault();
        try {
            await apiService.verifyAdminKey(passwordInput);
            sessionStorage.setItem('adminKey', passwordInput);
            setIsAuthenticated(true);
            setPasswordError('');
        } catch (err) {
            setPasswordError(t.wrongPassword);
            setPasswordInput('');
        }
    };

    const handleLogout = () => {
        sessionStorage.removeItem('adminKey');
        setIsAuthenticated(false);
        setAnalyticsData([]);
        setOverallStats(null);
    };

    const downloadCSV = () => {
        if (!analyticsData.length) return;
        const headers = ['Quiz Title', 'Quiz Key', 'Total Starts', 'Total Completions', 'Completion Rate (%)', 'Avg Time (s)'];
        const rows = analyticsData.map(q => [
            `"${q.quizTitle}"`,
            q.quizKey,
            q.totalStarts,
            q.totalCompletions,
            q.completionRate.toFixed(1),
            q.avgCompletionTimeSeconds ? Math.round(q.avgCompletionTimeSeconds) : 'N/A'
        ]);
        const csv = [headers.join(','), ...rows.map(r => r.join(','))].join('\n');
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `quiz-analytics-${new Date().toISOString().split('T')[0]}.csv`;
        a.click();
        URL.revokeObjectURL(url);
    };

    if (!isAuthenticated) {
        return (
            <div className="page-admin">
            <div className="admin-login-screen">
                <div className="admin-login-card">
                    <div className="admin-lock-icon">🔐</div>
                    <h2>{t.adminTitle}</h2>
                    <p style={{ color: '#888', marginBottom: '24px', fontSize: '0.95rem' }}>
                        This page is for administrators only.
                    </p>
                    <form onSubmit={handleLogin}>
                        <input
                            type="password"
                            className="admin-password-input"
                            placeholder={t.adminPassword}
                            value={passwordInput}
                            onChange={e => setPasswordInput(e.target.value)}
                            autoFocus
                        />
                        {passwordError && (
                            <div className="admin-error">{passwordError}</div>
                        )}
                        <button type="submit" className="start-button" style={{ width: '100%', marginTop: '16px' }}>
                            {t.adminLogin2}
                        </button>
                    </form>
                    <button
                        onClick={() => navigate('/')}
                        className="button-secondary"
                        style={{ marginTop: '16px', width: '100%', padding: '12px', borderRadius: '25px', border: 'none', cursor: 'pointer', fontSize: '1rem', background: '#f0f0f0', color: '#555' }}
                    >
                        {t.backToQuizzes}
                    </button>
                </div>
            </div>
            </div>
        );
    }

    if (loading) {
        return (
            <div className="page-admin">
                <div className="loading">
                    <div className="spinner"></div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="page-admin">
            <div className="container">
                <div className="error-message">
                    <h2>❌ {error}</h2>
                    <button className="button-primary" onClick={loadAnalytics} style={{ marginTop: '20px' }}>
                        {t.tryAgain}
                    </button>
                </div>
            </div>
            </div>
        );
    }

    return (
        <div className="page-admin">
        <div className="container" style={{ paddingTop: '30px', paddingBottom: '60px' }}>
            <div className="analytics-container">
                <div className="analytics-header" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '12px' }}>
                    <div>
                        <h1 style={{ color: '#333' }}>{t.adminTitle}</h1>
                        <p style={{ color: '#888', marginTop: '6px' }}>
                            Real-time quiz analytics — visible only to you.
                        </p>
                    </div>
                    <div style={{ display: 'flex', gap: '10px', flexWrap: 'wrap' }}>
                        <button className="start-button" onClick={downloadCSV}>
                            {t.downloadCSV}
                        </button>
                        <button
                            onClick={handleLogout}
                            style={{ background: '#ff4757', color: 'white', border: 'none', padding: '10px 20px', borderRadius: '20px', cursor: 'pointer', fontWeight: '600' }}
                        >
                            {t.adminLogout}
                        </button>
                    </div>
                </div>

                {overallStats && (
                    <div className="analytics-grid" style={{ margin: '30px 0' }}>
                        <div className="stat-card">
                            <div className="stat-value">{overallStats.totalQuizzes}</div>
                            <div className="stat-label">{t.totalQuizzes}</div>
                        </div>
                        <div className="stat-card" style={{ background: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)' }}>
                            <div className="stat-value">{overallStats.totalStarts.toLocaleString()}</div>
                            <div className="stat-label">{t.totalStarts}</div>
                        </div>
                        <div className="stat-card" style={{ background: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)' }}>
                            <div className="stat-value">{overallStats.totalCompletions.toLocaleString()}</div>
                            <div className="stat-label">{t.totalCompletions}</div>
                        </div>
                        <div className="stat-card" style={{ background: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)' }}>
                            <div className="stat-value">{overallStats.overallCompletionRate.toFixed(1)}%</div>
                            <div className="stat-label">{t.completionRate}</div>
                        </div>
                    </div>
                )}

                <h2 style={{ marginBottom: '20px', color: '#333' }}>{t.quizPerformance}</h2>
                {analyticsData.map((quiz) => (
                    <div key={quiz.quizKey} className="admin-quiz-row">
                        <h3 style={{ marginBottom: '15px', color: '#333' }}>{quiz.quizTitle}</h3>
                        <div className="admin-stats-grid">
                            <div className="admin-stat-item">
                                <div className="admin-stat-label">{t.starts}</div>
                                <div className="admin-stat-value" style={{ color: '#667eea' }}>{quiz.totalStarts.toLocaleString()}</div>
                            </div>
                            <div className="admin-stat-item">
                                <div className="admin-stat-label">{t.completions}</div>
                                <div className="admin-stat-value" style={{ color: '#4facfe' }}>{quiz.totalCompletions.toLocaleString()}</div>
                            </div>
                            <div className="admin-stat-item">
                                <div className="admin-stat-label">{t.completionRate}</div>
                                <div className="admin-stat-value" style={{ color: '#43e97b' }}>{quiz.completionRate.toFixed(1)}%</div>
                            </div>
                            <div className="admin-stat-item">
                                <div className="admin-stat-label">{t.avgTime}</div>
                                <div className="admin-stat-value" style={{ color: '#764ba2' }}>
                                    {quiz.avgCompletionTimeSeconds ? `${Math.round(quiz.avgCompletionTimeSeconds)}s` : 'N/A'}
                                </div>
                            </div>
                        </div>
                        {quiz.insightCategories && Object.keys(quiz.insightCategories).length > 0 && (
                            <div style={{ marginTop: '15px' }}>
                                <div style={{ fontSize: '0.85rem', color: '#888', marginBottom: '8px', fontWeight: '600' }}>
                                    {t.topCategories}
                                </div>
                                <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
                                    {Object.entries(quiz.insightCategories)
                                        .sort((a, b) => b[1] - a[1])
                                        .slice(0, 5)
                                        .map(([category, count]) => (
                                            <span key={category} className="insight-tag">
                                                {category.replace(/_/g, ' ')}: {count}
                                            </span>
                                        ))}
                                </div>
                            </div>
                        )}
                    </div>
                ))}

                <div style={{ textAlign: 'center', marginTop: '40px' }}>
                    <button className="button-primary" style={{ background: '#667eea', color: 'white', padding: '14px 40px', borderRadius: '25px', border: 'none', cursor: 'pointer', fontWeight: '700', fontSize: '1rem' }} onClick={() => navigate('/')}>
                        {t.backToQuizzes}
                    </button>
                </div>
            </div>
        </div>
        </div>
    );
};

export default AdminPage;
