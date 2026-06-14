
CREATE database TnP;
USE TnP;

-- creating and importing tables

CREATE TABLE students(
	student_id varchar(50) PRIMARY KEY ,
    branch varchar(50),
    gender varchar(50),
    age int,
    cgpa decimal(3,1),
    project_count int
    );
CREATE TABLE skills(
	student_id varchar(50) PRIMARY KEY ,
    branch varchar(50),
    excel_skill int,
    sql_skill int,
    tableau_skill int,
    python_skill int,
    communication_skill int
    );
    
CREATE TABLE internships(
	student_id varchar(50) PRIMARY KEY ,
    internship_count int,
    branch varchar(50),
    internship_domain varchar(50)
    );
CREATE TABLE placements(
	student_id varchar(50) PRIMARY KEY ,
    branch varchar(50),
    placement_status varchar(50),
    company varchar(50),
    package decimal(4,2)
    );
    
-- verifying imported data

select * from students
limit 10;
select * from skills
limit 10;
select * from internships
limit 10;
select * from placements
limit 10;

-- data quality check

select *
from placements
where placements.placement_status='placed'
and company=' ';

select *
from placements
where placements.package<0;

select student_id,
count(*)
from students
group by student_id
having count(*)>1;

-- total students

select count(*) as total_students
from students;

-- total placed students

select count(*) as total_placed_students
from placements
where placement_status='placed';

-- placement rate

SELECT ROUND(
100*SUM(CASE WHEN placement_status='Placed' THEN 1 ELSE 0 END)/COUNT(*),
2) AS placement_rate
FROM placements;

-- avg package

select avg(package)
from placements
where placement_status='placed';

-- branch analysis

select placements.branch,
ROUND(
100*SUM(CASE WHEN placement_status='Placed' THEN 1 ELSE 0 END)/COUNT(*),
2) AS placement_rate
FROM placements
group by branch;

-- avg packagae by branch

select placements.branch,
avg(package)
from placements
where placement_status='placed'
group by branch;

-- skill analysis

SELECT
ROUND(AVG(excel_skill),2),
ROUND(AVG(sql_skill),2),
ROUND(AVG(tableau_skill),2),
ROUND(AVG(python_skill),2)
FROM skills s
JOIN placements p
ON s.student_id=p.student_id
WHERE p.placement_status='Placed';

-- cgpa analysis

select 
case
when cgpa>8 then 'high'
when cgpa<6.5 then 'low'
else 'medium'
end cgpa_group,
count(*) total_students,
sum(case when placement_status='placed' then 1 else 0 end) placed_students
from students
join placements
on students.student_id=placements.student_id
group by cgpa_group;

-- end










