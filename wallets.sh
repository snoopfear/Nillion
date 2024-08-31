#!/bin/bash

# Путь к итоговому файлу, куда будут сохраняться все данные
OUTPUT_FILE="$HOME/nillion/accuser/combined_credentials.txt"
# Путь к файлу credentials.json
CREDENTIALS_FILE="$HOME/nillion/accuser/credentials.json"
# Команда для запуска Docker
DOCKER_CMD="sudo docker run -v $HOME/nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 initialise"

# Создаем или очищаем итоговый файл
echo "" > "$OUTPUT_FILE"

# Цикл для выполнения задачи 10 раз
for i in {1..10}; do
  # Шаг 1: Запуск Docker команды
  echo "Запуск Docker команды (итерация $i)..."
  $DOCKER_CMD

  # Шаг 2: Копирование данных из файла credentials.json в общий файл с добавлением номера
  if [ -f "$CREDENTIALS_FILE" ]; then
    echo "Добавление данных из credentials.json в $OUTPUT_FILE под номером $i"
    echo "=== Порядковый номер $i ===" >> "$OUTPUT_FILE"
    cat "$CREDENTIALS_FILE" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"  # Добавляем пустую строку для разделения

    # Шаг 3: Удаление файла credentials.json
    echo "Удаление файла credentials.json"
    rm "$CREDENTIALS_FILE"
  else
    echo "Файл credentials.json не найден!"
    exit 1
  fi

  # Небольшая пауза между итерациями (если необходимо)
  sleep 1
done

echo "Скрипт выполнен успешно!"
