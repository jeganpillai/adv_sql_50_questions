-- Question: Find the Top Travellers by Distance travelled by them

-- English Video: https://www.youtube.com/watch?v=Zsy2H6JyjD4
-- Tamil Video: https://www.youtube.com/watch?v=296-VdtfMUU

Create Table If Not Exists Users (id int, name varchar(30));
Truncate table Users;
insert into Users (id, name) values 
 ( 1, 'Alice'   )
,( 2, 'Bob'     )
,( 3, 'Alex'    )
,( 4, 'Alice'  )
,( 7, 'Lee'     )
,(13, 'Jonathan')
,(19, 'Elvis'   );

Create Table If Not Exists Rides (id int, user_id int, distance int);
Truncate table Rides;
insert into Rides (id, user_id, distance) values 
 (1001,  1, 120)
,(1002,  2, 317)
,(1003,  3, 222)
,(1004,  7, 100)
,(1005, 13, 312)
,(1006, 19,  50)
,(1007,  7, 120)
,(1008, 19, 400)
,(1009,  7, 230);

/*

+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Alice    | 0                  |
+----------+--------------------+
*/

select u.name
      ,coalesce(sum(distance),0) as travelled_distance
      from Users u 
 left join Rides r 
        on r.user_id = u.id 
  group by 1,u.id order by 2 desc, 1;
