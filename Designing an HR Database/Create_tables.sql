
-- CREATE education table

CREATE TABLE education (

                           education_id             SERIAL PRIMARY KEY,
                           education_lvl            VARCHAR(200)
);


-- INSERT DATA into educaiton table from the existing proj_stg table

INSERT INTO education (education_lvl)
SELECT DISTINCT education_lvl
FROM proj_stg;


-- CREATE department table

CREATE TABLE department (

                           department_id              SERIAL PRIMARY KEY,
                           department_nm              VARCHAR(300)
);

-- INSERT DATA into department table from the existing proj_stg table
INSERT INTO department (department_nm)

SELECT DISTINCT department_nm
                
FROM proj_stg;



-- CREATE job table

CREATE TABLE jobs (

                           job_id              SERIAL PRIMARY KEY,
                           job_title           VARCHAR(300),
                           department_id       BIGINT UNSIGNED,

CONSTRAINT FK_DEPARTMENT_ID FOREIGN KEY (department_id)
REFERENCES department(department_id)
);



-- INSERT DATA into job table from the existing proj_stg table

INSERT INTO jobs        (job_title, 
                        department_id)

SELECT DISTINCT job_title,
                d.department_id

FROM proj_stg ps 

JOIN department d 
ON ps.department_nm = d.department_nm ;






-- CREATE employee table
CREATE TABLE employee (
                          
                          emp_id           CHAR(6) PRIMARY KEY,
                          emp_nm           VARCHAR(500),
                          email            VARCHAR(150),
                          hire_dt          DATE,
                          education_id     BIGINT UNSIGNED,
                          department_id    BIGINT UNSIGNED,
                          

CONSTRAINT FK_EMP_EDUCATION_ID FOREIGN KEY (education_id )
REFERENCES education(education_id ),

CONSTRAINT FK_EMP_DEPARTMENT_ID FOREIGN KEY (department_id)
REFERENCES department(department_id)

);

INSERT INTO employee 


SELECT DISTINCT ps.emp_id,
                ps.emp_nm,
                ps.email,
                ps.hire_dt,
                e.education_id,
                d.department_id

FROM proj_stg ps

JOIN education e 
ON ps.education_lvl = e.education_lvl

JOIN department d 
ON ps.department_nm = d.department_nm ;




-- CREATE TABLE job_history

CREATE TABLE job_history (

                           hist_id             SERIAL PRIMARY KEY,
                           emp_id              CHAR(6),
                           job_id              BIGINT UNSIGNED,
                           start_dt            DATE,
                           end_dt              DATE,

CONSTRAINT FK_JOB_ID FOREIGN KEY (job_id )
REFERENCES jobs(job_id),

CONSTRAINT FK_EMP_ID FOREIGN KEY (emp_id )
REFERENCES employee(emp_id)
                        
);

INSERT INTO job_history (
                           emp_id,
                           job_id,
                           start_dt,
                           end_dt
)

SELECT ps.emp_id,
       j.job_id,
       ps.start_dt,
       ps.end_dt 


FROM proj_stg ps

JOIN jobs j 
ON j.job_title = ps.job_title;




-- CREATE salary table
CREATE TABLE salary (
                          
                          salary_id        SERIAL PRIMARY KEY,
                          emp_id           CHAR(6),
                          job_id           BIGINT UNSIGNED,
                          salary           INTEGER,



CONSTRAINT FK_SAL_EMP_ID FOREIGN KEY (emp_id )
REFERENCES employee(emp_id),

CONSTRAINT FK_SAL_JOB_ID FOREIGN KEY (job_id )
REFERENCES jobs(job_id)

);

INSERT INTO salary (emp_id,
                    job_id,
                    salary)


SELECT          Emp_id,
                job_id,
                ps.salary

 
FROM proj_stg ps 
JOIN jobs j 
ON ps.job_title = j.job_title;







-- CREATE manager table

CREATE TABLE manager (

                           manager_id            SERIAL PRIMARY KEY,
                           manager               VARCHAR(500),
                           emp_id                CHAR(6),
                           job_id                 BIGINT UNSIGNED,


CONSTRAINT FK_MAN_EMP_ID FOREIGN KEY (emp_id )
REFERENCES employee(emp_id),

CONSTRAINT FK_MAN_JOB_ID FOREIGN KEY (job_id )
REFERENCES jobs(job_id)
);

INSERT INTO manager (manager,
                     emp_id,
                     job_id)


SELECT          ps.manager,
                ps.emp_id,
                j.job_id

 
FROM proj_stg ps 
JOIN jobs j 
ON ps.job_title = j.job_title;




-- CREATE location table

CREATE TABLE location (

                           location_id   SERIAL PRIMARY KEY,
                           location      VARCHAR(200),
                           state         CHAR(2),
                           city          VARCHAR (30));


INSERT INTO location (
                           location,
                           state,
                           city)

SELECT DISTINCT   location,
                  state,
                  city

 
FROM proj_stg ps ;




-- CREATE state city_address

CREATE TABLE city_address (

                           emp_id                CHAR(6) PRIMARY KEY, 
                           address               VARCHAR(250),
                           location_id           BIGINT UNSIGNED,

CONSTRAINT FK_LOCATION_ID FOREIGN KEY (location_id )
REFERENCES location(location_id)


);


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

