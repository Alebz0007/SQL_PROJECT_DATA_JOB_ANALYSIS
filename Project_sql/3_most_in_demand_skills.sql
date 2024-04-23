/* QUESTION
- Most in=demand skills for my role
-Important to know the top skills to focus on honing
*/

select count (a.skill_id) as skill_count, skills
from skills_job_dim a
inner join job_postings_fact b
on a.job_id = b.job_id
inner join skills_dim c 
on a.skill_id = c.skill_id
where job_title_short = 'Data Analyst'
group by skills 
order by skill_count desc
limit 10