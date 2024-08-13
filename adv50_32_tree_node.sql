-- Question: Report the type of Node in the Tree

-- English Video: https://www.youtube.com/watch?v=bH6P2vzp4jM
-- Tamil Video: https://www.youtube.com/watch?v=v-jgc7mD7zA

Create table Tree (id int, p_id int);
Truncate table Tree;
insert into Tree (id, p_id) values 
 (1, Null)
,(2, 1)
,(3, 1)
,(4, 2)
,(5, 2);

/*
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
*/

-- Approach 1: Using CTE table 
with inner_user as (
select p_id as id 
       from Tree 
   group by p_id 
     having count(*) > 1)
select t.id,
       case when t.p_id is null then 'Root'
            when i.id is null then 'Leaf'
            else 'Inner' end as flg 
       from Tree t 
  left join inner_user i 
         on i.id = t.id;

-- Approach 2: Simplified CTE table
with inner_user as (
select distinct p_id as id 
       from Tree 
      where p_id is not null)
select t.id,
       case when t.p_id is null then 'Root'
            when i.id is null then 'Leaf'
            else 'Inner' end as flg 
from Tree t 
left join inner_user i 
on i.id = t.id;

-- Approach 3: Using Subquery table 
select t.id,
       case when t.p_id is null then 'Root'
            when t.id not in (select distinct p_id as id 
                                       from Tree 
                                      where p_id is not null) then 'Leaf'
            else 'Inner' end as flg 
from Tree t;

