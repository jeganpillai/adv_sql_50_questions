-- Question: Find the first login date for each player.

-- English Video: https://www.youtube.com/watch?v=qwFUybs5F84
-- Tamil Video: https://www.youtube.com/watch?v=3krB-ox-Pig

Create table Activity (
  player_id int, 
  device_id int, 
  event_date date, 
  games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values
 (1, 2, '2024-03-01', 5)
,(1, 2, '2024-05-02', 6)
,(2, 3, '2024-06-25', 1)
,(3, 1, '2024-03-02', 0)
,(3, 4, '2024-07-03', 5);

+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2024-03-01  |
| 2         | 2024-06-25  |
| 3         | 2024-03-02  |
+-----------+-------------+


-- Approach 1: General Aggregate logic 
select player_id, min(event_date) as first_login
       from Activity 
   group by 1;

-- Approach 2: Using Windows Function 
with all_dataset as (
select player_id, event_date,
       row_number() over(partition by player_id order by event_date) as rnk
       from Activity )
select player_id, event_date as first_login
       from all_dataset 
      where rnk = 1;
