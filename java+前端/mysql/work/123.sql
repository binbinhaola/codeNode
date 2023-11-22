CREATE TABLE studentInfo(

	sid INT PRIMARY KEY AUTO_INCREMENT COMMENT'学生编号',
	sname VARCHAR(10) NOT NULL COMMENT'学生姓名',
	sgender CHAR(2) NOT NULL COMMENT'学生性别',
	sage INT(3) NOT NULL COMMENT'学生年龄',
	saddress VARCHAR(50) COMMENT'家庭住址',
	semail VARCHAR(50) COMMENT'电子邮件'
)COMMENT'学生信息表',CHARSET='utf8';

INSERT INTO studentinfo VALUE('1','黄振图','男','27','北京市海淀区','zhentu@126.com'),
('2','李复真','女','22','江苏省南京市','fuzhen.li@126.com'),
('3','温华','男','20','湖北省荆州市','wenhua@163.com');