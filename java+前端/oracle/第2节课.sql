--基本查询
select * from emp;
select * from dept;
select grade ,losal,hisal from salgrade;



--查询指定列的数据
select grade ,losal from salgrade;
select empno,ename,hiredate,sal from emp;


--查询且不包含重复的数据
select empno,ename,job from emp;
select distinct job  from emp;
select * from emp;
select job,max(sal),avg(sal),152 from emp group by job

--指定别名
--注意，可以使用双引号，as可以省略
select * from emp;
select empno,ename ,sal*12 as "年薪" from emp;
select empno,ename ,sal*12  "年薪" from emp;
select empno,ename ,sal*12 年薪2 from emp;
select empno,ename ,sal*12 "年 薪 3" from emp;
--连接运算符（||）：用于字符串的拼接
select concat('hello','world')||'java' from dual;
select concat(concat('hello','world'),'python') from dual;
select 'hello'||'world'||'java'||'hi' from dual;



---运算符（+ - * / mod ）用于加减乘除模
select 1+2 from dual;

select 2/1.0,1/2.0 from dual;

select mod(10,3) from dual;

--where条件筛选scott
select * from emp where ename like concat(concat('%','C'),'%')


--伪列
select rowid,rownum from emp;


--排序 oder by  asc升序，desc降序
select empno,ename,sal from emp ;
select empno, ename,sal  from emp order by sal asc;


--多列排序
select empno,ename,sal  from emp order by sal desc,empno desc;



--表连接 


--内连接
select * from emp e
inner join dept d
on e.deptno=d.deptno


--左外连接--以左表为主，不管右边是否存在
select * from emp e
left join dept d
on e.deptno=d.deptno


--右外连接--以右表为主
select * from emp e
right join dept d
on e.deptno=d.deptno



--全连接，不管右表是否存在与之匹配的行
select * from emp e full join dept d 
on e.deptno=d.deptno

--交叉连接,不使用任何匹配条件，左表的每一行和右表每一行都匹配--生产笛卡尔积
select * from emp e cross join dept d 


--查询出的结果是 4*15=60条
select * from dept;

select * from emp e ,dept d  where e.deptno=d.deptno

select * from emp e cross join dept d 
where e.deptno=d.deptno


---一般加过滤条件where
--查询员工姓名，员工薪水及所在部门的名称
select ename,sal,dname from emp e
,dept d where e.deptno=d.deptno

select ename,sal,dname from emp e
inner join dept d on e.deptno=d.deptno

--查询每个员工的薪水等级 标准92SQL
select * from salgrade

select empno,ename,sal,grade as "薪水等级"
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal

--非标写法，有些数据库不支持
select empno,ename,sal,grade as "薪水等级"
from emp e, salgrade s
where e.sal between s.losal and s.hisal




---表的自连接：将1张表理解为2张表
--查询员工‘SMITH’ 的上级领导的姓名
SELECT  
e1.EMPNO "上级领导编号",e1.ENAME "上级领导名称",
e2.empno "员工编码",e2.ename "员工姓名"
from emp e1,emp e2 
where e1.empno  = e2.mgr and e2.ename='SMITH'

select * from emp;


--子查询：在SQL语句嵌套查询
1）单行子查询：=,<,>,<=,>=,<>
--查询与SMITH同部门的员工,分析先查smith所在的部门编号-作为筛选条件

SELECT * FROM EMP WHERE DEPTNO=(select deptno from emp where ename='SMITH')


2）多行子查询：in,not in
--查询与部门20员工同岗位的员工

SELECT * FROM EMP
 WHERE JOB IN (SELECT distinct JOB FROM EMP WHERE DEPTNO=20)


--exists子查询 
select sysdate from dual;
--select now() from dual;
select * from emp  --if(子查询是否有结果){ 执行主查询}else{主查询什么也不查询}
where exists (select sysdate from dual where 1=2)


