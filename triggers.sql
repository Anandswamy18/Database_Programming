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

ostgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# CREATE OR REPLACE FUNCTION update()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO table2(id,name,salary)
values (OLD.id,OLD.name,OLD.salary);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# create TRIGGER before_table1_update
BEFORE UPDATE ON table1
FOR EACH ROW
EXECUTE FUNCTION update();
ERROR:  trigger "before_table1_update" for relation "table1" already exists
mydatabase=# create TRIGGER before_table1_update
BEFORE UPDATE ON table1
FOR EACH ROW
EXECUTE FUNCTION update();
ERROR:  trigger "before_table1_update" for relation "table1" already exists
mydatabase=# update table1
SET salary=6000
WHERE id=1;
ERROR:  duplicate key value violates unique constraint "table2_pkey"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  SQL statement "INSERT INTO table2(id,name,salary)
values (OLD.id,OLD.name,OLD.salary)"
PL/pgSQL function update() line 3 at SQL statement
mydatabase=# create TRIGGER before_table1_update
BEFORE UPDATE ON table1
FOR EACH ROW
EXECUTE FUNCTION update();
ERROR:  trigger "before_table1_update" for relation "table1" already exists
mydatabase=# update table1
SET salary=6000
WHERE id=1;
ERROR:  duplicate key value violates unique constraint "table2_pkey"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  SQL statement "INSERT INTO table2(id,name,salary)
values (OLD.id,OLD.name,OLD.salary)"
PL/pgSQL function update() line 3 at SQL statement
mydatabase=# update table1
SET salary=6000
WHERE id=2;
ERROR:  duplicate key value violates unique constraint "table2_pkey"
DETAIL:  Key (id)=(2) already exists.
CONTEXT:  SQL statement "INSERT INTO table2(id,name,salary)
values (OLD.id,OLD.name,OLD.salary)"
PL/pgSQL function update() line 3 at SQL statement
mydatabase=# select * from table1;
 id | name | salary 
----+------+--------
  1 | abc  |   6000
  2 | bca  |  10000
(2 rows)

mydatabase=# select * from table2;
 id | name | salary 
----+------+--------
  1 | abc  |   5000
  2 | bca  |   7000
(2 rows)

mydatabase=# CREATE OR REPLACE FUNCTION copy_to_table2()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO table2 (id, name, salary)
    VALUES (OLD.id, OLD.name, OLD.salary);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# CREATE TRIGGER before_update_table1
BEFORE UPDATE ON table1
FOR EACH ROW
EXECUTE FUNCTION copy_to_table2();
CREATE TRIGGER
mydatabase=# select * from table1;
 id | name | salary 
----+------+--------
  1 | abc  |   6000
  2 | bca  |  10000
(2 rows)

mydatabase=# update table1
SET salary=6000
WHERE id=2;
ERROR:  duplicate key value violates unique constraint "table2_pkey"
DETAIL:  Key (id)=(2) already exists.
CONTEXT:  SQL statement "INSERT INTO table2(id,name,salary)
values (OLD.id,OLD.name,OLD.salary)"
PL/pgSQL function update() line 3 at SQL statement
mydatabase=# DROP TABLE IF EXISTS table2;

CREATE TABLE table2 (
    log_id SERIAL PRIMARY KEY,
    id INT,
    name VARCHAR(50),
    salary NUMERIC(10, 2)
);
DROP TABLE
CREATE TABLE
mydatabase=# update table1
SET salary=6000
WHERE id=2;
UPDATE 1
mydatabase=# select * from table2;
 log_id | id | name |  salary  
--------+----+------+----------
      1 |  2 | bca  | 10000.00
      2 |  2 | bca  | 10000.00
(2 rows)

mydatabase=# select * from table1;
 id | name | salary 
----+------+--------
  1 | abc  |   6000
  2 | bca  |   6000
(2 rows)

mydatabase=# update table1
SET name='anand'
WHERE id=2;
UPDATE 1
mydatabase=# select * from table2;
 log_id | id | name |  salary  
--------+----+------+----------
      1 |  2 | bca  | 10000.00
      2 |  2 | bca  | 10000.00
      3 |  2 | bca  |  6000.00
      4 |  2 | bca  |  6000.00
(4 rows)

mydatabase=# DELETE FROM table2
WHERE id = 2;
DELETE 4
mydatabase=# select * from table2;
 log_id | id | name | salary 
--------+----+------+--------
(0 rows)

mydatabase=# select * from table1;
 id | name  | salary 
----+-------+--------
  1 | abc   |   6000
  2 | anand |   6000
(2 rows)

mydatabase=# update table1
SET name='ask'
WHERE id=1;
UPDATE 1
mydatabase=# select * from table2;
 log_id | id | name | salary  
--------+----+------+---------
      5 |  1 | abc  | 6000.00
      6 |  1 | abc  | 6000.00
(2 rows)

mydatabase=# DELETE FROM table2
WHERE log_id=6;
DELETE 1
mydatabase=# cerate table table4(id int,name varchar(20),salary)
mydatabase-# ;
ERROR:  syntax error at or near "cerate"
LINE 1: cerate table table4(id int,name varchar(20),salary)
        ^
mydatabase=# create table table4(id int,name varchar(20),salary)
;
ERROR:  syntax error at or near ")"
LINE 1: create table table4(id int,name varchar(20),salary)
                                                          ^
mydatabase=# create table table4(id int,name varchar(20),salary)
;
ERROR:  syntax error at or near ")"
LINE 1: create table table4(id int,name varchar(20),salary)
                                                          ^
mydatabase=# create table table4(id int,name varchar(20),salary int);
;
CREATE TABLE
mydatabase=# create table table5(lod_id serial primary key,id int,name varchar(20),salary int);
CREATE TABLE
mydatabase=# create or replace function copy_to_table5()
mydatabase-# returns trigger as $$
mydatabase$# begin
mydatabase$# insert into table5(id,name,salary)
mydatabase$# values (OLD.id,OLD.name,OLD.salary);
mydatabase$# RETURN NEW;
mydatabase$# END;
mydatabase$# $$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# create trigger before_update-table4
mydatabase-# before update on table4
mydatabase-# for each row execute
mydatabase-# function copy_to_table5();
ERROR:  syntax error at or near "-"
LINE 1: create trigger before_update-table4
                                    ^
mydatabase=# create trigger before_update_table4
before update on table4
for each row execute
function copy_to_table5();
CREATE TRIGGER
mydatabase=# select * from table4;
 id | name | salary 
----+------+--------
(0 rows)

mydatabase=# insert into table4 (id,name,salary)
mydatabase-# values (1,'anand',5000);
INSERT 0 1
mydatabase=# select * from table4;
 id | name  | salary 
----+-------+--------
  1 | anand |   5000
(1 row)

mydatabase=# update table4
mydatabase-# set name='swamy'
mydatabase-# where id=1;
UPDATE 1
mydatabase=# select * from table4;
 id | name  | salary 
----+-------+--------
  1 | swamy |   5000
(1 row)

mydatabase=# select * from table5;
 lod_id | id | name  | salary 
--------+----+-------+--------
      1 |  1 | anand |   5000
(1 row)

mydatabase=# 

