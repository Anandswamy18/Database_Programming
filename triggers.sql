postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# \dt
          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | branch   | table | postgres
 public | course   | table | postgres
 public | emp      | table | postgres
 public | marks    | table | postgres
 public | student  | table | postgres
 public | students | table | postgres
(6 rows)

mydatabase=# CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);
CREATE TABLE
mydatabase=# INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Alice', 'Engineering', 75000.00),
(2, 'Bob', 'HR', 50000.00),
(3, 'Charlie', 'Engineering', 80000.00),
(4, 'David', 'Sales', 60000.00),
(5, 'Eva', 'HR', 55000.00);
INSERT 0 5
mydatabase=# CREATE TABLE IF NOT EXISTS employees_backup (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    archive_date DATE
);
CREATE TABLE
mydatabase=# DELIMITER $$

CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_backup (id, name, department, salary, archive_date)
    VALUES (OLD.id, OLD.name, OLD.department, OLD.salary, CURDATE());
END$$

DELIMITER ;
ERROR:  syntax error at or near "DELIMITER"
LINE 1: DELIMITER $$
        ^
mydatabase=# CREATE OR REPLACE FUNCTION archive_backup^Z 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employees_archive (id, name, department, salary, archive_date)
    VALUES (OLD.id, OLD.name, OLD.department, OLD.salary, CURRENT_DATE);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION archive_employee();

[1]+  Stopped                 psql
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ CREATE OR REPLACE FUNCTION archive_employee() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employees_archive (id, name, department, salary, archive_date)
    VALUES (OLD.id, OLD.name, OLD.department, OLD.salary, CURRENT_DATE);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION archive_employee();
-bash: syntax error near unexpected token `('
RETURNS: command not found
BEGIN: command not found
-bash: syntax error near unexpected token `('
-bash: syntax error near unexpected token `OLD.id,'
RETURN: command not found
END: command not found
3400: command not found
CREATE: command not found
BEFORE: command not found
FOR: command not found
-bash: syntax error near unexpected token `('
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ drop table employees_backup Command 'drop' not found, did you mean:
  command 'krop' from snap krop (0.6.0)
  command 'grop' from deb grop (2:0.10-1.2)
  command 'krop' from deb krop (0.6.0-2ubuntu1)
  command 'dtop' from deb diod (1.0.24-5.1)
See 'snap info <snapname>' for additional versions.
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ DROP TABLE IF EXISTS employees_backup; 
DROP: command not found                        
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ \c mydatabase
c: command not found
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# DROP TABLE IF EXISTS employees_backup;
DROP TABLE
mydatabase=# select * from employees;
 id |  name   | department  |  salary  
----+---------+-------------+----------
  1 | Alice   | Engineering | 75000.00
  2 | Bob     | HR          | 50000.00
  3 | Charlie | Engineering | 80000.00
  4 | David   | Sales       | 60000.00
  5 | Eva     | HR          | 55000.00
(5 rows)

mydatabase=# REATE TABLE IF NOT EXISTS employees_backup (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    archive_date DATE
);
ERROR:  syntax error at or near "REATE"
LINE 1: REATE TABLE IF NOT EXISTS employees_backup (
        ^
mydatabase=# CREATE TABLE IF NOT EXISTS employees_backup (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    archive_date DATE
);
CREATE TABLE
mydatabase=# CREATE OR REPLACE FUNCTION archive_employee() RETURNS trigger AS $$ 
BEGIN
    INSERT INTO employees_backup (id, name, department, salary, archive_date)
    VALUES (OLD.id, OLD.name, OLD.department, OLD.salary, CURRENT_DATE);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION archive_employee();
CREATE TRIGGER
mydatabase=# DELETE FROM employees WHERE id = 3;
DELETE 1
mydatabase=# select * from employees_backup;
 id |  name   | department  |  salary  | archive_date 
----+---------+-------------+----------+--------------
  3 | Charlie | Engineering | 80000.00 | 2024-06-03
(1 row)

