-- Know Yourself - Quiz Sets 4 & 5

-- ========================================
-- QUIZ SET 4: Choose Your Superpower
-- ========================================
INSERT INTO quiz_sets (quiz_key, title, tagline, hook, duration_seconds, promise, icon_emoji, display_order) VALUES
('choose_superpower', 'Choose Your Superpower', 'If you had a magic button, what would it do?', 'Discover your problem-solving personality type', 55, 'Find out what your brain is secretly optimized for', '🦸', 4);

DO $$
DECLARE
    v_quiz_id BIGINT;
    v_q_id BIGINT;
BEGIN
    SELECT id INTO v_quiz_id FROM quiz_sets WHERE quiz_key = 'choose_superpower';
    
    -- All 7 questions for this quiz set
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 1, 'You find a button that only works ONCE. What does it do?', 'magic_button'),
    (v_quiz_id, 2, 'What charges YOUR battery fastest?', 'battery_meter'),
    (v_quiz_id, 3, 'A genie offers to remove ONE friction from your life forever:', 'genie_offer'),
    (v_quiz_id, 4, 'Which statement secretly describes you?', 'secret_superpower'),
    (v_quiz_id, 5, 'What''s the REAL reason you haven''t done that thing yet?', 'honest_truth'),
    (v_quiz_id, 6, 'If you had a personal AI assistant, you''d want it to:', 'ideal_assistant'),
    (v_quiz_id, 7, 'When you look back at today tonight, what makes you feel proud?', 'mirror_question');
    
    -- Question 1 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 1;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, '"Skip the boring parts" of your routine forever', '⚡', 'skip_boring', 'Efficiency Hunter', 'You''re an Efficiency Hunter! You value your time fiercely.', 28, 'Your impatience with waste is healthy—it drives innovation!', 'efficiency_apps'),
    (v_q_id, 2, '"Show optimal path" for any decision you face', '🎯', 'optimal_path', 'Path Optimizer', 'You''re a Path Optimizer! Decision quality determines life quality.', 24, 'Your desire for the best path shows strategic brilliance!', 'decision_optimization_apps'),
    (v_q_id, 3, '"Say the right thing" in any conversation', '💬', 'right_words', 'Communication Master', 'You''re a Communication Master! Words create worlds.', 22, 'Your awareness of communication power will open doors!', 'communication_apps'),
    (v_q_id, 4, '"See life preview" of choices before you make them', '🔮', 'life_preview', 'Future Simulator', 'You''re a Future Simulator! Thinking ahead prevents regret.', 26, 'Your forward-thinking saves years of mistakes!', 'simulation_apps');
    
    -- Question 2 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 2;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Small wins throughout the day', '🎉', 'small_wins', 'Win Collector', 'You''re a Win Collector! Momentum builds from micro-victories.', 32, 'Your celebration of small wins creates unstoppable momentum!', 'micro_achievement_apps'),
    (v_q_id, 2, 'Real talk with people who understand you', '👥', 'real_talk', 'Deep Connector', 'You''re a Deep Connector! Authentic connection is your fuel.', 26, 'Your need for depth over breadth shows maturity!', 'deep_connection_apps'),
    (v_q_id, 3, 'Quiet moments to reset and breathe', '🧘', 'quiet_moments', 'Peace Seeker', 'You''re a Peace Seeker! Solitude recharges your soul.', 18, 'Your need for quiet shows you understand energy management!', 'meditation_apps'),
    (v_q_id, 4, 'Progress on something that matters', '🚀', 'progress_matters', 'Purpose Driver', 'You''re a Purpose Driver! Meaningful progress is your oxygen.', 24, 'Your focus on what matters will take you far!', 'meaningful_progress_apps');
    
    -- Question 3 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 3;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Decision fatigue - always know the right choice instantly', '🤔', 'no_decision_fatigue', 'Choice Liberator', 'You''re a Choice Liberator! Freedom from choice burden is freedom.', 29, 'Simplifying decisions will 10x your effectiveness!', 'decision_automation_apps'),
    (v_q_id, 2, 'Time stress - never feel rushed or behind again', '⏰', 'no_time_stress', 'Time Master', 'You''re a Time Master! Time freedom is true freedom.', 35, 'Your time awareness will create space for what matters!', 'time_freedom_apps'),
    (v_q_id, 3, 'Fear barrier - confidence to try anything without anxiety', '😰', 'no_fear', 'Courage Keeper', 'You''re a Courage Keeper! Fear is the only real limitation.', 18, 'Removing fear unlocks your full potential!', 'confidence_apps'),
    (v_q_id, 4, 'People-pleasing - comfortable saying no without guilt', '🎭', 'no_people_pleasing', 'Boundary Master', 'You''re a Boundary Master! No is a complete sentence.', 18, 'Healthy boundaries are self-love in action!', 'boundary_apps');
    
    -- Question 4 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 4;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, '"I see solutions" others miss completely', '🦸', 'see_solutions', 'Solution Spotter', 'You''re a Solution Spotter! You have vision beyond the obvious.', 19, 'This gift makes you invaluable in any situation!', 'solution_apps'),
    (v_q_id, 2, '"I spot potential" in people and situations', '💎', 'spot_potential', 'Potential Revealer', 'You''re a Potential Revealer! You see diamonds in the rough.', 16, 'This insight creates opportunity from nothing!', 'potential_apps'),
    (v_q_id, 3, '"I stay steady" when others panic', '🧭', 'stay_steady', 'Calm Anchor', 'You''re a Calm Anchor! Your stability grounds everyone around you.', 22, 'In chaos, you become the leader by default!', 'stability_apps'),
    (v_q_id, 4, '"I connect dots" no one else connects', '🎨', 'connect_dots', 'Pattern Weaver', 'You''re a Pattern Weaver! Synthesis creates breakthrough insights.', 15, 'Your ability to connect ideas is genius-level!', 'synthesis_apps');
    
    -- Question 5 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 5;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Too overwhelmed - don''t know where to start', '😓', 'overwhelmed', 'Clarity Seeker', 'You''re a Clarity Seeker! Breaking things down is your next step.', 38, 'One step at a time. You''ve got this!', 'clarity_apps'),
    (v_q_id, 2, 'No time - already juggling too much', '⏰', 'no_time', 'Time Juggler', 'You''re a Time Juggler! Prioritization is your key.', 32, 'What you can eliminate is as important as what you do!', 'priority_apps'),
    (v_q_id, 3, 'Fear of failing - what if it doesn''t work out?', '😰', 'fear_failing', 'Courage Seeker', 'You''re a Courage Seeker! Acknowledging fear is brave.', 18, 'Failure is feedback. You''re braver than you think!', 'courage_apps'),
    (v_q_id, 4, 'Missing piece - need tools/help/knowledge first', '🧩', 'missing_piece', 'Resource Finder', 'You''re a Resource Finder! Knowing what''s missing shows awareness.', 12, 'The resources you need are closer than you think!', 'resource_apps');
    
    -- Question 6 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 6;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Prioritize ruthlessly - tell me what actually matters today', '🎯', 'prioritize', 'Focus Master', 'You''re a Focus Master! Clarity on priorities is power.', 26, 'Knowing what matters most is the ultimate life skill!', 'focus_priority_apps'),
    (v_q_id, 2, 'Handle grunt work - do the boring stuff automatically', '🤖', 'handle_grunt', 'Automation Seeker', 'You''re an Automation Seeker! Free your mind for what matters.', 34, 'Automating the mundane unlocks your genius!', 'task_automation_apps'),
    (v_q_id, 3, 'Spark ideas - inspire me when I''m stuck', '💡', 'spark_ideas', 'Inspiration Chaser', 'You''re an Inspiration Chaser! Creativity needs fuel.', 22, 'Inspiration is everywhere when you''re open to it!', 'inspiration_apps'),
    (v_q_id, 4, 'Remember everything - be my second brain', '🧠', 'second_brain', 'Memory Expander', 'You''re a Memory Expander! External memory frees internal creativity.', 18, 'Your second brain will make you superhuman!', 'memory_apps');
    
    -- Question 7 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 7;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Got stuff done - kicked butt on my list', '✅', 'got_stuff_done', 'Execution Champion', 'You''re an Execution Champion! Doers change the world.', 36, 'Your follow-through separates you from dreamers!', 'execution_apps'),
    (v_q_id, 2, 'Showed up - even when it was hard', '💪', 'showed_up', 'Consistency King', 'You''re a Consistency King! Showing up is 80% of success.', 24, 'Your reliability is your reputation. Keep showing up!', 'consistency_apps'),
    (v_q_id, 3, 'Was present - connected meaningfully', '❤️', 'was_present', 'Presence Master', 'You''re a Presence Master! Being fully there is a gift.', 16, 'Your presence creates memories that last forever!', 'mindfulness_apps'),
    (v_q_id, 4, 'Learned something - grew a little bit', '🌱', 'learned_something', 'Growth Collector', 'You''re a Growth Collector! Daily learning compounds into mastery.', 24, 'You''re 1% better today. That''s how legends are built!', 'learning_apps');
