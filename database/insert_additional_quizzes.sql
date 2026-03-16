-- Know Yourself - Additional Quiz Sets (2-5)

-- ========================================
-- QUIZ SET 2: Hidden Genius Quiz
-- ========================================
INSERT INTO quiz_sets (quiz_key, title, tagline, hook, duration_seconds, promise, icon_emoji, display_order) VALUES
('hidden_genius', 'Hidden Genius Quiz', 'Find out what makes you exceptionally rare', 'What your choices say about your secret superpowers', 45, 'Discover your unique psychological edge', '💎', 2);

DO $$
DECLARE
    v_quiz_id BIGINT;
    v_q_id BIGINT;
BEGIN
    SELECT id INTO v_quiz_id FROM quiz_sets WHERE quiz_key = 'hidden_genius';
    
    -- Q1
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 1, 'If you could have ONE superpower in your phone, what would it be?', 'phone_superpower') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Know the future (predict traffic, weather, best time to do things)', '🔮', 'know_future', 'Future Thinker', 'You''re a Future Thinker! Only 15% of people think ahead like you.', 15, 'This makes you exceptional at avoiding problems before they happen!', 'predictive_apps'),
    (v_q_id, 2, 'Read minds (know what others really think/need instantly)', '💡', 'read_minds', 'Empathy Master', 'You''re an Empathy Master! Your desire to understand others deeply is profound.', 18, 'This social intelligence will open doors others can''t see!', 'social_intelligence_apps'),
    (v_q_id, 3, 'Control time (save time, never be late, do more in less time)', '⏰', 'control_time', 'Time Bender', 'You''re a Time Bender! Value of time is what separates success from struggle.', 35, 'Your time awareness is your greatest asset. Protect it fiercely!', 'time_management_apps'),
    (v_q_id, 4, 'Perfect decisions (always choose the best option effortlessly)', '🎯', 'perfect_decisions', 'Decision Master', 'You''re a Decision Master! Life quality is the sum of your decisions.', 32, 'Your recognition of this truth puts you ahead of 90% of people!', 'decision_apps');
    
    -- Q2
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 2, 'What''s the ONE thing you secretly wish was easier?', 'secret_wish') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Remembering everything without effort', '😴', 'remember_all', 'Memory Seeker', 'You''re a Memory Seeker! Your brain craves perfect recall.', 28, 'This desire shows you value information deeply. Build your second brain!', 'memory_enhancement_apps'),
    (v_q_id, 2, 'Healthy living without planning', '🍳', 'healthy_living', 'Wellness Guardian', 'You''re a Wellness Guardian! People who prioritize balance live 40% happier lives.', 22, 'Your self-awareness is rare and powerful!', 'health_wellness_apps'),
    (v_q_id, 3, 'Saving money without feeling restricted', '💰', 'save_money', 'Wealth Builder', 'You''re a Wealth Builder! Financial freedom starts with this exact mindset.', 25, 'Your desire for effortless saving shows financial intelligence!', 'finance_apps'),
    (v_q_id, 4, 'Staying calm when life gets chaotic', '😌', 'stay_calm', 'Peace Keeper', 'You''re a Peace Keeper! Inner peace is the ultimate competitive advantage.', 25, 'Your pursuit of calm in chaos shows extraordinary wisdom!', 'mental_wellness_apps');
    
    -- Q3
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 3, 'When you can''t sleep, what keeps you up?', 'three_am_question') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Replaying conversations and moments', '💭', 'replay_conversations', 'Reflective Analyst', 'You''re a Reflective Analyst! Your deep processing creates deep wisdom.', 30, 'This introspection is your superpower, not your weakness!', 'social_reflection_apps'),
    (v_q_id, 2, 'Tomorrow''s tasks spinning in my head', '📋', 'tomorrow_tasks', 'Mental Organizer', 'You''re a Mental Organizer! Your brain refuses to let important things slip.', 35, 'This responsibility shows you''re dependable—the rarest quality!', 'task_planning_apps'),
    (v_q_id, 3, 'Life decisions I need to make', '🎲', 'life_decisions', 'Future Architect', 'You''re a Future Architect! Big thinkers lose sleep over big choices.', 20, 'Your careful consideration prevents regret. This patience is powerful!', 'decision_making_apps'),
    (v_q_id, 4, 'Dreams and ideas I want to pursue', '✨', 'dreams_ideas', 'Visionary Creator', 'You''re a Visionary Creator! History''s greatest innovations came from people who thought like you at 3 AM!', 15, 'Your mind works when others sleep. Capture these midnight gems!', 'idea_capture_apps');
    
    -- Q4
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 4, 'What drains your energy MOST each day?', 'energy_thief') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Doing the same boring tasks repeatedly', '🔄', 'boring_tasks', 'Efficiency Genius', 'You''re an Efficiency Genius! You see solutions others miss!', 27, 'People who spot energy drains are natural problem-solvers!', 'automation_efficiency_apps'),
    (v_q_id, 2, 'Too many choices and decisions', '🤯', 'too_many_choices', 'Clarity Seeker', 'You''re a Clarity Seeker! Decision fatigue is real and you feel it.', 32, 'Simplifying choices will multiply your effectiveness 10x!', 'decision_simplification_apps'),
    (v_q_id, 3, 'Managing expectations of others', '👥', 'managing_expectations', 'Boundary Protector', 'You''re a Boundary Protector! Your awareness of others'' demands shows maturity.', 18, 'Learning to protect your energy is the key to sustainable success!', 'boundary_management_apps'),
    (v_q_id, 4, 'Digital chaos (too many apps, notifications, tabs)', '📱', 'digital_chaos', 'Focus Guardian', 'You''re a Focus Guardian! Deep work requires defending your attention.', 23, 'Your frustration with noise shows you value what matters. Stay fierce!', 'focus_management_apps');
    
    -- Q5
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 5, 'Imagine your perfect morning. It starts with:', 'perfect_morning') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Everything ready - no rushing, no stress', '☕', 'everything_ready', 'Peace Architect', 'You''re a Peace Architect! Preparation is the antidote to anxiety.', 28, 'Your desire for smooth mornings shows you understand momentum!', 'morning_routine_apps'),
    (v_q_id, 2, 'Clear priorities - knowing exactly what matters today', '🎯', 'clear_priorities', 'Momentum Master', 'You''re a Momentum Master! People who start strong are 300% more productive.', 22, 'Your morning mindset is your secret weapon!', 'priority_planning_apps'),
    (v_q_id, 3, 'Meaningful connection - quality time with loved ones', '💬', 'meaningful_connection', 'Relationship Investor', 'You''re a Relationship Investor! Relationships are the true wealth.', 18, 'Your priority on connection shows deep wisdom about life!', 'relationship_apps'),
    (v_q_id, 4, 'Quick win - accomplishing something before 9 AM', '🏆', 'quick_win', 'Early Achiever', 'You''re an Early Achiever! Morning victories set the tone for greatness.', 32, 'This habit alone puts you in the top 5% of achievers!', 'morning_productivity_apps');
    
    -- Q6
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 6, 'If your phone could do ONE thing it can''t do now, what would it be?', 'phone_wish') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Understand what I need before I search for it', '🧠', 'understand_needs', 'Intuitive Navigator', 'You''re an Intuitive Navigator! You think in possibilities, not limitations.', 20, 'This visionary trait puts you ahead of 90% of people!', 'predictive_tech_apps'),
    (v_q_id, 2, 'Do tasks automatically without me lifting a finger', '⚡', 'auto_tasks', 'Automation Visionary', 'You''re an Automation Visionary! You see the future of effortless productivity.', 28, 'Your vision of automation is tomorrow''s reality!', 'automation_apps'),
    (v_q_id, 3, 'Inspire me daily with personalized motivation', '🎨', 'daily_inspiration', 'Inspiration Collector', 'You''re an Inspiration Collector! You fuel yourself with positivity.', 27, 'Your commitment to daily inspiration shows growth mindset!', 'motivation_apps'),
    (v_q_id, 4, 'Guide me through decisions like a wise best friend', '🧭', 'decision_guide', 'Wisdom Seeker', 'You''re a Wisdom Seeker! Seeking guidance is strength, not weakness.', 25, 'The wisest people surround themselves with wise counsel!', 'advisory_apps');
    
    -- Q7
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 7, 'People don''t know this about you, but you''re REALLY good at:', 'hidden_talent') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Finding solutions others overlook', '🎯', 'finding_solutions', 'Solution Architect', 'You''re a Solution Architect! Problem-solving is your native language.', 22, 'The world needs more people like you seeing what others miss!', 'problem_solving_apps'),
    (v_q_id, 2, 'Understanding people and what they need', '🤝', 'understanding_people', 'Empathy Expert', 'You''re an Empathy Expert! This social intelligence is priceless.', 18, 'Your ability to read people is a rare and valuable gift!', 'social_apps'),
    (v_q_id, 3, 'Noticing patterns and connections', '📊', 'noticing_patterns', 'Pattern Master', 'You''re a Pattern Master! Seeing connections creates breakthrough insights.', 15, 'This analytical gift will unlock opportunities others can''t see!', 'analytics_apps'),
    (v_q_id, 4, 'Staying determined even when it''s hard', '💪', 'staying_determined', 'Silent Achiever', 'You''re a Silent Achiever! Your humility combined with talent is rare.', 25, 'The world needs more people like you leading quietly!', 'goal_persistence_apps');
