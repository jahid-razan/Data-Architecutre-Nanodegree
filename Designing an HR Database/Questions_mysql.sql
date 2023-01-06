-- Return a list of employees with Job Titles and Department Names

SELECT DISTINCT e.emp_id,
                e.emp_nm,
                j.job_title

FROM employee e 

JOIN job_history jh 
ON e.emp_id = jh.emp_id

JOIN jobs j
ON jh.job_id = j.job_id

LIMIT 10;


-- Insert Web Programmer as a new job title

INSERT INTO jobs (job_title) values ('Web Programmer');

-- Test insertion 
SELECT * 
FROM jobs 

-- Correct the job title from web programmer to web developer

UPDATE jobs
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

-- Test update
SELECT * 
FROM jobs 



-- Delete the job title Web Developer from the database
DELETE FROM jobs
WHERE job_title = 'Web Developer';

-- Test delete
SELECT * 
FROM jobs 



-- How many employees are in each department?

SELECT d.department_nm,
       COUNT(DISTINCT(emp_id)) as employeee_number
       
FROM department d

JOIN job_history jh 
ON d.department_id = jh.department_id

GROUP BY 1
ORDER BY 2 DESC;

-- Write a query that returns current and past jobs 
-- (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.

SELECT emp_nm, 
       job_title,
       department_nm,
       m.manager as manager_name,
       start_dt,
       end_dt
       

       
FROM employee e 

JOIN job_history jh 
ON e.emp_id = jh.emp_id 

JOIN department d
ON d.department_id = jh.department_id

JOIN manager m
ON m.manager_id = jh.manager_id 

JOIN jobs j
ON jh.job_id = j.job_id

WHERE emp_nm = 'Toni Lembeck';




-- CREATE A VIEW that return all employee attributes

CREATE VIEW all_employees AS 

(SELECT     e.emp_id,
            e.emp_nm, 
            e.email,
            e.hire_dt,
            j.job_title,
            s.salary,
            d.department_nm,
            m.manager,
            jh.start_dt,
            jh.end_dt,
            l.location, 
            c.address,
            l.city,
            l.state,
            education_lvl
            
FROM job_history jh  

JOIN employee e 
ON jh.emp_id = e.emp_id

JOIN jobs j
ON jh.job_id = j.job_id

JOIN department d
ON d.department_id = jh.department_id

JOIN education edu
ON edu.education_id = jh.education_id

JOIN manager m
ON m.manager_id = jh.manager_id 

JOIN salary s 
ON s.emp_id = jh.emp_id AND jh.job_id =  s.job_id 

JOIN city_address c 
ON e.emp_id = c.emp_id

JOIN location l 
ON c.location_id = l.location_id);





-- New user and access management

CREATE USER NoMgr LOGIN PASSWORD '1234abcd';

GRANT SELECT ON jobs TO NoMgr;
GRANT SELECT ON department TO NoMgr;
GRANT SELECT ON educaiton TO NoMgr;
GRANT SELECT ON manager TO NoMgr;
GRANT SELECT ON job_history TO NoMgr;
GRANT SELECT ON salary TO NoMgr;
GRANT SELECT ON employee TO NoMgr;
GRANT SELECT ON city_address TO NoMgr;
GRANT SELECT ON location TO NoMgr;

REVOKE SELECT ON salary FROM NoMgr;

-- ref for access: https://www.postgresqltutorial.com/postgresql-administration/postgresql-revoke/#:~:text=First%2C%20specify%20the%20one%20or,all%20tables%20in%20a%20schema.


-- stored proceedure mysql:

DELIMITER $$

CREATE PROCEDURE EmployeeHistory ( emp_nm VARCHAR(500))


BEGIN
        SELECT e.emp_id,
               emp_nm, 
			   job_title,
			   department_nm,
			   m.manager as manager_name,
			   start_dt,
			   end_dt
       

       
FROM employee e 

JOIN job_history jh 
ON e.emp_id = jh.emp_id AND e.emp_nm = emp_nm

JOIN department d
ON d.department_id = jh.department_id

JOIN manager m
ON m.manager_id = jh.manager_id 

JOIN jobs j
ON jh.job_id = j.job_id

WHERE emp_nm = emp_nm;
       END;
       
-- executing the stored procedure
call EmployeeHistory('Toni Lembeck');


-- dropping the stored procedure
DROP PROCEDURE EmployeeHistory;


-- postgres

CREATE OR REPLACE FUNCTION EmployeeHistory ( emp_nm VARCHAR(500))

returns table(

               emp_id                      CHAR(6),
               emp_nm                      VARCHAR(500), 
               job_title                   VARCHAR(300),
               department_nm               VARCHAR(300),
               manager_name                VARCHAR(500),
               start_dt                    DATE,
               end_dt                      DATE
)

 LANGUAGE plpgsql


BEGIN
        SELECT e.emp_id,
               emp_nm, 
               job_title,
               department_nm,
               m.manager as manager_name,
               start_dt,
               end_dt
       
       
FROM employee e 

JOIN job_history jh 
ON e.emp_id = jh.emp_id AND e.emp_nm = emp_nm

JOIN department d
ON d.department_id = jh.department_id

JOIN manager m
ON m.manager_id = jh.manager_id 

JOIN jobs j
ON jh.job_id = j.job_id

WHERE emp_nm = emp_nm;
       END;

SELECT * FROM call EmployeeHistory('Toni Lembeck');



