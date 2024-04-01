#!/bin/bash

# Очистка старой истории и создание новой с кастомными датами и сообщениями
# ⚠️ Убедись, что ты сделал резервную копию или работаешь в отдельной ветке!

# Шаг 1: Создай новую временную ветку
git checkout --orphan temp-history

# Шаг 2: Удали все файлы из индекса
git rm -rf . > /dev/null 2>&1

# Шаг 3: Добавь файлы заново
git add .

# Шаг 4: Массив коммитов: каждый элемент — дата и сообщение
# Формат: "YYYY-MM-DDTHH:MM:SS|комментарий"
commits=(
  "2024-04-01T10:00:00|Initial commit"
  "2024-04-03T15:30:00|Added core logic"
  "2024-04-06T09:45:00|Fixed bugs"
)

# Шаг 5: Применение коммитов
for entry in "${commits[@]}"; do
  IFS="|" read -r commit_date commit_msg <<< "$entry"
  
  GIT_AUTHOR_DATE="$commit_date" \
  GIT_COMMITTER_DATE="$commit_date" \
  git commit -m "$commit_msg" --date="$commit_date"
done

# Шаг 6: Удаляем старую ветку (если нужно) и переименовываем
git branch -D main
git branch -m main

# Шаг 7: Пушим с перезаписью истории
git push origin main --force

echo "✅ Готово: история переписана с новыми датами!"
