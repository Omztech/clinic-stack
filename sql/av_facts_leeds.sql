INSERT INTO av_facts (clinic_id, fact_type, true_value, source_url)
SELECT id, f.fact_type, f.true_value, f.source_url
FROM av_clinics c
JOIN (VALUES
 ('Skin Care Clinics','price_chemical_peel','Glycolic Peel 30% £125','https://skincareclinicsuk.com/prices/'),
 ('Skin Care Clinics','price_microneedling','SkinPen microneedling £210','https://skincareclinicsuk.com/prices/'),
 ('Skin Care Clinics','price_laser','Underarm laser hair removal £55 per session','https://skincareclinicsuk.com/prices/'),
 ('Skin Care Clinics','hours','Mon to Fri 7.30am to 7.30pm, Sat 9am to 6.30pm, Sun 10am to 4pm','https://skincareclinicsuk.com/'),
 ('Skin Care Clinics','address','21 York Place, Leeds, LS1 2EX','https://skincareclinicsuk.com/'),
 ('Skin Care Clinics','treatments','Laser hair removal, electrolysis, SkinPen microneedling, chemical peels, Hydro2 facial, vein treatments, mole mapping','https://skincareclinicsuk.com/'),
 ('Skin Doctor Clinics','price_laser','Underarm laser hair removal £125 per session (to confirm)','https://www.skindoctorclinics.co.uk/prices/'),
 ('Skin Doctor Clinics','hours','Mon 10am to 5pm, Tue 9.30am to 8pm, Wed and Thu 10am to 8pm, Fri and Sat 9.30am to 5pm, Sun closed','https://www.skindoctorclinics.co.uk/'),
 ('Skin Doctor Clinics','address','105 Otley Road, Headingley, Leeds, LS6 3PX','https://www.skindoctorclinics.co.uk/'),
 ('Skin Doctor Clinics','treatments','Laser hair removal, microneedling, chemical peels, face and body treatments, doctor-led skin care','https://www.skindoctorclinics.co.uk/'),
 ('HERA Laser and Skin','price_laser','Full body laser hair removal, 6 sessions £600; beard outline £35','https://heralaserandskin.com/products/full-body-consultation-patch-test-6-sessions-for-600'),
 ('HERA Laser and Skin','hours','Tue and Wed 10am to 6pm, Thu 12pm to 8pm, Fri 10am to 6pm, Sat 9am to 5pm, Sun and Mon closed','https://heralaserandskin.com/'),
 ('HERA Laser and Skin','address','275 Otley Road, Weetwood, Leeds, LS16 5LN','https://heralaserandskin.com/'),
 ('HERA Laser and Skin','treatments','Laser hair removal, facials and Hydrafacial, fat dissolving, semi-permanent makeup','https://heralaserandskin.com/')
) AS f(clinic, fact_type, true_value, source_url) ON f.clinic = c.name;
