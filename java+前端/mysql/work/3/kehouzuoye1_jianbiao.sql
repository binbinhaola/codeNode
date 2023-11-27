CREATE DATABASE MyFirstQQ

CREATE TABLE TestScore(

	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT'id',
	Star CHAR(3) NOT NULL COMMENT'星座'
	
)COMMENT'星座表' CHARSET='utf8';

CREATE TABLE BloodInfo(

	Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT'id',
	BloodType VARCHAR(3) NOT NULL COMMENT'血型'
	
)COMMENT'血型表' CHARSET='utf8';

CREATE TABLE Users(

	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT'id',
	LoginPWD CHAR(4) NOT NULL COMMENT'id',
	NickName VARCHAR(10) NOT NULL COMMENT'id',
	sex CHAR(2) NOT NULL COMMENT'性别',
	StarID INT(1) NOT NULL COMMENT'星座',
	bloodTypeID INT(1) NOT NULL COMMENT'血型'

)COMMENT'用户表' CHARSET='utf8';

ALTER TABLE Users
ADD CONSTRAINT fk_Star FOREIGN KEY(StarID)
REFERENCES testscore(id)

ALTER TABLE users
ADD CONSTRAINT fk_blood FOREIGN KEY(bloodTypeID)
REFERENCES bloodinfo(id)