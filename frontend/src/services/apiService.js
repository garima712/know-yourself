import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Request interceptor
apiClient.interceptors.request.use(
    (config) => {
        console.log('API Request:', config.method.toUpperCase(), config.url);
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

// Response interceptor
apiClient.interceptors.response.use(
    (response) => {
        console.log('API Response:', response.status, response.config.url);
        return response;
    },
    (error) => {
        console.error('API Error:', error.response?.data || error.message);
        return Promise.reject(error);
    }
);

const apiService = {
    // Quiz APIs
    getAllQuizSets: async () => {
        const response = await apiClient.get('/quiz/sets');
        return response.data;
    },

    getQuizSetByKey: async (quizKey) => {
        const response = await apiClient.get(`/quiz/sets/${quizKey}`);
        return response.data;
    },

    startQuiz: async (quizKey) => {
        const deviceType = /Mobile|Android|iPhone/i.test(navigator.userAgent) ? 'mobile' : 'desktop';
        const response = await apiClient.post('/quiz/start', {
            quizKey,
            userAgent: navigator.userAgent,
            deviceType,
            referrerUrl: document.referrer || window.location.href
        });
        return response.data;
    },

    submitAnswer: async (sessionUuid, questionId, optionId, responseTimeSeconds) => {
        const response = await apiClient.post('/quiz/answer', {
            sessionUuid,
            questionId,
            optionId,
            responseTimeSeconds
        });
        return response.data;
    },

    getSessionStatus: async (sessionUuid) => {
        const response = await apiClient.get(`/quiz/session/${sessionUuid}`);
        return response.data;
    },

    // Analytics APIs
    getAllAnalytics: async () => {
        const response = await apiClient.get('/analytics/all');
        return response.data;
    },

    getQuizAnalytics: async (quizKey) => {
        const response = await apiClient.get(`/analytics/quiz/${quizKey}`);
        return response.data;
    },

    getOverallStatistics: async () => {
        const response = await apiClient.get('/analytics/overview');
        return response.data;
    }
};

export default apiService;
