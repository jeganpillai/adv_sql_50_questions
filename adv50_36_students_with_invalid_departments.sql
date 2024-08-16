-- Question: Report the name of all students who are enrolled in departments that no longer exist

-- English Video: 
-- Tamil Video: 


Create table Departments (id int, name varchar(30));
Truncate table Departments;
insert into Departments (id, name) values 
 ( 1, 'Electrical Engineering')
,( 7, 'Computer Engineering')
,(13, 'Bussiness Administration');


Create table Students (id int, name varchar(30), department_id int);
Truncate table Students;
insert into Students (id, name, department_id) values 
 (23, 'Alice'   ,  1)
,( 1, 'Bob'     ,  7)
,( 5, 'Jennifer', 13)
,( 2, 'John'    , 14)
,( 4, 'Jasmine' , 77)
,( 3, 'Steve'   , 74)
,( 6, 'Luis'    ,  1)
,( 8, 'Jonathan',  7)
,( 7, 'Daiana'  , 33)
,(11, 'Madelynn',  1);

/*
+------+----------+
| id   | name     |
+------+----------+
| 2    | John     |
| 3    | Steve    |
| 4    | Jasmine  |
| 7    | Daiana   |
+------+----------+
*/

-- Approach 1: Using the LEFT JOIN 
select s.id, s.name
       from Students s 
  left join Departments d 
         on d.id = s.department_id
      where d.id is null 
   order by 1 ;

-- Approach 2: Using IN clause 
select s.id, s.name
       from Students s 
      where s.department_id not in (select d.id from Departments d )
   order by 1 ;
