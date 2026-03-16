# Check Database Status
$env:PGPASSWORD = 'postgres'
$psql = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

Write-Host "`nChecking database..." -ForegroundColor Cyan

# Check quiz sets
Write-Host "`n1. Quiz Sets:" -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -c "SELECT id, quiz_key, title FROM quiz_sets ORDER BY id;" -t -A

# Check questions per quiz
Write-Host "`n2. Questions per Quiz:" -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -c "SELECT qs.quiz_key, COUNT(q.id) as question_count FROM quiz_sets qs LEFT JOIN questions q ON qs.id = q.quiz_set_id GROUP BY qs.quiz_key ORDER BY qs.quiz_key;" -t -A

# Check options per question 
Write-Host "`n3. Options per Question:" -ForegroundColor Yellow
& $psql -U postgres -d knowyourself -c "SELECT q.quiz_set_id, q.question_order, COUNT(o.id) as option_count FROM questions q LEFT JOIN options o ON q.id = o.question_id GROUP BY q.quiz_set_id, q.question_order ORDER BY q.quiz_set_id, q.question_order LIMIT 10;" -t -A

Write-Host "`n"
