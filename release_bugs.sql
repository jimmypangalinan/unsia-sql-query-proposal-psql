CREATE TABLE release_bugs (
    rb_id SERIAL PRIMARY KEY,
    release_id INTEGER NOT NULL,
    bug_id INTEGER NOT NULL,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,
    resolution_status VARCHAR(20),
    notes TEXT,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_release_bugs_release 
        FOREIGN KEY (release_id) 
        REFERENCES releases(release_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_release_bugs_bug 
        FOREIGN KEY (bug_id) 
        REFERENCES bugs(bug_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_resolution_status CHECK (
        resolution_status IN ('open', 'in_progress', 'resolved', 'wont_fix', 'duplicate')
    ),
    
    CONSTRAINT chk_resolved_date CHECK (
        resolved_at IS NULL OR resolved_at >= detected_at
    ),
    
    -- Unique constraint untuk mencegah duplikasi
    CONSTRAINT uk_release_bug UNIQUE (release_id, bug_id)
);

-- Indexes untuk join optimization
CREATE INDEX idx_release_bugs_release ON release_bugs(release_id);
CREATE INDEX idx_release_bugs_bug ON release_bugs(bug_id);
CREATE INDEX idx_release_bugs_status ON release_bugs(resolution_status);

-- Documentation
COMMENT ON TABLE release_bugs IS 'Junction table untuk mapping bugs ke release tertentu';
COMMENT ON COLUMN release_bugs.resolution_status IS 'Status penanganan bug dalam konteks release spesifik';
COMMENT ON COLUMN release_bugs.resolved_at IS 'Timestamp ketika bug terselesaikan (must be >= detected_at)';