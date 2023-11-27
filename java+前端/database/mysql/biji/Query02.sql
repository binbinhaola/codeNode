#查询语法：
SELECT 要查询的列
FROM 表名1
[INNER JOIN 表名2 / LEFT JOIN 表2 / RIGHT JOIN 表2 ]
[WHERE 条件]
[GROUP BY 要分组的列]
[HAVING 对分组后的值进行筛选]
[ORDER BY 要排序的列]
[LIMIT 偏移量,记录数]

#分组查询：group by
SELECT sex AS 性别,studentNo AS 学号,studentName AS 姓名
FROM student
WHERE gradeId=1
GROUP BY sex;
#group by + group_concat():
SELECT sex AS 性别,GROUP_CONCAT(studentNo) AS 学号,GROUP_CONCAT(studentName) AS 姓名
FROM student
WHERE gradeId=1
GROUP BY sex;
#面试题：查询学生表中男生和女生的平均年龄各是多少
SELECT sex AS 性别,AVG(TIMESTAMPDIFF(YEAR,bornDate,NOW())) AS 平均年龄
FROM student
WHERE gradeId=1
GROUP BY sex
HAVING AVG(TIMESTAMPDIFF(YEAR,bornDate,NOW()))>30;

######################################################

#连接查询：适用于查询多表（内连接（重点）、外连接、自连接）
#1.内连接：inner join 
SELECT stu.studentNo,stu.studentName,sub.subjectName,r.studentResult
FROM student stu 
INNER JOIN result r ON stu.studentNo=r.studentNo
INNER JOIN `subject` sub ON r.subjectNo=sub.subjectNo
WHERE sub.subjectName='Logic Java';
#2.外连接（左外连接(保全左表),右外连接(保全右表)）
SELECT stu.studentNo,stu.studentName,r.studentResult
FROM student stu
LEFT JOIN result r ON stu.studentNo=r.studentNo;

SELECT stu.studentNo,stu.studentName,r.studentResult
FROM student stu
RIGHT JOIN result r ON stu.studentNo=r.studentNo;

SELECT c1.categoryName AS 父分类,GROUP_CONCAT(c2.categoryName) AS 子分类
FROM category c1,category c2
WHERE c1.categoryId=c2.pid
GROUP BY c1.categoryId;

########################################################

#查询学生表中年龄大于张秋丽的学生信息：
#方法一：分步查询
SELECT bornDate FROM student WHERE studentName='张秋丽';
SELECT * FROM student WHERE bornDate<'1994-09-08';
#方法二：子查询
SELECT * FROM student WHERE bornDate<(

	#subQuery
	SELECT bornDate FROM student WHERE studentName='张秋丽'

);
#查询Logic Java考试成绩大于60分的学生
SELECT * 
FROM student stu
INNER JOIN result r ON stu.studentNo=r.studentNo
INNER JOIN `subject` sub ON r.subjectNo=sub.subjectNo
WHERE sub.subjectName='Logic Java' AND r.studentResult>60;
#子查询改写：
SELECT * FROM student WHERE studentNo IN(

	SELECT studentNo FROM result r
	INNER JOIN `subject` sub ON r.subjectNo=sub.subjectNo
	WHERE sub.subjectName='Logic Java' AND r.studentResult>60
)
SELECT * FROM student WHERE studentNo IN(

	SELECT studentNo FROM result WHERE subjectNo=(
	
		SELECT subjectNo FROM `subject` WHERE subjectName='Logic Java'
	
	) AND studentResult>60
)

#EXISTS子查询
SELECT * FROM student WHERE EXISTS(

	SELECT * FROM student WHERE studentNo=100001

)
#查询Logic Java最近一次考试成绩
#如果有80以上的，则显示排在前5名的学员学号和分数
SELECT studentNo AS 学号,studentResult AS 分数 
FROM result
WHERE EXISTS(

	#查询Logic Java最近一次考试成绩大于80分的
	SELECT * FROM result WHERE subjectNo=(
	
		SELECT subjectNo FROM `subject` WHERE subjectName='Logic Java'
	
	) AND examDate=(
	
		SELECT MAX(ExamDate) FROM result WHERE subjectNo=(
		
			SELECT subjectNo FROM `subject` WHERE subjectName='Logic Java'
			
		)
	) AND studentResult>80

) AND subjectNo=(

	SELECT subjectNo FROM `subject` WHERE subjectName='Logic Java'

) ORDER BY studentResult DESC LIMIT 5;

#select + 子查询：子查询必须返回单行单列
#Operand should contain 1 column(s)
#Subquery returns more than 1 row
SELECT DISTINCT(

	SELECT studentName FROM student WHERE studentNo=10000
	
) FROM student; 

#from + 子查询：必须给查询出的表取别名
#Every derived table must have its own alias
SELECT * FROM (

	SELECT * FROM student

);

#创建临时表：
CREATE TEMPORARY TABLE studenttemp(

	SELECT * FROM student

)

SELECT * FROM studenttemp;


