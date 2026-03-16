# Reinitialize Database with All Data
$env:PGPASSWORD = 'postgres'
$psql = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Reinitializing Database" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Drop and recreate database
Write-Host "[1/5] Recreating database..." -ForegroundColor Yellow
& $psql -U postgres -c "DROP DATABASE IF EXISTS knowyourself;"
& $psql -U postgres -c "CREATE DATABASE knowyourself;"
Write-Host "[OK] Database created`n" -ForegroundColor Green

# Step 2: Create schema
Write-Host "[2/5] Creating schema..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\schema.sql"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Schema creation failed" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Schema created`n" -ForegroundColor Green

# Step 3: Insert quiz set 1
Write-Host "[3/5] Inserting Quiz Set 1..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_quiz_data.sql"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Quiz set 1 insertion failed" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Quiz set 1 inserted`n" -ForegroundColor Green

# Step 4: Insert quiz sets 2-3
Write-Host "[4/5] Inserting Quiz Sets 2-3..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_additional_quizzes.sql"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Quiz sets 2-3 insertion failed" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Quiz sets 2-3 inserted`n" -ForegroundColor Green

# Step 5: Insert quiz sets 4-5
Write-Host "[5/5] Inserting Quiz Sets 4-5..." -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -f "database\insert_remaining_quizzes.sql"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Quiz sets 4-5 insertion failed" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Quiz sets 4-5 inserted`n" -ForegroundColor Green

# Verify the data
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  Verification" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

Write-Host "Quiz Sets:" -ForegroundColor Cyan
& $psql -U postgres -d knowyourself -c "SELECT quiz_key, title FROM quiz_sets ORDER BY display_order;" -t

Write-Host "`nQuestions per Quiz:" -ForegroundColor Cyan
& $psql -U postgres -d knowyourself -c "SELECT qs.quiz_key, COUNT(q.id) as questions FROM quiz_sets qs LEFT JOIN questions q ON qs.id = q.quiz_set_id GROUP BY qs.quiz_key ORDER BY qs.quiz_key;" -t

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  Database Ready!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green
