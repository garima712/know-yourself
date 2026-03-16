@echo off
echo.
echo ========================================
echo   Know Yourself - Database Setup
echo ========================================
echo.

REM Check if PostgreSQL is installed
where psql >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PostgreSQL is not installed or not in PATH
    echo Please install PostgreSQL from: https://www.postgresql.org/download/
    pause
    exit /b 1
)

echo [1/4] Creating database...
psql -U postgres -c "DROP DATABASE IF EXISTS knowyourself;"
psql -U postgres -c "CREATE DATABASE knowyourself;"
echo [✓] Database created

echo.
echo [2/4] Creating schema...
psql -U postgres -d knowyourself -f database/schema.sql
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create schema
    pause
    exit /b 1
)
echo [✓] Schema created

echo.
echo [3/4] Inserting quiz data (Set 1)...
psql -U postgres -d knowyourself -f database/insert_quiz_data.sql
if %errorlevel% neq 0 (
    echo [ERROR] Failed to insert quiz data set 1
    pause
    exit /b 1
)
echo [✓] Quiz set 1 inserted

echo.
echo [4/4] Inserting additional quiz data (Sets 2-5)...
psql -U postgres -d knowyourself -f database/insert_additional_quizzes.sql
psql -U postgres -d knowyourself -f database/insert_remaining_quizzes.sql
if %errorlevel% neq 0 (
    echo [ERROR] Failed to insert additional quiz data
    pause
    exit /b 1
)
echo [✓] All quiz sets inserted

echo.
echo ========================================
echo   Database Setup Complete!
echo ========================================
echo.
echo Database: knowyourself
echo Host: localhost
echo Port: 5432
echo User: postgres
echo.
pause
