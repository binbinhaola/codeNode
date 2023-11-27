CREATE TABLE student_info(

	stuId INT PRIMARY KEY AUTO_INCREMENT COMMENT'学生编号',
	`name` VARCHAR(10) NOT NULL COMMENT'姓名',
	age INT(4) NOT NULL COMMENT'年龄',
	class VARCHAR(50) NOT NULL COMMENT'班级',
	email VARCHAR(50) NOT NULL COMMENT'邮箱',
	`subject`  VARCHAR(50) NOT NULL COMMENT'项目'

)COMMENT'学生信息表',CHARSET='utf8';

INSERT INTO student_info VALUE('1','高鹏','16','一班','gaopeng@163.com','跳远'),
('2','王一','15','一班','wangyi@qq.com','跳远'),
('3','刘晓','14','二班','xiaoliu@163.com','接力跑'),
('4','张花','15','二班','zhanghua@163.com','跳绳');