select
    job_schedule_type,
    avg(salary_year_avg) as avg_salary,
    avg(salary_hour_avg) as avg_hour_salary
from job_postings_fact
where job_posted_date > '2023-06-01'
group by  job_schedule_type;


select 
    extract( month from job_posted_date at time zone 'UTC' at time zone 'EST') as month,
    count(*) as number_of_job_postings
from job_postings_fact  
where 
    EXTRACT(year from job_posted_date) = 2023
group by 
    month
order by 
    month;
 

select
   d.name as company_name
from company_dim d
Inner join  job_postings_fact f
on d.company_id = f.company_id
where f.job_health_insurance = True
AND Extract(Quarter from f.job_posted_date) = 2;

create table january_jobs as 
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1
    AND extract(year from job_posted_date) = 2023;

create table february_jobs as 
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 2
    AND extract(year from job_posted_date) = 2023;

create table march_jobs as 
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 3
    AND extract(year from job_posted_date) = 2023;

    select 
        *
    from march_jobs;
    


/* Case satements */

select
    count(job_id) as number_of_jobs,
    case job_location 
        when 'Anywhere' then 'Remote'
        when 'New York, NY' then 'local'
        else 'Onsite'
        end as location_category
from job_postings_fact
where job_title_short = 'Data Engineer'
group by location_category;


with company_job_counts as ( 
    select 
        company_id,
        count(*) total_jobs
    from job_postings_fact
    group by company_id
)

select 
    c.name as company_name,
    j.total_jobs
from company_dim c
left join company_job_counts j
on c.company_id = j.company_id
order by total_jobs desc;



select
    s.skill_id,
    d.skills,
    s.job_counts

from (
    select 
        skill_id,
        count(job_id) as job_counts
    from skills_job_dim
    Group by skill_id
    order by count(job_id) desc
    limit 5) as s
 inner join skills_dim d 
 on s.skill_id = d.skill_id;




with total_job_postings as (
    select 
        f.company_id as company_id,
        d.name as company_name,
        count(*) as job_counts
    from job_postings_fact f
    inner join company_dim d 
        on f.company_id = d.company_id
    Group by f.company_id, d.name 
    order by count(*) desc
    )
select 
    company_id,
    company_name,
    job_counts,
    case 
        when job_counts > 50 then 'Large'
        when job_counts > 10 then' Medium'
        else 'Small'
        end as business_category
from total_job_postings;



with remote_job_counts as (
    select
        s.skill_id,
        s.skills as skill_name,
        count(*) as job_counts
    from skills_dim s 
    inner join skills_job_dim d
        on s.skill_id = d.skill_id
    inner join job_postings_fact f
        on d.job_id = f.job_id
    where f.job_work_from_home = True
    and f.job_title_short = 'Data Engineer'
    Group by s.skill_id, s.skills
    )
select 
    skill_id,
    skill_name,
    job_counts
from remote_job_counts
order by job_counts desc
limit 5;




with job_skills as (
    select
        s.skills,
        s.type,
        j.job_id
    from skills_dim s
    left join skills_job_dim j
    on s.skill_id = j.skill_id
)
select 
    s2.skills,
    type
from job_skills s2
left join job_postings_fact f
on s2.job_id = f.job_id
where Extract(Quarter from f.job_posted_date) = 1
and salary_year_avg > 70000;

select * 
from (
    select *
    from january_jobs
    union all
    select *
    from february_jobs
    union all
    select *
    from march_jobs) AS  first_quarter_jobs
where salary_year_avg > 70000
and job_title_short = 'Data Engineer';










