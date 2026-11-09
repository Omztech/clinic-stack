-- Week 3: clinic names pulled out by Gemini (AV Extract), with spellings merged into one name per clinic
CREATE OR REPLACE VIEW av_extracted_mentions AS
SELECT r.id AS run_id, r.model, r.prompt_id,
       (c->>'position')::int AS position,
       CASE
         WHEN c->>'name' ~* 'skin ?viva'                    THEN 'SkinViva'
         WHEN c->>'name' ~* 'illuminate'                    THEN 'Illuminate Skin Clinic'
         WHEN c->>'name' ~* 'laser clinics uk'              THEN 'Laser Clinics UK'
         WHEN c->>'name' ~* 'therapie'                      THEN 'Therapie Clinic'
         WHEN c->>'name' ~* 'private clinic'                THEN 'The Private Clinic'
         WHEN c->>'name' ~* 'courthouse'                    THEN 'Courthouse Clinics'
         WHEN c->>'name' ~* 'harrogate aesthetics'          THEN 'Harrogate Aesthetics'
         WHEN c->>'name' ~* 'harrogate skin'                THEN 'Harrogate Skin Clinic'
         WHEN c->>'name' ~* 'spire'                         THEN 'Spire Leeds Hospital'
         WHEN c->>'name' ~* 'ef medispa'                    THEN 'EF MEDISPA'
         WHEN c->>'name' ~* 'harvey nichols'                THEN 'Harvey Nichols'
         WHEN c->>'name' ~* 'nuffield'                      THEN 'Nuffield Health Leeds'
         WHEN c->>'name' ~* '(leeds skin clinic|skin clinic leeds)' THEN 'Leeds Skin Clinic'
         WHEN c->>'name' ~* 'derma clinic'                  THEN 'The Derma Clinic'
         WHEN c->>'name' ~* '(sk:?n clinic|^sk:n)'          THEN 'Sk:n'
         WHEN c->>'name' ~* 'dr\.? ?medispa'                THEN 'Dr. MediSpa'
         WHEN c->>'name' ~* 'skin care clinic'              THEN 'Skin Care Clinics'
         WHEN c->>'name' ~* '\mhera\M'                      THEN 'HERA Laser and Skin'
         WHEN c->>'name' ~* 'skin doctor'                   THEN 'Skin Doctor Clinics'
         ELSE trim(c->>'name')
       END AS clinic
FROM av_runs r,
     jsonb_array_elements(r.extracted->'clinics') AS c
WHERE r.extracted->>'status' = 'ok';
