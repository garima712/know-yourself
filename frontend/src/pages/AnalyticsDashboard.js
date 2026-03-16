import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import apiService from '../services/apiService';

const AnalyticsDashboard = () => {
    const [analyticsData, setAnalyticsData] = useState([]);
    const [overallStats, setOverallStats] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        loadAnalytics();
    }, []);

    const loadAnalytics = async () => {
        try {
            setLoading(true);
            const [analyticsResponse, statsResponse] = await Promise.all([
                apiService.getAllAnalytics(),
                apiService.getOverallStatistics()
            ]);

            if (analyticsResponse.success) {
                setAnalyticsData(analyticsResponse.data);
            }
            if (statsResponse.success) {
                setOverallStats(statsResponse.data);
            }
        } catch (err) {
            setError('Failed to load analytics data.');
            console.error('Error loading analytics:', err);
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
                    <h2>❌ {error}</h2>
                    <button className="button-primary" onClick={loadAnalytics} style={{marginTop: '20px'}}>
                        Try Again
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="container">
            <div className="analytics-container">
                <div className="analytics-header">
                    <h1>📊 Analytics Dashboard</h1>
                    <p style={{color: '#888', marginTop: '10px'}}>
                        Real-time insights into quiz performance and user engagement
                    </p>
                </div>

                {overallStats && (
                    <div className="analytics-grid" style={{marginBottom: '40px'}}>
                        <div className="stat-card">
                            <div className="stat-value">{overallStats.totalQuizzes}</div>
                            <div className="stat-label">Total Quizzes</div>
                        </div>
                        <div className="stat-card">
                            <div className="stat-value">{overallStats.totalStarts.toLocaleString()}</div>
                            <div className="stat-label">Total Starts</div>
                        </div>
                        <div className="stat-card">
                            <div className="stat-value">{overallStats.totalCompletions.toLocaleString()}</div>
                            <div className="stat-label">Total Completions</div>
                        </div>
                        <div className="stat-card">
                            <div className="stat-value">{overallStats.overallCompletionRate.toFixed(1)}%</div>
                            <div className="stat-label">Completion Rate</div>
                        </div>
                    </div>
                )}

                <h2 style={{marginBottom: '20px', color: '#333'}}>Quiz Performance</h2>
                {analyticsData.map((quiz) => (
                    <div 
                        key={quiz.quizKey} 
                        style={{
                            background: '#f8f9fa',
                            borderRadius: '15px',
                            padding: '30px',
                            marginBottom: '20px',
                            border: '2px solid #e9ecef'
                        }}
                    >
                        <h3 style={{marginBottom: '15px', color: '#333'}}>{quiz.quizTitle}</h3>
                        
                        <div style={{
                            display: 'grid',
                            gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))',
                            gap: '15px',
                            marginBottom: '20px'
                        }}>
                            <div>
                                <div style={{fontSize: '0.85rem', color: '#888', marginBottom: '5px'}}>
                                    Starts
                                </div>
                                <div style={{fontSize: '1.8rem', fontWeight: '700', color: '#667eea'}}>
                                    {quiz.totalStarts.toLocaleString()}
                                </div>
                            </div>
                            <div>
                                <div style={{fontSize: '0.85rem', color: '#888', marginBottom: '5px'}}>
                                    Completions
                                </div>
                                <div style={{fontSize: '1.8rem', fontWeight: '700', color: '#4facfe'}}>
                                    {quiz.totalCompletions.toLocaleString()}
                                </div>
                            </div>
                            <div>
                                <div style={{fontSize: '0.85rem', color: '#888', marginBottom: '5px'}}>
                                    Completion Rate
                                </div>
                                <div style={{fontSize: '1.8rem', fontWeight: '700', color: '#00f2fe'}}>
                                    {quiz.completionRate.toFixed(1)}%
                                </div>
                            </div>
                            <div>
                                <div style={{fontSize: '0.85rem', color: '#888', marginBottom: '5px'}}>
                                    Avg Time
                                </div>
                                <div style={{fontSize: '1.8rem', fontWeight: '700', color: '#764ba2'}}>
                                    {quiz.avgCompletionTimeSeconds ? 
                                        `${Math.round(quiz.avgCompletionTimeSeconds)}s` : 
                                        'N/A'}
                                </div>
                            </div>
                        </div>

                        {quiz.insightCategories && Object.keys(quiz.insightCategories).length > 0 && (
                            <div>
                                <h4 style={{marginBottom: '10px', color: '#666'}}>
                                    Top Insight Categories
                                </h4>
                                <div style={{
                                    display: 'flex',
                                    flexWrap: 'wrap',
                                    gap: '10px'
                                }}>
                                    {Object.entries(quiz.insightCategories)
                                        .sort((a, b) => b[1] - a[1])
                                        .slice(0, 5)
                                        .map(([category, count]) => (
                                            <div
                                                key={category}
                                                style={{
                                                    background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                                                    color: 'white',
                                                    padding: '8px 15px',
                                                    borderRadius: '20px',
                                                    fontSize: '0.85rem',
                                                    fontWeight: '600'
                                                }}
                                            >
                                                {category.replace(/_/g, ' ')}: {count}
                                            </div>
                                        ))}
                                </div>
                            </div>
                        )}
                    </div>
                ))}

                <div style={{textAlign: 'center', marginTop: '40px'}}>
                    <button className="button-primary" onClick={() => navigate('/')}>
                        ← Back to Quizzes
                    </button>
                </div>
            </div>
        </div>
    );
};

export default AnalyticsDashboard;
