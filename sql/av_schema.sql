CREATE TABLE IF NOT EXISTS av_clinics (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL,
  website TEXT,
  is_target BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS av_facts (
  id SERIAL PRIMARY KEY,
  clinic_id INT REFERENCES av_clinics(id),
  fact_type TEXT,
  true_value TEXT,
  source_url TEXT,
  checked_on DATE DEFAULT current_date
);

CREATE TABLE IF NOT EXISTS av_prompts (
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL,
  intent TEXT,
  prompt TEXT NOT NULL,
  active BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS av_runs (
  id SERIAL PRIMARY KEY,
  run_at TIMESTAMPTZ DEFAULT now(),
  prompt_id INT REFERENCES av_prompts(id),
  model TEXT NOT NULL,
  sample_no INT NOT NULL,
  answer TEXT,
  extracted JSONB
);

CREATE TABLE IF NOT EXISTS av_mentions (
  id SERIAL PRIMARY KEY,
  run_id INT REFERENCES av_runs(id),
  clinic_name TEXT,
  position INT,
  facts JSONB,
  sources JSONB
);
