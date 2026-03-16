# Reinitialize Database with Encoding Fix
$env:PGPASSWORD = 'postgres'
$env:PGCLIENTENCODING = 'UTF8'
$psql = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Reinitializing Database (UTF8)" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Drop and recreate database with UTF8
Write-Host "[1/5] Recreating database..." -ForegroundColor Yellow
& $psql -U postgres -c "DROP DATABASE IF EXISTS knowyourself WITH (FORCE);"
Start-Sleep -Seconds 2
& $psql -U postgres -c "CREATE DATABASE knowyourself ENCODING 'UTF8';"
Write-Host "[OK] Database created`n" -ForegroundColor Green

# Step 2: Create schema
Write-Host "[2/5] Creating schema..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\schema.sql"
Write-Host "[OK] Schema created`n" -ForegroundColor Green

# Step 3-5: Insert quiz data with encoding set
Write-Host "[3/5] Inserting Quiz Set 1..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_quiz_data.sql" 2>&1 | Out-Null
Write-Host "[OK] Processing complete`n" -ForegroundColor Green

Write-Host "[4/5] Inserting Quiz Sets 2-3..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_additional_quizzes.sql" 2>&1 | Out-Null
Write-Host "[OK] Processing complete`n" -ForegroundColor Green

Write-Host "[5/5] Inserting Quiz Sets 4-5..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_remaining_quizzes.sql" 2>&1 | Out-Null
Write-Host "[OK] Processing complete`n" -ForegroundColor Green

# Verify
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Verification" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$quizCount = & $psql -U postgres -d knowyourself -c "SELECT COUNT(*) FROM quiz_sets;" -t -A
Write-Host "Total Quiz Sets: $quizCount" -ForegroundColor Green

$questionCount = & $psql -U postgres -d knowyourself -c "SELECT COUNT(*) FROM questions;" -t -A
Write-Host "Total Questions: $questionCount" -ForegroundColor Green

$optionCount = & $psql -U postgres -d knowyourself -c "SELECT COUNT(*) FROM options;" -t -A
Write-Host "Total Options: $optionCount`n" -ForegroundColor Green

if ([int]$questionCount -gt 0) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  DATABASE READY!" -ForegroundColor Green
    Write-Host "========================================`n" -ForegroundColor Green
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  WARNING: No questions inserted!" -ForegroundColor Red  
    Write-Host "========================================`n" -ForegroundColor Red
}
