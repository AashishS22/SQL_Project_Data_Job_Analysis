/* 
Question: What are the top-paying Data Analyst jobs?
- identify tje top 10 highest-paying Data Analyst roles that are available remotely. 
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into  employment opportuniteies 
*/

select 
    f.job_id,
    f.job_title,
    f.job_location,
    f.job_schedule_type,
    f.salary_year_avg,
    f.job_posted_date,
    d.name as company_name
from job_postings_fact f
left join company_dim d 
    on f.company_id = d.company_id
where f.job_title_short = 'Data Analyst'
    AND f.job_location = 'Anywhere'
    AND f.salary_year_avg is not null
order by f.salary_year_avg desc
limit 10;