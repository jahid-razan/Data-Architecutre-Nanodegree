
-- CREATE TEMPERATURE TABLE IN ODS SCHEMA
CREATE OR REPLACE TABLE TEMPERATURE (
                          
                          DATE          DATE PRIMARY KEY,
                          MIN_TEMP      NUMBER,
                          MAX_TEMP      NUMBER,
                          NORMAL_MIN    FLOAT,
                          NORMAL_MAX    FLOAT

);

-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.TEMPERATURE TO ODS.TEMPERATURE TABLE
insert into TEMPERATURE(DATE, 
                       MIN_TEMP, 
                       MAX_TEMP, 
                       NORMAL_MIN, 
                       NORMAL_MAX)

SELECT  
        TO_DATE(DATE,'YYYYMMDD'),
        MIN_TEMP::NUMBER,
        MAX_TEMP::NUMBER,
        NORMAL_MIN::FLOAT,
        NORMAL_MAX::FLOAT
FROM UDACITYPROJECT.STAGING.TEMPERATURE;
       

-- CREATE PRECIPITATION TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE PRECIPITATION (

                           DATE          DATE PRIMARY KEY,
                           PRECIPITATION VARCHAR,
                           PRECIPITATION_NORMAL INTEGER
);

-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.PRECIPITATION TO ODS.PRECIPITATION TABLE

INSERT INTO PRECIPITATION  (DATE, 
                            PRECIPITATION, 
                            PRECIPITATION_NORMAL )

SELECT TO_DATE(DATE,'YYYYMMDD'),
       PRECIPITATION::VARCHAR,
       PRECIPITATION_NORMAL::INTEGER
FROM UDACITYPROJECT.STAGING.PRECIPITATION;

-- CREATE BUSINESS TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE BUSINESS (
                            
                            BUSINESS_ID   VARCHAR PRIMARY KEY,
                            ADDRESS       VARCHAR,
                            ATTRIBUTES    OBJECT,
                            CATEGORIES    VARCHAR,
                            HOURS         VARCHAR,
                            IS_OPEN       INTEGER,
                            LATITUDE      FLOAT,
                            LONGITUDE     FLOAT,
                            NAME          VARCHAR,
                            POSTAL_CODE   VARCHAR,
                            REVIEW_COUNT  INTEGER,
                            STARS         INTEGER,
                            STATE         VARCHAR); 

-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.BUSINESS  TO ODS.BUSINESS TABLE

INSERT INTO BUSINESS

    select  businessjson:business_id::varchar,
            businessjson:address::varchar,
            businessjson:attributes::object,
            businessjson:categories::varchar,
            businessjson:hours::varchar,
            businessjson:is_open::integer,
            businessjson:lattitude::float,
            businessjson:longitude::float,
            businessjson:name::string,
            businessjson:postal_code::varchar,
            businessjson:review_count::integer,
            businessjson:stars::integer,
            businessjson:state::varchar

FROM UDACITYPROJECT.STAGING.BUSINESS;



-- CREATE CUSTOMER TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE CUSTOMER (
                            
                            USER_ID                 VARCHAR PRIMARY KEY,
                            NAME                    VARCHAR,
                            YELPING_SINCE           DATE,
                            AVERAGE_STARS           FLOAT,
                            COMPLIMENT_COOL         INTEGER,
                            COMPLIMENT_CUTE         INTEGER,
                            COMPLIMENT_FUNNY        INTEGER,
                            COMPLIMENT_HOT          INTEGER,
                            COMPLIMENT_LIST         INTEGER,
                            COMPLIMENT_MORE         INTEGER,
                            COMPLIMENT_NOTE         INTEGER,
                            COMPLIMENT_PHOTOS       INTEGER,
                            COMPLIMENT_PLAIN        INTEGER,
                            COMPLIMENT_PROFILE      INTEGER,
                            COMPLIMENT_WRITER       INTEGER,
                            COOL                    INTEGER,
                            ELITE                   VARCHAR,
                            FANS                    INTEGER,
                            FRIENDS                 VARCHAR,
                            FUNNY                   INTEGER,
                            REVIEW_COUNT            INTEGER,
                            USEFUL                  INTEGER

); 



-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.CUSTOMER TO ODS.CUSTOMER
INSERT INTO CUSTOMER
    select  
            customerjson:user_id::varchar,
            customerjson:name::varchar,
            to_date(customerjson:yelping_since::string),
            customerjson:average_stars::varchar,
            customerjson:compliment_cool::integer,
            customerjson:compliment_cute::integer,
            customerjson:compliment_funny::integer,
            customerjson:compliment_hot::integer,
            customerjson:compliment_list::integer,
            customerjson:compliment_more::integer,
            customerjson:compliment_note::integer,
            customerjson:compliment_photos::integer,
            customerjson:compliment_plain::integer,
            customerjson:compliment_profile::integer,
            customerjson:compliment_writer::integer,
            customerjson:cool::integer,
            customerjson:elite::varchar,
            customerjson:fans::integer,
            customerjson:friends::VARCHAR,
            customerjson:funny::integer,

            customerjson:review_count::integer,
            customerjson:useful::integer



