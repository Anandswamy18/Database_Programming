anand@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ sudo -i -u postgres
[sudo] password for anand: 
postgres@anand-VivoBook-ASUSLaptop-X515EA-X515EA:~$ psql
psql (16.3 (Ubuntu 16.3-1.pgdg24.04+1))
Type "help" for help.

postgres=# psql -U username
postgres-# \l
postgres-# \c mydatabase   
You are now connected to database "mydatabase" as user "postgres".
mydatabase-# \dt
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | branch  | table | postgres
 public | student | table | postgres
(2 rows)

mydatabase-# \dt student 
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | student | table | postgres
(1 row)

mydatabase-# select * from student;
ERROR:  syntax error at or near "psql"
LINE 1: psql -U username
        ^
mydatabase=# select *
mydatabase-# from student;
 student_id | student_name | student_class | student_division 
------------+--------------+---------------+------------------
          1 | Revi         | 10th          | A
          2 | Suresh       | 11th          | B
          3 | Ramesh       | 12th          | C
(3 rows)

mydatabase=# selcect * 
mydatabase-# from branch;
ERROR:  syntax error at or near "selcect"
LINE 1: selcect * 
        ^
mydatabase=# select *
from branch;
 branch_id | branch_name | student_id 
-----------+-------------+------------
         1 | Science     |          1
         2 | Arts        |          2
         3 | Commerce    |          3
(3 rows)

mydatabase=# ^C
mydatabase=# INSERT INTO branch (branch_name, student_id) VALUES
('english', 4),
('social', 5),
('maths', 6);
ERROR:  insert or update on table "branch" violates foreign key constraint "branch_student_id_fkey"
DETAIL:  Key (student_id)=(4) is not present in table "student".
mydatabase=# INSERT INTO branch (branch_name, student_id) VALUES
('English', 1),  -- Student Revi belongs to English branch
('Social', 2),   -- Student Suresh belongs to Social branch
('Maths', 3);    -- Student Ramesh belongs to Maths branch
INSERT 0 3
mydatabase=# select *                                           
from branch;                                           
 branch_id | branch_name | student_id 
-----------+-------------+------------
         1 | Science     |          1
         2 | Arts        |          2
         3 | Commerce    |          3
         7 | English     |          1
         8 | Social      |          2
         9 | Maths       |          3
(6 rows)

mydatabase=# DELETE FROM branch WHERE branch_name IN ('English', 'Social', 'Maths');
DELETE 3
mydatabase=# select *                                                           from branch;
 branch_id | branch_name | student_id 
-----------+-------------+------------
         1 | Science     |          1
         2 | Arts        |          2
         3 | Commerce    |          3
(3 rows)

mydatabase=# INSERT INTO student (student_name, student_class, student_division) VALUES
('ask', '9th', 'D'),
('sabri', '10th', 'A');
ERROR:  null value in column "student_id" of relation "student" violates not-null constraint
DETAIL:  Failing row contains (null, ask, 9th, D).
mydatabase=# select * 
mydatabase-# from student
mydatabase-# left outer join branch
mydatabase-# on stu

mydatabase-# on student.student_id=branch_id=branch_id;
ERROR:  syntax error at or near "="
LINE 4: on student.student_id=branch_id=branch_id;
                                       ^
mydatabase=# select * 
from student
left outer join branch
on student.student_id=branch_id.branch_id;
ERROR:  missing FROM-clause entry for table "branch_id"
LINE 4: on student.student_id=branch_id.branch_id;
                              ^
mydatabase=# select * 
from student
left outer join branch
on student.student_id=branch_id.branch_id;
ERROR:  missing FROM-clause entry for table "branch_id"
LINE 4: on student.student_id=branch_id.branch_id;
                              ^
mydatabase=# select *
mydatabase-# from branch;
 branch_id | branch_name | student_id 
-----------+-------------+------------
         1 | Science     |          1
         2 | Arts        |          2
         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
LEFT OUTER JOIN branch ON student.student_id = branch.student_id;
mydatabase=# SELECT *
FROM student
LEFT OUTER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
RIGHT OUTER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
FULL OUTER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
CROSS JOIN branch;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         1 | Science     |          1
          3 | Ramesh       | 12th          | C                |         1 | Science     |          1
          1 | Revi         | 10th          | A                |         2 | Arts        |          2
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         2 | Arts        |          2
          1 | Revi         | 10th          | A                |         3 | Commerce    |          3
          2 | Suresh       | 11th          | B                |         3 | Commerce    |          3
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(9 rows)

mydatabase=# ^C
mydatabase=# INSERT INTO student (student_name, student_class, student_division) VALUES
('Emma', '9th', 'D'),
('Michael', '11th', 'A');
ERROR:  null value in column "student_id" of relation "student" violates not-null constraint
DETAIL:  Failing row contains (null, Emma, 9th, D).
mydatabase=# INSERT INTO student (student_name, student_class, student_division) VALUES
('Emma', '9th', 'D'),
('Michael', '11th', 'A');
ERROR:  null value in column "student_id" of relation "student" violates not-null constraint
DETAIL:  Failing row contains (null, Emma, 9th, D).
mydatabase=# INSERT INTO student (student_id, student_name, student_class, student_division) VALUES
(4, 'Emma', '9th', 'D'),
(5, 'Michael', '11th', 'A');
INSERT 0 2
mydatabase=# INSERT INTO branch (branch_name) VALUES
('Mathematics'),
('Biology');
INSERT 0 2
mydatabase=#  SELECT *
FROM student
RIGHT OUTER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
            |              |               |                  |        10 | Mathematics |           
            |              |               |                  |        11 | Biology     |           
