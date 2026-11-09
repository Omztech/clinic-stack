-- Week 3 Day 5: share of voice per clinic per model, with a 95% Wilson confidence range
-- Open questions only (prompts 1 to 8). Clinics never mentioned still show with k = 0.
WITH totals AS (
  SELECT model, COUNT(*) AS n
  FROM av_runs
  WHERE prompt_id BETWEEN 1 AND 8
  GROUP BY model
), hits AS (
  SELECT r.model, m.clinic_name, COUNT(DISTINCT r.id) AS k
  FROM av_runs r
  JOIN av_mentions m ON m.run_id = r.id
  WHERE r.prompt_id BETWEEN 1 AND 8
  GROUP BY r.model, m.clinic_name
), all_rows AS (
  SELECT t.model, c.name AS clinic_name, c.is_target, COALESCE(h.k, 0) AS k, t.n
  FROM totals t
  CROSS JOIN av_clinics c
  LEFT JOIN hits h ON h.model = t.model AND h.clinic_name = c.name
)
SELECT model, clinic_name, is_target, k, n,
  ROUND(k::numeric / n, 3) AS share,
  ROUND(((k::numeric/n) + 1.92/n - 1.96*sqrt((k::numeric/n)*(1-k::numeric/n)/n + 0.9604/(n*n))) / (1 + 3.8416/n), 3) AS low,
  ROUND(((k::numeric/n) + 1.92/n + 1.96*sqrt((k::numeric/n)*(1-k::numeric/n)/n + 0.9604/(n*n))) / (1 + 3.8416/n), 3) AS high
FROM all_rows
ORDER BY model, share DESC, clinic_name;
