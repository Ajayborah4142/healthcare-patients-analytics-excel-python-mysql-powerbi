# Healthcare Analysis

**Project:** Patient Demographics, Revenue & Operational Analysis (Ecxel,Python,MySQL,Power BI)

**Description**

This repository contains a complete MySQL-based analytics project for a synthetic healthcare dataset. The goal is to demonstrate how to load healthcare records into a relational database, run analysis queries, and extract operational and business insights (patient demographics, billing/revenue, resource utilization, insurance activity, and treatment correlations).

---

## Contents of this repository

* `data_cleaning.ipynb` — Python notebook where initial data cleaning, preprocessing, and exploratory analysis were performed using `Pandas` and `Matplotlib`.

* `visualizations/` — (optional) includes charts/plots generated from Python analysis to augment SQL findings.

* `healthcare_schema.sql` — SQL script that creates the `Healthcare_db` database and `healthcare` table and includes the `LOAD DATA LOCAL INFILE` statement to import CSV data.

* `queries.sql` — Collection of analytical SQL queries (grouping, aggregation, ranking) used to generate the insights described in this README.

* `README.md` — (you are reading it) project overview, how to run the scripts, and interpretation of results.

* `data/healthcare_dataset.csv` — The CSV dataset (NOT included in repo; see instructions below on how to add it). **Do not** add PHI or sensitive real patient data to the public repo.

---

## Schema (table `healthcare`)

The `healthcare` table used in this project has the following columns:

* `Name` VARCHAR(100)
* `Age` INT
* `Gender` VARCHAR(100)
* `Blood_Type` VARCHAR(100)
* `Medical_Condition` VARCHAR(100)
* `Admission_Date` DATE
* `Doctor` VARCHAR(100)
* `Hospital` VARCHAR(100)
* `Insurance_Provider` VARCHAR(100)
* `Billing_Amount` FLOAT
* `Room_Number` INT
* `Admission_Type` VARCHAR(100)
* `Discharge_Date` DATE
* `Medication` VARCHAR(100)
* `Test_Results` VARCHAR(100)

(See `healthcare_schema.sql` for the exact CREATE TABLE statement and the `LOAD DATA` command.)

---

## Quickstart — run locally (MySQL)

1. Install MySQL (8.0+ recommended) and enable `local_infile` if needed.
2. Place your CSV file at `data/healthcare_dataset.csv` inside the repository (or update the path in the SQL script).
3. From a MySQL client (or CLI) run the schema script:

```sql
-- open your MySQL client and run
SOURCE healthcare_schema.sql;
```

4. Verify data loaded with:

```sql
USE Healthcare_db;
SELECT COUNT(*) FROM healthcare;
SELECT * FROM healthcare LIMIT 10;
```

> If `LOAD DATA LOCAL INFILE` fails, ensure the MySQL server and client allow `local_infile` and that your client session has the `LOCAL` capability. Example workaround:

```sql
SET GLOBAL local_infile = 1;
-- then reconnect the client and run LOAD DATA LOCAL INFILE ...
```

---

## Analytical queries included

The `queries.sql` file includes a curated set of SQL queries grouped into three main categories. Below is a short description of each query (full SQL is in `queries.sql`):

### 1) Patient Demographics & Service Optimization

* Gender & age distribution of patients (GROUP BY Gender, Age)
* Most common medical conditions (top 1 and top N)
* Admissions by hospital and by doctor (top admitting hospitals/doctors)

### 2) Revenue & Billing Analysis

* Average billing amount per medical condition
* Top insurance providers by claim count
* Monthly billing and admission trends (GROUP BY MONTHNAME(Admission_Date))

### 3) Operational & Resource Management

* Average patient count per medical condition (derived aggregation)
* Most frequently used room numbers
* Most prescribed medications
* Discharge and recovery counts by doctor
* Correlation of test results to average billing amount
* Most common admission types (Elective, Urgent, Emergency)

Each query is followed by the observed result from the sample dataset (for reproducibility and to help you validate your run). See `queries.sql` for the executable SQL.

---

## Findings (summary of results from the sample dataset)

> The following is a high-level summary extracted from the dataset used while developing this project. Re-run the queries on your data to confirm.

