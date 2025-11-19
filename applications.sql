CREATE TABLE applications (
    app_id SERIAL PRIMARY KEY,
    app_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    repository_url VARCHAR(255),
    tech_stack VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints tambahan
    CONSTRAINT chk_app_name_length CHECK (LENGTH(app_name) >= 3),
    CONSTRAINT chk_repository_url CHECK (repository_url IS NULL OR repository_url LIKE 'http%')
);

-- Membuat index untuk performa query
CREATE INDEX idx_applications_name ON applications(app_name);

-- Membuat comment untuk dokumentasi
COMMENT ON TABLE applications IS 'Master table untuk menyimpan informasi aplikasi yang dikembangkan';
COMMENT ON COLUMN applications.app_id IS 'Primary key - Auto-increment identifier';
COMMENT ON COLUMN applications.app_name IS 'Nama unik aplikasi, minimal 3 karakter';
COMMENT ON COLUMN applications.tech_stack IS 'Technology stack yang digunakan (contoh: React, Node.js, PostgreSQL)';