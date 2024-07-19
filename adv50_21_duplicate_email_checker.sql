-- Question: Report all the duplicate emails

-- English Video: https://www.youtube.com/watch?v=EClJafK82Z4
-- Tamil Video: https://www.youtube.com/watch?v=i9HtiL05wmA

Create table Person (id int, email varchar(255));
Truncate table Person;
insert into Person (id, email) values 
 (1, 'jegan@gwd.com')
,(2, 'arjun@gwd.com')
,(3, 'jegan@gwd.com');

/*
+---------------+
| Email         |
+---------------+
| jegan@gwd.com |
+---------------+
*/

-- Approach 1: Using Self Join 
select distinct p1.email 
       from Person p1
 inner join Person p2 
         on p2.email = p1.email 
        and p2.id <> p1.id;

-- Approach 2: Using Simple Aggregate Function 
select email
       from Person
   group by 1 having count(*) > 1;

-- Approach 3: Using Windows Function 
with all_raw_data as (
select email,
       count(*) over(partition by email) as dup 
       from Person )
select distinct email 
       from all_raw_data 
      where dup > 1; 
