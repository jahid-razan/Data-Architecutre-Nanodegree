-- SELECT DATABASE
USE DATABASE UDACITYPROJECT;

-- SELECT WAREHOUSE
USE WAREHOUSE COMPUTE_WH;

-- SELECT SCHEMA
USE SCHEMA STAGING;

-- CREATE JSON FILE FORMAT
create or replace file format myjsonformat type='JSON' strip_outer_array=true;

-- CREATE STAGING AREA
create or replace stage my_json_stage file_format = myjsonformat;


-- CREATE A TABLE FOR THE BUSINESS JSON FILE
create or replace table business(businessjson variant);


-- INSERT THE business.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\business.json @my_json_stage auto_compress=true;


-- COPY business.JOSN file from staging area into table
copy into business from @my_json_stage/business.json.gz file_format=myjsonformat on_error='skip_file';



-- CREATE A TABLE FOR THE COVID JSON FILE
create table covid(covidjson variant);

-- INSERT THE covid.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\covid.json @my_json_stage auto_compress=true parallel=20;


-- COPY covid.JOSN file from staging area into table
copy into covid from @my_json_stage/covid.json.gz file_format=myjsonformat on_error='skip_file';



-- CREATE A TABLE FOR THE CHECK_IN JSON FILE
create table checkin(checkinjson variant);

-- INSERT THE checkin.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\checkin.json @my_json_stage auto_compress=true parallel=25;


-- COPY checkin.JSON file from staging area into table
copy into checkin from @my_json_stage/checkin.json.gz file_format=myjsonformat on_error='skip_file';




-- CREATE A TABLE FOR THE REVIEW JSON FILE
create table review(reviewjson variant);

-- INSERT THE review.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\review.json @my_json_stage auto_compress=true parallel=25;


-- COPY review.JSON  file from staging area into table
copy into review from @my_json_stage/review.json.gz file_format=myjsonformat on_error='skip_file';



-- CREATE A TABLE FOR THE TIPS JSON FILE
create table tip(tipjson variant);

-- INSERT THE tip.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\tip.json @my_json_stage auto_compress=true parallel=25;


-- COPY tip.JOSN file from staging area into table
copy into tip from @my_json_stage/tip.json.gz file_format=myjsonformat on_error='skip_file';


-- CREATE A TABLE FOR THE CUSTOMER JSON FILE
create table customer(customerjson variant);

-- INSERT THE customer.JSON file
put file:///C:\Users\jahid.razan\Desktop\Udacity_Data_viz\Data_Architect_Nanodegree\Project_02\user.json @my_json_stage auto_compress=true parallel=25;


-- COPY customer.JOSN file from staging area into table
copy into customer from @my_json_stage/user.json.gz file_format=myjsonformat on_error='skip_file';

