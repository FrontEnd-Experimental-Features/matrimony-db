
CREATE TABLE IF NOT EXISTS user_credentials (
    id SERIAL PRIMARY KEY NOT NULL, -- Unique ID for the credential entry
    user_id INT NOT NULL,            -- Foreign key referencing user_details
    password_hash VARCHAR(255) NOT NULL, -- Hashed password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the credential was created
    FOREIGN KEY (user_id) REFERENCES user_details(id) -- Foreign key constraint
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO user_credentials (user_id, password_hash) VALUES
(1, crypt('test11', gen_salt('bf'))),  -- Hashed password for John Doe
(2, crypt('test22', gen_salt('bf'))), -- Hashed password for Jane Smith
(3, crypt('test33', gen_salt('bf'))), -- Hashed password for Alice Johnson
(4, crypt('test44', gen_salt('bf'))), -- Hashed password for Bob Brown
(5, crypt('test55', gen_salt('bf'))); -- Hashed password for Charlie Davis