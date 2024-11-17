CREATE OR REPLACE VIEW user_profile_view AS
SELECT 
    ud.id AS user_id,
    ud.user_name,
    ud.date_of_birth,
    ud.is_verified_flag,
    ud.gender,
    cd.phone,
    cd.email,
    cd.current_location,
    fd.family_status,
    ft.type_name AS family_type,
    fd.number_of_siblings,
    fo.occupation_name AS father_occupation,  -- Father's occupation
    mo.occupation_name AS mother_occupation,   -- Mother's occupation
    ced.college,
    ed.education_level,
    ed.full_form AS education_full_form,
    pr.profession_name,
    ced.company,
    ced.annual_income,
    hid.hobbies,
    hid.interests,
    hid.sports,
    hid.music,
    pcb.creator_name AS profile_created_by,
    lf.description AS looking_for
FROM 
    user_details ud
JOIN 
    contact_details cd ON ud.id = cd.user_id
JOIN 
    family_details fd ON ud.id = fd.user_id
JOIN 
    family_type ft ON fd.family_type_id = ft.id
JOIN 
    career_education_details ced ON ud.id = ced.user_id
JOIN 
    education ed ON ced.education_id = ed.id
JOIN 
    profession pr ON ced.profession_id = pr.id
JOIN 
    hobbies_interests_details hid ON ud.id = hid.user_id
JOIN 
    about_profile ap ON ud.id = ap.user_id
JOIN 
    profile_created_by pcb ON ap.profile_created_by_id = pcb.id
JOIN 
    looking_for lf ON ap.looking_for_id = lf.id
JOIN 
    occupation fo ON fd.father_occupation_id = fo.id  -- Join for father's occupation
JOIN 
    occupation mo ON fd.mother_occupation_id = mo.id; -- Join for mother's occupation