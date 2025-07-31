# 🎓 Student Placement Analysis with SQL

This project focuses on analyzing student placement patterns using SQL. It investigates key academic, behavioral, and experiential factors like **IQ**, **CGPA**, **internship experience**, and **projects completed**, and how they influence a student's likelihood of getting placed.

---

## 📁 Dataset: `college_student_placement_dataset.csv`

### Key Columns:

| Column Name             | Description                                     |
|-------------------------|-------------------------------------------------|
| `college_id`            | Unique ID for each student                     |
| `iq`                    | IQ score of the student                        |
| `prev_sem_result`       | Previous semester result (float)               |
| `cgpa`                  | CGPA (Cumulative GPA)                          |
| `academic_performance` | Academic score (normalized)                    |
| `internship_experience`| Whether student had internship (`True/False`)  |
| `extra_curricular_score`| Score in extracurricular activities           |
| `communication_skills` | Communication score                            |
| `projectes_completed`  | Number of completed academic projects          |
| `placement`            | Whether student was placed (`True/False`)     |

---

## 📊 Objectives & KPIs

### ✅ Overall Metrics

| KPI | Description                         | SQL |
|-----|-------------------------------------|-----|
| 1   | Total Students                      | `SELECT COUNT(*) FROM college;` |
| 2   | Total Placed Students               | `SELECT COUNT(*) FROM college WHERE placement = true;` |
| 3   | Overall Placement Rate (%)          | `ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*), 2)` |

### 📈 IQ & Academic Performance

| KPI | Question                                             | SQL |
|-----|------------------------------------------------------|-----|
| 4   | Average IQ of placed students                        | `SELECT AVG(CAST(iq AS FLOAT)) FROM college WHERE placement = 'true';` |
| 5   | Average CGPA of placed vs. non-placed students       | `SELECT AVG(cgpa), placement FROM college GROUP BY placement;` |
| 6   | Top 5 students with highest IQ among those placed    | `SELECT college_id, iq FROM college WHERE placement = true ORDER BY CAST(iq AS FLOAT) DESC LIMIT 5;` |

### 🛠️ Internships & Projects

| KPI | Question                                                                 | SQL |
|-----|--------------------------------------------------------------------------|-----|
| 7   | Placement rate with vs. without internship experience                    | See full query below 👇 |
| 8   | Total students with internship                                           | `SELECT COUNT(*) FROM college WHERE internship_experience = true;` |
| 9   | Total students without internship                                        | `SELECT COUNT(*) FROM college WHERE internship_experience = false;` |
| 10  | Placement count (with internship)                                        | `SELECT COUNT(*) FROM college WHERE internship_experience = true AND placement = true;` |
| 11  | Placement count (without internship)                                     | `SELECT COUNT(*) FROM college WHERE internship_experience = false AND placement = true;` |
| 12  | Placement rate (with internship)                                         | `ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*), 2)` where internship = true |
| 13  | Placement rate (without internship)                                      | same as above, where internship = false |

---

## 🧠 Key Insight

> 📌 Students **with internship experience** have significantly higher placement rates (~80–85%) compared to those without (~50%).  
> 💡 Recommendation: Encourage internships & project-based learning to improve placement outcomes.

---

## 🧾 Full SQL Query (Internship vs Placement Rate)

```CREATE TABLE college  (
			college_id VARCHAR(100),
			iq VARCHAR(50),
			prev_sem_result FLOAT,
			cgpa FLOAT,
			academic_performance INT ,
			internship_experience BOOLEAN,
			extra_curricular_score INT,
			communication_skills INT,
			projectes_completed INT,
			placement BOOLEAN)

			--  Overall Placement Metrics

SELECT*FROM college

-- 1.Total students

SELECT COUNT(*) AS No_Of_Students FROM college 

-- 2.Total Placed Students

SELECT COUNT(*) AS Total_Students_placed FROM college
WHERE placement = true

-- 3. Placement rate 

SELECT
ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*),2) AS placement_rate
FROM 
college


				-- IQ & Academic Performance

-- 4.What is the average IQ of placed students?
select*from college

SELECT Placement, AVG(CAST(IQ AS FLOAT)) AS avg_iq
FROM college
WHERE Placement = 'Yes'
GROUP BY Placement;

-- 5.What is the average CGPA of placed vs. non-placed students?

SELECT AVG(cgpa) AS avg_cgpa , placement
FROM college
GROUP BY 2

-- 6.Who are the top 5 students with the highest IQ among those placed?
SELECT college_id , iq 
FROM college
GROUP BY 1,2
limit 5

			-- INTERNSHIPS & PROJECTS

			
-- 7 What is the placement rate among students with vs. without internship experience?

SELECT*FROM college

SELECT internship_experience ,
ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*),2) AS placement_rate
FROM college
GROUP BY 1

-- 	Total Students With Internship

SELECT COUNT(college_id ) AS Students_With_Internship
FROM college
WHERE internship_experience =true

-- 	Total Students Without Internship


SELECT COUNT(college_id ) AS Students_Without_Internship
FROM college
WHERE internship_experience =false

--  Placement Count (With Internship)

SELECT COUNT(placement)
FROM college
WHERE internship_experience = true

-- Placement Count (Without Internship)

SELECT COUNT(placement)
FROM college
WHERE internship_experience = false

--	Placement Rate With Internship (%)
SELECT ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*),2) AS placement_rate
FROM college
WHERE internship_experience = true

-- 	Placement Rate Without Internship (%)

SELECT ROUND(100.0 * SUM(CASE WHEN placement = 'true' THEN 1 ELSE 0 END)/COUNT(*),2) AS placement_rate
FROM colleges
WHERE internship_experience = false


SELECT 
    internship_experience,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement = 'True' THEN 1 ELSE 0 END) AS total_placed,
    ROUND(
        100.0 * SUM(CASE WHEN placement = 'True' THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS placement_rate_percentage
FROM 
    college
GROUP BY 
    internship_experience;






















