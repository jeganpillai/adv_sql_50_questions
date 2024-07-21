-- Question: Report the distinct titles of the kid-friendly movies streamed in June 2024

-- English Video: 
-- Tamil Video: 

Create table Content (content_id varchar(30), 
                      title varchar(30), 
                      Kids_content ENUM('Y', 'N'), 
                      content_type varchar(30));
Truncate table Content;
insert into Content (content_id, title, Kids_content, content_type) values 
 (1, 'Aladdin'          , 'N', 'Movies')
,(2, 'Algebra for Kids' , 'Y', 'Series')
,(3, 'Database Sols'    , 'N', 'Series')
,(4, 'Grow With Data'   , 'Y', 'Movies')
,(5, 'Cinderella'       , 'Y', 'Movies')
,(9, 'Pokemon'          , 'Y', 'Series');

Create table TVProgram (program_date date, 
                        content_id int, 
                        channel varchar(30));
Truncate table TVProgram;
insert into TVProgram (program_date, content_id, channel) values 
 ('2024-06-10 08:00', 1, 'Grow With Data TV' )
,('2024-05-11 12:00', 2, 'Grow With Data TV' )
,('2024-05-12 12:00', 3, 'Grow With Data TV' )
,('2024-06-13 14:00', 4, 'Disney Plus'       )
,('2024-06-18 14:00', 4, 'Disney Plus'       )
,('2024-07-15 16:00', 5, 'Disney Plus'       )
,('2024-05-09 09:00', 9, 'Cartoon Network'   )
,('2024-06-04 13:00', 9, 'Cartoon Network'   );

/*
+----------------+
| title          |
+----------------+
| Grow With Data |
+----------------+
*/

select distinct c.title
       from TVProgram t 
 inner join Content c 
         on c.content_id = t.content_id 
        and c.kids_content = 'Y'
        and c.content_type = 'Movies'
--        and left(t.program_date,7) = '2020-06' 
--        and program_date between '2024-06-01 00:00' and '2024-06-30 23:59'
        and EXTRACT(YEAR_MONTH FROM program_date) = 202406;

