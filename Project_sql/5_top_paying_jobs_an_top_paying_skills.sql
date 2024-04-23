 /* QUESTION
 -COMBINATION OF HIGHEST ANNUAL AVERAGE SALARY AND MOST IN-DEMAND SKILL*/

with highest_avg_salary AS(
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
),

in_demand_skills as (
select count (a.skill_id) as skill_count, skills
from skills_job_dim a
inner join job_postings_fact b
on a.job_id = b.job_id
inner join skills_dim c 
on a.skill_id = c.skill_id
where job_title_short = 'Data Analyst'
group by skills 
order by skill_count desc
)

SELECT in_demand_skills.skills, in_demand_skills.skill_count, highest_avg_salary.avg_salary
from highest_avg_salary 
inner join in_demand_skills
on highest_avg_salary.skills = in_demand_skills.skills
order by skill_count desc