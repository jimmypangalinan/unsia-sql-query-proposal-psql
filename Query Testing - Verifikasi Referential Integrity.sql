-- Test 1: View all releases with application dan environment names
SELECT 
    r.release_id,
    a.app_name,
    e.env_name,
    r.version_number,
    r.release_type,
    r.status,
    r.release_date,
    r.deployed_by
FROM releases r
INNER JOIN applications a ON r.app_id = a.app_id
INNER JOIN environments e ON r.env_id = e.env_id
ORDER BY r.release_date DESC;

-- Test 2: Bugs per release with resolution status
SELECT 
    a.app_name,
    r.version_number,
    b.title AS bug_title,
    b.severity,
    rb.resolution_status,
    rb.detected_at,
    rb.resolved_at
FROM release_bugs rb
INNER JOIN releases r ON rb.release_id = r.release_id
INNER JOIN applications a ON r.app_id = a.app_id
INNER JOIN bugs b ON rb.bug_id = b.bug_id
ORDER BY a.app_name, r.version_number;

-- Test 3: Applications dengan jumlah releases per environment
SELECT 
    a.app_name,
    e.env_type,
    COUNT(r.release_id) AS total_releases,
    MAX(r.release_date) AS latest_release
FROM applications a
LEFT JOIN releases r ON a.app_id = r.app_id
LEFT JOIN environments e ON r.env_id = e.env_id
GROUP BY a.app_name, e.env_type
ORDER BY a.app_name, e.env_type;

-- Test 4: Critical bugs yang belum resolved
SELECT 
    b.bug_id,
    b.title,
    b.severity,
    b.reported_at,
    COUNT(rb.release_id) AS affected_releases
FROM bugs b
LEFT JOIN release_bugs rb ON b.bug_id = rb.bug_id
WHERE b.severity = 'critical' 
  AND b.is_resolved = FALSE
GROUP BY b.bug_id, b.title, b.severity, b.reported_at
ORDER BY b.reported_at DESC;

-- Test 5: Release success rate per application
SELECT 
    a.app_name,
    COUNT(*) AS total_releases,
    SUM(CASE WHEN r.status = 'deployed' THEN 1 ELSE 0 END) AS successful_releases,
    SUM(CASE WHEN r.status = 'failed' THEN 1 ELSE 0 END) AS failed_releases,
    SUM(CASE WHEN r.status = 'rolled_back' THEN 1 ELSE 0 END) AS rolled_back_releases,
    ROUND(100.0 * SUM(CASE WHEN r.status = 'deployed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_percent
FROM applications a
INNER JOIN releases r ON a.app_id = r.app_id
GROUP BY a.app_name
ORDER BY success_rate_percent DESC;