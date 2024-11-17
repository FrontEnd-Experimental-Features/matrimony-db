-- Step 1: Alter the table to add the gender column
ALTER TABLE user_details
ADD COLUMN gender VARCHAR(10) NOT NULL DEFAULT 'Male';

-- Step 2: Update existing records to set gender to Male
UPDATE user_details
SET gender = 'Male';