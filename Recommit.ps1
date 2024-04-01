# Проверка, что текущая папка — это Git репозиторий
if (-not (Test-Path .git)) {
    Write-Host "❌ Это не Git репозиторий! Перейди в папку с репозиторием."
    exit
}

# Переход на новую "чистую" ветку
git checkout --orphan temp-history

# Удаление только файлов, которые были изменены, но не удаление всех
git add .

# Массив коммитов: дата и сообщение
$commits = @(
    "2024-04-01T10:00:00|Initial commit",
    "2024-04-03T15:30:00|Added core logic",
    "2024-04-06T09:45:00|Fixed bugs"
)

# Применение коммитов с подделанными датами
foreach ($commit in $commits) {
    $parts = $commit -split "\|"
    $date = $parts[0]
    $message = $parts[1]
    
    $env:GIT_COMMITTER_DATE = $date
    git commit -m $message --date=$date
}

# Удаление старой ветки main и переименование
git branch -D main
git branch -m main

# Форс-пуш новой истории в GitHub
git push origin main --force

Write-Host "✅ Готово: история переписана с нужными датами!"
