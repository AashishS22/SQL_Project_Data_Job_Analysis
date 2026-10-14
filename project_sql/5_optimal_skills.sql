with skills_demand as (
    select
        s.skill_id,
        s.skills,
        count(d.job_id) as job_counts
    from skills_dim s
    inner join skills_job_dim d
        on s.skill_id = d.skill_id
    inner join job_postings_fact f
        on d.job_id = f.job_id
    where job_title_short = 'Data Analyst'
        AND salary_year_avg is not null
        And job_work_from_home = True
    Group by s.skill_id
 
),
average_salary as (
    select
        s.skill_id,
        s.skills,
        Round(avg(f.salary_year_avg),0) as avg_salary
    from skills_dim s
    inner join skills_job_dim d
        on s.skill_id = d.skill_id
    inner join job_postings_fact f
        on d.job_id = f.job_id
    where job_title_short = 'Data Analyst'
        AND f.salary_year_avg is not null
    Group by s.skill_id
   
)
select 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.job_counts,
    average_salary.avg_salary
from skills_demand
inner join average_salary
    on skills_demand.skill_id = average_salary.skill_id
order by  avg_salary desc,
        job_counts Desc
       
limit 20;
