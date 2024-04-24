 /* QUESTION
 -COMBINATION OF HIGHEST ANNUAL AVERAGE SALARY AND MOST IN-DEMAND SKILL*/

WITH highest_avg_salary AS(
SELECT skills, ROUND(avg(b.salary_year_avg), 0) AS avg_salary
FROM skills_job_dim a
INNER JOIN job_postings_fact b
ON a.job_id = b.job_id
INNER JOIN skills_dim c 
ON a.skill_id = c.skill_id
WHERE (job_title_short = 'Data Analyst' AND job_location = 'Anywhere') AND
salary_year_avg IS NOT NULL
GROUP BY skills 
ORDER BY avg_salary DESC
),

in_demand_skills AS (
SELECT count (a.skill_id) as skill_count, skills
FROM skills_job_dim a
INNER JOIN job_postings_fact b
ON a.job_id = b.job_id
INNER JOIN skills_dim c 
ON a.skill_id = c.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills 
ORDER BY skill_count DESC
)

SELECT in_demand_skills.skills, in_demand_skills.skill_count, highest_avg_salary.avg_salary
FROM highest_avg_salary 
INNER JOIN in_demand_skills
ON highest_avg_salary.skills = in_demand_skills.skills
ORDER BY skill_count desc