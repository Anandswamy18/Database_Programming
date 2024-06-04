sudo] password for anand: 
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# -- Incorrect SQL syntax
SELECT * FROM employees  WHERE id = 1
mydatabase-# \dt
              List of relations
 Schema |       Name       | Type  |  Owner   
--------+------------------+-------+----------
 public | branch           | table | postgres
 public | course           | table | postgres
 public | emp              | table | postgres
 public | employees        | table | postgres
 public | employees_backup | table | postgres
 public | marks            | table | postgres
 public | ref_students     | table | postgres
 public | student          | table | postgres
 public | students         | table | postgres
(9 rows)

mydatabase-# -- Incorrect SQL syntax
SELECT * FROM employees  WHERE id = 1
mydatabase-# select * from employees where id=1
mydatabase-# select * from employees;
ERROR:  syntax error at or near "SELECT"
LINE 4: SELECT * FROM employees  WHERE id = 1
        ^
mydatabase=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# select * from employees;
 id | name  | department  |  salary  
----+-------+-------------+----------
  1 | Alice | Engineering | 75000.00
  2 | Bob   | HR          | 50000.00
  4 | David | Sales       | 60000.00
  5 | Eva   | HR          | 55000.00
(4 rows)

mydatabase=# select * from employees where id=1
mydatabase-# -- Division by zero
SELECT 1 / 0;
ERROR:  syntax error at or near "SELECT"
LINE 3: SELECT 1 / 0;
        ^
mydatabase=# -- Unique constraint violation
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);

INSERT INTO users (email) VALUES ('user@example.com');
INSERT INTO users (email) VALUES ('user@example.com');
CREATE TABLE
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "users_email_key"
DETAIL:  Key (email)=(user@example.com) already exists.
mydatabase=# -- Foreign key violation
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO orders (user_id) VALUES (999); -- Assuming user_id 999 does not exist
CREATE TABLE
ERROR:  insert or update on table "orders" violates foreign key constraint "orders_user_id_fkey"
DETAIL:  Key (user_id)=(999) is not present in table "users".
mydatabase=# -- Not null constraint violation
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO products (name) VALUES (NULL);
CREATE TABLE
ERROR:  null value in column "name" of relation "products" violates not-null constraint
DETAIL:  Failing row contains (1, null).
mydatabase=# -- Accessing a non-existent table
SELECT * FROM non_existent_table;
ERROR:  relation "non_existent_table" does not exist
LINE 1: SELECT * FROM non_existent_table;
                      ^
mydatabase=# DO $$
BEGIN
    BEGIN
        -- Attempt to divide by zero
        PERFORM 1 / 0;
    EXCEPTION
        WHEN division_by_zero THEN
            RAISE NOTICE 'Division by zero error caught!';
    END;
END $$;
NOTICE:  Division by zero error caught!
DO
mydatabase=# CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);

DO $$
BEGIN
    BEGIN
        -- Attempt to insert a duplicate email
        INSERT INTO users (email) VALUES ('user@example.com');
        INSERT INTO users (email) VALUES ('user@example.com');
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'Unique constraint violation caught!';
    END;
END $$;
ERROR:  relation "users" already exists
NOTICE:  Unique constraint violation caught!
DO
mydatabase=# CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DO $$
BEGIN
    BEGIN
        -- Attempt to insert a non-existent user_id
        INSERT INTO orders (user_id) VALUES (999);
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'Foreign key violation caught!';
    END;
END $$;
ERROR:  relation "orders" already exists
NOTICE:  Foreign key violation caught!
DO
mydatabase=# CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

DO $$
BEGIN
    BEGIN
        -- Attempt to insert a null value
        INSERT INTO products (name) VALUES (NULL);
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'Not null constraint violation caught!';
    END;
END $$;
ERROR:  relation "products" already exists
NOTICE:  Not null constraint violation caught!
DO
mydatabase=# CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

DO $$
BEGIN
    BEGIN
        -- Attempt to insert a null value
        INSERT INTO products (name) VALUES (NULL);
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'Not null constraint violation caught!';
    END;
END $$;
ERROR:  relation "products" already exists
NOTICE:  Not null constraint violation caught!
DO
mydatabase=# 