FROM UDACITYPROJECT.STAGING.CUSTOMER;

-- CREATE TIP TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE TIP (

                            TIP_ID              NUMBER AUTOINCREMENT PRIMARY KEY,
                            BUSINESS_ID         VARCHAR,
                            COMPLIMENT_COUNT    INTEGER,
                            DATE                DATE,
                            TEXT                VARCHAR,
                            USER_ID             VARCHAR
                            
); 

-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.TIP  TO ODS.TIP
INSERT INTO TIP  (          BUSINESS_ID,
                            COMPLIMENT_COUNT,
                            DATE,
                            TEXT,
                            USER_ID)

    select  
            tipjson:business_id::varchar,
            tipjson:compliment_count::integer,
            to_date(tipjson:date::string),
            tipjson:text::varchar,
            tipjson:user_id::varchar


FROM UDACITYPROJECT.STAGING.TIP;


-- CREATE REVIEW TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE  REVIEW (
                            
                            REVIEW_ID     VARCHAR PRIMARY KEY,
                            BUSINESS_ID   VARCHAR,
                            COOL          INTEGER,
                            DATE          DATE,      
                            FUNNY         INTEGER,
                            STARS         INTEGER,
                            TEXT          VARCHAR,
                            USEFUL        INTEGER,
                            USER_ID       VARCHAR
        

 ); 


-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.REVIEW  TO ODS.REVIEW
INSERT INTO REVIEW

    select  
            reviewjson:review_id::varchar,
            reviewjson:business_id::varchar,
            reviewjson:cool::integer,
            to_date(reviewjson:date::string),
            reviewjson:funny::integer,
            reviewjson:stars::integer,
            reviewjson:text::varchar,
            reviewjson:useful::integer,
            reviewjson:user_id::varchar


FROM UDACITYPROJECT.STAGING.REVIEW;




CREATE OR REPLACE TABLE  COVID (
                            
                            ID                           NUMBER AUTOINCREMENT PRIMARY KEY,
                            BUSINESS_ID                  VARCHAR,
                            CALL_TO_ACTION_ENABLED       VARCHAR,
                            COVID_BANNER                 VARCHAR,
                            GRUBHUB_ENABLED              VARCHAR,  
                            REQUEST_A_QUOTE_ENABLED      VARCHAR,
                            TEMPORARY_CLOSED_UNTIL       VARCHAR,
                            VIRTUAL_SERVICES_OFFERED     VARCHAR,
                            DELIVERY_OR_TAKEOUT          VARCHAR,
                            HIGHLIGHTS                   VARCHAR

);
 

INSERT INTO COVID (
                            BUSINESS_ID,
                            CALL_TO_ACTION_ENABLED,
                            COVID_BANNER,
                            GRUBHUB_ENABLED,  
                            REQUEST_A_QUOTE_ENABLED,
                            TEMPORARY_CLOSED_UNTIL,
                            VIRTUAL_SERVICES_OFFERED,
                            DELIVERY_OR_TAKEOUT,
                            HIGHLIGHTS)
 
select  
            covidjson:business_id::VARCHAR,
            covidjson:"Call To Action enabled"::VARCHAR,
            covidjson:"Covid Banner"::VARCHAR,
            covidjson:"Grubhub enabled"::VARCHAR,
            covidjson:"Request a Quote Enabled"::VARCHAR,
            covidjson:"Temporary Closed Until"::VARCHAR,
            covidjson:"Virtual Services Offered"::VARCHAR,
            covidjson:"delivery or takeout"::VARCHAR,
            covidjson:highlights::VARCHAR

FROM UDACITYPROJECT.STAGING.COVID;




-- CREATE CHECKIN TABLE IN ODS SCHEMA

CREATE OR REPLACE TABLE  CHECKIN (

                            BUSINESS_ID   VARCHAR PRIMARY KEY,
                            DATE          VARCHAR); 


-- COPY DATA FROM STAGING SCHEMA TO ODS FROM STAGING.REVIEW  TO ODS.REVIEW
INSERT INTO CHECKIN

    select  
            checkinjson:business_id::varchar,
            checkinjson::varchar

FROM UDACITYPROJECT.STAGING.CHECKIN;


-- sql code to integrate climate and Yelp data

SELECT   b.business_id,
         b.attributes,
         r.date, 
         r.stars,
         t.max_temp,
         p.precipitation,
         c.user_id,
         co.call_to_action_enabled,
         tip.compliment_count

         
          
  FROM review r 
  
  LEFT JOIN precipitation p 
  ON r.date = p.date 
  
  LEFT JOIN temperature t 
  ON r.date = t.date 

  JOIN checkin ch 
  ON r.business_id = ch.business_id 

  JOIN business b 
  ON b.business_id = ch.business_id  

  JOIN covid co 
  ON co.business_id = b.business_id 
  
  JOIN customer c
  ON r.user_id = c.user_id
  
  JOIN tip 
  ON tip.user_id = r.user_id
  
  LIMIT 5;
      
