
/* QUESTION
-Highest paying skills coefficient to average annual salary*/


select skills, ROUND(avg(b.salary_year_avg), 0) as avg_salary
from skills_job_dim a
inner join job_postings_fact b
on a.job_id = b.job_id
inner join skills_dim c 
on a.skill_id = c.skill_id
where (job_title_short = 'Data Analyst' AND job_location = 'Anywhere') and
salary_year_avg is NOT NULL
group by skills 
order by avg_salary desc
