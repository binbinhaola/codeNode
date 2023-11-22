CREATE TABLE person(

	number INT(4) PRIMARY KEY AUTO_INCREMENT COMMENT'序号',
	`name` VARCHAR(50) NOT NULL COMMENT'姓名',
	sex CHAR(2) COMMENT'性别',
	bornDate DATETIME COMMENT'出生日期'
)COMMENT '人员信息' CHARSET='utf8';

ALTER TABLE person RENAME tb_person;

ALTER TABLE tb_person DROP borndate;

ALTER TABLE tb_person ADD bornDate DATE COMMENT'出生日期';

ALTER TABLE tb_person CHANGE number `id` BIGINT(10) COMMENT'序号';