-- Question: Find the Quiet Students in all Exams

-- English Video: https://www.youtube.com/watch?v=d_C3SB2ZWdg
-- Tamil Video  : https://www.youtube.com/watch?v=18W67mqjPtw

Create table Student (student_id int, student_name varchar(30));
Truncate table Student;
insert into Student (student_id, student_name) values 
(1, 'Daniel'  ),
(2, 'Jade'    ),
(3, 'Stella'  ),
(4, 'Jonathan'),
(5, 'Will'    );

Create table Exam (exam_id int, student_id int, score int);
Truncate table Exam;
insert into Exam (exam_id, student_id, score) values 
(10, 1, 70),
(10, 2, 80),
(10, 3, 90),
(20, 1, 80),
(30, 1, 70),
(30, 3, 80),
(30, 4, 90),
(40, 1, 60),
(40, 2, 70),
(40, 4, 80);

/*
-- Output: 
+-------------+---------------+
| student_id  | student_name  |
+-------------+---------------+
| 2           | Jade          |
+-------------+---------------+
*/

--  Approach 1: Using Subquery 
with raw_data as (
select exam_id, 
       min(score) as min_score, 
       max(score) as max_score 
       from Exam
   group by 1 )
,qualified_dataset as (
select e.student_id, count(e.exam_id) as total_exams
       from Exam e 
 inner join raw_data r 
         on r.exam_id = e.exam_id 
        and r.min_score <> e.score and r.max_score <> e.score 
   group by 1 )
select a.student_id , s.student_name
       from qualified_dataset a 
 inner join (select student_id, count(exam_id) as total_exams 
                    from Exam group by 1) b 
         on b.student_id = a.student_id 
        and b.total_exams = a.total_exams
 inner join Student s 
         on s.student_id = a.student_id
   order by 1 ; 

-- Appraoch 2: Using windows function
with raw_data as (
select exam_id,
       student_id,
       score,
       dense_rank() over(partition by exam_id order by score) as lst,
       dense_rank() over(partition by exam_id order by score desc) as fst
       from Exam )
,exception_list as (
select distinct student_id from raw_data where lst = 1 or fst = 1)
select distinct a.student_id, s.student_name 
       from raw_data a 
 inner join Student s 
         on s.student_id = a.student_id
        and a.student_id not in (select student_id from exception_list)
        -- and a.student_id not in (select student_id 
        --                                 from raw_data 
        --                                where lst = 1 or fst = 1)

-- Approach 3: Replace subquery with LEFT join 

with raw_data as (
select exam_id,
       student_id,
       score,
       dense_rank() over(partition by exam_id order by score) as lst,
       dense_rank() over(partition by exam_id order by score desc) as fst
       from Exam )
select distinct a.student_id, s.student_name 
       from raw_data a 
 inner join Student s 
         on s.student_id = a.student_id
  left join (select distinct c.student_id 
                    from raw_data c where c.lst = 1 or c.fst = 1) c 
         on c.student_id = a.student_id
      where c.student_id is null 
   order by 1 ;           
