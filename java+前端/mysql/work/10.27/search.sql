SELECT student.sid AS 学号,student.stuName AS 姓名
FROM student
JOIN score ON score.sid = student.sid
JOIN course ON course.cid = score.cid
JOIN teacher ON teacher.tid = course.tid
WHERE (teacher.teaName='方芳');

SELECT student.sid AS 学号, student.stuName AS 姓名
FROM student
JOIN score ON score.sid = student.sid
WHERE score.score<60

CREATE TABLE temScore(

	SELECT student.sid AS 学号,student.stuName AS 姓名, score.score AS 成绩
	FROM student
	JOIN score ON score.sid = student.sid
	JOIN course ON course.cid = score.cid
	JOIN teacher ON teacher.tid = course.tid
	WHERE teacher.teaName ='方芳' AND course.cName='MySQL'
	ORDER BY score.score
	LIMIT 3,3

);

CREATE VIEW student_view
AS
SELECT student.sid AS 学号,student.stuName AS 姓名,course.cName AS 参考科目,score.score AS 成绩
FROM student
JOIN score ON score.sid = student.sid
JOIN course ON course.cid = score.cid
ORDER BY student.stuName;

