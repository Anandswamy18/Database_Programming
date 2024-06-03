 DECLARE
    -- Declare the cursor
    CURSOR emp_cursor IS
        SELECT first_name, last_name FROM employees;
    
    -- Declare variables to hold the cursor data
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
BEGIN
    -- Open the cursor
    OPEN emp_cursor;
    
    -- Loop through each row in the cursor
    LOOP
        -- Fetch data from the cursor into variables
        FETCH emp_cursor INTO v_first_name, v_last_name;
        
        -- Exit the loop when no more rows are fetched
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Print the employee name
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_cursor;
END;
ERROR:  syntax error at or near "emp_cursor"
LINE 3:     CURSOR emp_cursor IS
                   ^
ERROR:  syntax error at or near "v_first_name"
LINE 1: v_first_name employees.first_name%TYPE;
        ^
ERROR:  syntax error at or near "v_last_name"
LINE 1: v_last_name employees.last_name%TYPE;
        ^
ERROR:  syntax error at or near "OPEN"
LINE 3:     OPEN emp_cursor;
            ^
ERROR:  syntax error at or near "LOOP"
LINE 1: LOOP
        ^
ERROR:  syntax error at or near "EXIT"
LINE 1: EXIT WHEN emp_cursor%NOTFOUND;
        ^
ERROR:  syntax error at or near "DBMS_OUTPUT"
LINE 1: DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || ...
        ^
ERROR:  syntax error at or near "LOOP"
LINE 1: END LOOP;
            ^
ERROR:  cursor "emp_cursor" does not exist
WARNING:  there is no transaction in progress
COMMIT
mydatabase=# DECLARE
    -- Declare the cursor
    CURSOR emp_cursor IS
        SELECT first_name, last_name FROM employees;
    
    -- Declare variables to hold the cursor data
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
BEGIN
    -- Open the cursor
    OPEN emp_cursor;
    
    -- Loop through each row in the cursor
    LOOP
        -- Fetch data from the cursor into variables
        FETCH emp_cursor INTO v_first_name, v_last_name;
        
        -- Exit the loop when no more rows are fetched
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Print the employee name
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_cursor;
END;
/
ERROR:  syntax error at or near "emp_cursor"
LINE 3:     CURSOR emp_cursor IS
                   ^
ERROR:  syntax error at or near "v_first_name"
LINE 1: v_first_name employees.first_name%TYPE;
        ^
ERROR:  syntax error at or near "v_last_name"
LINE 1: v_last_name employees.last_name%TYPE;
        ^
ERROR:  syntax error at or near "OPEN"
LINE 3:     OPEN emp_cursor;
            ^
ERROR:  syntax error at or near "LOOP"
LINE 1: LOOP
        ^
ERROR:  syntax error at or near "EXIT"
LINE 1: EXIT WHEN emp_cursor%NOTFOUND;
        ^
ERROR:  syntax error at or near "DBMS_OUTPUT"
LINE 1: DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || ...
        ^
ERROR:  syntax error at or near "LOOP"
LINE 1: END LOOP;
            ^
ERROR:  cursor "emp_cursor" does not exist
WARNING:  there is no transaction in progress
COMMIT
mydatabase-# DO $$ 
DECLARE
    student_cursor CURSOR FOR 
    SELECT student_id, first_name, last_name FROM student;

    student_record RECORD;  

BEGIN
 
    OPEN student_cursor;

    LOOP
        FETCH student_cursor INTO student_record;

        EXIT WHEN NOT FOUND; 

        RAISE NOTICE 'ID: %, Name: % %', student_record.student_id, student_record.first_name, student_record.last_name;
    END LOOP;

    CLOSE student_cursor;
END $$;
ERROR:  syntax error at or near "/"
LINE 1: /
        ^
mydatabase=# DO $$
DECLARE
    student_cursor CURSOR FOR 
        SELECT student_id, first_name, last_name FROM student;

    student_record RECORD;  
BEGIN
    OPEN student_cursor;
    LOOP
        FETCH student_cursor INTO student_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: % %', student_record.student_id, student_record.first_name, student_record.last_name;
    END LOOP;
    CLOSE student_cursor;
END $$;
ERROR:  column "first_name" does not exist
LINE 1: SELECT student_id, first_name, last_name FROM student
                           ^
QUERY:  SELECT student_id, first_name, last_name FROM student
CONTEXT:  PL/pgSQL function inline_code_block line 8 at OPEN
mydatabase=#  id |  name   | department  |  salary  
----+---------+-------------+----------
  1 | Alice   | Engineering | 75000.00
  2 | Bob     | HR          | 50000.00
  3 | Charlie | Engineering | 80000.00
  4 | David   | Sales       | 60000.00
  5 | Eva     | HR          | 55000.00
(5 rows)
mydatabase-#  id |  name   | department  |  salary  
----+---------+-------------+----------
  1 | Alice   | Engineering | 75000.00
  2 | Bob     | HR          | 50000.00
  3 | Charlie | Engineering | 80000.00
  4 | David   | Sales       | 60000.00
  5 | Eva     | HR          | 55000.00
(5 rows)
mydatabase-# DO $$
DECLARE
    emp_cursor CURSOR FOR 
        SELECT id, name, department, salary FROM employees;

    emp_record RECORD;  
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %, Department: %, Salary: %', emp_record.id, emp_record.name, emp_record.department, emp_record.salary;
    END LOOP;
    CLOSE emp_cursor;
END $$;
ERROR:  syntax error at or near "id"
LINE 1: id |  name   | department  |  salary  
        ^
mydatabase=# DO $$
DECLARE
    emp_cursor CURSOR FOR 
        SELECT id, name, department, salary FROM employees;

    emp_record employees%ROWTYPE;  
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %, Department: %, Salary: %', emp_record.id, emp_record.name, emp_record.department, emp_record.salary;
    END LOOP;
    CLOSE emp_cursor;
END $$;
NOTICE:  ID: 1, Name: Alice, Department: Engineering, Salary: 75000.00
NOTICE:  ID: 2, Name: Bob, Department: HR, Salary: 50000.00
NOTICE:  ID: 4, Name: David, Department: Sales, Salary: 60000.00
NOTICE:  ID: 5, Name: Eva, Department: HR, Salary: 55000.00
DO
mydatabase=# 

