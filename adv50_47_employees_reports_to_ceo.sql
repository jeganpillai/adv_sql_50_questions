-- Question: Employees Reports to CEO

-- English Video: 
-- Tamil Video: 

Create table Employees 
(employee_id int, employee_name varchar(30), manager_id int);
Truncate table Employees;
insert into Employees (employee_id, employee_name, manager_id) values
( 1, 'CEO'  , 1),
( 3, 'Alice' , 3),
( 2, 'Bob'   , 1),
( 4, 'Daniel', 2),
( 7, 'Luis'  , 4),
( 8, 'John'  , 3),
( 9, 'Angela', 8),
(77, 'Robert', 1);

/*
+-------------+---------------+
| employee_id | employee_name |
+-------------+---------------+
|           2 | Bob           |
|          77 | Robert        |
|           4 | Daniel        |
|           7 | Luis          |
+-------------+---------------+
*/

-- Approach 1: Using Subquery 
with first_level as (
select employee_id, employee_name
       from Employees
      where manager_id = 1 
        and employee_id <> 1 )
,second_level as (
select distinct a.employee_id, a.employee_name
       from Employees a 
 inner join first_level b 
         on b.employee_id = a.manager_id)
 select distinct a.employee_id, a.employee_name
        from Employees a 
  inner join second_level b 
          on b.employee_id = a.manager_id
 union all 
 select a.employee_id, a.employee_name from second_level a
 union all 
 select a.employee_id, a.employee_name from first_level a ;



-- Approach 2: Using recursive option 
 with recursive first_level as (
select employee_id, employee_name
       from Employees
      where manager_id = 1 
        and employee_id <> 1 
union all 
select a.employee_id, a.employee_name
       from Employees a 
 inner join first_level b 
         on b.employee_id = a.manager_id
)
select * from first_level ;

