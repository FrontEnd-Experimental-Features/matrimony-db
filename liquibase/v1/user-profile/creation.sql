CREATE TABLE IF NOT EXISTS user_details (
    id SERIAL PRIMARY KEY , -- Unique ID for the user
    date_of_birth DATE NOT NULL,     -- Date of Birth
    user_name VARCHAR(255) NOT NULL, -- User Name
    is_verified_flag BOOLEAN DEFAULT true -- Verified Flag
); 

CREATE TABLE contact_details (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the contact details
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    phone VARCHAR(15) NOT NULL,      -- Phone number
    email VARCHAR(255) NOT NULL,     -- Email address
    current_location VARCHAR(255) NOT NULL, -- Current location
    FOREIGN KEY (user_id) REFERENCES user_details(id) -- Foreign key constraint
);
 
 CREATE TABLE family_type (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the family type
    type_name VARCHAR(255) NOT NULL UNIQUE -- Name of the family type (e.g., Nuclear Family)
);

CREATE TABLE occupation (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the occupation
    occupation_name VARCHAR(255) NOT NULL UNIQUE -- Name of the occupation (e.g., Business, Teacher)
);

CREATE TABLE family_details (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the family details
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    family_type_id INT NOT NULL,     -- Foreign key referencing family_type
    family_status VARCHAR(255) NOT NULL, -- Family Status
    father_occupation_id INT NOT NULL, -- Foreign key referencing occupation for father's occupation
    mother_occupation_id INT NOT NULL, -- Foreign key referencing occupation for mother's occupation
    number_of_siblings INT NOT NULL, -- Number of Siblings
    FOREIGN KEY (user_id) REFERENCES user_details(id), -- Foreign key constraint
    FOREIGN KEY (family_type_id) REFERENCES family_type(id), -- Foreign key constraint
    FOREIGN KEY (father_occupation_id) REFERENCES occupation(id), -- Foreign key constraint for father's occupation
    FOREIGN KEY (mother_occupation_id) REFERENCES occupation(id) -- Foreign key constraint for mother's occupation
);

CREATE TABLE education (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the education level
    education_level VARCHAR(255) NOT NULL UNIQUE, -- Name of the education level (e.g., B.Tech, M.Sc)
    full_form VARCHAR(255) NOT NULL -- Full form of the education level
);

CREATE TABLE profession (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the profession
    profession_name VARCHAR(255) NOT NULL UNIQUE, -- Name of the profession (e.g., Software Developer, Teacher)
    description VARCHAR(255)
);

CREATE TABLE career_education_details (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the career and education details
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    education_id INT NOT NULL,       -- Foreign key referencing education
    college VARCHAR(255) NOT NULL,    -- College name
    profession_id INT NOT NULL,      -- Foreign key referencing profession
    company VARCHAR(255) NOT NULL,     -- Company name
    annual_income VARCHAR(50) NOT NULL, -- Annual income range
    FOREIGN KEY (user_id) REFERENCES user_details(id), -- Foreign key constraint
    FOREIGN KEY (education_id) REFERENCES education(id), -- Foreign key constraint
    FOREIGN KEY (profession_id) REFERENCES profession(id) -- Foreign key constraint
);


CREATE TABLE hobbies_interests_details (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the hobbies and interests details
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    hobbies VARCHAR(255) NOT NULL,   -- Hobbies
    interests VARCHAR(255) NOT NULL, -- Interests
    sports VARCHAR(255) NOT NULL,    -- Sports
    music VARCHAR(255) NOT NULL,     -- Music preferences
    FOREIGN KEY (user_id) REFERENCES user_details(id) -- Foreign key constraint
);

CREATE TABLE profile_created_by (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the profile creator
    creator_name VARCHAR(255) NOT NULL UNIQUE -- Name of the profile creator (e.g., Self, Parent, Friend)
);

CREATE TABLE looking_for (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the looking for options
    description VARCHAR(255) NOT NULL UNIQUE -- Description of what the user is looking for (e.g., Life Partner, Friendship)
);

CREATE TABLE about_profile (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the about profile details
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    profile_created_by_id INT NOT NULL, -- Foreign key referencing profile_created_by
    looking_for_id INT NOT NULL,     -- Foreign key referencing looking_for
    FOREIGN KEY (user_id) REFERENCES user_details(id), -- Foreign key constraint
    FOREIGN KEY (profile_created_by_id) REFERENCES profile_created_by(id), -- Foreign key constraint
    FOREIGN KEY (looking_for_id) REFERENCES looking_for(id) -- Foreign key constraint
);

