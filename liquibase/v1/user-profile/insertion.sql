INSERT INTO family_type (type_name) VALUES
('Nuclear Family'),
('Joint Family'),
('Single Parent Family'),
('Extended Family'),
('Blended Family');

INSERT INTO occupation (occupation_name) VALUES
('Business'),
('Teacher'),
('Engineer'),
('Doctor'),
('Homemaker'),
('Artist'),
('Software Developer'),
('Nurse'),
('Accountant'),
('Chef'),
('Lawyer'),
('Scientist'),
('Marketing Specialist'),
('Sales Executive'),
('Data Analyst'),
('Architect'),
('Electrician'),
('Plumber'),
('Mechanic'),
('Graphic Designer'),
('Web Developer'),
('Pharmacist'),
('Veterinarian'),
('Financial Analyst'),
('Project Manager'),
('Human Resources Manager'),
('Real Estate Agent'),
('Social Worker'),
('Researcher'),
('Content Writer'),
('Photographer'),
('Others');


INSERT INTO education (education_level, full_form) VALUES
('B.Tech', 'Bachelor of Technology'),                -- Bachelor of Technology
('M.Tech', 'Master of Technology'),                  -- Master of Technology
('B.Sc', 'Bachelor of Science'),                     -- Bachelor of Science
('M.Sc', 'Master of Science'),                       -- Master of Science
('MBA', 'Master of Business Administration'),        -- Master of Business Administration
('Ph.D', 'Doctor of Philosophy'),                   -- Doctor of Philosophy
('Diploma', 'Diploma in a specific field'),         -- Diploma in a specific field
('High School', 'High School Diploma'),              -- High School Diploma
('Associate Degree', 'Associate Degree'),            -- Associate Degree
('Certificate Course', 'Certificate Course'),        -- Certificate in a specific skill or subject
('Vocational Training', 'Vocational Training'),      -- Vocational Training
('GED', 'General Educational Development'),          -- General Educational Development
('B.A.', 'Bachelor of Arts'),                         -- Bachelor of Arts
('M.A.', 'Master of Arts'),                           -- Master of Arts
('B.Com', 'Bachelor of Commerce'),                    -- Bachelor of Commerce
('M.Com', 'Master of Commerce'),                      -- Master of Commerce
('LLB', 'Bachelor of Laws'),                          -- Bachelor of Laws
('LLM', 'Master of Laws'),                            -- Master of Laws
('D.Ed', 'Diploma in Education'),                     -- Diploma in Education
('BBA', 'Bachelor of Business Administration'),       -- Bachelor of Business Administration
('MCA', 'Master of Computer Applications'),           -- Master of Computer Applications
('Others', 'Others');                                 -- Option for unspecified education levels


INSERT INTO profession (profession_name, description) VALUES
('Software Engineer', 'Develops software applications and systems'),
('Doctor', 'Medical professional who diagnoses and treats patients'),
('Teacher', 'Educates students in schools or other institutions'),
('Lawyer', 'Legal professional who provides legal advice and representation'),
('Accountant', 'Manages financial records and transactions'),
('Architect', 'Designs buildings and structures'),
('Chef', 'Professional cook who prepares and manages kitchen operations'),
('Nurse', 'Healthcare professional who provides patient care'),
('Business Analyst', 'Analyzes business processes and recommends improvements'),
('Dentist', 'Healthcare professional specializing in oral health'),
('Civil Engineer', 'Designs and oversees construction projects'),
('Pharmacist', 'Dispenses medication and provides healthcare advice'),
('Pilot', 'Operates aircraft for commercial or private flights'),
('Veterinarian', 'Medical professional who treats animals'),
('Graphic Designer', 'Creates visual content for various media'),
('Financial Advisor', 'Provides guidance on financial investments and planning'),
('Professor', 'Teaches at college or university level'),
('Psychologist', 'Studies and treats mental health and behavior'),
('Marketing Manager', 'Develops and implements marketing strategies'),
('Police Officer', 'Maintains law and order and protects citizens'),
('Journalist', 'Researches and reports news stories'),
('Interior Designer', 'Plans and designs interior spaces'),
('Data Scientist', 'Analyzes complex data sets to find patterns'),
('Physical Therapist', 'Helps patients recover physical abilities'),
('Human Resources Manager', 'Manages employee relations and recruitment'),
('Others', 'Others');

