-- CREATE NEW DATABASE
CREATE DATABASE udacity_project;

-- Use the newly created database 
USE udacity_project;


-- CREATE jobs table 

CREATE TABLE jobs (

                           job_id              SERIAL PRIMARY KEY,
                           job_title           VARCHAR(300)
);



-- INSERT DATA into jobs table from the existing proj_stg table

INSERT INTO jobs        (job_title)

SELECT DISTINCT job_title

FROM proj_stg ps;




-- Select first 05 rows for test purpose

SELECT *
FROM jobs
LIMIT 5; 




-- CREATE department table

CREATE TABLE department (

                           department_id              SERIAL PRIMARY KEY,
                           department_nm              VARCHAR(300)
);

-- INSERT DATA into department table from the existing proj_stg table
INSERT INTO department (department_nm)

SELECT DISTINCT department_nm
                
FROM proj_stg;


-- Select first 05 rows for test purpose

SELECT *
FROM department
LIMIT 5; 




-- CREATE education table

CREATE TABLE education (

                           education_id             SERIAL PRIMARY KEY,
                           education_lvl            VARCHAR(200)
);


-- INSERT DATA into education table from the existing proj_stg table

INSERT INTO education (education_lvl)
SELECT DISTINCT education_lvl
FROM proj_stg;



-- Select first 05 rows for test purpose

SELECT *
FROM education
LIMIT 5; 



-- CREATE manager table

CREATE TABLE manager (

                           manager_id            SERIAL PRIMARY KEY,
                           manager               VARCHAR(500)

);

-- INSERT DATA into manager table from the existing proj_stg table
INSERT INTO manager (manager)
SELECT  DISTINCT ps.manager 
FROM proj_stg ps;



-- Select first 05 rows for test purpose

SELECT *
FROM manager
LIMIT 5; 





-- CREATE employee table
CREATE TABLE employee (
                          
                          emp_id           CHAR(6) PRIMARY KEY,
                          emp_nm           VARCHAR(500),
                          email            VARCHAR(150),
                          hire_dt          DATE


);

-- INSERT DATA into employee table from the existing proj_stg table
INSERT INTO employee 


SELECT DISTINCT ps.emp_id,
                ps.emp_nm,
                ps.email,
                ps.hire_dt

FROM proj_stg ps;


-- Select first 05 rows for test purpose

SELECT *
FROM employee
LIMIT 5;






-- CREATE TABLE job_history

CREATE TABLE job_history (

                           hist_id             SERIAL PRIMARY KEY,
                           emp_id              CHAR(6),
                           start_dt            DATE,
                           end_dt              DATE,
                           job_id              INTEGER,
                           department_id       INTEGER,
                           education_id        INTEGER,
                           manager_id          INTEGER,

CONSTRAINT FK_JOB_ID FOREIGN KEY (job_id )
REFERENCES jobs(job_id),

CONSTRAINT FK_DEPARTMENT_ID FOREIGN KEY (department_id)
REFERENCES department(department_id),

CONSTRAINT FK_EDUCATION_ID FOREIGN KEY (education_id)
REFERENCES education(education_id),


CONSTRAINT FK_MANAGER_ID FOREIGN KEY (manager_id )
REFERENCES manager(manager_id)
                        
);

-- INSERT DATA into job_history table from the existing proj_stg table
INSERT INTO job_history (
                           emp_id,
                           start_dt,
                           end_dt,
                           job_id,
                           department_id,
                           education_id,
                           manager_id

)

SELECT ps.emp_id,
       ps.start_dt,
       ps.end_dt,
       j.job_id,
       d.department_id,
       e.education_id,
       m.manager_id



FROM proj_stg ps

JOIN jobs j 
ON j.job_title = ps.job_title

JOIN department d 
ON ps.department_nm = d.department_nm

JOIN education e 
ON ps.education_lvl = e.education_lvl

JOIN manager m 
ON ps.manager= m.manager;



-- Select first 05 rows for test purpose

SELECT *
FROM job_history
LIMIT 5;

-- CREATE salary table
CREATE TABLE salary (
                          
                          salary_id        SERIAL PRIMARY KEY,
                          emp_id           CHAR(6),
                          job_id           INTEGER,
                          salary           INTEGER,



CONSTRAINT FK_SAL_EMP_ID FOREIGN KEY (emp_id )
REFERENCES employee(emp_id),

CONSTRAINT FK_SAL_JOB_ID FOREIGN KEY (job_id )
REFERENCES jobs(job_id)

);




-- INSERT DATA into salary table from the existing proj_stg table

INSERT INTO salary (emp_id,
                    job_id,
                    salary)


SELECT          Emp_id,
                job_id,
                ps.salary

 
FROM proj_stg ps 
JOIN jobs j 
ON ps.job_title = j.job_title;



-- Select first 05 rows for test purpose

SELECT *
FROM salary
LIMIT 5;


-- CREATE location table

CREATE TABLE location (

                           location_id   SERIAL PRIMARY KEY,
                           location      VARCHAR(200),
                           state         CHAR(2),
                           city          VARCHAR (30));



-- INSERT DATA into location table from the existing proj_stg table
INSERT INTO location (
                           location,
                           state,
                           city)

SELECT DISTINCT   location,
                  state,
                  city

 
FROM proj_stg ps ;


-- Select first 05 rows for test purpose

SELECT *
FROM location
LIMIT 5;

-- CREATE state city_address

CREATE TABLE city_address (

                           emp_id                CHAR(6) PRIMARY KEY, 
                           address               VARCHAR(250),
                           location_id           INTEGER,

CONSTRAINT FK_LOCATION_ID FOREIGN KEY (location_id )
REFERENCES location(location_id)


);

-- INSERT DATA into city_address table from the existing proj_stg table
INSERT INTO city_address (                           
                           
                           emp_id,
                           address,
                           location_id)

SELECT DISTINCT ps.emp_id,
                ps.address,
                l.location_id 

FROM proj_stg ps
JOIN location l 
ON ps.location = l.location;


-- Select first 05 rows for city address

SELECT *
FROM city_address
LIMIT 5;