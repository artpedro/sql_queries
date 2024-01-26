SELECT candidate.name,
ROUND(((score.math*2.0)+(score.specific*3.0)+(score.project_plan*5.0))/10.0,2) AS avg
FROM candidate
JOIN score ON candidate.id = score.candidate_id
ORDER BY avg DESC;