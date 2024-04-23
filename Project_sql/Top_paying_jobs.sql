/* QUESTION
- What are the top paying Data Analyst jobs?
- Identify the top 10 highest paying Data Analyst Roles that are available remotely
- Focus on job postings with specified salaries (not null values)
-Why this? Highlights the top paying opportunites for Data Analysts, offering insights into employment forecasts
*/

select 
job_id, 
job_title,
job_title_short,
job_via,
job_work_from_home,
job_schedule_type,
job_posted_date,
salary_year_avg,
name as company_name
from job_postings_fact
left join company_dim 
on job_postings_fact.company_id = company_dim.company_id
where (job_title_short = 'Data Analyst' and job_location = 'Anywhere') and (salary_year_avg > 70000)
order by salary_year_avg desc
limit 10