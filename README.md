# Introduction
Dive into the data job market! Focusing on data analyst roles. This project explores top paying jobs, in-demand skills and where high demands meet high salary in data analytics.
SQL queries? Check them out here : [project_sql_folder](/Project_sql/)
# Background
Driven by a quest to navigate the data analyst job more effectively, this product was borne from a desire to identify top paid and in-demand skills, 
streamlining others work to find optimal job opportunites.
Data for this course was sourced from (https://lukebarousse.com/sql). It's 
packed with useful insights on job titles, salaries, location and essential skills required.
### The questions that I sought out to answer from this analysis is thus:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for Data Analysts?
4. What skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools Used
During this analysis, I harnessed the power of the following tools:
-  **SQL**: The foundation of my analysis, allowing me to unearth and query the database to discover critical details.
- **PostgreSQL:** The database management system (DBMS) of choice, ideal for handling the job posting data
- **Visual Studio Code:** The database editor of choice, my go-to and personal favourite.
- **Git and GitHub:** Essential for version control, for sharing my SQL analysis and scripts, ensuring collaboration and project tracking
# Analysis
Each query for this project aimed at investigating specific aspects of the job analysis market. Here's how I approached the questions:
### Top-paying jobs: 
Aimed at identifying top paying roles. I filtered data analyst roles by location and average annual salary, with my focus on remote jobs. This query shows the high paying jobs in the field:
```SQL
SELECT 
job_id, 
job_title,
job_title_short,
job_via,
job_work_from_home,
job_schedule_type,
job_posted_date,
salary_year_avg,
name as company_name
FROM job_postings_fact
LEFT JOIN company_dim 
ON job_postings_fact.company_id = company_dim.company_id
WHERE (job_title_short = 'Data Analyst' and job_location = 'Anywhere') and (salary_year_avg > 70000)
ORDER BY salary_year_avg desc
LIMIT 10;
```
Here's the breakdown of my findings:

**Salary:** There's a wide salary range in the data analyst roles ranging from $180,000 up to $650,000, indicating significant salary potential for the field.

**Employers:** Diversity of employers is something I also discovered. Companies like SmartAsset, Meta, AT&T are among those ofering higher salaries, showing a broad interest across varying industries.

**Job Title Variety:** There's also a high diversity in job titles, from Data analysts to Director of Analytics, showing varied roles and specializations within the field.

### Top-paying skills:
In this section, I sought to extract the data for the most lucrative skills i.e skills that command higher salaries among data analysts, with a view to knowing where and what skills to hone and sharpen up.

```SQL
WITH TOP_SKILLS AS
(
SELECT job_id, job_title_short, job_via, job_work_from_home, salary_year_avg
FROM job_postings_fact
WHERE (job_title_short = 'Data Analyst' AND job_location = 'Anywhere') AND (salary_year_avg > 70000)
ORDER BY salary_year_avg DESC
)
SELECT job_title_short,
c.skill_id,
c.skills, 
salary_year_avg
FROM TOP_SKILLS a 
INNER JOIN skills_job_dim b
ON a.job_id = b.job_id
INNER JOIN skills_dim c
ON b.skill_id = c.skill_id
ORDER BY salary_year_avg DESC;
```

 Here's the breakdown of my findings: 
- SQL tops out the list of the most lucrative skills to learn in 2023 when vying for the data analyst role, with earnings over $250,000 annually.

-  AWS, Azure and other cloud computing skills equally bring in top dollar of over $200,000.

- Excel, Python, Power BI, tableau, all equally good analytical tools are also highly regarded, and are not too far off SQL in terms of grossing.

**Most In-Demand Skills**

My third analysis was to answer and extract the data for which skills were the most demanded by employers when considering hiring staff for the data analyst role.

```SQL
SELECT count (a.skill_id) AS skill_count, skills
FROM skills_job_dim a
INNER JOIN job_postings_fact b
ON a.job_id = b.job_id
INNER JOIN skills_dim c 
ON a.skill_id = c.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills 
ORDER BY skill_count DESC
LIMIT 10;

```
** Here's the breakdown of my analysis:
- SQL is by far the most sought after skill in the data analysis job market
- Excel, Python, tableau and power bi all follow after in that order
- As a data analyst, these should be the primary skills to focus on honing.

**Average annual salary to skill:**

In this query, my goal was to find out the general average of the annualized salaries of top skills i.e those skills that, on average over  a large dataset, stand out, within the data analyst role.

```SQL
SELECT skills, ROUND(avg(b.salary_year_avg), 0) as avg_salary
FROM skills_job_dim a
INNER JOIN job_postings_fact b
ON a.job_id = b.job_id
INNER JOIN skills_dim c 
ON a.skill_id = c.skill_id
WHERE (job_title_short = 'Data Analyst' AND job_location = 'Anywhere') AND
salary_year_avg is NOT NULL
GROUP BY skills 
ORDER BY avg_salary desc;
```

Here's what I learnt:
- None of the top 5 in-demand skills for a data analyst , over an annualized average earnings analysis earned above $120,000, meaning that even though they're in demand, not a bunch of those employed having those skills earn top dollar from them.
- On average, programming language skills pay out more, even though the niche is smaller. As a matter of fact, that I believe is the reason why on average, they earn higher than the in-demand skills.

**Most Optimal: High paying and high demand**

In this final analysis, after I've analyzed and drawn resourceful insight from the dataset, I've decided to go for the best of both worlds i.e most optimal. This is because the high paying niche jobs will usually be much tougher to land. The in-demand skills gives me a better chance in a competitive market and when paired with a reasonably good salary, it's something more realistic.

```SQL
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
```
Here's what I discovered: 
- The top 5 in demand skills for data analysts are very much valid. Sure the average annual salary does not get up to a $100,000, but its pretty much relevant all-round.
- cloud based data analytics is the most lucrative of the bunch.
- python pays the best of the top 5 in-demand skills on average.
# What I Learnt
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

**Complex Query Crafting:**

- Mastered the art of advanced SQL, merging tables like a pro, also using WITH clauses to merge and blend tables, ninja style!!
- Sharpened up my aggregate function expertise, using clauses like COUNT, AVG, ROUND as worthy companions in SQL analysis.
- My analytical wizardry and critical thinking skills also got turbo charged, with a far better ability to solve complex real world puzzles, turning questions into actionable SQL queries
# Conclusion
*-The top 5 in demand skills for data analysts are very much valid. Sure the average annual salary does not get up to a $100,000, but its pretty much relevant all-round.*

*-On average, programming language skills pay out more, even though the niche is smaller. As a matter of fact, that I believe is the reason why on average, they earn higher than the in-demand skills.*

*-  SQL is by far the most sought after skill in the data analysis job market
Excel, Python, tableau and power bi all follow after in that order.
As a data analyst, these should be the primary skills to focus on honing.*

*-SQL tops out the list of the most lucrative skills to learn in 2023 when vying for the data analyst role, with earnings over $250,000 annually.
AWS, Azure and other cloud computing skills equally bring in top dollar of over $200,000. 
Excel, Python, Power BI, tableau, all equally good analytical tools are also highly regarded, and are not too far off SQL in terms of grossing.*

*-There's a wide salary range in the data analyst roles ranging from $180,000 up to $650,000, indicating significant salary potential for the field.
Diversity of employers is something I also discovered. Companies like SmartAsset, Meta, AT&T are among those ofering higher salaries, showing a broad interest across varying industries. There's also a high diversity in job titles, from Data analysts to Director of Analytics, showing varied roles and specializations within the field.*

### Closing
This project really levelled up my SQL skill querying ability. Critical thinking skills got supercharged. The ability to provide useful insight into the world of job postings data analytics will help my and any other person who chooses to use them to make better choices when scouring for data jobs from all around the world.