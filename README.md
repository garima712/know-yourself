# ✨ Know Yourself

**Interactive Personality Quiz Application with Real-Time Analytics**

Discover something amazing about yourself in just 60 seconds! Know Yourself is a modern, mobile-responsive web application that offers engaging personality quizzes designed to reveal hidden insights about users while collecting valuable market research data.

---

## 🎯 Project Overview

### What Makes This Special?

- **5 Dynamic Quiz Sets**: Each with 7 carefully crafted questions
- **Instant Personality Insights**: Real-time positive feedback after each answer
- **No Going Back**: Once answered, questions are locked (progressive commitment)
- **Mobile-First Design**: Beautiful, responsive UI that works on any device
- **Real-Time Analytics**: Track views, completions, and user insights
- **Market Research Engine**: Hidden layer that identifies app opportunities
- **Loosely Coupled Architecture**: Independent frontend, backend, and database

---

## 🏗️ Architecture

```
know_yourself/
├── backend/              # Spring Boot REST API
│   ├── src/main/java/com/knowyourself/quiz/
│   │   ├── controller/   # REST Controllers
│   │   ├── service/      # Business Logic
│   │   ├── repository/   # Data Access
│   │   ├── entity/       # JPA Entities
│   │   ├── dto/          # Data Transfer Objects
│   │   └── config/       # Configuration
│   └── pom.xml           # Maven dependencies
├── frontend/             # React SPA
│   ├── src/
│   │   ├── pages/        # Page Components
│   │   ├── services/     # API Services
│   │   └── styles/       # CSS Styles
│   └── package.json      # npm dependencies
├── database/             # PostgreSQL Scripts
│   ├── schema.sql        # Database schema
│   ├── insert_quiz_data.sql          # Quiz Set 1
│   ├── insert_additional_quizzes.sql # Quiz Sets 2-3
│   └── insert_remaining_quizzes.sql  # Quiz Sets 4-5
├── setup-database.bat    # Database setup script
├── run-backend.bat       # Backend startup script
└── run-frontend.bat      # Frontend startup script
```

---

## 🎬 Quick Start

### Prerequisites

Before you begin, ensure you have the following installed:

1. **PostgreSQL 12+**
   - Download: https://www.postgresql.org/download/
   - Default user: `postgres`
   - Default password: `postgres` (or your custom password)

2. **Java 17+**
   - Download: https://adoptium.net/

3. **Maven 3.6+**
   - Download: https://maven.apache.org/download.cgi

4. **Node.js 16+**
   - Download: https://nodejs.org/

### Installation Steps

#### Step 1: Setup Database

```bash
# Navigate to project directory
cd know_yourself

# Run database setup script
setup-database.bat
```

This will:
- Create `knowyourself` database
- Create all tables and relationships
- Insert all 5 quiz sets with 35 questions total
- Insert all 140 answer options with personality insights

#### Step 2: Configure Backend (Optional)

If you need to change database credentials, edit:
`backend/src/main/resources/application.yml`

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/knowyourself
    username: postgres  # Change if needed
    password: postgres  # Change if needed
