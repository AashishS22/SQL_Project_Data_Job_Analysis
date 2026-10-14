/*
Question: What are the most in-demand skills for data Analyst?
- Retrives the top 5 skills with thr highest demand in the job market,
providing insights into the most valuable skills for job seekers. 

*/




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
Group by s.skill_id, s.skills 
order by  count(d.job_id) desc
limit 5
