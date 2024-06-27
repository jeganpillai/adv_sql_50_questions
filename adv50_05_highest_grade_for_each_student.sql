-- Question: Find the highest grade with its corresponding course for each student

-- English Video: https://www.youtube.com/watch?v=mlVHOSNubuc
-- Tamil Video: https://www.youtube.com/watch?v=1rnoBMWlF0s

Create table Enrollments (student_id int, course_id int, grade int);
Truncate table Enrollments;
insert into Enrollments (student_id, course_id, grade) values 
 (2, 2, 95)
,(2, 3, 95)
,(1, 1, 90)
,(1, 2, 99)
,(3, 1, 80)
,(3, 2, 75)
,(3, 3, 82);

/*
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+
*/

-- Approach 1: Using CTE table to get the Max grade
with max_grades as (
select student_id, max(grade) as max_grade from Enrollments group by 1)
select e.student_id,
       min(course_id) as course_id,
       e.grade
       from Enrollments e 
 inner join max_grades m 
         on m.student_id = e.student_id 
        and m.max_grade = e.grade 
   group by 1,3
   order by 1;

-- Approach 2: Using Subquery table to get the Max grade
select e.student_id,
       min(course_id) as course_id,
       e.grade
       from Enrollments e 
 inner join (select student_id, max(grade) as max_grade from Enrollments group by 1) m 
         on m.student_id = e.student_id 
        and m.max_grade = e.grade 
group by 1,3 order by 1;

-- Approach 3: Clean version of approach 2
select e.student_id,
       min(course_id) as course_id,
       min(e.grade) as grade
       from Enrollments e 
 inner join (select student_id, max(grade) as max_grade from Enrollments group by 1) m 
         on m.student_id = e.student_id 
        and m.max_grade = e.grade 
group by 1 order by 1;

-- Approach 4: Using Windows function 
with max_grades as (
select student_id, 
       course_id, 
       grade,
       row_number() over(partition by student_id order by grade desc, course_id) as rnum
       from Enrollments)
select student_id, 
       course_id, 
       grade
       from max_grades 
      where rnum = 1
   order by 1;
