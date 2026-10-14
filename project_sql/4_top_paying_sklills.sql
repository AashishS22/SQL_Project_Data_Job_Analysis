/*
What are the top skills based on salary?
- Look at the average salary associated with each skills for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location.
why? : It reveals how different skills impact salary levels for Data analysts and 
helps identify the most financially rewarding skills to acquire or improve. 
*/


select
    s.skills,
    Round(avg(f.salary_year_avg),0) as average_salary
from skills_dim s
inner join skills_job_dim d
    on s.skill_id = d.skill_id
inner join job_postings_fact f
    on d.job_id = f.job_id
where job_title_short = 'Data Engineer'
AND f.salary_year_avg is not null
Group by s.skills 
order by average_salary Desc
limit 25


/*
Software development skills lead: Node ($181,862) and Mongo ($179,403) top the list, suggesting overlap between highly paid data engineering and application development roles.
Specialized data systems stand out: Cassandra ($150,255), Scala ($143,161), and Kafka ($143,086) feature among the highest-paying skills.
Niche skills need context: Solidity and Clojure rank highly, but without posting counts, a few high-paying roles could inflate their averages.




[
  {
    "skills": "node",
    "average_salary": "181862"
  },
  {
    "skills": "mongo",
    "average_salary": "179403"
  },
  {
    "skills": "ggplot2",
    "average_salary": "176250"
  },
  {
    "skills": "solidity",
    "average_salary": "166250"
  },
  {
    "skills": "vue",
    "average_salary": "159375"
  },
  {
    "skills": "codecommit",
    "average_salary": "155000"
  },
  {
    "skills": "ubuntu",
    "average_salary": "154455"
  },
  {
    "skills": "clojure",
    "average_salary": "153663"
  },
  {
    "skills": "cassandra",
    "average_salary": "150255"
  },
  {
    "skills": "rust",
    "average_salary": "147771"
  },
  {
    "skills": "drupal",
    "average_salary": "147500"
  },
  {
    "skills": "perl",
    "average_salary": "145540"
  },
  {
    "skills": "next.js",
    "average_salary": "145000"
  },
  {
    "skills": "angular",
    "average_salary": "143319"
  },
  {
    "skills": "scala",
    "average_salary": "143161"
  },
  {
    "skills": "kafka",
    "average_salary": "143086"
  },
  {
    "skills": "gdpr",
    "average_salary": "142369"
  },
  {
    "skills": "shell",
    "average_salary": "141725"
  },
  {
    "skills": "macos",
    "average_salary": "141617"
  },
  {
    "skills": "numpy",
    "average_salary": "141605"
  },
  {
    "skills": "opencv",
    "average_salary": "141250"
  },
  {
    "skills": "atlassian",
    "average_salary": "140644"
  },
  {
    "skills": "ibm cloud",
    "average_salary": "140547"
  },
  {
    "skills": "splunk",
    "average_salary": "140156"
  },
  {
    "skills": "kubernetes",
    "average_salary": "140092"
  }
]






*/