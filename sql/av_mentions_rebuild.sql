-- Week 3: rebuild clinic mentions for one model, with correct positions.
-- Handles the "Skin viva" spelling. Run after adding new clinics to av_clinics.
DELETE FROM av_mentions
WHERE run_id IN (SELECT id FROM av_runs WHERE model = 'gemini-3.5-flash-lite');

INSERT INTO av_mentions (run_id, clinic_name, position)
SELECT run_id, name, RANK() OVER (PARTITION BY run_id ORDER BY pos)
FROM (
  SELECT r.id AS run_id, c.name,
         strpos(replace(lower(r.answer), 'skin viva', 'skinviva'), lower(c.name)) AS pos
  FROM av_runs r CROSS JOIN av_clinics c
  WHERE r.model = 'gemini-3.5-flash-lite'
) x
WHERE pos > 0;
