anand@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ sudo -i -u postgres
[sudo] password for anand: 
Sorry, try again.
[sudo] password for anand: 
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# \c mydatabase
You are now connected to database "mydatabase" as user "postgres".
mydatabase=# select from students
mydatabase-# select * from students;
ERROR:  syntax error at or near "select"
LINE 2: select * from students;
        ^
mydatabase=# \d
                   List of relations
 Schema |          Name           |   Type   |  Owner   
--------+-------------------------+----------+----------
 public | branch                  | table    | postgres
 public | branch_branch_id_seq    | sequence | postgres
 public | course                  | table    | postgres
 public | course_enrollment_view  | view     | postgres
 public | marks                   | table    | postgres
 public | marks_mark_id_seq       | sequence | postgres
 public | student                 | table    | postgres
 public | student_grade_report    | view     | postgres
 public | students                | table    | postgres
 public | students_student_id_seq | sequence | postgres
(10 rows)

mydatabase=# \t
Tuples only is on.
mydatabase=# \dt 
 public | branch   | table | postgres
 public | course   | table | postgres
 public | marks    | table | postgres
 public | student  | table | postgres
 public | students | table | postgres

mydatabase=# select * from students;
          1 | John       | Doe       | 1998-09-20    | john.doe@example.com       |       101
          2 | Jane       | Smith     | 2000-03-12    | jane.smith@example.com     |       102
          3 | Alice      | Johnson   | 1999-07-05    | alice.johnson@example.com  |          
          4 | Bob        | Williams  | 2001-11-30    | bob.williams@example.com   |       103
          5 | Emily      | Brown     | 1998-05-15    | emily.brown@example.com    |       102
          6 | Michael    | Davis     | 2002-02-18    | michael.davis@example.com  |       102
          7 | Sarah      | Martinez  | 2003-08-10    | sarah.martinez@example.com |       103
          8 | David      | Anderson  | 1997-12-25    | david.anderson@example.com |       101
          9 | Emma       | Garcia    | 2000-04-03    | emma.garcia@example.com    |       103

mydatabase=# select * from marks;
      17 |          3 |       102 |    72 | B
      18 |          5 |       103 |    11 | F
      19 |          7 |       101 |    55 | C
      20 |          8 |       103 |    35 | D
      21 |          9 |       101 |    33 | D
      22 |          1 |       101 |    87 | A
      23 |          2 |       101 |    87 | A

mydatabase=# select * from course;
       101 | Mathematics    | Dr. Smith              |       5
       102 | Rocket Science | Dr. A.P.J.Abdual Kalam |       5
       103 | PHYSICS        | Dr. Newton             |       5

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM marks
    WHERE course_id = 101
);
 John       | Doe
 Jane       | Smith
 Sarah      | Martinez
 Emma       | Garcia

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM marks
    WHERE course_id = 101
);
 John       | Doe
 Jane       | Smith
 Sarah      | Martinez
 Emma       | Garcia

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id NOT IN (
    SELECT student_id
    FROM marks
    WHERE grade = 'F'
);
 John       | Doe
 Jane       | Smith
 Alice      | Johnson
 Bob        | Williams
 Michael    | Davis
 Sarah      | Martinez
 David      | Anderson
 Emma       | Garcia

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id  IN (
    SELECT student_id
    FROM marks
    WHERE grade = 'F'
);
 Emily      | Brown

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id  IN (
    SELECT student_id
    FROM marks
    WHERE grade = 'A'
);
 John       | Doe
 Jane       | Smith

mydatabase=# \d 
 public | branch                  | table    | postgres
 public | branch_branch_id_seq    | sequence | postgres
 public | course                  | table    | postgres
 public | course_enrollment_view  | view     | postgres
 public | marks                   | table    | postgres
 public | marks_mark_id_seq       | sequence | postgres
 public | student                 | table    | postgres
 public | student_grade_report    | view     | postgres
 public | students                | table    | postgres
 public | students_student_id_seq | sequence | postgres

mydatabase=# \d marks
 mark_id    | integer              |           | not null | nextval('marks_mark_id_seq'::regclass)
 student_id | integer              |           |          | 
 course_id  | integer              |           |          | 
 marks      | integer              |           |          | 
 grade      | character varying(2) |           |          | 

mydatabase=# SELECT first_name, last_name
FROM students
WHERE student_id  IN (
    SELECT student_id
    FROM marks
    WHERE marks = 35 
);
 David      | Anderson

