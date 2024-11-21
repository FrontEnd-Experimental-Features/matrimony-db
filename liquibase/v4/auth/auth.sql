-- Drop existing objects
DROP FUNCTION IF EXISTS public.authenticate CASCADE;
DROP TYPE IF EXISTS public.authenticate_input CASCADE;
DROP TYPE IF EXISTS public.authenticate_input_record CASCADE;
DROP TYPE IF EXISTS public.auth_result CASCADE;

-- Create input types
CREATE TYPE public.authenticate_input_record AS (
    email text,
    password text
);

CREATE TYPE public.authenticate_input AS (
    input public.authenticate_input_record
);

-- Create result type
CREATE TYPE public.auth_result AS (
    auth_result json,  -- Changed to auth_result
    client_mutation_id text
);

-- Create authentication function
CREATE OR REPLACE FUNCTION public.authenticate(
    auth public.authenticate_input
)
    RETURNS public.auth_result
    LANGUAGE sql
    STABLE
    SECURITY DEFINER
AS $$
    SELECT 
        CASE 
            WHEN uc.password_hash = crypt((auth).input.password, uc.password_hash) THEN
                ROW(
                    json_build_object(
                        'id', ud.id,
                        'userName', ud.user_name,
                        'dateOfBirth', ud.date_of_birth,
                        'gender', ud.gender,
                        'isVerifiedFlag', ud.is_verified_flag
                    ),
                    NULL::text
                )::public.auth_result
            ELSE NULL::public.auth_result
        END
    FROM contact_details cd
    JOIN user_credentials uc ON uc.user_id = cd.user_id
    JOIN user_details ud ON ud.id = cd.user_id
    WHERE cd.email = (auth).input.email
    LIMIT 1;
$$;

-- Grant permissions
GRANT EXECUTE ON FUNCTION public.authenticate(public.authenticate_input) TO postgraphile;
GRANT SELECT ON TABLE public.contact_details TO postgraphile;
GRANT SELECT ON TABLE public.user_credentials TO postgraphile;
GRANT SELECT ON TABLE public.user_details TO postgraphile;

COMMIT;