* **Age & Gender:** The dataset includes a wide age range (teens through 80s). There are clear counts per age and gender — useful for targeted services and staffing.
* **Most common condition:** *Arthritis* was the top single medical condition by record count in the sample run.
* **Top billed conditions:** Conditions showing the highest average billing were Obesity, Diabetes, Asthma, Arthritis, Hypertension, and Cancer (in descending order by sample averages).
* **Insurance providers:** Cigna, Medicare, UnitedHealthcare, Blue Cross, and Aetna were the largest providers by claim count.
* **Monthly revenue pattern:** The dataset shows monthly variation in total billing, with `February` being the lowest and `July/August` the highest in the sample.
* **Resource hotspots:** Some rooms (e.g., 393, 491, 420) appear more frequently used — these may be high-turnover or specialty rooms.
* **Medications:** Top prescribed items included Lipitor, Ibuprofen, Aspirin, Paracetamol, and Penicillin.
* **Test result correlation:** Average billing across `Normal`, `Inconclusive`, and `Abnormal` test results was similar (sample averages are within a narrow band), suggesting more analysis is needed to detect cost drivers.

---

## Key Metrics at a Glance

* **Total Patients:** 55,000
* **Unique Medical Conditions:** 6 (Arthritis, Diabetes, Hypertension, Asthma, Obesity, Cancer)
* **Top Insurance Provider:** Cigna (11,249 claims)
* **Average Billing Amount:** $25,537
* **Most Frequent Admission Type:** Elective
* **Highest Monthly Revenue:** July ($122.75M)
* **Lowest Monthly Revenue:** February ($107.89M)
* **Most Prescribed Medication:** Lipitor (11,140 prescriptions)
* **Room with Highest Turnover:** Room 393 (181 patients)

## Findings (summary of results from the sample dataset)

> The following is a high-level summary extracted from the dataset used while developing this project. Re-run the queries on your data to confirm.

* **Age & Gender:** The dataset includes a wide age range (teens through 80s). There are clear counts per age and gender — useful for targeted services and staffing.
* **Most common condition:** *Arthritis* was the top single medical condition by record count in the sample run.
* **Top billed conditions:** Conditions showing the highest average billing were Obesity, Diabetes, Asthma, Arthritis, Hypertension, and Cancer (in descending order by sample averages).
* **Insurance providers:** Cigna, Medicare, UnitedHealthcare, Blue Cross, and Aetna were the largest providers by claim count.
* **Monthly revenue pattern:** The dataset shows monthly variation in total billing, with `February` being the lowest and `July/August` the highest in the sample.
* **Resource hotspots:** Some rooms (e.g., 393, 491, 420) appear more frequently used — these may be high-turnover or specialty rooms.
* **Medications:** Top prescribed items included Lipitor, Ibuprofen, Aspirin, Paracetamol, and Penicillin.
* **Test result correlation:** Average billing across `Normal`, `Inconclusive`, and `Abnormal` test results was similar (sample averages are within a narrow band), suggesting more analysis is needed to detect cost drivers.

---

## Next steps & recommendations

1. **Data quality checks:** Add scripts to validate and clean columns (missing dates, anomalous ages, negative billing values, inconsistent medication names).
2. **Indexing for performance:** Add indexes on `Admission_Date`, `Medical_Condition`, `Hospital`, and `Insurance_Provider` for faster analytical queries.
3. **Longitudinal analysis:** Compute patient-level time series (readmissions, average length of stay, cost per episode) by adding unique patient identifiers.
4. **Visualizations:** Create dashboards (Tableau/Power BI or Python notebooks with matplotlib/plotly) to show monthly revenue trends, age/gender pyramids, top conditions, and bed occupancy heatmaps.
5. **Privacy:** Before publishing any real dataset, remove or anonymize personally identifying information (names, exact dates, addresses). Consider the HIPAA/GDPR implications if using real patient data.

---

## Files to commit / not commit

* ✅ `healthcare_schema.sql` (commit)
* ✅ `queries.sql` (commit)
* ✅ `README.md` (commit)
* ✅ `data/healthcare_dataset.csv` 

Add a `.gitignore` entry for `data/*.csv` if you store raw CSVs locally but don't want them in the repo.

---

## How to cite / credit

This project was prepared as a demonstration of SQL-based healthcare analytics. If you reuse these queries or scripts, please credit the author in the repository `CONTRIBUTING` or the notebook header.

---

## 👨‍💻 Author

**Ajay Borah**  
📧 Email: [ajayborah4142@gmail.com]  
💼 GitHub: [https://github.com/Ajayborah4142] 
🧠 Passionate about SQL, data analytics, and business insights.  
