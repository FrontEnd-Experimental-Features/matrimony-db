-- Create a composite type for the authentication result
CREATE TYPE public.auth_result AS (
  user_details json
);

-- Create a type to represent the authentication input
CREATE TYPE public.authenticate_input AS (
  email text,
  password text
);

-- Create the authentication function
CREATE OR REPLACE FUNCTION public.authenticate(
  input public.authenticate_input
) RETURNS public.auth_result AS $$
DECLARE
  result public.auth_result;
  user_id int;
  _password_matches boolean;
BEGIN
  -- First, verify the credentials
  SELECT ud.id, (uc.password_hash = crypt(input.password, uc.password_hash))
  INTO user_id, _password_matches
  FROM public.user_details ud
  JOIN public.contact_details cd ON ud.id = cd.user_id
  JOIN public.user_credentials uc ON ud.id = uc.user_id
  WHERE cd.email = input.email;

  -- If no user found or password doesn't match, raise an error
  IF user_id IS NULL OR NOT _password_matches THEN
    RAISE EXCEPTION 'Invalid email or password';
  END IF;

  -- Get user details
  SELECT json_build_object(
    'id', ud.id,
    'userName', ud.user_name,
    'dateOfBirth', ud.date_of_birth,
    'gender', ud.gender,
    'isVerifiedFlag', ud.is_verified_flag
  )
  INTO result.user_details
  FROM public.user_details ud
  WHERE ud.id = user_id;

  RETURN result;
END;
$$ LANGUAGE plpgsql STRICT SECURITY DEFINER;

-- Comment to explain the function
COMMENT ON FUNCTION public.authenticate(public.authenticate_input) IS 'Authenticates a user and returns their details';

-- Create a dedicated user for postgraphile
CREATE ROLE postgraphile LOGIN PASSWORD 'your_password';

-- Grant usage on the schema
GRANT USAGE ON SCHEMA public TO postgraphile;

-- Grant execute on specific functions
GRANT EXECUTE ON FUNCTION public.authenticate(public.authenticate_input) TO postgraphile;

-- Grant select on necessary tables (if needed)
GRANT SELECT ON TABLE public.user_details TO postgraphile;
