DROP DATABASE IF EXISTS Healthcare_db;
CREATE DATABASE Healthcare_db;

USE Healthcare_db;

DROP TABLE IF EXISTS healthcare;
CREATE TABLE healthcare(
Name VARCHAR(100) ,
Age INT ,
Gender VARCHAR(100),
Blood_Type VARCHAR(100), 
Medical_Condition VARCHAR(100) ,
Admission_Date DATE ,
Doctor VARCHAR(100) ,
Hospital VARCHAR(100),
Insurance_Provider VARCHAR(100), 
Billing_Amount FLOAT,
Room_Number INT ,
Admission_Type VARCHAR(100),
Discharge_Date DATE,
Medication VARCHAR(100),
Test_Results VARCHAR(100)
);

SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE "C:/Users/Lenovo/OneDrive/Documents/Health Care Analysis/Data/healthcare_dataset.csv"  INTO TABLE healthcare
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-------------------------------------------------------------------------------------------------------------------------------------

#                                    Patient Demographics & Service Optimization

# Q.1) What is the gender and age distribution of patients?

SELECT Gender, Age, COUNT(*) AS Total_Count
FROM healthcare
GROUP BY Gender, Age
ORDER BY Age ASC ;

# Q.2) Which medical conditions are most common among patients?

SELECT Medical_Condition
FROM healthcare
GROUP BY Medical_Condition
ORDER BY COUNT(*) DESC
LIMIT 1 ;

# Q.3) How does patient admission vary by hospital or doctor?

SELECT Hospital,
    COUNT(*) AS Total_Admissions
FROM healthcare
GROUP BY Hospital
ORDER BY 
    Total_Admissions DESC;

#                                  2. Revenue & Billing Analysis

# Q.4) What is the average billing amount per medical condition?

SELECT Medical_Condition,
       ROUND(AVG(Billing_Amount),2) AS Avg_Billing_Amount
FROM healthcare 
GROUP BY Medical_ConditioN
ORDER BY Avg_Billing_Amount DESC ;

# Q.5) Which insurance providers are handling the largest number of claims?

SELECT Insurance_Provider,
       COUNT(*) AS Total_Insurance_Claim
FROM healthcare 
GROUP BY Insurance_Provider
ORDER BY Total_Insurance_Claim DESC ;

# Q.6) Are there monthly trends in billing or patient admissions?

SELECT 
    MONTHNAME(Admission_Date) AS Month,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing_Amount
FROM healthcare 
GROUP BY MONTHNAME(Admission_Date)
ORDER BY Total_Billing_Amount ASC;


#                              3. Operational & Resource Management

# Q.7) What is the average length of stay per medical condition or admission type?

SELECT 
    AVG(Patient_Count) AS Avg_Patient_Per_Condition
FROM (
    SELECT 
        Medical_Condition,
        COUNT(*) AS Patient_Count
    FROM 
        healthcare
    GROUP BY 
        Medical_Condition
) AS condition_counts;

-------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM healthcare;