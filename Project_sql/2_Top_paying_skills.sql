/* QUESTION
- what skills are required for the top paying Data Analyst jobs?
- Reference the top 10 highest paying jobs from the first query
- Add the specific skills equired for these roles
- Why? It provides a detailed look at which high paying jobs demand certain skills, 
helping job_sekers hone and develop these skills to enable them land top_paying jobs...
*/

WITH TOP_SKILLS AS
(
select job_id, job_title_short, job_via, job_work_from_home, salary_year_avg
from job_postings_fact
where (job_title_short = 'Data Analyst' and job_location = 'Anywhere') and (salary_year_avg > 70000)
order by salary_year_avg desc
)
SELECT job_title_short,
c.skill_id,
c.skills, 
salary_year_avg
FROM TOP_SKILLS a 
inner join skills_job_dim b
on a.job_id = b.job_id
inner join skills_dim c
on b.skill_id = c.skill_id
order by salary_year_avg desc

