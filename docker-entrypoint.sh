#!/bin/bash
set -e

# Получаем адрес из переменных окружения Render или используем стандартный
# ВАЖНО: В панели Render добавь HOST_ADDRESS = browserquest-php-docker-llm.onrender.com
HOST_ADDRESS=${HOST_ADDRESS:-"localhost"}

echo "====================================================================="
echo "Настройка Grobi Project: BrowserQuest-PHP"
echo "Адрес сервера: $HOST_ADDRESS"
echo "Порт для клиента: 443 (WSS)"
echo "====================================================================="

# Генерируем конфиг, который заставит телефон подключаться через HTTPS/WSS
# Мы принудительно ставим порт 443 и secure: true для работы через Render
echo '{
    "host": "'"$HOST_ADDRESS"'",
    "port": 443,
    "secure": true
}' > /app/Web/config/config_local.json

# Также обновим основной билд-конфиг на всякий случай
echo '{
    "host": "'"$HOST_ADDRESS"'",
    "port": 443,
    "secure": true
}' > /app/Web/config/config_build.json

# Проверка сгенерированного файла в логах
echo "Конфигурация успешно создана:"
cat /app/Web/config/config_local.json

# Запуск основного сервера Workerman
echo "Запуск сервера Workerman..."
exec php /app/start.php start
