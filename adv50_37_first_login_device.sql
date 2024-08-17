-- Question: Report the device that is first logged in for each player

-- English Video: 
-- Tamil Video: 

Create table Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values 
 (1, 2, '2024-03-01', 5)
,(1, 2, '2024-08-02', 6)
,(2, 3, '2024-08-25', 1)
,(3, 1, '2024-03-02', 0)
,(3, 4, '2024-08-03', 5);

/*
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
*/

-- Approach 1: Using CTE table 
with raw_data as (
    select player_id, min(event_date) as event_date from Activity group by 1
)
select a.player_id, a.device_id
       from Activity a 
 inner join raw_Data b 
         on b.player_id = a.player_id 
        and b.event_date = a.event_date;

-- Approach 2: Using Subquery Table 
select a.player_id, a.device_id
       from Activity a 
 inner join (select player_id, min(event_date) as event_date from Activity group by 1) b 
         on b.player_id = a.player_id 
        and b.event_date = a.event_date;        

-- Approach 3: Using Correlated Qubquery table 
select a.player_id, a.device_id
       from Activity a 
      where event_date = (select min(event_date) as event_date 
                                 from Activity src
                                where src.player_id = a.player_id );

-- Approach 4: Using WINDOWS function
with raw_data as (
select a.player_id, a.device_id,
       row_number() over(partition by a.player_id order by event_date) as chk
       from Activity a )
select player_id, device_id
       from raw_data where chk = 1;
