CREATE TABLE releases (
    release_id SERIAL PRIMARY KEY,
    app_id INTEGER NOT NULL,
    env_id INTEGER NOT NULL,
    version_number VARCHAR(20) NOT NULL,
    release_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    release_type VARCHAR(20),
    status VARCHAR(20) NOT NULL,
    release_notes TEXT,
    deployed_by VARCHAR(100),
    rollback_release_id INTEGER,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_releases_app 
        FOREIGN KEY (app_id) 
        REFERENCES applications(app_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_releases_env 
        FOREIGN KEY (env_id) 
        REFERENCES environments(env_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_releases_rollback 
        FOREIGN KEY (rollback_release_id) 
        REFERENCES releases(release_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_release_type CHECK (
        release_type IN ('major', 'minor', 'patch', 'hotfix')
    ),
    
    CONSTRAINT chk_release_status CHECK (
        status IN ('pending', 'deployed', 'failed', 'rolled_back')
    ),
    
    CONSTRAINT chk_version_format CHECK (
        version_number ~ '^\d+\.\d+\.\d+$' -- Semantic versioning format: X.Y.Z
    ),
    
    -- Unique constraint untuk mencegah duplikasi versi per app
    CONSTRAINT uk_app_version UNIQUE (app_id, version_number)
);

-- Indexes untuk performa query
CREATE INDEX idx_releases_app ON releases(app_id);
CREATE INDEX idx_releases_env ON releases(env_id);
CREATE INDEX idx_releases_status ON releases(status);
CREATE INDEX idx_releases_date ON releases(release_date DESC);

-- Documentation
COMMENT ON TABLE releases IS 'Tabel utama untuk tracking semua release aplikasi';
COMMENT ON COLUMN releases.version_number IS 'Semantic versioning format: MAJOR.MINOR.PATCH (contoh: 1.2.3)';
COMMENT ON COLUMN releases.release_type IS 'Tipe release: major (breaking changes), minor (features), patch (bugfix), hotfix (urgent fix)';
COMMENT ON COLUMN releases.rollback_release_id IS 'Referensi ke release sebelumnya jika terjadi rollback';