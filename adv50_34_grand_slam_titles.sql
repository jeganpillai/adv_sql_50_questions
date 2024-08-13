-- Question: Report the number of grand slam tournaments won by each player

-- English Video: 
-- Tamil Video: 

Create table Players (player_id int, player_name varchar(20));
Truncate table Players;
insert into Players (player_id, player_name) values 
 (1, 'Novak')
,(2, 'Carlos')
,(3, 'Nadal')
,(4, 'Daniil');

Create table Championships (year int, 
                            US_open int, 
                            Wimbledon int, 
                            Fr_open int, 
                            Au_open int);
Truncate table Championships;
insert into Championships (year, US_open, Wimbledon, Fr_open, Au_open) values
 (2023, 1, 2, 1, 1)
,(2022, 2, 1, 3, 3)
,(2021, 4, 1, 1, 1);

/*
+-----------+-------------+-------------------+
| player_id | player_name | grand_slams_count |
+-----------+-------------+-------------------+
| 1         | Novak       | 7                 |
| 2         | Carlos      | 2                 |
| 3         | Nadal       | 2                 |
| 4         | Daniil      | 1                 |
+-----------+-------------+-------------------+
*/

-- Approach 1: Brute Force Method 
with raw_data as (
select p.player_id,
       p.player_name,
       1 as gs_count
from Championships c 
inner join Players p 
on p.player_id = c.fr_open 
union all 
select p.player_id,
       p.player_name,
       1 as gs_count
from Championships c 
inner join Players p 
on p.player_id = c.wimbledon 
union all 
select p.player_id,
       p.player_name,
       1 as gs_count
from Championships c 
inner join Players p 
on p.player_id = c.us_open  
union all 
select p.player_id,
       p.player_name,
       1 as gs_count
from Championships c 
inner join Players p 
on p.player_id = c.au_open  
)
select player_id, player_name, count(*) as grand_slams_count
from raw_data 
group by 1,2 ;

-- Approach 2: Optimal solution 
with raw_data as (
select US_open as player_id from Championships 
union all 
select wimbledon as player_id from Championships
union all 
select fr_open as player_id from Championships
union all 
select au_open as player_id from Championships)
select p.player_id,
       p.player_name,
       count(*) as grand_slams_count 
from raw_data src 
inner join Players p 
on p.player_id = src.player_id
group by 1,2;

-- Approach 3: Call the table once 
select p.player_id,
       p.player_name,
      sum( case when p.player_id = c.us_open then 1 else 0 end
     + case when p.player_id = c.wimbledon then 1 else 0 end
     + case when p.player_id = c.fr_open then 1 else 0 end
     + case when p.player_id = c.au_open then 1 else 0 end) as grand_slams_count 

from Championships c 
inner join Players p 
on p.player_id = c.us_open 
or p.player_id = c.wimbledon
or p.player_id = c.fr_open
or p.player_id = c.au_open 
group by 1,2;
