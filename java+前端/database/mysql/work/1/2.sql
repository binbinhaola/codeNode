CREATE TABLE IF NOT EXISTS `subject`(
	
	subjectNo INT(4) PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '班级编号',
	subjectName VARCHAR(50) COMMENT'课程名称',
	classHour INT(4) COMMENT'学时',
	gradeID INT(4) COMMENT'年级编号'
)COMMENT'成绩表' CHARSET='utf8'



