#查询1
SELECT studentinfo.stuName,studentinfo.stuNumber,studentexam.ExamSubject,studentexam.ExamResult
FROM studentinfo
RIGHT JOIN studentexam ON studentinfo.stuId = studentexam.EStuID
ORDER BY studentinfo.stuNumber,studentexam.ExamResult DESC;

#查询2
SELECT studentinfo.stuJoinTime,AVG(studentexam.ExamResult)
FROM studentinfo
JOIN studentexam ON studentinfo.stuid=studentexam.EStuID
GROUP BY MONTH(studentinfo.stuJoinTime);

#查询3
SELECT classinfo.ClassNumber,AVG(studentexam.ExamResult)
FROM studentinfo
JOIN studentexam ON studentinfo.stuId=studentexam.EStuID
JOIN classinfo ON studentinfo.sClassID=classinfo.ClassID
GROUP BY classinfo.ClassNumber

#查询4
SELECT classinfo.ClassID,classinfo.ClassNumber,AVG(studentexam.ExamResult)
FROM studentinfo
JOIN studentexam ON studentinfo.stuId=studentexam.EStuID
JOIN classinfo ON studentinfo.sClassID=classinfo.ClassID
WHERE studentinfo.stuSex='男'
GROUP BY classinfo.ClassNumber
ORDER BY AVG(studentexam.ExamResult);

#查询5
SELECT teacherinfo.teacherName,teacherinfo.teacherTel,classinfo.ClassNumber,studentinfo.stuName,studentinfo.stuNumber
FROM teacherinfo
JOIN classinfo ON teacherinfo.teacherID = classinfo.CTeacherID
JOIN studentinfo ON classinfo.ClassID = studentinfo.sClassID
GROUP BY studentinfo.stuName
ORDER BY teacherinfo.teacherName
