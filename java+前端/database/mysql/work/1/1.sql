CREATE TABLE IF NOT EXISTS result(
	studentNo INT(4) NOT NULL COMMENT'学号',
	subjectNo INT(4) NOT NULL COMMENT'课程编号',
	examDate DATETIME NOT NULL resultCOMMENT'考试日期',
	studentResult INT(4) NOT NULL COMMENT'考试成绩'
)COMMENT '课程表' CHARSET='utf8'