3）多列子查询：条件有多个
--查询与SMITH同部门同岗位的员工
select deptno,job from emp where ename='SMITH'
SELECT * FROM EMP WHERE DEPTNO=20

SELECT * FROM EMP WHERE 
DEPTNO=(select deptno from emp where ename='SMITH')
AND JOB=(select job from emp where ename='SMITH')

SELECT * FROM EMP WHERE 
(deptno,job)
=(select deptno,job from emp where ename='SMITH')


4）多行多列子查询：     
--查询每个部门工资最高的员工信息

select * from emp 
where (deptno,sal) in 
(select deptno,max(sal) from emp e group by deptno)

--相关子查询：在主查询中，每查询一条记录，需要重新做一次子查询，这种称为相关子查询。
--子查询依赖外部条件
select * from emp e where sal=(
select max(sal) from emp  where e.deptno=emp.deptno
)



5）内联视图子查询：将子查询作为另1个查询的数据源
select * from (select * from xx)

--统计公司有几个岗位
select count(1) from (
  select distinct job from emp
)
--统计每个岗位上有多少员工
select job, count(job) from emp group by job
--查询薪水最低的5个员工
select t.*,rownum from(
select * from emp order by sal
) t where rownum<=5


6）相关子查询：子查询依赖于父查询的数据(子查询只能返回一条记录，一般是主键表)
--查询员工姓名和部门名称
select ename, deptno,
(select dname from dept  
where e.deptno=dept.deptno ) as "部门名称" 
from emp e

 
14、增删改中使用子查询
--删除薪水低于ALLEN的员工
delete from emp where sal<(select sal from emp where ename='aLLEN')

--将SMITH的薪水修改成和ALLEN一样
UPDATE EMP SET SAL=(select sal from emp where ename='aLLEN')
WHERE ENAME='smith'


insert into xx(select * from yy)

--分页查询：在子查询中使用rownum作为固定列并指定别名
select * from(
  select t.*,rownum as rn from (
	 select * from emp order by sal desc
	) t where rownum<=10
)where rn>5

--综合练习：查询薪水高于部门平均薪水的员工
select deptno,avg(sal) from emp group by deptno;


--子查询+连接查询
select * from emp e,
(select deptno,avg(sal) as pj from emp group by deptno) t
where e.sal>t.pj and e.deptno=t.deptno

select * from emp;
--相关子查询
select * from emp e where sal>(
select avg(sal) from emp where deptno=e.deptno
)


--比较操作符
select * from emp where ename like '_S%' 


--IN 在指定值范围内
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE EMPNO IN(7788,7839,1122)


--is null
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM IS NULL

--between and
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM between 300.00 and 6000


--not 连接
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM IS not NULL



--逻辑运算
--查询薪水高于2000或者岗位为CLERK的员工信息，同时还要满足其姓名首字母为大写J


17、集合操作符
将两个查询的结果组合成一个结果集 

--求并集
Union（联合）：返回两个查询选定的所有的不重复的行--5行 
select deptno from emp
UNION
select deptno from dept;

Union all（联合所有）：返回两个查询选定的所有行，包括重复行--19行


select deptno from emp
UNION ALL
select deptno from dept;

--求交集--两个集合中存在
Intersect（交集）：返回两个查询都有的行

select deptno from emp
INTERSECT
select deptno from dept;



--求差集
--从第一个集合中减去第二个集合的数据
--或者是说，在第一个集合中存在，在第二个集合中不存在的
select * from dept
Minus（减集）：返回由第1个查询选定但是没有被第2个查询选定的行。
select deptno from dept
MINUS
select deptno from emp



select sysdate from dual;
注意：集合操作符联接的各个查询要具有相同的列数，且对应列的数据类型必须相同。
SELECT * FROM emp WHERE hiredate>'1-1月-1981';
SELECT * FROM emp WHERE hiredate>'1986/2/22';
