
-- Create input type for logout
CREATE TYPE public.logout_input AS (
    user_id integer,
    logout boolean
);

-- Create result type for logout
CREATE TYPE public.logout_result AS (
    success boolean,
    logout_time timestamp,
    client_mutation_id text
);

/**
 * @name logout
 * @type mutation
 * @procedure
 */
CREATE OR REPLACE FUNCTION public.logout(
    input logout_input
)
    RETURNS public.logout_result
    LANGUAGE plpgsql
    VOLATILE
    SECURITY DEFINER
AS $$
DECLARE
    logout_timestamp timestamp;
BEGIN
    -- Update the most recent incomplete session
    UPDATE login_sessions 
    SET logout_time = CURRENT_TIMESTAMP
    WHERE user_id = (input).user_id 
    AND logout_time IS NULL
    AND id = (
        SELECT id 
        FROM login_sessions 
        WHERE user_id = (input).user_id 
        AND logout_time IS NULL 
        ORDER BY login_time DESC 
        LIMIT 1
    )
    RETURNING logout_time INTO logout_timestamp;

    -- Return the result
    RETURN ROW(
        CASE WHEN logout_timestamp IS NOT NULL THEN true ELSE false END,
        logout_timestamp,
        NULL::text
    )::public.logout_result;
END;
$$;

-- Grant necessary permissions
GRANT EXECUTE ON FUNCTION public.logout(logout_input) TO matrimony_user;

-- Add comments for PostGraphile
COMMENT ON TYPE public.logout_input IS E'@graphql({"name": "LogoutInput", "description": "Input for logout"})';
COMMENT ON TYPE public.logout_result IS E'@graphql({"name": "LogoutPayload", "description": "Result from logout"})';
COMMENT ON FUNCTION public.logout IS E'@graphql({"name": "logout", "description": "Logs out a user and records the logout time", "type": "mutation"})
Logs out a user by recording the logout time in their active session.
@arg input The logout input containing user_id and logout flag
@resultFieldName success';