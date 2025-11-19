CREATE TABLE bugs (
    bug_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    severity VARCHAR(20) NOT NULL,
    bug_type VARCHAR(50),
    reported_by VARCHAR(100),
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_resolved BOOLEAN DEFAULT FALSE,
    
    -- Check Constraints
    CONSTRAINT chk_bug_severity CHECK (
        severity IN ('critical', 'high', 'medium', 'low')
    ),
    
    CONSTRAINT chk_bug_type CHECK (
        bug_type IN ('functionality', 'performance', 'security', 'UI', 'data', 'integration', 'other')
    ),
    
    CONSTRAINT chk_title_length CHECK (LENGTH(title) >= 10),
    CONSTRAINT chk_description_length CHECK (LENGTH(description) >= 20)
);

-- Indexes
CREATE INDEX idx_bugs_severity ON bugs(severity);
CREATE INDEX idx_bugs_resolved ON bugs(is_resolved);
CREATE INDEX idx_bugs_type ON bugs(bug_type);
CREATE INDEX idx_bugs_reported_date ON bugs(reported_at DESC);

-- Documentation
COMMENT ON TABLE bugs IS 'Master table untuk bug/defect tracking';
COMMENT ON COLUMN bugs.severity IS 'Tingkat keparahan: critical (sistem down), high (major impact), medium (moderate impact), low (minor issue)';
COMMENT ON COLUMN bugs.bug_type IS 'Kategori bug berdasarkan area yang terpengaruh';