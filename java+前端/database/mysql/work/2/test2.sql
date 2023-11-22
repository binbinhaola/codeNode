SELECT ucompany
FROM tb_Users;

SELECT *
FROM tb_inoutfield;

SELECT *
FROM tb_inoutinfo;

SELECT * 
FROM tb_users
WHERE uname 
LIKE '梁%';

SELECT *
FROM tb_inoutinfo
WHERE rdate BETWEEN 2 AND 3;

SELECT *
FROM tb_inoutinfo
WHERE rmoney BETWEEN 1000 AND 5000;

SELECT SUM(rmoney)
FROM tb_inoutinfo;
