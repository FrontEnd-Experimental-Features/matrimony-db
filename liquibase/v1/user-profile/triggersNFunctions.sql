-- Create the function for generating the profile_id (already shown earlier)
CREATE OR REPLACE FUNCTION generate_profile_id()
RETURNS TRIGGER AS $$
DECLARE
    new_profile_id VARCHAR(7);
BEGIN
    -- Loop until a unique profile_id is generated
    LOOP
        -- Generate profile_id as three letters followed by four digits
        new_profile_id := CONCAT(
            CHR(65 + FLOOR(RANDOM() * 26)::INT),  -- First letter (A-Z)
            CHR(65 + FLOOR(RANDOM() * 26)::INT),  -- Second letter (A-Z)
            CHR(65 + FLOOR(RANDOM() * 26)::INT),  -- Third letter (A-Z)
            LPAD(FLOOR(RANDOM() * 10000)::TEXT, 4, '0')  -- Four digits (0000-9999)
        );
        
        -- Check if the generated profile_id already exists in the table
        IF NOT EXISTS (SELECT 1 FROM user_details WHERE profile_id = new_profile_id) THEN
            -- If the profile_id doesn't exist, set it and exit the loop
            NEW.profile_id := new_profile_id;
            RETURN NEW;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Create the function for generating the user_name
CREATE OR REPLACE FUNCTION generate_user_name()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if middle_name is not null
    IF NEW.middle_name IS NOT NULL THEN
        -- Concatenate first_name, middle_name, and last_name
        NEW.user_name := CONCAT(NEW.first_name, ' ', NEW.middle_name, ' ', NEW.last_name);
    ELSE
        -- If middle_name is null, concatenate only first_name and last_name
        NEW.user_name := CONCAT(NEW.first_name, ' ', NEW.last_name);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for profile_id generation
CREATE TRIGGER trigger_generate_profile_id
BEFORE INSERT ON user_details
FOR EACH ROW EXECUTE FUNCTION generate_profile_id();

-- Create the trigger for user_name generation
CREATE TRIGGER trigger_generate_user_name
BEFORE INSERT ON user_details
FOR EACH ROW EXECUTE FUNCTION generate_user_name();
