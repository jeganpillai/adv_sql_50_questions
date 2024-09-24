-- Question: Report the most experienced employees in each project.

-- English Video: 
-- Tamil Video: 

Create table Project(project_id int, employee_id int);
Truncate table Project;
insert into Project (project_id, employee_id) values 
 (1, 1)
,(1, 2)
,(1, 3)
,(2, 1)
,(2, 4);

Create table Employee (employee_id int, 
                       name varchar(10), 
                       experience_years int);
Truncate table Employee;
insert into Employee (employee_id, name, experience_years) values 
 (1, 'Khaled', 3)
,(2, 'Ali'   , 2)
,(3, 'John'  , 3)
,(4, 'Doe'   , 2);

/*
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
*/

-- Approach 1: Using CTE table 
with raw_data as (
select p.project_id,
       max(experience_years) as max_experience_years
       from Project p 
 inner join Employee e 
         on e.employee_id = p.employee_id 
   group by 1)
select p.project_id,
       p.employee_id
       from Project p 
 inner join Employee e 
         on e.employee_id = p.employee_id 
 inner join raw_data as r 
         on r.project_id = p.project_id 
        and r.max_experience_years = e.experience_years;

-- Approach 2: subquery table 
select p.project_id,
       p.employee_id
       from Project p 
 inner join Employee e 
         on e.employee_id = p.employee_id 
 inner join (select p.project_id,
                    max(experience_years) as max_experience_years
                    from Project p 
              inner join Employee e 
                      on e.employee_id = p.employee_id 
                group by 1) as r 
         on r.project_id = p.project_id 
        and r.max_experience_years = e.experience_years;

-- Approach 3: Correlated Subquery
select p.project_id,
       p.employee_id
       from Project p 
 inner join Employee e 
         on e.employee_id = p.employee_id 
        and e.experience_years = (select max(ee.experience_years) as max_experience_years
                                         from Project pp
                                   inner join Employee ee 
                                           on ee.employee_id = pp.employee_id 
                                          and pp.project_id = p.project_id);

-- Approach 4: Using concatenation 
select p.project_id,
       p.employee_id
       from Project p 
 inner join Employee e 
         on e.employee_id = p.employee_id 
        and (p.project_id, e.experience_years) in (select pp.project_id, 
                                                          max(ee.experience_years) as max_experience_years
                                         from Project pp
                                   inner join Employee ee 
                                           on ee.employee_id = pp.employee_id 
                                           group by 1);

-- Approach 5: Using windows function 
WITH RankedEmployees AS (
SELECT p.project_id,
       e.employee_id,
       e.experience_years,
       dense_RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS experience_rank
       FROM Employee e
 INNER JOIN Project p ON p.employee_id = e.employee_id)
SELECT project_id,
       employee_id
       FROM RankedEmployees
      WHERE experience_rank = 1;
