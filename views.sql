mydatabase=# CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    course_id INTEGER
);
CREATE TABLE
mydatabase=# INSERT INTO students (first_name, last_name, date_of_birth, email, course_id)
VALUES                            
    ('John', 'Doe', '1998-09-20', 'john.doe@example.com', 101),
    ('Jane', 'Smith', '2000-03-12', 'jane.smith@example.com', 102),
    ('Alice', 'Johnson', '1999-07-05', 'alice.johnson@example.com', NULL),
    ('Bob', 'Williams', '2001-11-30', 'bob.williams@example.com', 103),
    ('Emily', 'Brown', '1998-05-15', 'emily.brown@example.com', 102),
    ('Michael', 'Davis', '2002-02-18', 'michael.davis@example.com', 102),
    ('Sarah', 'Martinez', '2003-08-10', 'sarah.martinez@example.com', 103),
    ('David', 'Anderson', '1997-12-25', 'david.anderson@example.com', 101),
    ('Emma', 'Garcia', '2000-04-03', 'emma.garcia@example.com', 103);
INSERT 0 9
mydatabase=# CREATE TABLE course (
    course_id INTEGER PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100),
    credits INTEGER
);
CREATE TABLE
mydatabase=# INSERT INTO course (course_id, course_name, instructor, credits)
VALUES
    (101, 'Mathematics', 'Dr. Smith', 5),
    (102, 'Rocket Science', 'Dr. A.P.J.Abdual Kalam', 5),
    (103, 'PHYSICS', 'Dr. Newton', 5);
INSERT 0 3
mydatabase=# CREATE VIEW course_enrollment_view AS
SELECT s.student_id, s.first_name, s.last_name, s.date_of_birth, s.email, c.course_name, c.instructor
FROM students s
LEFT JOIN course c ON s.course_id = c.course_id;
CREATE VIEW
mydatabase=# SELECT * FROM course_enrollment_view;
 student_id | first_name | last_name | date_of_birth |           email            |  course_name   |       instructor       
------------+------------+-----------+---------------+----------------------------+----------------+------------------------
          1 | John       | Doe       | 1998-09-20    | john.doe@example.com       | Mathematics    | Dr. Smith
          2 | Jane       | Smith     | 2000-03-12    | jane.smith@example.com     | Rocket Science | Dr. A.P.J.Abdual Kalam
          3 | Alice      | Johnson   | 1999-07-05    | alice.johnson@example.com  |                | 
          4 | Bob        | Williams  | 2001-11-30    | bob.williams@example.com   | PHYSICS        | Dr. Newton
          5 | Emily      | Brown     | 1998-05-15    | emily.brown@example.com    | Rocket Science | Dr. A.P.J.Abdual Kalam
          6 | Michael    | Davis     | 2002-02-18    | michael.davis@example.com  | Rocket Science | Dr. A.P.J.Abdual Kalam
          7 | Sarah      | Martinez  | 2003-08-10    | sarah.martinez@example.com | PHYSICS        | Dr. Newton
          8 | David      | Anderson  | 1997-12-25    | david.anderson@example.com | Mathematics    | Dr. Smith
          9 | Emma       | Garcia    | 2000-04-03    | emma.garcia@example.com    | PHYSICS        | Dr. Newton
(9 rows)

mydatabase=# -- Create the marks table
CREATE TABLE marks (
    mark_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES course(course_id),
    marks INTEGER,
    grade VARCHAR(2)
);

-- Insert values into the marks table
INSERT INTO marks (student_id, course_id, marks, grade) VALUES
    (3, 102, 72, 'B'),
    (5, 103, 11, 'F'),
    (7, 101, 55, 'C'),
    (8, 103, 35, 'D'),
    (9, 101, 33, 'D'),
    (10, 101, 57, 'C'),
    (1, 101, 87, 'A'),
   
CREATE TABLE
mydatabase-# select * from marks;
ERROR:  syntax error at or near "select"
LINE 11: select * from marks;
         ^
mydatabase=# -- Create the marks table
CREATE TABLE marks (
    mark_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES course(course_id),
    marks INTEGER,
    grade VARCHAR(2)
);
ERROR:  relation "marks" already exists
mydatabase=# select * from marks;
 mark_id | student_id | course_id | marks | grade 
---------+------------+-----------+-------+-------
(0 rows)

mydatabase=# INSERT INTO marks (student_id, course_id, marks, grade) VALUES
    (3, 102, 72, 'B'),
    (5, 103, 11, 'F'),
    (7, 101, 55, 'C'),
    (8, 103, 35, 'D'),
    (9, 101, 33, 'D'),
    (10, 101, 57, 'C'),
    (1, 101, 87, 'A'),
    (2, 101, 87, 'A');
ERROR:  insert or update on table "marks" violates foreign key constraint "marks_student_id_fkey"
DETAIL:  Key (student_id)=(10) is not present in table "students".
mydatabase=# INSERT INTO marks (student_id, course_id, marks, grade) VALUES
    (3, 102, 72, 'B'),
    (5, 103, 11, 'F'),
    (7, 101, 55, 'C'),
    (8, 103, 35, 'D'),
    (9, 101, 33, 'D'),
    (10, 101, 57, 'C'),
    (1, 101, 87, 'A'),
    (2, 101, 87, 'A');
ERROR:  insert or update on table "marks" violates foreign key constraint "marks_student_id_fkey"
DETAIL:  Key (student_id)=(10) is not present in table "students".
mydatabase=# INSERT INTO marks (student_id, course_id, marks, grade) VALUES
    (3, 102, 72, 'B'),
    (5, 103, 11, 'F'),
    (7, 101, 55, 'C'),
    (8, 103, 35, 'D'),
    (9, 101, 33, 'D'),
    (1, 101, 87, 'A'),
    (2, 101, 87, 'A');
INSERT 0 7
mydatabase=# CREATE VIEW student_grade_report AS
SELECT s.first_name, s.last_name, c.course_name, m.marks, m.grade
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN course c ON m.course_id = c.course_id;
CREATE VIEW
mydatabase=# SELECT * FROM course_enrollment_vstudent_grade_report^Zw;

[1]+  Stopped                 psql
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ SELECT * FROM student_grade_report;
SELECT: command not found
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ select * from student_grade_report;
-bash: syntax error near unexpected token `from'
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ SELECT * FROM student_grade_report;
SELECT: command not found
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ \c mydatabase
c: command not found
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase 
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# SELECT * FROM student_grade_report;
 first_name | last_name |  course_name   | marks | grade 
------------+-----------+----------------+-------+-------
 Alice      | Johnson   | Rocket Science |    72 | B
 Emily      | Brown     | PHYSICS        |    11 | F
 Sarah      | Martinez  | Mathematics    |    55 | C
 David      | Anderson  | PHYSICS        |    35 | D
 Emma       | Garcia    | Mathematics    |    33 | D
 John       | Doe       | Mathematics    |    87 | A
 Jane       | Smith     | Mathematics    |    87 | A
(7 rows)

mydatabase=# 
