CREATE TABLE environments (
    env_id SERIAL PRIMARY KEY,
    env_name VARCHAR(50) NOT NULL UNIQUE,
    env_type VARCHAR(20) NOT NULL,
    config_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraint untuk validasi tipe environment
    CONSTRAINT chk_env_type CHECK (env_type IN ('development', 'staging', 'production', 'testing')),
    CONSTRAINT chk_env_name_length CHECK (LENGTH(env_name) >= 3)
);

-- Index untuk performa
CREATE INDEX idx_environments_type ON environments(env_type);
CREATE INDEX idx_environments_active ON environments(is_active);

-- Documentation comments
COMMENT ON TABLE environments IS 'Master table untuk environment deployment (dev, staging, prod)';
COMMENT ON COLUMN environments.env_type IS 'Tipe environment: development, staging, production, atau testing';
COMMENT ON COLUMN environments.is_active IS 'Flag untuk menandai environment yang masih aktif digunakan';