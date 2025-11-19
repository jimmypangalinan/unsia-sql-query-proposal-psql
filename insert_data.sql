INSERT INTO applications (app_name, description, repository_url, tech_stack) VALUES
('CustomerPortal', 'Web-based customer management portal', 'https://github.com/company/customer-portal', 'React, Node.js, PostgreSQL'),
('MobileApp', 'Cross-platform mobile application', 'https://github.com/company/mobile-app', 'React Native, Firebase'),
('BackendAPI', 'RESTful API service', 'https://github.com/company/backend-api', 'Python, FastAPI, PostgreSQL'),
('AdminDashboard', 'Internal admin dashboard', 'https://github.com/company/admin-dashboard', 'Vue.js, Express, MongoDB'),
('DataPipeline', 'ETL data processing pipeline', 'https://github.com/company/data-pipeline', 'Apache Airflow, Python, Spark');

-- Insert Environments
INSERT INTO environments (env_name, env_type, config_url, is_active) VALUES
('Development Server', 'development', 'https://config.company.com/dev', TRUE),
('Staging Server', 'staging', 'https://config.company.com/staging', TRUE),
('Production Server', 'production', 'https://config.company.com/prod', TRUE),
('Testing Lab', 'testing', 'https://config.company.com/test', TRUE),
('Production DR', 'production', 'https://config.company.com/prod-dr', FALSE);

-- Insert Releases
INSERT INTO releases (app_id, env_id, version_number, release_type, status, release_notes, deployed_by) VALUES
(1, 1, '1.0.0', 'major', 'deployed', 'Initial release with core features', 'john.doe@company.com'),
(1, 2, '1.0.0', 'major', 'deployed', 'Initial release - staging validation', 'john.doe@company.com'),
(1, 3, '1.0.0', 'major', 'deployed', 'Initial production release', 'jane.smith@company.com'),
(1, 3, '1.0.1', 'patch', 'deployed', 'Critical security patch', 'jane.smith@company.com'),
(1, 3, '1.1.0', 'minor', 'deployed', 'Added new customer search feature', 'john.doe@company.com'),
(2, 1, '2.0.0', 'major', 'deployed', 'Complete UI redesign', 'alex.johnson@company.com'),
(2, 2, '2.0.0', 'major', 'failed', 'Performance issues detected', 'alex.johnson@company.com'),
(3, 3, '3.5.2', 'patch', 'deployed', 'Bug fixes for authentication', 'sarah.connor@company.com'),
(4, 1, '0.9.0', 'minor', 'pending', 'Pre-release testing', 'mike.wilson@company.com'),
(5, 2, '1.2.0', 'minor', 'rolled_back', 'Data corruption issue - rolled back', 'emma.davis@company.com');

-- Insert Bugs
INSERT INTO bugs (title, description, severity, bug_type, reported_by, is_resolved) VALUES
('Login page crashes on mobile Safari', 'Users cannot login using Safari browser on iPhone 12 and above. Stack trace shows null pointer exception.', 'high', 'functionality', 'qa.team@company.com', FALSE),
('Slow query performance on customer search', 'Customer search takes 5+ seconds for databases with >100k records. Needs query optimization.', 'medium', 'performance', 'john.doe@company.com', FALSE),
('SQL injection vulnerability in search', 'Search input not properly sanitized allowing SQL injection attacks. CRITICAL SECURITY ISSUE.', 'critical', 'security', 'security.team@company.com', TRUE),
('Dashboard charts not rendering', 'Sales dashboard charts show blank canvas on Firefox browser version 98+.', 'low', 'UI', 'jane.smith@company.com', TRUE),
('Data export feature timeout', 'Export to CSV fails for datasets larger than 10k rows with timeout error.', 'medium', 'functionality', 'alex.johnson@company.com', FALSE),
('Memory leak in background service', 'Background sync service shows increasing memory usage over 24 hour period leading to OOM errors.', 'high', 'performance', 'ops.team@company.com', FALSE),
('Incorrect date format in reports', 'Reports show dates in MM/DD/YYYY instead of DD/MM/YYYY for EMEA region users.', 'low', 'data', 'emma.davis@company.com', TRUE),
('API rate limiting not working', 'Rate limiting middleware allows more requests than configured limit.', 'medium', 'functionality', 'sarah.connor@company.com', TRUE);

-- Insert Release_Bugs (mapping bugs to releases)
INSERT INTO release_bugs (release_id, bug_id, resolution_status, notes) VALUES
(1, 1, 'open', 'Bug discovered during initial deployment'),
(1, 2, 'in_progress', 'Database team working on index optimization'),
(3, 3, 'resolved', 'Fixed in version 1.0.1 with parameterized queries'),
(4, 3, 'resolved', 'This release specifically addressed the security vulnerability'),
(5, 4, 'resolved', 'Fixed by updating chart.js library to v3.9.1'),
(5, 5, 'in_progress', 'Investigating batch processing approach'),
(6, 6, 'open', 'Memory profiling scheduled for next sprint'),
(7, 2, 'wont_fix', 'Performance acceptable for staging environment'),
(8, 8, 'resolved', 'Rate limiter middleware replaced with Redis-based solution'),
(10, 7, 'resolved', 'But caused data corruption - reason for rollback');

-- Verifikasi: Check row counts
SELECT 'applications' AS table_name, COUNT(*) AS row_count FROM applications
UNION ALL
SELECT 'environments', COUNT(*) FROM environments
UNION ALL
SELECT 'releases', COUNT(*) FROM releases
UNION ALL
SELECT 'bugs', COUNT(*) FROM bugs
UNION ALL
SELECT 'release_bugs', COUNT(*) FROM release_bugs;