-- Question: Find employees who have the highest salary in each of the departments.

-- English Video: 
-- Tamil Video: 


Create table Employee (id int, name varchar(255), salary int, departmentId int);
Truncate table Employee;
insert into Employee (id, name, salary, departmentId) values 
 (1, 'Joe'  , 70000, 1)
,(2, 'Jim'  , 90000, 1)
,(3, 'Henry', 80000, 2)
,(4, 'Sam'  , 60000, 2)
,(5, 'Max'  , 90000, 1);

Create table Department (id int, name varchar(255));
Truncate table Department;
insert into Department (id, name) values 
 (1, 'IT')
,(2, 'Sales');

/*
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
*/

-- Approach 1: Using CTE table 
with raw_data as (
select departmentId, max(salary) as salary
       from Employee 
   group by 1)
select d.name as Department,
       e.name as Employee,
       e.salary
       from Employee e 
 inner join raw_data r 
         on r.departmentId = e.departmentId 
        and r.salary = e.salary
 inner join Department d 
         on d.id = e.departmentId;

-- Approach 2: Using Subquery Table
select d.name as Department,
       e.name as Employee,
       e.salary
       from Employee e 
 inner join (select departmentId, max(salary) as salary
                    from Employee 
                group by 1) r 
         on r.departmentId = e.departmentId 
        and r.salary = e.salary
 inner join Department d 
         on d.id = e.departmentId;

-- Approach 3: Using Correlated Qubquery table
select d.name as Department,
       e.name as Employee,
       e.salary 
       from Employee e 
 inner join Department d 
         on d.id = e.departmentId
        and e.salary = (select max(ee.salary) as salary
                               from Employee ee
                              where ee.departmentId = e.departmentId )

-- Approach 4: Using concatenated values
select d.name as Department,
       e.name as Employee,
       e.salary 
       from Employee e 
 inner join Department d 
         on d.id = e.departmentId
        and (e.departmentId, e.salary) in (select ee.departmentid, 
                                                  max(ee.salary) as salary
                                                  from Employee ee
                                              group by 1 )

-- Approach 5: Using WINDOWS function
with raw_data as (
select d.name as Department,
       e.name as Employee,
       e.salary,
       dense_rank() over(partition by d.name order by e.salary desc) as rnum 
       from Employee e 
 inner join Department d 
         on d.id = e.departmentId)
select Department, 
       Employee, 
       Salary
       from raw_data 
      where rnum = 1;
