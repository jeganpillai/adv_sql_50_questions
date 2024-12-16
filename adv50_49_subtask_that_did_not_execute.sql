-- Question: Find the Subtask that did not Execute

-- English Video: 
-- Tamil Video:

Create table Tasks (task_id int, subtasks_count int);
Truncate table Tasks;
insert into Tasks (task_id, subtasks_count) values 
(1, 3),
(2, 2),
(3, 4);

Create table Executed (task_id int, subtask_id int);
Truncate table Executed;
insert into Executed (task_id, subtask_id) values 
(1, 2),
(3, 1),
(3, 2),
(3, 3),
(3, 4);

/*
-- Output: 
+---------+------------+
| task_id | subtask_id |
+---------+------------+
| 1       | 1          |
| 1       | 3          |
| 2       | 1          |
| 2       | 2          |
+---------+------------+
*/

-- Approach 1: Hardcoded subtask values 
with seq_dataset as (
select 1 as num 
union all 
select 2 
union all 
select 3 
union all 
select 4 )
select a.task_id,
       b.num as subtask_id,
       a.subtasks_count
       from Tasks a 
 inner join seq_dataset b 
         on 1 = 1 
        and b.num <= a.subtasks_count 
  left join Executed e 
         on e.task_id = a.task_id 
        and e.subtask_id = b.num 
      where e.subtask_id is null 
   order by 1,2,3;


-- Approach 2: Using Recursive function and start with One 
with recursive all_task as (
select task_id,
       1 as subtask_id,
       subtasks_count 
       from Tasks
union all 
select a.task_id,
       b.subtask_id + 1 as subtask_id ,
       a.subtasks_count
       from Tasks a 
 inner join all_task b 
         on b.task_id = a.task_id 
        and a.subtasks_count > b.subtask_id
)
select a.task_id,
       a.subtask_id 
       from all_task a 
  left join Executed e 
         on e.task_id = a.task_id 
        and e.subtask_id = a.subtask_id
      where e.subtask_id is null 
   order by 1,2;


-- Approach 3: Using Recursive function and start with subtask count 
with recursive all_task as (
select task_id,
       subtasks_count as subtask_id 
       from Tasks
union all 
select a.task_id,
       b.subtask_id - 1 as subtask_id 
from Tasks a 
inner join all_task b 
on b.task_id = a.task_id 
and b.subtask_id > 1
)
select a.task_id,
       a.subtask_id 
       from all_task a 
  left join Executed e 
         on e.task_id = a.task_id 
        and e.subtask_id = a.subtask_id
      where e.subtask_id is null 
   order by 1,2;

-- Approach 4: Replace LEFT join with NOT IN clause 
with recursive all_task as (
select task_id,
       subtasks_count as subtask_id 
       from Tasks
union all 
select a.task_id,
       b.subtask_id - 1 as subtask_id 
       from Tasks a 
 inner join all_task b 
         on b.task_id = a.task_id 
        and b.subtask_id > 1)
select a.task_id,
       a.subtask_id 
       from all_task a 
      where (a.task_id, a.subtask_id) not in (select task_id, subtask_id
                                                     from Executed ) 
   order by 1,2; 