END $$;


-- ========================================
-- QUIZ SET 5: The Honest Truth Test
-- ========================================
INSERT INTO quiz_sets (quiz_key, title, tagline, hook, duration_seconds, promise, icon_emoji, display_order) VALUES
('honest_truth', 'The Honest Truth Test', 'What you really need (but won''t admit)', 'The most accurate personality insight you''ll get today', 40, 'Understand what''s been holding you back', '💭', 5);

DO $$
DECLARE
    v_quiz_id BIGINT;
    v_q_id BIGINT;
BEGIN
    SELECT id INTO v_quiz_id FROM quiz_sets WHERE quiz_key = 'honest_truth';
    
    -- All 7 questions
    INSERT INTO questions (quiz_set_id, question_order, question_text, question_key) VALUES
    (v_quiz_id, 1, 'What do you wish was easier?', 'wish_easier'),
    (v_quiz_id, 2, 'If no one judged, what would you do more of?', 'no_judgment'),
    (v_quiz_id, 3, 'You keep postponing things because:', 'postponing_reason'),
    (v_quiz_id, 4, 'You feel most stressed when:', 'stress_trigger'),
    (v_quiz_id, 5, 'You''d feel SO much better if:', 'feel_better'),
    (v_quiz_id, 6, 'What makes you forget to take care of yourself?', 'forget_selfcare'),
    (v_quiz_id, 7, 'Your ideal day would include:', 'ideal_day');
    
    -- Q1 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 1;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Starting my day with energy and clarity', '🌅', 'morning_energy', 'Morning Seeker', 'You''re a Morning Seeker! Your day''s quality starts with morning quality.', 32, 'Master your mornings, master your life!', 'morning_routine_apps'),
    (v_q_id, 2, 'Knowing I''m focusing on the right things', '🎯', 'right_focus', 'Direction Finder', 'You''re a Direction Finder! Clarity prevents wasted effort.', 28, 'When you know where you''re going, you get there faster!', 'focus_direction_apps'),
    (v_q_id, 3, 'Balancing everyone''s needs including my own', '🤝', 'balance_needs', 'Balance Artist', 'You''re a Balance Artist! Harmony requires constant adjustment.', 25, 'Your awareness of balance shows maturity!', 'life_balance_apps'),
    (v_q_id, 4, 'Ending my day feeling accomplished', '😌', 'end_accomplished', 'Closure Seeker', 'You''re a Closure Seeker! Completion brings peace.', 15, 'Small daily wins create lifetime success!', 'daily_closure_apps');
    
    -- Q2 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 2;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Rest without guilt', '🛌', 'rest_no_guilt', 'Rest Warrior', 'You''re a Rest Warrior! Rest is productive.', 28, 'Your body and mind need recovery. Honor that!', 'rest_apps'),
    (v_q_id, 2, 'Create without perfection', '🎨', 'create_imperfect', 'Creative Free Spirit', 'You''re a Creative Free Spirit! Done is better than perfect.', 22, 'Your creativity doesn''t need permission to exist!', 'creative_freedom_apps'),
    (v_q_id, 3, 'Learn random things I''m curious about', '🎓', 'learn_random', 'Curious Explorer', 'You''re a Curious Explorer! Curiosity is intelligence having fun.', 24, 'Follow your curiosity—it knows where to go!', 'curiosity_apps'),
    (v_q_id, 4, 'Share my ideas and opinions', '🗣️', 'share_ideas', 'Voice Finder', 'You''re a Voice Finder! Your perspective matters.', 26, 'The world needs your unique viewpoint. Speak up!', 'expression_apps');
    
    -- Q3 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 3;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Too many decisions drain you', '🤯', 'decision_drain', 'Decision Protector', 'You''re a Decision Protector! Reduce choices to increase action.', 34, 'Simplify decisions to preserve energy for what matters!', 'decision_reduction_apps'),
    (v_q_id, 2, 'Never feel like "the right time"', '⏰', 'never_right_time', 'Perfect Waiter', 'You''re a Perfect Waiter! Now is the only time there is.', 30, 'Done imperfectly now beats perfect never. Start messy!', 'action_apps'),
    (v_q_id, 3, 'Worried about doing it wrong', '😰', 'fear_wrong', 'Safety Seeker', 'You''re a Safety Seeker! Progress requires risk.', 22, 'Every expert was once a beginner who kept going!', 'confidence_building_apps'),
    (v_q_id, 4, 'Unclear which step comes first', '🎯', 'unclear_steps', 'Clarity Craver', 'You''re a Clarity Craver! Breaking it down makes it doable.', 14, 'One clear next step is all you need!', 'step_by_step_apps');
    
    -- Q4 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 4;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Too many things demanding my attention', '📱', 'too_many_demands', 'Attention Guardian', 'You''re an Attention Guardian! Protect your focus fiercely.', 38, 'Your attention is your most valuable asset!', 'attention_management_apps'),
    (v_q_id, 2, 'Not sure if I''m making progress', '❓', 'unsure_progress', 'Progress Tracker', 'You''re a Progress Tracker! What gets measured gets managed.', 24, 'Track your wins—you''re progressing more than you know!', 'progress_tracking_apps'),
    (v_q_id, 3, 'Time is slipping away too fast', '⏱️', 'time_slipping', 'Time Protector', 'You''re a Time Protector! Time awareness creates time abundance.', 20, 'Intentional time use creates the life you want!', 'time_tracking_apps'),
    (v_q_id, 4, 'Trying to keep everyone happy', '🎭', 'keep_happy', 'Harmony Seeker', 'You''re a Harmony Seeker! You can''t pour from an empty cup.', 18, 'Your happiness matters too—prioritize it!', 'self_priority_apps');
    
    -- Q5 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 5;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Your brain wasn''t so cluttered', '🧠', 'brain_clutter', 'Mental Space Seeker', 'You''re a Mental Space Seeker! Mental clarity is freedom.', 32, 'Clear your mind to see your path!', 'mental_clarity_apps'),
    (v_q_id, 2, 'You could see your progress clearly', '✅', 'see_progress', 'Visual Tracker', 'You''re a Visual Tracker! Seeing progress motivates more progress.', 26, 'Make your progress visible and watch motivation soar!', 'visual_progress_apps'),
    (v_q_id, 3, 'You knew your efforts mattered', '🎯', 'efforts_matter', 'Meaning Maker', 'You''re a Meaning Maker! Purpose fuels persistence.', 22, 'Your efforts create ripples you can''t yet see!', 'impact_visibility_apps'),
    (v_q_id, 4, 'Life had less friction and more flow', '⚡', 'less_friction', 'Flow Seeker', 'You''re a Flow Seeker! Removing friction creates momentum.', 20, 'Smooth paths lead to faster progress!', 'friction_reduction_apps');
    
    -- Q6 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 6;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Getting lost in tasks and to-dos', '📋', 'lost_tasks', 'Task Warrior', 'You''re a Task Warrior! Remember to zoom out sometimes.', 35, 'Tasks are means, not ends. Remember your why!', 'purpose_reminder_apps'),
    (v_q_id, 2, 'Taking care of everyone else first', '👥', 'others_first', 'Caregiver Soul', 'You''re a Caregiver Soul! You can''t serve from an empty vessel.', 28, 'Self-care isn''t selfish—it''s necessary!', 'selfcare_reminder_apps'),
    (v_q_id, 3, 'Hyperfocusing on goals and achievements', '🎯', 'hyperfocus_goals', 'Achievement Driver', 'You''re an Achievement Driver! Balance achievement with being.', 20, 'You are enough, even between achievements!', 'balance_reminder_apps'),
    (v_q_id, 4, 'Falling into infinite scroll mode', '📱', 'scroll_mode', 'Digital Drifter', 'You''re a Digital Drifter! Awareness is the first step to change.', 17, 'Redirect this time toward your dreams!', 'digital_wellness_apps');
    
    -- Q7 options
    SELECT id INTO v_q_id FROM questions WHERE quiz_set_id = v_quiz_id AND question_order = 7;
    INSERT INTO options (question_id, option_order, option_text, option_emoji, option_key, personality_trait, personality_description, personality_rarity_percent, empowerment_message, insight_category) VALUES
    (v_q_id, 1, 'Clarity on what matters most', '🎯', 'clarity_matters', 'Clarity Champion', 'You''re a Clarity Champion! Clarity is power.', 28, 'When priorities are clear, decisions are easy!', 'clarity_apps'),
    (v_q_id, 2, 'Energy that doesn''t run out', '⚡', 'endless_energy', 'Energy Optimizer', 'You''re an Energy Optimizer! Energy management beats time management.', 26, 'Protect your energy sources and eliminate drains!', 'energy_management_apps'),
    (v_q_id, 3, 'Meaningful connections', '❤️', 'meaningful_connections', 'Connection Keeper', 'You''re a Connection Keeper! Relationships are life''s riches.', 22, 'Invest in relationships—they compound forever!', 'relationship_quality_apps'),
    (v_q_id, 4, 'Peace of mind at bedtime', '😌', 'peace_bedtime', 'Peace Finder', 'You''re a Peace Finder! Sleep well, live  well.', 24, 'Evening peace creates morning power!', 'evening_peace_apps');
END $$;
