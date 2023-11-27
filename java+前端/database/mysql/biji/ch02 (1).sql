#DDL:数据库定义语言
CREATE DROP ALTER
#修改表名：
ALTER TABLE ss01 RENAME ss;
#添加列：
ALTER TABLE ss ADD `password` VARCHAR(10) NOT NULL; 
#修改列：
ALTER TABLE ss CHANGE `password` `pwd` CHAR(10) NOT NULL;
ALTER TABLE ss MODIFY  `pwd` VARCHAR(10);
#删除列：
ALTER TABLE ss DROP `pwd`;


#DML:数据库操作语言(insert,delete,update)
#1.新增：
INSERT INTO classes (sname,openDate) VALUES ('数据库','2022-10-10');
INSERT INTO classes (sname,openDate) VALUES ('数据库1',DEFAULT),('数据库2',DEFAULT);
#向新表中插入多条数据：（1.新表不存在）
CREATE TABLE studentTest(

	SELECT studentNo,studentName,sex FROM student

);
#向新表中插入多条数据：（2.新表存在）
INSERT INTO studentTest (studentNo,studentName,sex)
SELECT studentNo,studentName,sex FROM student;

#2.修改：
UPDATE student SET sex='女',address='长沙' WHERE studentNo=10003;

#3.删除：delete
DROP TABLE student;#删除表结构（DDL）
DELETE FROM classes WHERE sid=7;#条件删除
DELETE FROM classes;#删除表中所有数据（标识列不还原）
TRUNCATE TABLE classes;#清空表数据（标识列还原）


#DQL：数据库查询语言（select）
#数学函数：
SELECT ROUND(ROUND(RAND(),4)*10000+1000);#随机数
SELECT CEIL(4.2);#向上取整
SELECT FLOOR(4.9);#向下取整
SELECT ROUND(4.5);#四舍五入
#时间函数：
SELECT NOW();
SELECT YEAR(NOW());
SELECT MONTH(NOW());
#聚合函数：
#count():计数
SELECT COUNT(*) FROM student;
#max():最大值   min():最小值
SELECT MAX(studentResult) FROM result;
#sum():求和
SELECT SUM(studentResult) FROM result;
#avg():平均分
SELECT AVG(studentResult) FROM result;

#基础查询：
SELECT * FROM student;#查询所有
SELECT * FROM student WHERE sex='男';#条件查询
SELECT studentNo,studentName FROM student WHERE sex='男';#固定列查询
SELECT studentNo AS 学号,studentName AS 姓名 FROM student WHERE sex='男';#取别名1
SELECT studentNo 学号,studentName 姓名 FROM student WHERE sex='男';#取别名2
#查询成绩在60~80分的数据：
SELECT * FROM result WHERE studentResult>60 AND studentResult<80; 
#查询学生表中地址为空的学生信息：
SELECT * FROM student WHERE address IS NULL OR address='';


#模糊查询：
#通配符：%(任意长度字符)  _(单个字符) 
#like
SELECT * FROM student WHERE studentName LIKE '张%';
SELECT * FROM student WHERE studentName LIKE '张__';
#姓名中包含%的学生信息：
SELECT * FROM student WHERE studentName LIKE '%%%';#查询所有
#转义：escape
SELECT * FROM student WHERE studentName LIKE '%:%%' ESCAPE ':';
#between and：
SELECT * FROM result WHERE studentResult BETWEEN 60 AND 80;
#regExp:
SELECT * FROM student WHERE studentName REGEXP '张';
SELECT * FROM student WHERE address REGEXP '天津|上海|河北';
#in:
SELECT * FROM student WHERE address IN ('天津','上海','河北');

#排序：order by   ASC:升序  DESC：降序
SELECT *
FROM student
WHERE sex='男' 
ORDER BY studentNo DESC;

#限制行的使用：limit
SELECT *
FROM student
WHERE sex='男' 
ORDER BY studentNo DESC
LIMIT 0,2

#应用：分页查询
#假设一共20条数据，每页显示4条数据
#第一页：....limit 0,4
#第二页：....limit 4,4
#第三页: ....limit 8,4


#查询语法：
SELECT 要查询的列
FROM 表名
[WHERE 条件]
[ORDER BY 要排序的列]
[LIMIT 偏移量,显示记录数]

