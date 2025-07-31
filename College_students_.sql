CREATE TABLE college  (
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
FROM college
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

































