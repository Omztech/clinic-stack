-- Week 3: fact accuracy on the fact questions (prompts 9 to 12)
-- extracted.status = refused (no answer given) or answered; extracted.check = correct or wrong (checked by hand against av_facts)
SELECT model,
       CASE WHEN extracted->>'status' = 'refused' THEN 'missing'
            ELSE extracted->>'check' END AS result,
       COUNT(*) AS answers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY model), 0) AS pct
FROM av_runs
WHERE prompt_id BETWEEN 9 AND 12
  AND extracted IS NOT NULL
GROUP BY model, 2
ORDER BY model, answers DESC;
