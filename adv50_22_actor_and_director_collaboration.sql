-- Question: Find all the pairs of actor and director where they collaborated at least three times.

-- English Video: https://www.youtube.com/watch?v=E5pKAe-F8hw
-- Tamil Video:https://www.youtube.com/watch?v=hO057__D_R0 

Create table ActorDirector (seq int, actor_id int, director_id int);
Truncate table ActorDirector;
insert into ActorDirector (seq, actor_id, director_id) values 
 (0, 1, 1)
,(1, 1, 1)
,(2, 1, 1)
,(3, 1, 2)
,(4, 1, 2)
,(5, 2, 1)
,(6, 2, 1);

/*
drop table ActorDirector;
Create table ActorDirector (seq int,
                            actor_id varchar(50), 
                            director_id varchar(50)
                            );
Truncate table ActorDirector;
insert into ActorDirector (seq, actor_id, director_id) values 
 (0, 'Vijay', 'Atlee')
,(1, 'Vijay', 'Atlee')
,(2, 'Vijay', 'Atlee')
,(3, 'Kamal', 'Manirathnam')
,(4, 'Kamal', 'Manirathnam')
,(5, 'Vijay', 'Lokesh')
,(6, 'Vijay', 'Lokesh');
*/

/*
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| Vijay       | Atlee       |
+-------------+-------------+
*/

-- Approach 1: Using Aggregation Method
select actor_id, director_id
       from ActorDirector 
   group by 1,2 
     having count(*) >=3 ;

-- Approach 2: Using Windows Function
using Windows function 
with all_data as (
select distinct actor_id, director_id,
       count(*) over(partition by actor_id, director_id) as cnt 
       from ActorDirector)
select actor_id , director_id
       from all_data 
      where cnt >= 3;
