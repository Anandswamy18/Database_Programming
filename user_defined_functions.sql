CREATE TABLE ref_students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    grade VARCHAR(10),
    major VARCHAR(100)
);
CREATE TABLE
mydatabase=# ALTER TABLE students
ADD COLUMN marks INT;
ALTER TABLE
mydatabase=# INSERT INTO students (first_name, last_name, age, gender, grade, major, marks) 
VALUES 
('virat', 'kholi', 20, 'Male', 'A', 'Computer Science', 85),
('MS', 'Dhoni', 22, 'Male', 'B', 'Mathematics', 78),
('yuvraj', 'Singh', 21, 'Male', 'B', 'Physics', 90),
('Bhuvi', 'Kumar', 19, 'male', 'A', 'Biology', 92);
ERROR:  column "age" of relation "students" does not exist
LINE 1: INSERT INTO students (first_name, last_name, age, gender, gr...
                                                     ^
mydatabase=# ALTER TABLE ref_students                                                   
ADD COLUMN marks INT;
ALTER TABLE
mydatabase=# INSERT INTO students (first_name, last_name, age, gender, grade, major, marks) 
VALUES 
('virat', 'kholi', 20, 'Male', 'A', 'Computer Science', 85),
('MS', 'Dhoni', 22, 'Male', 'B', 'Mathematics', 78),
('yuvraj', 'Singh', 21, 'Male', 'B', 'Physics', 90),
('Bhuvi', 'Kumar', 19, 'male', 'A', 'Biology', 92);
ERROR:  column "age" of relation "students" does not exist
LINE 1: INSERT INTO students (first_name, last_name, age, gender, gr...
                                                     ^
mydatabase=# INSERT INTO ref_ students (first_name, last_name, age, gender, grade, major, marks) 
VALUES 
('virat', 'kholi', 20, 'Male', 'A', 'Computer Science', 85),
('MS', 'Dhoni', 22, 'Male', 'B', 'Mathematics', 78),
('yuvraj', 'Singh', 21, 'Male', 'B', 'Physics', 90),
('Bhuvi', 'Kumar', 19, 'male', 'A', 'Biology', 92);
ERROR:  syntax error at or near "students"
LINE 1: INSERT INTO ref_ students (first_name, last_name, age, gende...
                         ^
mydatabase=# INSERT INTO ref_students (first_name, last_name, age, gender, grade, major, marks) 
VALUES 
('virat', 'kholi', 20, 'Male', 'A', 'Computer Science', 85),
('MS', 'Dhoni', 22, 'Male', 'B', 'Mathematics', 78),
('yuvraj', 'Singh', 21, 'Male', 'B', 'Physics', 90),
('Bhuvi', 'Kumar', 19, 'male', 'A', 'Biology', 92);
INSERT 0 4
mydatabase=# select * from ref_students;
 student_id | first_name | last_name | age | gender | grade |      major       | marks 
------------+------------+-----------+-----+--------+-------+------------------+-------
          1 | virat      | kholi     |  20 | Male   | A     | Computer Science |    85
          2 | MS         | Dhoni     |  22 | Male   | B     | Mathematics      |    78
          3 | yuvraj     | Singh     |  21 | Male   | B     | Physics          |    90
          4 | Bhuvi      | Kumar     |  19 | male   | A     | Biology          |    92
(4 rows)

mydatabase=# ALTER TABLE students
DROP COLUMN marks;
ALTER TABLE
mydatabase=# select * from students;
 student_id | first_name | last_name | date_of_birth |           email            | course_id 
------------+------------+-----------+---------------+----------------------------+-----------
          1 | John       | Doe       | 1998-09-20    | john.doe@example.com       |       101
          2 | Jane       | Smith     | 2000-03-12    | jane.smith@example.com     |       102
          3 | Alice      | Johnson   | 1999-07-05    | alice.johnson@example.com  |          
          4 | Bob        | Williams  | 2001-11-30    | bob.williams@example.com   |       103
          5 | Emily      | Brown     | 1998-05-15    | emily.brown@example.com    |       102
          6 | Michael    | Davis     | 2002-02-18    | michael.davis@example.com  |       102
          7 | Sarah      | Martinez  | 2003-08-10    | sarah.martinez@example.com |       103
          8 | David      | Anderson  | 1997-12-25    | david.anderson@example.com |       101
          9 | Emma       | Garcia    | 2000-04-03    | emma.garcia@example.com    |       103
(9 rows)

mydatabase=# CREATE OR REPLACE FUNCTION calculate_average_age()
RETURNS FLOAT AS $$
DECLARE
    total_age INT;
    total_students INT;
    avg_age FLOAT;
BEGIN
    SELECT SUM(age), COUNT(*)
    INTO total_age, total_students
    FROM students;

    avg_age := total_age / total_students;
    
    RETURN avg_age;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# SELECT calculate_average_age();
ERROR:  column "age" does not exist
LINE 1: SELECT SUM(age), COUNT(*)
                   ^
QUERY:  SELECT SUM(age), COUNT(*)
                                       FROM students
CONTEXT:  PL/pgSQL function calculate_average_age() line 7 at SQL statement
mydatabase=# DROP FUNCTION IF EXISTS calculate_average_age();
DROP FUNCTION
mydatabase=# CREATE OR REPLACE FUNCTION calculate_average_age()
RETURNS FLOAT AS $$
DECLARE
    total_age INT;
    total_students INT;
    avg_age FLOAT;
BEGIN
    SELECT SUM(age), COUNT(*)
    INTO total_age, total_students
    FROM ref_students;

    avg_age := total_age / total_students;
    
    RETURN avg_age;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# SELECT calculate_average_age();
 calculate_average_age 
-----------------------
                    20
(1 row)

mydatabase=# CREATE OR REPLACE FUNCTION count_male_students()
RETURNS INT AS $$
DECLARE
    male_count INT;
BEGIN
    SELECT COUNT(*)
    INTO male_count
    FROM  ref_students
    WHERE gender = 'Male';

    RETURN male_count;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# select count_male_students();
 count_male_students 
---------------------
                   3
(1 row)

mydatabase=# CREATE OR REPLACE FUNCTION update_student_grade(student_id_param INT, new_grade_param VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE ref_students
    SET grade = new_grade_param
    WHERE student_id = student_id_param;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# SELECT update_student_grade(1, 'B'); -- Update the grade of student with ID 1 to 'B'
 update_student_grade 
----------------------
 
(1 row)

mydatabase=# select * from ref_students;
 student_id | first_name | last_name | age | gender | grade |      major       | marks 
------------+------------+-----------+-----+--------+-------+------------------+-------
          2 | MS         | Dhoni     |  22 | Male   | B     | Mathematics      |    78
          3 | yuvraj     | Singh     |  21 | Male   | B     | Physics          |    90
          4 | Bhuvi      | Kumar     |  19 | male   | A     | Biology          |    92
          1 | virat      | kholi     |  20 | Male   | B     | Computer Science |    85
(4 rows)

mydatabase=# CREATE OR REPLACE FUNCTION update_student_grade(student_id_param INT, new_marks_param INT)
RETURNS VOID AS $$
BEGIN
    UPDATE ref_students
    SET marks = new_marks_param
    WHERE student_id = student_id_param;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mydatabase=# SELECT update_student_grade(1, 100); 
 update_student_grade 
----------------------
 
(1 row)

mydatabase=# select * from ref_students;
 student_id | first_name | last_name | age | gender | grade |      major       | marks 
------------+------------+-----------+-----+--------+-------+------------------+-------
          2 | MS         | Dhoni     |  22 | Male   | B     | Mathematics      |    78
          3 | yuvraj     | Singh     |  21 | Male   | B     | Physics          |    90
          4 | Bhuvi      | Kumar     |  19 | male   | A     | Biology          |    92
          1 | virat      | kholi     |  20 | Male   | B     | Computer Science |   100
(4 rows)

mydatabase=# SELECT update_student_grade(1, 'A'); 
 update_student_grade 
----------------------
 
(1 row)

mydatabase=# select * from ref_students;
 student_id | first_name | last_name | age | gender | grade |      major       | marks 
------------+------------+-----------+-----+--------+-------+------------------+-------
          2 | MS         | Dhoni     |  22 | Male   | B     | Mathematics      |    78
          3 | yuvraj     | Singh     |  21 | Male   | B     | Physics          |    90
          4 | Bhuvi      | Kumar     |  19 | male   | A     | Biology          |    92
          1 | virat      | kholi     |  20 | Male   | A     | Computer Science |   100
(4 rows)

mydatabase=# 

