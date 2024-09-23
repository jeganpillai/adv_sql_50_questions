-- Question: Find the Team size for each employee
Create table If Not Exists Employee (employee_id int, team_id int);
Truncate table Employee;
insert into Employee (employee_id, team_id) values 
 (1, 8)
,(2, 8)
,(3, 8)
,(4, 7)
,(5, 9)
,(6, 9);

-- expected output is: 
+-------------+------------+
| employee_id | team_size  |
+-------------+------------+
|     1       |     3      |
|     2       |     3      |
|     3       |     3      |
|     4       |     1      |
|     5       |     2      |
|     6       |     2      |
+-------------+------------+
  
-- Approach 1: Using CTE logic 
with agg_data as (
    select team_id, count(team_id) as team_size from Employee group by 1
)
select e.employee_id,
       a.team_size
       from Employee e 
 inner join agg_data a 
         on a.team_id = e.team_id; 

-- Approach 2: Using subquery table 
select e.employee_id,
       a.team_size
       from Employee e 
 inner join (select team_id, count(team_id) as team_size from Employee group by 1) a 
         on a.team_id = e.team_id 

-- Approach 3: Using windows function
select employee_id,
       count(*) over(partition by team_id) as team_size 
       from Employee ;
