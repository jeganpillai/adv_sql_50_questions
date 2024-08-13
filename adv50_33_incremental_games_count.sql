-- Question: Report for each player and date, how many games played so far by the player

-- English Video: https://www.youtube.com/watch?v=LNT7ztN3SdQ
-- Tamil Video: https://www.youtube.com/watch?v=LAIkH9AgrZo 

Create table Activity (player_id int, 
                       device_id int, 
                       event_date date, 
                       games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values
 (1, 2, '2016-03-01', 5)
,(1, 2, '2016-05-02', 6)
,(1, 3, '2017-06-25', 1)
,(3, 1, '2016-03-02', 0)
,(3, 4, '2018-07-03', 5);

/*
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
*/

-- Approach 1: Using Self join 
select a1.player_id,
       a1.event_date,
       sum(a2.games_played) as games_played_so_far
       from Activity a1
 inner join Activity a2 
         on a2.player_id = a1.player_id 
        and a2.event_date <= a1.event_date 
   group by 1,2
   order by 1,2,3;


-- Approach 2: Using Windows function 
select player_id,
       event_date,
       games_played,
       sum(games_played) over(partition by player_id order by event_date) as chk
       from Activity;
