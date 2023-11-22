USE mysql;
SELECT * FROM USER;

INSERT INTO deposit VALUES('1010357612345678','定期','3年定期'),
VALUES('1010357612121134','活期','活期半年');

INSERT INTO userInfo(customerName,PID,telephone,address )
     VALUES('张三','123456789012345','010-67898978','北京海淀');
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerID)
     VALUES('1010357612345678',1,1000,1000,1);
INSERT INTO userInfo(customerName,PID,telephone)
     VALUES('李四','321245678912345678','0478-44443333');   
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerID)
     VALUES('1010357612121134',2,1,1,2);
