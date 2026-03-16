# 🚀 QUICK START GUIDE

## Get Know Yourself Running in 5 Minutes!

---

### ⚡ Super Quick Start (3 Commands)

```bash
# 1. Setup database (one time only)
setup-database.bat

# 2. Start backend (keep running)
run-backend.bat

# 3. Start frontend (in new terminal)
run-frontend.bat
```

Then open: **http://localhost:3000**

---

### 📋 Prerequisites Checklist

Before you start, install these (one time only):

- [ ] **PostgreSQL** - https://www.postgresql.org/download/
- [ ] **Java 17** - https://adoptium.net/
- [ ] **Maven** - https://maven.apache.org/download.cgi
- [ ] **Node.js** - https://nodejs.org/

All installed? Great! Let's go! 🎉

---

### 🎯 Step-by-Step

#### 1️⃣ Setup Database (First Time Only)

```bash
cd know_yourself
setup-database.bat
```

**What it does:**
- Creates `knowyourself` database
- Creates all tables
- Loads all 5 quiz sets with questions
- Takes about 10 seconds

**Expected output:**
```
[✓] Database created
[✓] Schema created
[✓] Quiz set 1 inserted
[✓] All quiz sets inserted
Database Setup Complete!
```

---

#### 2️⃣ Start Backend Server

```bash
run-backend.bat
```

**What it does:**
- Builds Spring Boot application
- Starts REST API server
- Takes about 30 seconds first time

**Expected output:**
```
╔═══════════════════════════════════════════════════╗
║        Know Yourself - Quiz Application          ║
║        Backend Server Running Successfully        ║
║        API: http://localhost:8080/api            ║
╚═══════════════════════════════════════════════════╝
```

**⚠️ Keep this window open!**

---

#### 3️⃣ Start Frontend Server

**Open a NEW terminal/command prompt**

```bash
cd know_yourself
run-frontend.bat
```

**What it does:**
- Installs React dependencies (first time only)
- Starts development server
- Opens browser automatically

**Expected output:**
```
Compiled successfully!
Local: http://localhost:3000
```

**⚠️ Keep this window open too!**

---

### ✅ Verify It's Working

You should see:

1. **Browser opens automatically** to http://localhost:3000
2. **Beautiful gradient homepage** with 5 quiz cards
3. **Click any quiz** → Answer 7 questions
4. **Get personality insights** after each answer
5. **Complete a quiz** → See completion screen
6. **Check analytics** → View dashboard

---

### 🎮 Try It Out!

1. **Start a quiz**: Click any quiz card
2. **Answer questions**: Choose one option per question
3. **See feedback**: Get instant personality insights
4. **Complete it**: Finish all 7 questions
5. **Try another**: Go back and try different quizzes
6. **View analytics**: Click "View Analytics Dashboard"

---

### 🔧 Common Issues

#### ❌ "PostgreSQL not found"
```bash
# Install PostgreSQL first
# Then add to PATH: C:\Program Files\PostgreSQL\XX\bin
```

#### ❌ "Java not found"
```bash
# Install Java 17+
# Verify: java -version
```

#### ❌ "Port 8080 already in use"
```bash
# Stop other apps using port 8080
# Or change port in: backend/src/main/resources/application.yml
```

#### ❌ "Port 3000 already in use"
```bash
# React will prompt to use 3001
# Just press 'Y' to continue
```

#### ❌ "Cannot connect to database"
```bash
# Check PostgreSQL is running
# Verify username/password in application.yml
# Default: postgres/postgres
```

---

### 🎯 URLs to Remember

| Service | URL |
|---------|-----|
| **Frontend** | http://localhost:3000 |
| **Backend API** | http://localhost:8080/api |
| **Analytics** | http://localhost:3000/analytics |

---

### 📊 API Testing (Optional)

Test backend directly with these endpoints:

```bash
# Get all quiz sets
curl http://localhost:8080/api/quiz/sets

# Get analytics
curl http://localhost:8080/api/analytics/overview
```

---

### 🎓 What to Explore

1. **Homepage**: See all 5 quiz sets
2. **Quiz Experience**: Answer questions
3. **Personality Feedback**: After each answer
4. **Completion**: Finish a full quiz
5. **Analytics Dashboard**: Real-time stats
6. **Mobile View**: Resize browser or use phone

---

### 🔄 Restarting

**If you close everything:**

```bash
# Just start backend and frontend again
# (Database stays running)
run-backend.bat
run-frontend.bat
```

**Database is already setup!** No need to run `setup-database.bat` again.

---

### 📱 Test on Mobile

1. Find your computer's IP address:
   ```bash
   ipconfig  # Windows
   # Look for IPv4 Address (e.g., 192.168.1.100)
   ```

2. On your phone browser:
   ```
   http://YOUR_IP:3000
   ```

3. Make sure phone and computer are on same WiFi

---

### 🎉 Success!

If you can:
- ✅ See the homepage
- ✅ Start a quiz
- ✅ Answer questions
- ✅ Get feedback
- ✅ View analytics

**You're all set! Enjoy exploring!** 🚀

---

### 🆘 Still Having Issues?

1. Check the full [README.md](README.md)
2. Review console output for errors
3. Verify all prerequisites are installed
4. Make sure ports 8080 and 3000 are free
5. Check PostgreSQL is running

---

### 🎯 Next Steps

- Try all 5 quiz sets
- Check the analytics dashboard
- View the source code to learn
- Add your own quiz sets
- Customize the styling

---

**Happy Quiz Taking! 🎊**

*Remember: This app is designed to feel amazing while collecting valuable insights!*