(5 rows)

mydatabase=# select 8
mydatabase-# 
mydatabase-# ;
 ?column? 
----------
        8
(1 row)

mydatabase=# select *
mydatabase-# from student 
mydatabase-# left outer join branch
mydatabase-# on student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
          5 | Michael      | 11th          | A                |           |             |           
          4 | Emma         | 9th           | D                |           |             |           
(5 rows)

mydatabase=# select *
from student 
right outer join branch
on student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
            |              |               |                  |        10 | Mathematics |           
            |              |               |                  |        11 | Biology     |           
(5 rows)

mydatabase=# select *
from student 
right outer join branch
on student.student_id = branch.branch_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
            |              |               |                  |        10 | Mathematics |           
            |              |               |                  |        11 | Biology     |           
(5 rows)

mydatabase=# select *
from student 
full outer join branch
on student.student_id = branch.branch_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
            |              |               |                  |        10 | Mathematics |           
            |              |               |                  |        11 | Biology     |           
          5 | Michael      | 11th          | A                |           |             |           
          4 | Emma         | 9th           | D                |           |             |           
(7 rows)

mydatabase=# select 8
;
 ?column? 
----------
        8
(1 row)

mydatabase=# SELECT *
FROM student
CROSS JOIN branch;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         1 | Science     |          1
          3 | Ramesh       | 12th          | C                |         1 | Science     |          1
          4 | Emma         | 9th           | D                |         1 | Science     |          1
          5 | Michael      | 11th          | A                |         1 | Science     |          1
          1 | Revi         | 10th          | A                |         2 | Arts        |          2
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         2 | Arts        |          2
          4 | Emma         | 9th           | D                |         2 | Arts        |          2
          5 | Michael      | 11th          | A                |         2 | Arts        |          2
          1 | Revi         | 10th          | A                |         3 | Commerce    |          3
          2 | Suresh       | 11th          | B                |         3 | Commerce    |          3
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
          4 | Emma         | 9th           | D                |         3 | Commerce    |          3
          5 | Michael      | 11th          | A                |         3 | Commerce    |          3
          1 | Revi         | 10th          | A                |        10 | Mathematics |           
          2 | Suresh       | 11th          | B                |        10 | Mathematics |           
          3 | Ramesh       | 12th          | C                |        10 | Mathematics |           
          4 | Emma         | 9th           | D                |        10 | Mathematics |           
          5 | Michael      | 11th          | A                |        10 | Mathematics |           
          1 | Revi         | 10th          | A                |        11 | Biology     |           
          2 | Suresh       | 11th          | B                |        11 | Biology     |           
          3 | Ramesh       | 12th          | C                |        11 | Biology     |           
          4 | Emma         | 9th           | D                |        11 | Biology     |           
          5 | Michael      | 11th          | A                |        11 | Biology     |           
(25 rows)

mydatabase=# SELECT *
FROM student
INNER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
INNER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
INNER JOIN branch ON student.student_id = branch.student_id;
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
          2 | Suresh       | 11th          | B                |         2 | Arts        |          2
          3 | Ramesh       | 12th          | C                |         3 | Commerce    |          3
(3 rows)

mydatabase=# SELECT *
FROM student
where student_name='Revi'
mydatabase-#         
INNER JOIN branch ON student.student_id = branch.student_id;
ERROR:  syntax error at or near "INNER"
LINE 5: INNER JOIN branch ON student.student_id = branch.student_id;
        ^
mydatabase=# select *
mydatabase-# from student 
mydatabase-# ;
 student_id | student_name | student_class | student_division 
------------+--------------+---------------+------------------
          1 | Revi         | 10th          | A
          2 | Suresh       | 11th          | B
          3 | Ramesh       | 12th          | C
          4 | Emma         | 9th           | D
          5 | Michael      | 11th          | A
(5 rows)

mydatabase=# SELECT *
FROM student
INNER JOIN branch
ON stdent.student_id = branch.student_id
WHERE student.student_name = 'Revi';
ERROR:  missing FROM-clause entry for table "stdent"
LINE 4: ON stdent.student_id = branch.student_id
           ^
mydatabase=# SELECT *
FROM student
INNER JOIN branch
ON stduent.student_id = branch.student_id
WHERE student.student_name = 'Revi';
ERROR:  missing FROM-clause entry for table "stduent"
LINE 4: ON stduent.student_id = branch.student_id
           ^
mydatabase=# SELECT *
FROM student
INNER JOIN branch
ON student.student_id = branch.student_id
WHERE student.student_name = 'Revi';
 student_id | student_name | student_class | student_division | branch_id | branch_name | student_id 
------------+--------------+---------------+------------------+-----------+-------------+------------
          1 | Revi         | 10th          | A                |         1 | Science     |          1
(1 row)

mydatabase=# select * 
mydatabase-# from student;
 student_id | student_name | student_class | student_division 
------------+--------------+---------------+------------------
          1 | Revi         | 10th          | A
          2 | Suresh       | 11th          | B
          3 | Ramesh       | 12th          | C
          4 | Emma         | 9th           | D
          5 | Michael      | 11th          | A
(5 rows)

mydatabase=# select * 
from student;
