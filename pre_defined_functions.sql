ydatabase=# SELECT AVG(age) FROM ref_students;
         avg         
---------------------
 20.5000000000000000
(1 row)

mydatabase=# SELECT COUNT(*) FROM refstudents;
ERROR:  relation "refstudents" does not exist
LINE 1: SELECT COUNT(*) FROM refstudents;
                             ^
mydatabase=# SELECT COUNT(*) FROM ref_students;
 count 
-------
     4
(1 row)

mydatabase=# SELECT MAX(age) FROM ref_students;
 max 
-----
  22
(1 row)

mydatabase=# SELECT MIN(age) FROM ref_students;
 min 
-----
  19
(1 row)

mydatabase=# SELECT ROUND(AVG(age)) FROM ref_students;
 round 
-------
    21
(1 row)

mydatabase=# SELECT UPPER(first_name) FROM ref_students;
 upper  
--------
 MS
 YUVRAJ
 BHUVI
 VIRAT
(4 rows)

mydatabase=# SELECT LOWER(last_name) FROM ref_students;
 lower 
-------
 dhoni
 singh
 kumar
 kholi
(4 rows)

mydatabase=# SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM ref_students;
  full_name   
--------------
 MS Dhoni
 yuvraj Singh
 Bhuvi Kumar
 virat kholi
(4 rows)

mydatabase=# SELECT CURRENT_DATE;
 current_date 
--------------
 2024-06-03
(1 row)
mydatabase=# SELECT LENGTH(first_name) AS name_length FROM ref_students;
 name_length 
-------------
           2
           6
           5
           5
(4 rows)
