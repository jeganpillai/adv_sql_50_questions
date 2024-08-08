-- Question: write a solution to recommend pages to the user 

-- English Video: 
-- Tamil Video: 

Create table Friendship (user1_id int, user2_id int);
Truncate table Friendship;
insert into Friendship (user1_id, user2_id) values 
 (1, 2)
,(1, 3)
,(1, 4)
,(2, 3)
,(2, 4)
,(2, 5)
,(6, 1);

Create table Likes (user_id int, page_id int);
Truncate table Likes;
insert into Likes (user_id, page_id) values 
 (1, 88)
,(2, 23)
,(3, 24)
,(4, 56)
,(5, 11)
,(6, 33)
,(2, 77)
,(3, 77)
,(6, 88);

/*
+------------------+
| recommended_page |
+------------------+
| 23               |
| 24               |
| 56               |
| 33               |
| 77               |
+------------------+
*/

select distinct page_id as recommended_page
       from (select user1_id as user_id from Friendship f where user2_id = 1 
             union 
             select user2_id as user_id from Friendship f where user1_id = 1) f
 inner join Likes l
         on l.user_id = f.user_id
      where page_id not in (select page_id from Likes where user_id = 1)
   order by 1;
