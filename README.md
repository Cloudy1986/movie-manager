# Movie Manager

## Set up database instructions

Set up the `movie_manager` development database and `movies` table:

1. Connect to `psql`
2. Create the database using the `psql` command `CREATE DATABASE movie_manager;`
3. Connect to the database using the `psql` command `/c movie_manager;`
4. Run the query `CREATE TABLE movies (id SERIAL PRIMARY KEY, title VARCHAR(100));`
5. Run the query `CREATE TABLE comments (id SERIAL PRIMARY KEY, text VARCHAR(200), movie_id INTEGER REFERENCES movies (id));`
6. Run the query `CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));`
7. Run the query `ALTER TABLE movies ADD COLUMN user_id INTEGER REFERENCES users (id);`

Set up the `movie_manager_test` test database and `movies` table:

1. Connect to `psql`
2. Create the database using the `psql` command `CREATE DATABASE movie_manager_test;`
3. Connect to the database using the `psql` command `/c movie_manager_test;`
4. Run the query `CREATE TABLE movies (id SERIAL PRIMARY KEY, title VARCHAR(100));`
5. Run the query `CREATE TABLE comments (id SERIAL PRIMARY KEY, text VARCHAR(200), movie_id INTEGER REFERENCES movies (id));`
6. Run the query `CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));`
7. Run the query `ALTER TABLE movies ADD COLUMN user_id INTEGER REFERENCES users (id);`
