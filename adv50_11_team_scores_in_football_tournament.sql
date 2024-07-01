-- Question: Report the Team Scores in Football Tournament

-- English Video: 
-- Tamil Video: 

Create table Teams (team_id int, 
                    team_name varchar(30));
Truncate table Teams;
insert into Teams (team_id, team_name) values 
 ('10', 'Leetcode FC')
,('20', 'NewYork FC')
,('30', 'Atlanta FC')
,('40', 'Chicago FC')
,('50', 'Toronto FC');

Create table Matches (match_id int, 
                      host_team int, 
                      guest_team int, 
                      host_goals int, 
                      guest_goals int);
Truncate table Matches;
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values 
 (1, 10, 20, 3, 0)
,(2, 30, 10, 2, 2)
,(3, 10, 50, 5, 1)
,(4, 20, 30, 1, 0)
,(5, 50, 30, 1, 0);

/*
| team_id    | team_name    | num_points    |
+------------+--------------+---------------+
| 10         | Leetcode FC  | 7             |
| 20         | NewYork FC   | 3             |
| 50         | Toronto FC   | 3             |
| 30         | Atlanta FC   | 1             |
| 40         | Chicago FC   | 0             |
+------------+--------------+---------------+
*/

with all_data_points as (
select host_team as team_id,
       t.team_name,
       case when host_goals > guest_goals then 3
            when host_goals = guest_goals then 1
            else 0 end as num_points 
from Matches m
inner join Teams t
on t.team_id = m.host_team
union all 
select guest_team as team_id,
       t.team_name,
       case when guest_goals > host_goals then 3
            when guest_goals = host_goals then 1
            else 0 end as num_points 
from Matches m
inner join Teams t
on t.team_id = m.guest_team)
select t.team_id,
       t.team_name,
       coalesce(sum(num_points),0) as num_points
       from Teams t 
       left join all_data_points a 
       on a.team_id = t.team_id
group by 1,2 order by 3 desc, 1;
