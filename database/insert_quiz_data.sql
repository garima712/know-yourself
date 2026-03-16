-- Know Yourself - Quiz Data Insertion
-- All 5 Quiz Sets with Questions and Options

-- ========================================
-- QUIZ SET 1: Future You Blueprint
-- ========================================
INSERT INTO quiz_sets (quiz_key, title, tagline, hook, duration_seconds, promise, icon_emoji, display_order) VALUES
('future_you_blueprint', 'Future You Blueprint', 'Discover what your daily habits reveal about your future potential', '7 questions that show who you''re becoming', 60, 'Unlock your productivity archetype', '🎯', 1);

-- Get the quiz set ID
DO $$
DECLARE
    v_quiz_id BIGINT;
    v_q1_id BIGINT;
    v_q2_id BIGINT;
    v_q3_id BIGINT;
    v_q4_id BIGINT;
    v_q5_id BIGINT;
    v_q6_id BIGINT;
    v_q7_id BIGINT;
BEGIN
    SELECT id INTO v_quiz_id FROM quiz_sets WHERE quiz_key = 'future_you_blueprint';
    
    -- Question 1
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 1, 'When you wake up, what''s your first instinct?', 'morning_instinct')
    RETURNING id INTO v_q1_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q1_id, 1, 'Check what I missed (notifications, news, messages)', '📱', 'check_missed', 'Information Seeker', 'You''re an Information Seeker! You stay connected and informed.', 28, 'Your awareness keeps you ahead of everyone else. This curiosity is your superpower!', 'communication_apps'),
    (v_q1_id, 2, 'Plan and organize my day', '📅', 'plan_day', 'Strategic Planner', 'You''re a Strategic Planner! People who organize ahead are 3x more likely to achieve their goals.', 22, 'Your planning mindset separates achievers from dreamers. You''re building your future every morning!', 'planning_apps'),
    (v_q1_id, 3, 'Take a moment for myself', '🧘', 'moment_self', 'Wellness Guardian', 'You''re a Wellness Guardian! Self-awareness is the foundation of success.', 15, 'While others rush, you center yourself. This rare wisdom will serve you for life!', 'wellness_apps'),
    (v_q1_id, 4, 'Jump straight into action', '⚡', 'straight_action', 'Action Catalyst', 'You''re an Action Catalyst! Your momentum creates opportunities others miss.', 35, 'You don''t wait for perfect—you make progress. This bias toward action is incredibly powerful!', 'productivity_apps');
    
    -- Question 2
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 2, 'What frustrates you MOST in your daily routine?', 'daily_frustration')
    RETURNING id INTO v_q2_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q2_id, 1, 'Forgetting important things', '🤔', 'forget_things', 'Detail Guardian', 'You''re a Detail Guardian! Your attention to detail is what creates excellence.', 30, 'The fact you care about remembering shows your commitment to excellence. That''s rare!', 'memory_apps'),
    (v_q2_id, 2, 'Wasting time on repetitive tasks', '⏰', 'repetitive_tasks', 'Efficiency Master', 'You''re an Efficiency Master! Optimization thinkers often become great innovators.', 25, 'You see waste where others see "normal". This vision makes you an innovator!', 'automation_apps'),
    (v_q2_id, 3, 'Deciding what to eat/cook', '🍽️', 'food_decisions', 'Decision Optimizer', 'You''re a Decision Optimizer! You value your mental energy for what matters most.', 20, 'Recognizing decision fatigue shows high emotional intelligence. You''re protecting your best thinking!', 'food_planning_apps'),
    (v_q2_id, 4, 'Missing opportunities or deals', '💡', 'miss_opportunities', 'Opportunity Hunter', 'You''re an Opportunity Hunter! You know life rewards those who stay alert.', 25, 'Your awareness of missed chances means you''re ready to catch the next one. Stay sharp!', 'discovery_apps');
    
    -- Question 3
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 3, 'How do you prefer to learn new things?', 'learning_style')
    RETURNING id INTO v_q3_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q3_id, 1, 'Short videos or visual content', '🎬', 'visual_content', 'Visual Learner', 'You''re a Visual Learner! Your brain processes images 60,000x faster than text.', 40, 'Your visual processing power is extraordinary. Use it to learn anything faster!', 'video_apps'),
    (v_q3_id, 2, 'Interactive practice and games', '🎮', 'interactive_games', 'Kinesthetic Explorer', 'You''re a Kinesthetic Explorer! Learning by doing creates the strongest neural pathways.', 18, 'You learn deeper than most because you experience it. This gives you mastery, not just knowledge!', 'gamified_apps'),
    (v_q3_id, 3, 'Reading at my own pace', '📖', 'reading_pace', 'Reflective Scholar', 'You''re a Reflective Scholar! Deep processing leads to true understanding.', 22, 'While others skim, you absorb. This depth makes you the expert everyone turns to!', 'reading_apps'),
    (v_q3_id, 4, 'Listening while doing other tasks', '🎧', 'listening_multitask', 'Multitask Master', 'You''re a Multitask Master! You maximize every moment for growth.', 20, 'Your ability to stack learning with life is brilliant efficiency. You''re always leveling up!', 'audio_apps');
    
    -- Question 4
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 4, 'What makes you feel MOST accomplished?', 'accomplishment_definition')
    RETURNING id INTO v_q4_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q4_id, 1, 'Checking off my to-do list', '✅', 'todo_list', 'Completion Champion', 'You''re a Completion Champion! Finishers are rarer and more valuable than starters.', 32, 'Every checkmark is proof of your follow-through. This discipline builds empires!', 'task_management_apps'),
    (v_q4_id, 2, 'Making progress on long-term goals', '🎯', 'longterm_progress', 'Vision Keeper', 'You''re a Vision Keeper! Only 8% of people consistently work toward long-term goals.', 18, 'While others chase quick wins, you''re building legacy. Your patience is power!', 'goal_tracking_apps'),
    (v_q4_id, 3, 'Helping others succeed', '🤝', 'helping_others', 'Impact Multiplier', 'You''re an Impact Multiplier! Leaders who lift others create exponential success.', 15, 'Your success through others shows true leadership. This generosity will return 10x!', 'social_impact_apps'),
    (v_q4_id, 4, 'Creating something unique', '🎨', 'creating_unique', 'Creative Architect', 'You''re a Creative Architect! Creators shape the future while others follow it.', 25, 'Your drive to create is what changes the world. Never stop building!', 'creative_tools_apps');
    
    -- Question 5
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 5, 'When you have 5 free minutes, you usually:', 'micro_moments')
    RETURNING id INTO v_q5_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q5_id, 1, 'Scroll social media without purpose', '📲', 'scroll_social', 'Comfort Seeker', 'You''re a Comfort Seeker! Your honesty about habits is the first step to transformation.', 45, 'Awareness is everything. Now that you see it, you can redirect this time to fuel your dreams!', 'content_curation_apps'),
    (v_q5_id, 2, 'Wish you could do something productive', '💭', 'wish_productive', 'Potential Activator', 'You''re a Potential Activator! Your desire for productivity shows untapped ambition.', 28, 'This restlessness is your inner greatness calling. Channel it and watch yourself soar!', 'micro_productivity_apps'),
    (v_q5_id, 3, 'Feel you should be more active', '🏃', 'should_active', 'Health Conscious', 'You''re Health Conscious! Your body awareness shows you value longevity.', 15, 'Listening to your body''s needs is wisdom. Small movements now create massive health later!', 'quick_fitness_apps'),
    (v_q5_id, 4, 'Try to learn something quickly', '🧠', 'learn_quickly', 'Growth Maximizer', 'You''re a Growth Maximizer! You turn dead time into development time.', 12, 'This habit compounds daily. In 5 years, you''ll be unrecognizable—in the best way!', 'micro_learning_apps');
    
    -- Question 6
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 6, 'What would make your daily life 10x easier?', 'simplification_desire')
    RETURNING id INTO v_q6_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q6_id, 1, 'Everything organized in one dashboard', '🗂️', 'one_dashboard', 'System Architect', 'You''re a System Architect! You see the power of centralized control.', 24, 'Your desire for systems shows strategic thinking. Build your dashboard and unlock hours daily!', 'hub_dashboard_apps'),
    (v_q6_id, 2, 'Smart AI that predicts my needs', '🤖', 'ai_prediction', 'Future Thinker', 'You''re a Future Thinker! You embrace technology others fear.', 22, 'Your vision of AI assistance is tomorrow''s reality. Early adopters win big!', 'ai_assistant_apps'),
    (v_q6_id, 3, 'Instant access to my most-used tools', '⚡', 'instant_access', 'Speed Optimizer', 'You''re a Speed Optimizer! Every second matters to you.', 26, 'Your impatience with friction is healthy. Speed compounds into extraordinary productivity!', 'launcher_apps'),
    (v_q6_id, 4, 'Less time managing multiple apps', '🎯', 'less_app_management', 'Simplicity Seeker', 'You''re a Simplicity Seeker! The smartest people value elegant simplicity.', 28, 'Complexity is the enemy of execution. Your clarity will help you move faster than everyone!', 'app_management_apps');
    
    -- Question 7
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 7, 'Your ideal smartphone helper would:', 'digital_companion')
    RETURNING id INTO v_q7_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q7_id, 1, 'Motivate and encourage you daily', '💪', 'daily_motivation', 'Inspiration Seeker', 'You''re an Inspiration Seeker! You know mindset is everything.', 30, 'Your recognition that motivation matters shows emotional intelligence. Protect your energy!', 'motivation_coach_apps'),
    (v_q7_id, 2, 'Predict what you need before asking', '🔮', 'predict_needs', 'Efficiency Futurist', 'You''re an Efficiency Futurist! Predictive technology is your ideal partner.', 25, 'Your vision of seamless tech is coming. Position yourself to ride this wave!', 'predictive_ai_apps'),
    (v_q7_id, 3, 'Connect you with your tribe', '👥', 'connect_tribe', 'Community Builder', 'You''re a Community Builder! You know success is better together.', 20, 'Your tribal thinking is ancient wisdom. The right connections will 10x your impact!', 'community_apps'),
    (v_q7_id, 4, 'Help you make better decisions', '🧩', 'better_decisions', 'Wisdom Seeker', 'You''re a Wisdom Seeker! Good decisions compound into an extraordinary life.', 25, 'Every choice shapes your future. Your desire for better decisions will lead you to greatness!', 'decision_helper_apps');
END $$;
