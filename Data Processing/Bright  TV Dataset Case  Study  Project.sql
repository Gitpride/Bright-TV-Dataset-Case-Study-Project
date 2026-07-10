-- Databricks notebook source
--==================================
--BRIGHT TV CASE STUDY
--==================================

--==================================
--1. VIEW THE DATASET
--==================================

SELECT * 
FROM bright.tv.user_profile;

--=================================
--2. TOTAL NUMBER OF RECORDS
--=================================

SELECT COUNT(*) Total_ Count
FROM bright.tv.user_profile;

--================================
--CHECK FOR DUPLICATE USERIDs
--================================

SELECT UserID,
       COUNT(*) AS Subcriber
FROM bright.tv.user_profile
GROUP BY UserID
HAVING COUNT(*) > 1;

--================================
--3. DATA QUALITY CHECKS
--================================

--Check UserID
SELECT DISTINCT UserID
FROM bright.tv.user_profile;

--Check Name
SELECT DISTINCT Name
FROM bright.tv.user_profile;

--Check Surname
SELECT DISTINCT Surname
FROM bright.TV.user_profile;

--Check Email
SELECT DISTINCT Email
FROM bright.tv.user_profile;

--Check Gender
SELECT DISTINCT Gender 
FROM bright.tv.user_profile;

--Check Race
SELECT DISTINCT Race 
FROM bright.tv.user_profile;

--Check Age
SELECT MAX(Age),
       MIN(Age)
 FROM bright.tv.user_profile;

--Check Province
SELECT DISTINCT Province
FROM bright.tv.user_profile;

--Check Social Media Handle
SELECT DISTINCT `Social Media Handle` AS Social_Media_Handle
FROM bright.tv.user_profile;



--================================
--4. CREATE CLEANED DATASET
--================================

WITH test_view AS
(
SELECT
        UserID,

        CASE
                WHEN Name = 'None' THEN 'Unknown'
                WHEN Name = ' ' THEN 'Unknown'
                WHEN Name IS NULL THEN 'Unknown'
        ELSE Name
        END AS Name,

        CASE 
                WHEN Surname = 'None' THEN 'Unknown'
                WHEN Surname = ' ' THEN 'Unknown'
                WHEN Surname IS NULL THEN 'Unknown'
        ELSE Surname
        END AS Surname,

        CASE
                WHEN Email = 'None' THEN 'Unknown'
                WHEN Email = ' ' THEN 'Unknown'
                WHEN Email IS NULL THEN 'Unknown'
        ELSE Email
        END AS Email,

        CASE
                WHEN Gender = 'None' THEN 'Unknown'
                WHEN Gender = ' ' THEN 'Unknown'
                WHEN Gender IS NULL THEN 'Unknown'
        ELSE Gender
        END AS Sex,

        CASE
                WHEN Race = 'None' THEN 'Unknown'
                WHEN Race = 'Other' THEN 'Unknown'
                WHEN Race = ' ' THEN 'Unknown'
                WHEN Race IS NULL THEN 'Unknown'
        ELSE Race
        END AS Ethnicity,

        Age,
        CASE
                WHEN Age = 0  THEN '01. Infant: 0'
                WHEN Age BETWEEN 1 AND 12 THEN '02. Kids: 1-12'
                WHEN Age BETWEEN 13 AND 17 THEN '03. Youth: 13-17'
                WHEN Age BETWEEN 18 AND 35 THEN '04. Youth Adult: 18-35'
                WHEN Age BETWEEN 36 AND 50 THEN '05. Adult: 36-50'
                WHEN Age BETWEEN 13 AND 17 THEN '03. Youth: 13-17'
                WHEN Age BETWEEN 18 AND 35 THEN '04. Youth Adult: 18-35'
                WHEN Age BETWEEN 36 AND 50 THEN '05. Adult: 36-50'
                WHEN Age BETWEEN 51 AND 60 THEN '06. Elder: 51-60'
                WHEN Age > 60 THEN '07. Pensioner'         
        ELSE Age       
        END AS Age_Group,  

         CASE
                WHEN Province = 'None' THEN 'Unknown'
                WHEN Province = ' ' THEN 'Unknown'
                WHEN Province IS NULL THEN 'Unknown'
        ELSE Province
        END AS Region,

        CASE
                WHEN `Social Media Handle` = 'None' THEN 'Unknown'
                WHEN `Social Media Handle` = ' ' THEN 'Unknown'
                WHEN `Social Media Handle` IS NULL THEN 'Unknown'
        ELSE `Social Media Handle`
        END AS Social_Media_Handle
FROM bright.tv.user_profile
)
SELECT * 
FROM test_view;



--==================================
--VIEWRSHIP 
--==================================

---=================================
--1. VIEW DATASET
--==================================

SELECT *
FROM bright.tv.viewership;

--==================================
--2. TOTAL NUMBER OF RECORDS
--==================================

SELECT COUNT(*)
FROM bright.tv.viewership;

--==================================
--3. DATA QUALITY CHECKS
--==================================

--Check UserID0
SELECT DISTINCT UserID0
FROM bright.tv.viewership;

--Check Channel2
SELECT DISTINCT Channel2
FROM bright.tv.viewership
ORDER BY Channel2;

--Check RecordDate2
SELECT DISTINCT RecordDate2
FROM bright.tv.viewership;

--Check `Duration 2`
SELECT DISTINCT `Duration 2` AS Duration_2
FROM bright.tv.viewership
ORDER BY Duration_2;

--Check userid4
SELECT DISTINCT userid4
FROM bright.tv.viewership;

--==================================
--CREATE CLEANED DATA
--==================================




SELECT
    COALESCE(UserID0, Userid4) AS UserID,
      MONTH(RecordDate2) AS Month_ID,
      DATE_FORMAT(RecordDate2, 'dd/MM/yyyy') AS Watch_Date,
      DATE_FORMAT(RecordDate2, 'HH:mm:ss') AS Watch_Time,
      DAYOFWEEK(RecordDate2) AS Day_Of_Week,
      DATE_FORMAT(RecordDate2,'EEEE') Day_Name,
      
        CASE
                WHEN Channel2 IN ('SawSee', 'Sawsee') THEN 'Sawsee'
                WHEN Channel2 IN ('SuperSport Live Events', 'Supersport Live Events') THEN 'Live Events'
        ELSE Channel2
        END AS TV_Channel,

        CASE
                WHEN  DATE_FORMAT(RecordDate2,'EEEE') IN('Saturday','Sunday') THEN 'Weekend'
        ELSE 'Weekday'
        END AS Day_Classification,

        CASE 
                WHEN Watch_Time BETWEEN '00:00:00' AND '05:59:59' THEN '01. Midnight'
                WHEN Watch_Time BETWEEN '06:00:00' AND '11:59:59' THEN '02. Morning'
                WHEN Watch_Time BETWEEN '12:00:00' AND '16:59:59' THEN '03. Afternoon'
                WHEN Watch_Time BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
        END AS Time_Of_Day    
FROM bright.tv.viewership;
 






