INSERT INTO deposit VALUES('1','定期','3年定期'),
('2','活期','活期半年');

INSERT INTO userInfo(customerName,PID,telephone,address )
     VALUES('张三','123456789012345','010-67898978','北京海淀');
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerID)
     VALUES('1010357612345678',1,1000,1000,1);
INSERT INTO userInfo(customerName,PID,telephone)
     VALUES('李四','321245678912345678','0478-44443333');   
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerID)
     VALUES('1010357612121134',2,1,1,2);

/*--------------交易信息表插入交易记录--------------------------*/
INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('支取','1010357612345678',900);  
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance-900 WHERE cardID='1010357612345678';
/*--------------交易信息表插入交易记录--------------------------*/
INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('存入','1010357612121134',5000);   
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance+5000 WHERE cardID='1010357612121134';



