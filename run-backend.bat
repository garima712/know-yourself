@echo off
echo.
echo ========================================
echo   Know Yourself - Backend Server
echo ========================================
echo.

cd backend

REM Check if Maven is installed
where mvn >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Maven is not installed or not in PATH
    echo Please install Maven from: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

REM Check if Java is installed
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java is not installed or not in PATH
    echo Please install Java 17 or higher
    pause
    exit /b 1
)

echo [INFO] Building backend...
call mvn clean package -DskipTests
if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo [INFO] Starting Spring Boot application...
echo.
call mvn spring-boot:run

pause
