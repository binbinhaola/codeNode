CREATE DATABASE school3

CREATE TABLE result(
	
	stuID INT PRIMARY KEY NOT NULL COMMENT'学生ID',
	stuName VARCHAR(10) NOT NULL COMMENT'学生姓名',
	subName VARCHAR(20) NOT NULL COMMENT'课程名',
	testDate DATETIME NOT NULL COMMENT'考试时间',
	result INT NOT NULL COMMENT'成绩'
	
)COMMENT'考试成绩表',CHARSET='utf8'


INSERT INTO result VALUE('4','张萍','Logic Java',NOW(),'90'),
('5','韩秋洁','Logic Java',NOW(),'75');


SET autocommit=0;
BEGIN;
INSERT INTO result VALUE('1','郭靖','Logic Java',NOW(),'70'),
('2','李文才','Logic Java',NOW(),'65'),
('3','李斯文','Logic Java',NOW(),'80')
COMMIT;

SET autocommit=0;
BEGIN;
INSERT INTO result VALUE('4','张萍','Logic Java',NOW(),'110'),
('5','韩秋洁','Logic Java',NOW(),'120');
ROLLBACK;
