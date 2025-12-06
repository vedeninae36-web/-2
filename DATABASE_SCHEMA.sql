-- =============================================================================
-- DATABASE_SCHEMA.sql
-- Схема базы данных для веб-приложения "Умный список задач"
-- Используется с SQLite
-- =============================================================================

-- Включаем поддержку внешних ключей (на случай, если используется вручную)
PRAGMA foreign_keys = ON;

-- Таблица категорий задач
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    color TEXT NOT NULL DEFAULT '#cccccc'  -- Цвет в формате HEX (#RRGGBB)
);

-- Таблица задач
CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    priority TEXT NOT NULL DEFAULT 'medium' CHECK(priority IN ('low', 'medium', 'high')),
    category_id INTEGER,
    deadline DATETIME,  -- Формат: 'YYYY-MM-DD HH:MM:SS'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_completed BOOLEAN NOT NULL DEFAULT 0,  -- 0 = false, 1 = true
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Индексы для ускорения частых операций
CREATE INDEX IF NOT EXISTS idx_tasks_priority        ON tasks(priority);
CREATE INDEX IF NOT EXISTS idx_tasks_category_id     ON tasks(category_id);
CREATE INDEX IF NOT EXISTS idx_tasks_deadline        ON tasks(deadline);
CREATE INDEX IF NOT EXISTS idx_tasks_is_completed    ON tasks(is_completed);
CREATE INDEX IF NOT EXISTS idx_tasks_created_at      ON tasks(created_at);
CREATE INDEX IF NOT EXISTS idx_categories_name       ON categories(name);

-- =============================================================================
-- Конец схемы
-- =============================================================================