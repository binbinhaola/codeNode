CREATE TABLE userInfo(

	customerID INT PRIMARY KEY AUTO_INCREMENT COMMENT'客户编号',
	customerName VARCHAR(5) NOT NULL COMMENT'开户名',
	PID VARCHAR(18) NOT NULL COMMENT'身份证号',
	telephone CHAR(11) NOT NULL COMMENT'手机号',
	address VARCHAR(50) COMMENT'居住地址'

)COMMENT'客户信息表', CHARSET='utf8';

CREATE TABLE cardInfo(

	cardID CHAR(20) PRIMARY KEY NOT NULL COMMENT'银行卡号',
	curID VARCHAR(10) NOT NULL DEFAULT 'RMB' COMMENT'货币种类',
	savingID INT NOT NULL COMMENT'存款类型',
	openDate TIMESTAMP NOT NULL DEFAULT NOW() COMMENT'开户日期',
	openMoney DECIMAL(20) NOT NULL COMMENT'开户金额',
	balance DECIMAL(20) NOT NULL COMMENT'余额',
	`password` VARCHAR(10) NOT NULL DEFAULT '888888' COMMENT'密码',
	IsReportLoss BIT NOT NULL DEFAULT 0 COMMENT'是否挂失',
	customerID INT NOT NULL COMMENT '客户编号' 
	
)COMMENT'银行卡信息',CHARSET='utf8';


CREATE TABLE tradeInfo(

	transDate TIMESTAMP NOT NULL DEFAULT NOW() COMMENT'交易时间',
	cardID CHAR(20) NOT NULL COMMENT'卡号',
	transType CHAR(10) NOT NULL COMMENT'交易类型',
	transMoney DECIMAL(20) NOT NULL COMMENT'交易金额',
	remark TEXT COMMENT'备注'
	
)COMMENT'交易信息表',CHARSET='utf8';

CREATE TABLE deposit(

	savingID INT PRIMARY KEY AUTO_INCREMENT COMMENT'存款类型号',
	savingName VARCHAR(10) NOT NULL COMMENT'存款类型',
	descrip VARCHAR(50) COMMENT'描述'
)COMMENT'存款类型',CHARSET='utf8';


	ALTER TABLE cardInfo
	ADD CONSTRAINT fk_savingID FOREIGN KEY (savingID)
	REFERENCES deposit(savingID);
	
	ALTER TABLE cardInfo
	ADD CONSTRAINT fk_customerID FOREIGN KEY (customerID)
	REFERENCES userInfo(customerID);
	
	ALTER TABLE tradeInfo
	ADD CONSTRAINT fk_cardID FOREIGN KEY (cardID)
	REFERENCES cardInfo(cardID);