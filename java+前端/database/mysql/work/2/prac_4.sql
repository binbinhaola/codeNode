UPDATE student 
SET email='stu20000@163.com',loginPad='000' 
WHERE studentNo='20000';

UPDATE `SUBJECT`
SET classhour=classhour-10
WHERE classhour >200 AND gradeID=1;

CREATE TABLE stuent_grade1(
	SELECT *
	FROM student
	WHERE gradeID='1'
)