INSERT INTO profile_created_by (creator_name) VALUES
('Self'),
('Parent'),
('Friend'),
('Sibling'),
('Relative'),
('Guardian');

INSERT INTO looking_for (description) VALUES
('Life Partner'),
('Friendship'),
('Companionship'),
('Marriage'),
('Casual Dating'),
('Networking');


INSERT INTO user_details (date_of_birth, first_name, middle_name, last_name,gender, is_verified_flag) VALUES 
    ('1990-01-01', 'John', 'Middle', 'Doe', 'Male', true),
    ('1985-06-15', 'Jane', 'Ann', 'Smith', 'Female', false),
    ('2000-09-30', 'Bob', 'Robert', 'Jones', 'Male', true),
    ('1992-04-10', 'Alice', 'Marie', 'Taylor', 'Female', false),
    ('1988-12-22', 'Charlie', 'Lee', 'Brown', 'Male', true);


INSERT INTO contact_details (user_id, phone, email, current_location) VALUES
(1, '+91 98765 43210', 'john.doe@example.com', 'Mumbai, India'),
(2, '+91 98765 12345', 'jane.smith@example.com', 'Delhi, India'),
(3, '+91 98765 67890', 'alice.johnson@example.com', 'Bangalore, India'),
(4, '+91 98765 54321', 'bob.brown@example.com', 'Chennai, India'),
(5, '+91 98765 09876', 'charlie.davis@example.com', 'Hyderabad, India');

INSERT INTO family_details (user_id, family_type_id, family_status, father_occupation_id, mother_occupation_id, number_of_siblings) VALUES
(1, 1, 'Middle Class', 1, 5, 2),    -- Nuclear Family, Business father, Homemaker mother
(2, 2, 'Upper Class', 3, 2, 1),     -- Joint Family, Engineer father, Teacher mother
(3, 1, 'Middle Class', 4, 8, 2),    -- Nuclear Family, Doctor father, Nurse mother
(4, 3, 'Upper Middle Class', 11, 5, 0),  -- Single Parent Family, Lawyer father, Homemaker mother
(5, 2, 'Middle Class', 1, 13, 3);    -- Joint Family, Business father, Marketing Specialist mother

INSERT INTO career_education_details (user_id, education_id, college, profession_id, company, annual_income) VALUES
(1, 1, 'IIT Mumbai', 1, 'Tech Corp', '15-20 LPA'),           -- B.Tech, Software Engineer
(2, 5, 'IIM Bangalore', 19, 'Brand Co', '20-25 LPA'),        -- MBA, Marketing Manager
(3, 4, 'Stanford University', 23, 'Data Inc', '18-22 LPA'),  -- M.Sc, Data Scientist
(4, 2, 'Harvard University', 2, 'HealthCare Ltd', '25-30 LPA'), -- M.Tech, Doctor
(5, 11, 'MIT', 11, 'Engineering Solutions', '12-18 LPA');     -- Civil Engineer

INSERT INTO hobbies_interests_details (user_id, hobbies, interests, sports, music) VALUES
(1, 'Reading, Traveling', 'Technology, Photography', 'Cricket, Badminton', 'Classical, Rock'),
(2, 'Cooking, Gardening', 'Art, Music', 'Football, Tennis', 'Pop, Jazz'),
(3, 'Hiking, Painting', 'Science, Literature', 'Basketball, Volleyball', 'Hip Hop, Classical'),
(4, 'Writing, Traveling', 'History, Culture', 'Rugby, Swimming', 'Rock, Country'),
(5, 'Photography, Music', 'Nature, Technology', 'Baseball, Cricket', 'Electronic, Jazz');

INSERT INTO about_profile (user_id, profile_created_by_id, looking_for_id) VALUES
(1, 1, 1),  -- User ID 1, created by Self, looking for Life Partner
(2, 2, 2),  -- User ID 2, created by Parent, looking for Friendship
(3, 1, 1),  -- User ID 3, created by Self, looking for Life Partner
(4, 3, 3),  -- User ID 4, created by Friend, looking for Companionship
(5, 1, 4);  -- User ID 5, created by Self, looking for Marriage