END $$;


-- ========================================
-- QUIZ SET 3: Life Soundtrack Personality
-- ========================================
INSERT INTO quiz_sets (quiz_key, title, tagline, hook, duration_seconds, promise, icon_emoji, display_order) VALUES
('life_soundtrack', 'Life Soundtrack Personality', 'Which movie character are you living as right now?', 'Your vibe reveals your hidden potential', 50, 'Learn why you think differently than 92% of people', '🎬', 3);

DO $$
DECLARE
    v_quiz_id BIGINT;
    v_q_id BIGINT;
BEGIN
    SELECT id INTO v_quiz_id FROM quiz_sets WHERE quiz_key = 'life_soundtrack';
    
    -- Q1: The Movie Montage
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 1, 'If your life was a movie scene right now, which soundtrack plays?', 'movie_soundtrack') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, '"Eye of the Tiger" - I''m fighting to level up', '🎵', 'eye_tiger', 'Rising Phoenix', 'You''re a Rising Phoenix! People in your chapter become the strongest.', 28, 'Your struggle today is your superpower tomorrow!', 'motivation_growth_apps'),
    (v_q_id, 2, '"Here Comes the Sun" - Things are finally getting better', '🌅', 'here_sun', 'Hope Keeper', 'You''re a Hope Keeper! Your optimism after hardship is beautiful.', 22, 'The best chapters come after the storm. You''ve earned this!', 'positivity_apps'),
    (v_q_id, 3, '"Don''t Stop Me Now" - I''m on fire and unstoppable', '⚡', 'unstoppable', 'Momentum Force', 'You''re a Momentum Force! When you''re in flow, nothing can stop you.', 20, 'Ride this wave as far as it takes you. You''ve earned this energy!', 'peak_performance_apps'),
    (v_q_id, 4, '"The Climb" - It''s tough, but I''m pushing through', '🎭', 'the_climb', 'Resilient Warrior', 'You''re a Resilient Warrior! Perseverance is the ultimate superpower.', 30, 'Every step forward counts. You''re stronger than you know!', 'perseverance_apps');
    
    -- Q2: Your Phone Confession
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 2, 'Be honest - what do you reach for your phone hoping to find?', 'phone_confession') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Validation (likes, messages, someone thinking of me)', '💌', 'validation', 'Connection Craver', 'You''re a Connection Craver! Humans are wired for belonging.', 40, 'Your need for connection is beautiful and human. Find your tribe!', 'social_connection_apps'),
    (v_q_id, 2, 'Purpose (something meaningful to do right now)', '🎯', 'purpose', 'Purpose Seeker', 'You''re a Purpose Seeker! While others scroll mindlessly, you crave meaning.', 18, 'This rare quality makes you destined for impact!', 'purpose_apps'),
    (v_q_id, 3, 'Escape (distraction from stress or boredom)', '😂', 'escape', 'Balance Seeker', 'You''re a Balance Seeker! Rest is productive too.', 27, 'Your honesty about needing breaks shows self-awareness!', 'mindful_escape_apps'),
    (v_q_id, 4, 'Answers (solutions to problems I''m facing)', '🧠', 'answers', 'Solution Hunter', 'You''re a Solution Hunter! You use technology as a tool, not a toy.', 15, 'Your resourcefulness will solve problems others give up on!', 'solution_finder_apps');
    
    -- Q3: The Time Machine
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 3, 'If you could get back ONE hour every day, you''d use it to:', 'time_machine') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Level up yourself (learn, workout, grow)', '💪', 'level_up', 'Growth Architect', 'You''re a Growth Architect! Only 8% prioritize self-evolution like you.', 8, 'You''re not just living life—you''re designing it!', 'self_improvement_apps'),
    (v_q_id, 2, 'Connect deeper (quality time with people who matter)', '❤️', 'connect_deeper', 'Relationship Investor', 'You''re a Relationship Investor! Time with loved ones is priceless.', 24, 'These connections are your greatest legacy!', 'quality_time_apps'),
    (v_q_id, 3, 'Create something (build, make, express yourself)', '🎨', 'create_something', 'Creative Soul', 'You''re a Creative Soul! Creators leave fingerprints on the future.', 16, 'Your urge to create is what makes life meaningful!', 'creative_apps'),
    (v_q_id, 4, 'Just breathe (rest, recharge, exist without pressure)', '😌', 'just_breathe', 'Wisdom Holder', 'You''re a Wisdom Holder! Rest is not laziness—it''s strategic.', 22, 'Your understanding of rest shows maturity beyond most!', 'rest_recovery_apps');
    
    -- Questions 4-7 continue in similar format...
    -- For brevity, including just the inserts without full details
    
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 4, 'What does your inner voice say most often?', 'inner_voice') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, '"I can do better" - pushing myself to improve', '🔥', 'do_better', 'Relentless Optimizer', 'You''re a Relentless Optimizer! Champions think exactly like you!', 26, 'Your drive for excellence isn''t pressure—it''s passion!', 'self_improvement_apps'),
    (v_q_id, 2, '"It''ll work out" - staying optimistic and hopeful', '🤗', 'work_out', 'Optimism Warrior', 'You''re an Optimism Warrior! Hope is your superpower.', 28, 'Your positive outlook attracts positive outcomes!', 'positivity_mindset_apps'),
    (v_q_id, 3, '"There must be a way" - solving problems creatively', '🧩', 'find_way', 'Path Finder', 'You''re a Path Finder! Where others see walls, you find doors.', 18, 'This resourcefulness makes you invaluable!', 'creative_problem_solving_apps'),
    (v_q_id, 4, '"Why is this so hard?" - questioning and figuring things out', '💭', 'why_hard', 'Deep Thinker', 'You''re a Deep Thinker! Questions lead to breakthroughs.', 28, 'Your curiosity will unlock answers others never find!', 'analytical_apps');
    
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 5, 'What notification would make you smile instantly?', 'notification_wish') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, '"Someone appreciates you" - recognition or thank you', '🎉', 'appreciation', 'Impact Craver', 'You''re an Impact Craver! You want to matter!', 32, 'This is the mark of true leaders!', 'recognition_apps'),
    (v_q_id, 2, '"Task completed automatically" - life made easier for you', '✅', 'task_auto', 'Efficiency Lover', 'You''re an Efficiency Lover! Work smarter, not harder.', 26, 'Automation is freedom. Pursue it relentlessly!', 'automation_notification_apps'),
    (v_q_id, 3, '"Opportunity discovered" - perfect match for your needs', '💡', 'opportunity', 'Serendipity Seeker', 'You''re a Serendipity Seeker! Magic happens when preparation meets opportunity.', 20, 'Stay ready and opportunities will find you!', 'opportunity_apps'),
    (v_q_id, 4, '"You hit a milestone" - progress you didn''t realize', '🏆', 'milestone', 'Progress Tracker', 'You''re a Progress Tracker! Celebrating wins fuels more wins.', 22, 'Track your journey—progress is happening!', 'milestone_tracking_apps');
    
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 6, 'In an alternate reality where you have NO limitations, you''d:', 'parallel_universe') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Launch that idea you keep thinking about', '🚀', 'launch_idea', 'Caged Visionary', 'You''re a Caged Visionary! History''s game-changers started where you are!', 24, 'Your dreams are bigger than your current reality!', 'idea_launch_apps'),
    (v_q_id, 2, 'Help solve a problem you see in the world', '🌍', 'solve_problem', 'World Changer', 'You''re a World Changer! Purpose-driven people create movements.', 16, 'Your vision for better is what changes everything!', 'social_impact_apps'),
    (v_q_id, 3, 'Master a skill you''ve always wanted', '🎯', 'master_skill', 'Mastery Seeker', 'You''re a Mastery Seeker! Excellence is its own reward.', 28, 'The pursuit of mastery is the path to fulfillment!', 'skill_mastery_apps'),
    (v_q_id, 4, 'Design your perfect daily routine without compromise', '🏝️', 'perfect_routine', 'Life Designer', 'You''re a Life Designer! Intentional living is revolutionary.', 32, 'Your ideal day is possible—design it and live it!', 'routine_design_apps');
    
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 7, 'When do you feel most ALIVE and like the real you?', 'superpower_moment') RETURNING id INTO v_q_id;
    
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Crushing goals and seeing results', '🎯', 'crushing_goals', 'Achievement Addict', 'You''re an Achievement Addict! Results validate your effort.', 30, 'Your results-focus drives extraordinary outcomes!', 'achievement_apps'),
    (v_q_id, 2, 'Solving puzzles others find impossible', '💡', 'solving_puzzles', 'Puzzle Master', 'You''re a Puzzle Master! Complex problems light you up.', 14, 'Your brain is wired for breakthroughs!', 'problem_solving_apps'),
    (v_q_id, 3, 'Making someone''s day better', '🤝', 'making_day', 'Joy Spreader', 'You''re a Joy Spreader! Givers gain the most.', 22, 'Your impact on others is your greatest achievement!', 'kindness_apps'),
    (v_q_id, 4, 'In flow state - time disappears when I''m doing my thing', '🌊', 'flow_state', 'Flow Master', 'You''re a Flow Master! You''ve found your zone of genius.', 14, 'Protect and nurture this gift—it''s rare!', 'flow_apps');
END $$;
