

-- CREATE BUSINESS TABLE IN WAREHOUSE SCHEMA

CREATE OR REPLACE TABLE DIM_BUSINESS (
                            
                            BUSINESS_ID   VARCHAR PRIMARY KEY,
                            NAME          VARCHAR,
                            STATE         VARCHAR);
                        

INSERT INTO DIM_BUSINESS 

SELECT DISTINCT BUSINESS_ID, 
                NAME, 
                STATE
                
FROM ODS.BUSINESS;


-- CREATE REVIEW TABLE IN WAREHOUSE SCHEMA
CREATE OR REPLACE TABLE  DIM_REVIEW (
                            
                            REVIEW_ID     VARCHAR PRIMARY KEY,  
                            USER_ID       VARCHAR,
                            BUSINESS_ID   VARCHAR,
                            DATE          DATE, 
                            STARS         INTEGER,

constraint fk_BUSINESS_ID foreign key (BUSINESS_ID)
references ODS.BUSINESS (BUSINESS_ID), 

                            
constraint fk_USER_ID foreign key (USER_ID)
references ODS.CUSTOMER(USER_ID)); 

INSERT INTO DIM_REVIEW

SELECT          REVIEW_ID,
                USER_ID,
                BUSINESS_ID, 
                DATE, 
                STARS
                
FROM ODS.REVIEW;



-- CREATE CUSTOMER TABLE IN WAREHOUSE SCHEMA
CREATE OR REPLACE TABLE  DIM_USER (
                            
                            USER_ID                 VARCHAR PRIMARY KEY,
                            NAME                    VARCHAR,
                            YELPING_SINCE           DATE,
                            AVERAGE_STARS           FLOAT,
                            REVIEW_COUNT            INTEGER); 


INSERT INTO DIM_USER

SELECT         
                USER_ID,
                NAME, 
                YELPING_SINCE, 
                AVERAGE_STARS,
                REVIEW_COUNT

                
FROM ODS.CUSTOMER;


-- CREATE TEMPERATURE TABLE IN WAREHOUSE SCHEMA
CREATE OR REPLACE TABLE DIM_CLIMATE (
                        
                          DATE                 DATE PRIMARY KEY,
                          MIN_TEMP             NUMBER,
                          MAX_TEMP             NUMBER,
                          NORMAL_MIN           FLOAT,
                          NORMAL_MAX           FLOAT,
                          PRECIPITATION        VARCHAR,
                          PRECIPITATION_NORMAL INTEGER); 


INSERT INTO DIM_CLIMATE

select distinct 
                T.DATE, 
                MIN_TEMP, 
                MAX_TEMP,
                NORMAL_MIN,
                NORMAL_MAX,
                P.PRECIPITATION,
                P.PRECIPITATION_NORMAL

                
FROM ODS.TEMPERATURE T
JOIN ODS.PRECIPITATION p
ON T.DATE = P.DATE;




-- CREATE RATING ANALYSIS TABLE IN IN WAREHOUSE SCHEMA FOR REPORTING PURPOSE

CREATE OR REPLACE TABLE RATING_ANALYSIS (

                            RATING_ID            NUMBER AUTOINCREMENT, 
                            BUSINESS_ID          VARCHAR,
                            NAME                 VARCHAR,
                            STATE                VARCHAR,
                            STARS                INTEGER,
                            DATE                 DATE,   
                            MIN_TEMP             NUMBER,
                            MAX_TEMP             NUMBER,
                            PRECIPITATION_NORMAL INTEGER,
                            USER_ID              VARCHAR,
                            AVERAGE_STARS        FLOAT,
                            REVIEW_ID            VARCHAR, 
                            

constraint fk_BUSINESS_ID foreign key (BUSINESS_ID)
references ODS.BUSINESS (BUSINESS_ID), 

constraint fk_REVIEW_ID foreign key (REVIEW_ID)
references ODS.REVIEW (REVIEW_ID),


constraint fk_DATE_TEMP foreign key (DATE)
references ODS.TEMPERATURE(DATE), 


constraint fk_DATE_PERCIPTATION foreign key (DATE)
references ODS.PRECIPITATION(DATE),

constraint fk_USER_ID foreign key (USER_ID)
references ODS.CUSTOMER(USER_ID)

);

INSERT INTO RATING_ANALYSIS ( BUSINESS_ID,
                              NAME,
                              STATE,
                              STARS,
                              DATE,   
                              MIN_TEMP,
                              MAX_TEMP,
                              PRECIPITATION_NORMAL,
                              USER_ID,
                              AVERAGE_STARS,
                              REVIEW_ID)

SELECT          B.BUSINESS_ID,
                B.NAME,
                B.STATE,
                R.STARS,
                T.DATE,
                T.MIN_TEMP,
                T.MAX_TEMP,
                P.PRECIPITATION_NORMAL,
                C.USER_ID,
                C.AVERAGE_STARS,
                R.REVIEW_ID




FROM ODS.BUSINESS B,
     ODS.TEMPERATURE T,
     ODS.PRECIPITATION P,
     ODS.REVIEW R,
     ODS.CUSTOMER C 

WHERE (T.DATE = P.DATE) 
      AND (T.DATE = R.DATE) 
      AND R.BUSINESS_ID =  B.BUSINESS_ID
      AND C.USER_ID = R.USER_ID;

