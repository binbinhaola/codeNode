ALTER TABLE emp
ADD CONSTRAINT fk_DEPTNO FOREIGN KEY (DEPTNO)
REFERENCES dept(DEPTNO);

#1
SELECT emp.ENAME AS 员工姓名,emp.SAL AS 工资,dept.DNAME AS 工作部门
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE emp.ENAME = 'smith';

#2
SELECT ename AS 姓名,(sal*13) AS 年薪
FROM emp

#3
SELECT ename AS 姓名
FROM emp
WHERE sal>3000

#4
SELECT ename AS 姓名
FROM emp
WHERE sal>=800 AND sal<=1600

#5
SELECT ename AS 姓名,hiredate AS 入职时间
FROM emp 
WHERE hiredate > '1982-1-1'

#6
SELECT ename AS 姓名
FROM emp
WHERE ename LIKE 'S%'

#7
SELECT ename AS 姓名
FROM emp
WHERE ename LIKE '__O%'

#8
SELECT enmae AS 姓名
FROM emp 
WHERE empno IN '7369','7499','7521'

#9
SELECT ename AS 姓名
FROM emp
WHERE mgr IS NULL

#10
SELECT ename AS 姓名,job AS 职位,sal AS 工资
FROM emp
WHERE ename LIKE 'S%' AND (job='manager' OR sal > 500)

#11
SELECT *
FROM emp
ORDER BY deptno,sal DESC

#12
SELECT *
FROM emp
ORDER BY deptno ,hiredate DESC

#13
SELECT *
FROM emp
ORDER BY (sal*12) DESC

#14
SELECT *
FROM emp
ORDER BY sal DESC LIMIT 1

#15
SELECT *
FROM emp
ORDER BY sal  LIMIT 1

#16
SELECT *
FROM emp
WHERE sal >(SELECT AVG(sal) FROM emp)

#17
SELECT MAX(sal) AS 最高工资,MIN(sal) AS 最低工资,deptno AS 部门号
FROM emp
GROUP BY deptno
ORDER BY deptno DESC 


#18
SELECT deptno AS 部门号,AVG(sal) AS 平均工资
FROM emp
WHERE sal <2000

#19
SELECT ename AS 姓名,sal AS  工资
FROM emp

#20
SELECT emp.ename AS 姓名,emp.SAL AS 工资,dept.DNAME AS 部门名
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO

#21
SELECT *FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename = 'jones')

#22
SELECT * FROM emp
WHERE deptno =(SELECT deptno FROM emp WHERE ename='smith')
AND ename !=(SELECT ename FROM emp WHERE ename='smith')

#23
SELECT * FROM emp
WHERE deptno =(SELECT deptno FROM emp WHERE ename='smith')
AND job =(SELECT job FROM emp WHERE ename='smith')
AND ename !=(SELECT ename FROM emp WHERE ename='smith')

#24
SELECT *
FROM emp
GROUP BY ename 
HAVING sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno)




#25
SELECT ename AS 姓名,sal AS 工资,deptno AS 部门编号
FROM emp
WHERE sal >ALL(
	SELECT sal 
	FROM emp
	WHERE deptno = '30'
)