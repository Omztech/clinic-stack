-- Week 3 Day 4: share of voice per clinic, per AI model, on the open questions (prompts 1 to 8)
CREATE OR REPLACE VIEW av_share_of_voice AS
SELECT md.model,
       c.name,
       c.is_target,
       COUNT(m.id) AS open_mentions,
       ROUND(100.0 * COUNT(m.id) / NULLIF((SELECT COUNT(*) FROM av_runs x
              WHERE x.model = md.model AND x.prompt_id BETWEEN 1 AND 8), 0), 1) AS share_pct,
       ROUND(AVG(m.position), 1) AS avg_position
FROM av_clinics c
CROSS JOIN (SELECT DISTINCT model FROM av_runs) md
LEFT JOIN av_runs r
  ON r.model = md.model AND r.prompt_id BETWEEN 1 AND 8
LEFT JOIN av_mentions m
  ON m.run_id = r.id AND m.clinic_name = c.name
GROUP BY md.model, c.name, c.is_target;