```

#### Step 3: Start Backend Server

```bash
# From project root
run-backend.bat
```

Backend will start on: **http://localhost:8080/api**

#### Step 4: Start Frontend Server

```bash
# Open a NEW terminal/command prompt
run-frontend.bat
```

Frontend will open automatically at: **http://localhost:3000**

---

## 📊 Quiz Sets

### 1. **Future You Blueprint** 🎯
*Discover what your daily habits reveal about your future potential*
- Duration: 60 seconds
- Focus: Productivity and planning patterns
- Insights: Planning vs. Action-oriented behavior

### 2. **Hidden Genius Quiz** 💎
*Find out what makes you exceptionally rare*
- Duration: 45 seconds
- Focus: Unique psychological traits
- Insights: Problem-solving and decision-making style

### 3. **Life Soundtrack Personality** 🎬
*Which movie character are you living as right now?*
- Duration: 50 seconds
- Focus: Current life phase and energy
- Insights: Resilience and motivation patterns

### 4. **Choose Your Superpower** 🦸
*If you had a magic button, what would it do?*
- Duration: 55 seconds
- Focus: Problem-solving preferences
- Insights: Automation and efficiency needs

### 5. **The Honest Truth Test** 💭
*What you really need (but won't admit)*
- Duration: 40 seconds
- Focus: Deep emotional needs
- Insights: Balance and self-care priorities

---

## 🎨 Features

### For Users:

✅ **Beautiful Mobile-First UI**
- Gradient backgrounds
- Smooth animations
- Touch-friendly buttons
- Progress tracking

✅ **Engaging Experience**
- Instant personality feedback
- Positive reinforcement after each answer
- Emoji-rich interface
- Rarity percentages (e.g., "Only 15% of people...")

✅ **No Pressure**
- Quick 40-60 second quizzes
- Can't change previous answers (progressive commitment)
- Auto-advance after feedback

### For Administrators:

📊 **Real-Time Analytics Dashboard**
- Total starts and completions
- Completion rates per quiz
- Average completion time
- Popular insight categories
- Overall statistics

📈 **Market Research Intelligence**
- Each answer maps to app categories
- Track which app types are most desired
- Identify market gaps
- User pain point analysis

---

## 🔧 API Endpoints

### Quiz Endpoints

```
GET    /api/quiz/sets                    # Get all quiz sets
GET    /api/quiz/sets/{quizKey}          # Get specific quiz
POST   /api/quiz/start                   # Start a quiz session
POST   /api/quiz/answer                  # Submit an answer
GET    /api/quiz/session/{sessionUuid}   # Get session status
```

### Analytics Endpoints

```
GET    /api/analytics/all                # Get all quiz analytics
GET    /api/analytics/quiz/{quizKey}     # Get quiz-specific analytics
GET    /api/analytics/overview           # Get overall statistics
```

---

## 💾 Database Schema

### Core Tables:

1. **quiz_sets**: Stores quiz metadata (title, tagline, duration, etc.)
2. **questions**: Stores questions for each quiz
3. **options**: Stores answer options with personality insights
4. **sessions**: Tracks user quiz sessions
5. **responses**: Stores user answers
6. **analytics_daily**: Daily aggregated analytics

### Key Relationships:

- One quiz set → Many questions
- One question → Many options
- One session → Many responses
- Smart tracking with device type, IP, user agent

---

## 🎯 Behind-the-Scenes Intelligence

Each question is strategically designed to reveal:

### Question 1: Morning Routine
**Maps to**: Communication vs. Planning vs. Wellness vs. Productivity apps

### Question 2: Daily Frustrations
**Maps to**: Memory vs. Automation vs. Food Planning vs. Discovery apps

### Question 3: Learning Style
**Maps to**: Video vs. Gamified vs. Reading vs. Audio app preferences

### Question 4: Achievement Definition
**Maps to**: Task Management vs. Goal Tracking vs. Social Impact vs. Creative tools

### Question 5: Micro-Moments
**Maps to**: Content Curation vs. Micro-Productivity vs. Quick Fitness vs. Learning apps

### Question 6: Simplification Desire
**Maps to**: Hub/Dashboard vs. AI Assistant vs. Launcher vs. App Management solutions

### Question 7: Digital Companion
**Maps to**: Motivation Coach vs. Predictive AI vs. Community vs. Decision-Helper apps

---

## 🚀 Technology Stack

### Backend
- **Framework**: Spring Boot 3.2.0
- **Language**: Java 17
- **Database**: PostgreSQL
- **ORM**: Hibernate/JPA
- **Build Tool**: Maven

### Frontend
- **Framework**: React 18
- **Routing**: React Router v6
- **HTTP Client**: Axios
- **Styling**: Custom CSS (no framework dependency)

### Database
- **RDBMS**: PostgreSQL 12+
- **Features**: Triggers, Views, Stored Procedures

---

## 📱 Mobile Support

The application is fully responsive and optimized for:
- ✅ iOS (iPhone/iPad)
- ✅ Android phones and tablets
- ✅ Desktop browsers (Chrome, Firefox, Safari, Edge)
- ✅ Touch interactions
- ✅ Small screen optimization

---

## 🛠️ Configuration

### Environment Variables (Optional)

Create `.env` file in frontend root:

```env
REACT_APP_API_URL=http://localhost:8080/api
```

### CORS Configuration

Backend is configured to accept requests from:
- `http://localhost:3000` (Development)
- Any origin (can be restricted in production)

