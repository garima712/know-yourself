import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import QuizPage from './pages/QuizPage';
import AnalyticsDashboard from './pages/AnalyticsDashboard';
import './styles/App.css';

function App() {
    return (
        <Router>
            <div className="App">
                <Routes>
                    <Route path="/" element={<HomePage />} />
                    <Route path="/quiz/:quizKey" element={<QuizPage />} />
                    <Route path="/analytics" element={<AnalyticsDashboard />} />
                </Routes>
            </div>
        </Router>
    );
}

export default App;
