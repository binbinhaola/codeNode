#查询1
SELECT * FROM teacherinfo
WHERE teacherTel REGEXP '^139'

#查询2
SELECT stuNumber,stuName,sClassID FROM studentinfo
WHERE MONTH(stuJoinTime)='3'
AND EXISTS(SELECT stuAge FROM studentinfo)

#查询3
SELECT stuName,stuJoinTime FROM studentinfo
WHERE stuNumber IN('001','002','003')

#查询4
SELECT stuName,stuSex,stuAddress FROM studentinfo
WHERE stuAge BETWEEN 16 AND 18;

#查询5
SELECT examSubject,ExamResult FROM studentexam
ORDER BY studentexam.ExamSubject

#查询6
SELECT AVG(stuAge) FROM studentinfo

#查询7
SELECT examsubject AS sub,examresult FROM studentexam
WHERE examsubject='sql'
GROUP BY examsubject
HAVING MIN(studentexam.ExamResult)

#查询8
SELECT studentinfo.stuName,studentexam.ExamSubject,studentexam.ExamResult
FROM studentinfo
JOIN studentexam ON studentinfo.stuId=studentexam.EStuID
WHERE studentexam.ExamSubject='java'
ORDER BY studentexam.ExamResult DESC LIMIT 1

#查询9
SELECT stuSex,AVG(stuAge)
FROM studentinfo
WHERE stuSex='男'
GROUP BY stuSex

#查询10
SELECT COUNT(EstuId)FROM studentExam WHERE EStuID=(
	SELECT stuId FROM studentinfo WHERE stuName='火云邪神'
)

#查询11
SELECT COUNT(DISTINCT CTeacherID) AS 班主任 FROM classinfo

#查询12
SELECT examSubject AS 科目,AVG(ExamResult) AS 平均成绩
FROM studentexam
GROUP BY examSubject

#查询13
SELECT studentinfo.stuName AS 姓名,SUM(studentexam.ExamResult) AS 总成绩
FROM studentinfo
JOIN studentexam ON studentinfo.stuId = studentexam.EStuID
GROUP BY studentinfo.stuName

#查询14
SELECT classinfo.ClassNumber AS 班级,studentinfo.stuAge AS 最小年龄
FROM classinfo
JOIN studentinfo ON classinfo.ClassID=studentinfo.sClassID
GROUP BY classinfo.ClassID

#查询15
SELECT COUNT(studentinfo.stuId) AS 不及格人数
FROM studentinfo
JOIN studentexam ON studentinfo.stuId=studentexam.EStuID
WHERE studentexam.ExamResult<60


#查询16

SELECT studentinfo.stuName AS 姓名,SUM(studentexam.ExamResult) AS 总成绩
FROM studentinfo
JOIN studentexam ON studentinfo.stuId = studentexam.EStuID
GROUP BY studentinfo.stuName
HAVING SUM(studentexam.ExamResult)>140

#查询17
SELECT studentinfo.stuName AS 姓名,COUNT(studentexam.EStuID) AS 考试次数
FROM studentinfo
JOIN studentexam ON studentexam.EStuID=studentinfo.stuId
GROUP BY studentinfo.stuName

#查询18
SELECT stuSex AS 性别,ROUND(AVG(stuAge),1) AS 平均年龄
FROM studentinfo
GROUP BY studentinfo.stuSex


#查询19
SELECT examSubject AS 科目,ROUND(AVG(ExamResult),2) AS 平均成绩
FROM studentexam
GROUP BY examSubject
HAVING AVG(ExamResult)>80

#查询20
SELECT studentinfo.stuName AS 姓名,SUM(studentexam.ExamResult) AS 总成绩
FROM studentinfo
JOIN studentexam ON studentinfo.stuId = studentexam.EStuID
GROUP BY studentinfo.stuName 
ORDER BY SUM(studentexam.ExamResult)DESC
