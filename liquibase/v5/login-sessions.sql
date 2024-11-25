-- Create LoginSessions table
CREATE TABLE IF NOT EXISTS login_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    login_time TIMESTAMP NOT NULL,
    logout_time TIMESTAMP,
    session_duration INTEGER, -- Duration in minutes
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
        REFERENCES user_details(id)
        ON DELETE CASCADE
);

-- Create function to calculate session duration in minutes
CREATE OR REPLACE FUNCTION calculate_session_duration()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.logout_time IS NOT NULL AND NEW.login_time IS NOT NULL THEN
        NEW.session_duration = EXTRACT(EPOCH FROM (NEW.logout_time - NEW.login_time))/60;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically calculate session duration
CREATE TRIGGER update_session_duration
    BEFORE INSERT OR UPDATE
    ON login_sessions
    FOR EACH ROW
    EXECUTE FUNCTION calculate_session_duration();

-- Add comments for documentation
COMMENT ON TABLE login_sessions IS 'Stores user login session information';
COMMENT ON COLUMN login_sessions.id IS 'Primary key for the login session';
COMMENT ON COLUMN login_sessions.user_id IS 'Foreign key reference to user_details table';
COMMENT ON COLUMN login_sessions.login_time IS 'Timestamp when user logged in';
COMMENT ON COLUMN login_sessions.logout_time IS 'Timestamp when user logged out (can be null for active sessions)';
COMMENT ON COLUMN login_sessions.session_duration IS 'Session duration in minutes (automatically calculated)';

-- Create index on user_id for faster lookups
CREATE INDEX idx_login_sessions_user_id ON login_sessions(user_id);

-- Create index on login_time for faster queries
CREATE INDEX idx_login_sessions_login_time ON login_sessions(login_time);

-- Create function to handle login session
CREATE OR REPLACE FUNCTION handle_login_session(user_id_param INTEGER)
RETURNS void AS $$
DECLARE
    incomplete_sessions INTEGER;
BEGIN
    -- Check for incomplete sessions
    SELECT COUNT(*) INTO incomplete_sessions
    FROM login_sessions 
    WHERE user_id = user_id_param 
    AND logout_time IS NULL;

    -- Only create new session if no incomplete sessions exist
    IF incomplete_sessions = 0 THEN
        INSERT INTO login_sessions (user_id, login_time)
        VALUES (user_id_param, CURRENT_TIMESTAMP);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Grant necessary permissions
GRANT EXECUTE ON FUNCTION handle_login_session(INTEGER) TO matrimony_user;
GRANT SELECT, INSERT, UPDATE ON TABLE login_sessions TO matrimony_user;

-- Create or replace the authenticate function to include session handling
CREATE OR REPLACE FUNCTION public.authenticate(
    input authenticate_input
)
    RETURNS public.auth_result
    LANGUAGE plpgsql
    VOLATILE
    SECURITY DEFINER
AS $$
DECLARE
    user_details json;
    jwt_token text;
    found_user_id integer;
BEGIN
    -- First get the JWT token and user_id
    SELECT ud.id, generate_jwt(ud.id) INTO found_user_id, jwt_token
    FROM contact_details cd
    JOIN user_credentials uc ON uc.user_id = cd.user_id
    JOIN user_details ud ON ud.id = cd.user_id
    WHERE cd.email = (input).email
    AND uc.password_hash = crypt((input).password, uc.password_hash)
    LIMIT 1;

    -- Then get user details
    SELECT 
        CASE 
            WHEN uc.password_hash = crypt((input).password, uc.password_hash) THEN
                json_build_object(
                    'id', ud.id,
                    'userName', ud.user_name,
                    'dateOfBirth', ud.date_of_birth,
                    'gender', ud.gender,
                    'isVerifiedFlag', ud.is_verified_flag,
                    'jwtToken', jwt_token
                )
            ELSE NULL
        END INTO user_details
    FROM contact_details cd
    JOIN user_credentials uc ON uc.user_id = cd.user_id
    JOIN user_details ud ON ud.id = cd.user_id
    WHERE cd.email = (input).email
    LIMIT 1;

    IF user_details IS NULL THEN
        RAISE EXCEPTION 'Invalid email or password';
    END IF;

    -- Handle login session
    PERFORM handle_login_session(found_user_id);

    RETURN ROW(user_details, NULL::text)::public.auth_result;
END;
$$;