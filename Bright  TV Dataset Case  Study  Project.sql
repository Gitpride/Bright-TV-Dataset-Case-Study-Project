-- Databricks notebook source
SELECT * 
FROM bright.tv.user_profile;

---Data Cleaning---

SELECT COUNT(*)
FROM bright.tv.user_profile;

SELECT DISTINCT UserID
FROM bright.tv.user_profile;

SELECT *
FROM bright.tv.user_profile
WHERE UserID IS NULL
   OR Name IS NULL
   OR Surname IS NULL
   OR Email IS NULL
   OR Gender IS NULL
   OR Race IS NULL
   OR Age IS NULL
   OR Province IS NULL
   OR `Social Media Handle` IS NULL;

SELECT DISTINCT Gender 
FROM bright.tv.user_profile;

SELECT DISTINCT Name
FROM bright.tv.user_profile;

SELECT DISTINCT Surname
FROM bright.TV.user_profile;

SELECT UserID,
       Name, 
       Email,
              CASE 
                     WHEN Surname = 'None' THEN 'Unknown'
                     ELSE Surname
              END AS Surname,
                     Gender,
                     Race,
                     Province,
                     `Social Media Handle`
FROM bright.tv.user_profile;

SELECT UserID,
       Name,
       Surname,
       Email,
              CASE 
                      WHEN Gender = 'None' THEN 'Unknown'
                      ELSE Gender 
              END AS Gender,
                      Race,
                      Age,
                      Province,
                      `Social Media Handle`
FROM bright.tv.user_profile;

SELECT DISTINCT Race 
FROM bright.tv.user_profile;
    
SELECT UserID, 
       Name,
       Surname,
       Email,
       Gender,
              CASE
                      WHEN Race = 'None' THEN 'Unknown'
                      ELSE Race
              END AS  Race,
                      Age,
                      Province,
                      `Social Media Handle`
FROM bright.tv.user_profile;

SELECT MAX(Age),
       MIN(Age)
 FROM bright.tv.user_profile;

SELECT UserID, 
       Name,
       Surname,
       Email,
       Gender,
       Race,
                CASE
                        WHEN Age BETWEEN 0 AND 12 THEN 'Children'
                        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers'
                        WHEN Age BETWEEN 18 AND 24 THEN 'Young Adults'
                        WHEN Age BETWEEN 25 AND 34 THEN 'Adults'
                        WHEN Age BETWEEN 35 AND 44 THEN 'Middle Adults'
                        WHEN Age BETWEEN 45 AND 54 THEN 'Mature Adults'
                        WHEN Age BETWEEN 55 AND 64 THEN 'Older Adults'
                        WHEN Age >= 65 THEN 'Seniors'
                END AS Age_Group,
                       Province,
                       `Social Media Handle`
FROM bright.tv.user_profile;


                   


