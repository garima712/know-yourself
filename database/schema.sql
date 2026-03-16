-- Know Yourself - Complete Database Schema
-- Personality Quiz Application with Analytics

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS analytics_daily CASCADE;
DROP TABLE IF EXISTS responses CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS options CASCADE;
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS quiz_sets CASCADE;

-- ========================================
-- QUIZ SETS TABLE
-- ========================================
CREATE TABLE quiz_sets (
    id BIGSERIAL PRIMARY KEY,
    quiz_key VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    tagline VARCHAR(300) NOT NULL,
    hook VARCHAR(300) NOT NULL,
    duration_seconds INT NOT NULL,
    promise VARCHAR(300) NOT NULL,
    icon_emoji VARCHAR(10) NOT NULL,
    display_order INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    total_completions INT DEFAULT 0,
    total_starts INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_quiz_sets_active ON quiz_sets(is_active, display_order);
CREATE INDEX idx_quiz_sets_key ON quiz_sets(quiz_key);

-- ========================================
-- QUESTIONS TABLE
-- ========================================
CREATE TABLE questions (
    id BIGSERIAL PRIMARY KEY,
    quiz_set_id BIGINT NOT NULL REFERENCES quiz_sets(id) ON DELETE CASCADE,
    question_order INT NOT NULL,
    question_text TEXT NOT NULL,
    question_key VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(quiz_set_id, question_order)
);

CREATE INDEX idx_questions_quiz_set ON questions(quiz_set_id, question_order);

-- ========================================
-- OPTIONS TABLE
-- ========================================
CREATE TABLE options (
    id BIGSERIAL PRIMARY KEY,
    question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    option_order INT NOT NULL,
    option_text TEXT NOT NULL,
    option_emoji VARCHAR(10) NOT NULL,
    option_key VARCHAR(100) NOT NULL,
    personality_trait VARCHAR(100) NOT NULL,
    personality_description TEXT NOT NULL,
    personality_rarity_percent INT NOT NULL,
    empowerment_message TEXT NOT NULL,
    insight_category VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(question_id, option_order)
);

CREATE INDEX idx_options_question ON options(question_id, option_order);

-- ========================================
-- SESSIONS TABLE
-- ========================================
CREATE TABLE sessions (
    id BIGSERIAL PRIMARY KEY,
    session_uuid VARCHAR(36) UNIQUE NOT NULL,
    quiz_set_id BIGINT NOT NULL REFERENCES quiz_sets(id),
    current_question INT DEFAULT 1,
    is_completed BOOLEAN DEFAULT FALSE,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    user_agent TEXT,
    ip_address VARCHAR(45),
    device_type VARCHAR(50),
    referrer_url TEXT
);

CREATE INDEX idx_sessions_uuid ON sessions(session_uuid);
CREATE INDEX idx_sessions_quiz_completed ON sessions(quiz_set_id, is_completed);
CREATE INDEX idx_sessions_started_at ON sessions(started_at);

-- ========================================
-- RESPONSES TABLE
-- ========================================
CREATE TABLE responses (
    id BIGSERIAL PRIMARY KEY,
    session_id BIGINT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    question_id BIGINT NOT NULL REFERENCES questions(id),
    option_id BIGINT NOT NULL REFERENCES options(id),
    question_order INT NOT NULL,
    response_time_seconds DECIMAL(6,2),
    answered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_responses_session ON responses(session_id, question_order);
CREATE INDEX idx_responses_question ON responses(question_id);
CREATE INDEX idx_responses_option ON responses(option_id);

-- ========================================
-- ANALYTICS DAILY TABLE
-- ========================================
CREATE TABLE analytics_daily (
    id BIGSERIAL PRIMARY KEY,
    quiz_set_id BIGINT NOT NULL REFERENCES quiz_sets(id),
    analytics_date DATE NOT NULL,
    page_views INT DEFAULT 0,
    quiz_starts INT DEFAULT 0,
    quiz_completions INT DEFAULT 0,
    avg_completion_time_seconds DECIMAL(8,2),
    completion_rate DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(quiz_set_id, analytics_date)
);

CREATE INDEX idx_analytics_date ON analytics_daily(analytics_date);
CREATE INDEX idx_analytics_quiz_date ON analytics_daily(quiz_set_id, analytics_date);

-- ========================================
-- FUNCTIONS AND TRIGGERS
-- ========================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for quiz_sets
CREATE TRIGGER update_quiz_sets_updated_at 
    BEFORE UPDATE ON quiz_sets 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for analytics_daily
CREATE TRIGGER update_analytics_daily_updated_at 
    BEFORE UPDATE ON analytics_daily 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Function to calculate completion rate
CREATE OR REPLACE FUNCTION calculate_completion_rate(p_quiz_set_id BIGINT)
RETURNS DECIMAL(5,2) AS $$
DECLARE
    v_starts INT;
    v_completions INT;
    v_rate DECIMAL(5,2);
BEGIN
    SELECT total_starts, total_completions 
    INTO v_starts, v_completions
    FROM quiz_sets 
    WHERE id = p_quiz_set_id;
    
    IF v_starts = 0 THEN
        RETURN 0.00;
    END IF;
    
    v_rate := (v_completions::DECIMAL / v_starts::DECIMAL) * 100;
    RETURN ROUND(v_rate, 2);
END;
$$ LANGUAGE plpgsql;

-- View for quiz analytics
CREATE OR REPLACE VIEW quiz_analytics_summary AS
SELECT 
    qs.id,
    qs.quiz_key,
    qs.title,
    qs.total_starts,
    qs.total_completions,
    calculate_completion_rate(qs.id) as completion_rate,
    COUNT(DISTINCT s.id) as active_sessions,
    AVG(EXTRACT(EPOCH FROM (s.completed_at - s.started_at))) as avg_completion_seconds
FROM quiz_sets qs
LEFT JOIN sessions s ON qs.id = s.quiz_set_id
GROUP BY qs.id, qs.quiz_key, qs.title, qs.total_starts, qs.total_completions;

-- View for popular options
CREATE OR REPLACE VIEW popular_options_view AS
SELECT 
    q.quiz_set_id,
    qs.title as quiz_title,
    qu.question_text,
    o.option_text,
    o.option_emoji,
    o.insight_category,
    COUNT(r.id) as selection_count,
    ROUND((COUNT(r.id)::DECIMAL / 
           (SELECT COUNT(*) FROM responses r2 WHERE r2.question_id = r.question_id)::DECIMAL * 100), 2) as percentage
FROM responses r
JOIN options o ON r.option_id = o.id
JOIN questions qu ON r.question_id = qu.id
JOIN quiz_sets qs ON qu.quiz_set_id = qs.id
JOIN sessions s ON r.session_id = s.id
WHERE s.is_completed = TRUE
GROUP BY q.quiz_set_id, qs.title, qu.question_text, o.option_text, o.option_emoji, o.insight_category, r.question_id
ORDER BY selection_count DESC;

COMMENT ON TABLE quiz_sets IS 'Stores different personality quiz sets';
COMMENT ON TABLE questions IS 'Stores questions for each quiz set';
COMMENT ON TABLE options IS 'Stores answer options with personality insights';
COMMENT ON TABLE sessions IS 'Tracks user quiz sessions';
COMMENT ON TABLE responses IS 'Stores user responses to questions';
COMMENT ON TABLE analytics_daily IS 'Daily analytics aggregation for performance';
