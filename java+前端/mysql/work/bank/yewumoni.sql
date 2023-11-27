SET autocommit=0;
BEGIN;
UPDATE userinfo
SET pid = 123456121
WHERE customerName = '张三';
COMMIT;

SET autocommit=0;
BEGIN;
UPDATE cardinfo
SET IsReportLoss = 1
WHERE customerID='1';
COMMIT;


SELECT transType,SUM(transMoney)
FROM tradeinfo
GROUP BY transType

SELECT cardID,customerID
FROM cardinfo WHERE WEEK(NOW())=WEEK(openDate);

SELECT DISTINCT cardID FROM tradeinfo
WHERE transMoney = (
	SELECT MAX(transMoney) FROM tradeinfo
)

SELECT userinfo.customerName,userinfo.telephone,cardinfo.cardID
FROM userinfo
JOIN cardinfo ON userinfo.customerID=cardinfo.customerID
WHERE cardinfo.IsReportLoss = '1';

SELECT userinfo.customerName,cardinfo.cardID,cardinfo.balance
FROM userinfo
JOIN cardinfo ON userinfo.customerID=cardinfo.customerID
WHERE cardinfo.balance <0;

CREATE VIEW view_userinfo
AS 
SELECT customerID AS 客户id,
customerName AS 客户名,
PID AS 账户号,
telephone AS 联系电话,
address AS 联系地址
FROM userinfo

CREATE VIEW view_cardInfo
AS 
SELECT cardID AS 银行卡号,
curID AS 货币类型,
deposit.savingName AS 存款类型,
openDate AS 开卡日期,
openMoney AS 开户金额,
balance AS 现有存款,
customerID AS 客户号
FROM cardinfo
JOIN deposit ON cardinfo.savingID=cardinfo.savingID
GROUP BY cardID

CREATE VIEW view_transInfo
AS
SELECT transDate AS 交易日期,
cardID AS 银行卡号,
transType AS 交易类型,
transMoney AS 交易金额,
remark AS 备注
FROM tradeinfo;
