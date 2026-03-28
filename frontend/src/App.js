import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import QuizPage from './pages/QuizPage';
import AdminPage from './pages/AdminPage';
import { LanguageProvider } from './context/LanguageContext';
import './styles/App.css';

function App() {
    return (
        <LanguageProvider>
            <Router>
                <div className="App">
                    <Routes>
                        <Route path="/" element={<HomePage />} />
                        <Route path="/quiz/:quizKey" element={<QuizPage />} />
                        <Route path="/admin" element={<AdminPage />} />
                    </Routes>
                </div>
            </Router>
        </LanguageProvider>
    );
}

export default App;
