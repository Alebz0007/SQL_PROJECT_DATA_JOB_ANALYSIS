
/* QUESTION
-Highest paying skills coefficient to average annual salary*/


SELECT skills, ROUND(avg(b.salary_year_avg), 0) as avg_salary
FROM skills_job_dim a
INNER JOIN job_postings_fact b
ON a.job_id = b.job_id
INNER JOIN skills_dim c 
ON a.skill_id = c.skill_id
WHERE (job_title_short = 'Data Analyst' AND job_location = 'Anywhere') AND
salary_year_avg is NOT NULL
GROUP BY skills 
ORDER BY avg_salary desc
