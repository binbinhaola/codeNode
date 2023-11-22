#创建用户并授权：
GRANT SELECT,INSERT ON myschools.student
TO `student57`@`localhost` IDENTIFIED BY '123456';

#查看用户：
USE mysql;
SELECT * FROM USER;

#查看用户权限：
SHOW GRANTS FOR `student57`@`localhost`;

#撤销权限：
REVOKE INSERT ON myschools.student FROM `student57`@`localhost`;

#普通用户修改自己的密码：
SET PASSWORD=PASSWORD('123456');

#超级用户才能修改其他用户密码：
SET PASSWORD FOR `student57`@`localhost`=PASSWORD('123456');

#统计银行总存入金额和总支取金额
SELECT tradeType AS 资金流向,SUM(tradeMoney) AS 总金额
FROM tradeinfo 
GROUP BY tradeType;

#查询本月交易金额最高的卡号
#...

#删除用户：
DROP USER `student57`@`localhost`;


