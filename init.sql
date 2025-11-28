CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  email VARCHAR(30)
);

INSERT INTO users (name, email) VALUES
    ('Hector', 'hector@gmail.com'),
    ('Eduardo', 'eduardo@gmail.com'),
    ('Keyla', 'keyla@gmail.com');