---

## 📈 Analytics Insights

### Metrics Tracked:

1. **Page Views**: How many users saw each quiz
2. **Quiz Starts**: How many began the quiz
3. **Completions**: How many finished
4. **Completion Rate**: Percentage who completed
5. **Average Time**: Time to complete
6. **Popular Options**: Most selected answers
7. **Insight Categories**: App category preferences

### Sample Use Cases:

- **Product Development**: Which app to build based on user needs
- **Market Validation**: Validate app ideas before development
- **User Segmentation**: Understand different user types
- **Feature Prioritization**: What features users want most

---

## 🔒 Security Features

- Input validation using Jakarta Bean Validation
- SQL injection protection via JPA/Hibernate
- XSS protection through React's built-in escaping
- CORS configuration
- Error handling and logging
- Session UUID for security

---

## 🐛 Troubleshooting

### Database Connection Fails

```bash
# Check if PostgreSQL is running
pg_ctl status

# Verify credentials in application.yml match your PostgreSQL setup
```

### Backend Won't Start

```bash
# Check Java version
java -version  # Should be 17+

# Clean Maven cache
mvn clean
```

### Frontend Won't Start

```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules
npm install
```

### Port Already in Use

```bash
# Backend (8080)
# Change in application.yml: server.port

# Frontend (3000)
# Will auto-prompt for alternative port
```

---

## 🎓 Learning Resources

### For Developers:

This project demonstrates:
- ✅ RESTful API design
- ✅ React hooks and state management
- ✅ PostgreSQL database modeling
- ✅ Spring Boot best practices
- ✅ Responsive CSS design
- ✅ User experience optimization
- ✅ Analytics implementation

---

## 📝 Future Enhancements

Potential additions:
- [ ] Social sharing of results
- [ ] Email capture for follow-ups
- [ ] Multi-language support
- [ ] Quiz builder admin panel
- [ ] Export analytics to CSV
- [ ] A/B testing framework
- [ ] Push notifications
- [ ] Progressive Web App (PWA)

---

## 🤝 Contributing

This project was created as a demonstration of:
- Interactive quiz design
- Market research through engagement
- Full-stack development
- Mobile-first UX

Feel free to:
- Add new quiz sets
- Improve UI/UX
- Enhance analytics
- Optimize performance

---

## 📜 License

This project is created for educational and demonstration purposes.

---

## 👨‍💻 Developer Notes

### Adding a New Quiz Set:

1. Insert into `quiz_sets` table
2. Add 7 questions to `questions` table
3. Add 4 options per question to `options` table
4. Include personality insights and empowerment messages
5. Map options to insight categories

### Modifying Questions:

Questions are immutable once responses exist. To modify:
1. Create new quiz version
2. Deprecate old version
3. Migrate analytics if needed

---

## 📞 Support

For issues, questions, or suggestions:
- Check the troubleshooting section above
- Review the code comments
- Check the console logs
- Verify all prerequisites are installed

---

## 🎉 Success Checklist

After setup, you should see:

✅ Database with 5 quiz sets and 35 questions  
✅ Backend running on http://localhost:8080/api  
✅ Frontend running on http://localhost:3000  
✅ Beautiful homepage with 5 quiz cards  
✅ Smooth quiz-taking experience  
✅ Personality feedback after each answer  
✅ Analytics dashboard with live data  

---

**Built with ❤️ for discovering human potential**

*Know Yourself - Because self-awareness is the first step to greatness*
