# Makefile для автоматизации установки и запуска проекта

.PHONY: help install setup run clean

help:
	@echo "Доступные команды:"
	@echo "  make install  - установить все зависимости"
	@echo "  make setup    - настроить базу данных (PostgreSQL должен быть установлен)"
	@echo "  make run      - запустить сервер"
	@echo "  make clean    - очистить виртуальное окружение"

install:
	@echo "📦 Установка зависимостей..."
	python3 -m venv venv
	. venv/bin/activate && pip install --upgrade pip
	. venv/bin/activate && pip install -r requirements.txt
	@echo "✅ Зависимости установлены"

setup:
	@echo "🗄️  Настройка базы данных..."
	@echo "⚠️  Убедитесь, что PostgreSQL запущен"
	@echo "Создаем базу данных demo_exam_db..."
	sudo -u postgres psql -c "CREATE DATABASE demo_exam_db;" 2>/dev/null || echo "✅ База данных уже существует"
	@echo "Применяем миграции..."
	. venv/bin/activate && python manage.py migrate
	@echo "✅ База данных готова"

run:
	@echo "🚀 Запуск сервера..."
	. venv/bin/activate && python manage.py runserver

clean:
	@echo "🧹 Очистка..."
	rm -rf venv
	rm -rf __pycache__
	find . -name "*.pyc" -delete
	@echo "✅ Очистка завершена"

# Команда для полной установки (все в одном)
all: install setup
	@echo "🎉 Проект готов к запуску! Выполните 'make run' для старта сервера"
	