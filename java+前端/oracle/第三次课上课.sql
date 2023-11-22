--单行函数
--1.日期函数
select sysdate from dual; -- 2023/2/14 8:54:19
select to_char(sysdate) from dual; --14-2月 -23


--日期函数 d-日期  n-月数
--Add_Months(d,n):返回给指定日期加上指定月数后的日期值
select add_months('14-2月 -22',12) from dual;
select add_months(2023/2/14 8:54:19,12) from dual;


--Months_Between(d1,d2):返回两个日期之间的月数
select months_between('14-2月 -21',sysdate) from dual;
select months_between('14-3月 -21','14-2月 -21') from dual;


--Last_Day(d):返回指定日期  当月的最后一天的日期值
select last_day(sysdate) from dual;
select last_day('14-3月 -21') from dual;


--Round(d[,fmt]):返回四舍五入后的日期值
--月的四舍五入以每月的15号为基准
--年的四舍五入以每年的6月为基准MONTH
select SYSDATE, round(sysdate,'YEAR') AS "年",round(sysdate,'MONTH') FROM DUAL;


--Next_Day(d,day):返回指定日期之后的星期几(day-1)的日期
--星期日=1，星期一=2，*****星期四=5 星期六==7
select next_day(sysdate,6) from dual;

--Extract(fmt from d):提取日期时间类型中的特定部分
select sysdate,
extract(YEAR FROM SYSDATE) 年,
extract(MONTH FROM SYSDATE) 月,
extract(DAY FROM SYSDATE) 日

from dual;
select * from emp where extract(YEAR FROM hiredate)='1981'
--字符函数
--1）length(char) 返回字符个数
--2）lengthb(char) 返回字节个数
select length('hello'),lengthb('hello') from dual;
select length('中国'),lengthb('中国') from dual;


--字符串下标从1开始，0也表示第1个字符
--3）substr(字符串,开始下标[,截取长度]) --截取字符串
--cssl@126.com 截取邮箱用户名和网站名
select substr('hello@xx.com.cn',7,6) from dual;
select substr('hello@xx.com.cn',6,6) from dual;


--4）instr(字符串,要找的字符) 查找字符串，返回对应的下标，未找到返回0
select instr('hello world','o') from dual;
select instr('hello world','x') from dual;


--也就是说：
select instr('hello world,hello python','o',6) from dual; ---从第6位开始找
select instr('hello world,hello python','o',6,2) from dual;--从第6位开始找，第2次出现的位置

--查询'S'开头的员工信息
select * from emp where instr(ename,'S')=1

--&参数名：表示接收用户输入  1685496@qq.com
select substr('&s',instr('&s','@')+1) from dual;


--5）replace(字符串,旧字符[,新字符]) 替换字符串
--将空格使用*替换
select replace(ename,'S','*') FROM EMP;

--去除指定右边边元素
select rtrim('helloadmin','admin') from dual;

--去掉所有空格
SELECT length('  hello world  '), 
REPLACE('  hello world  ',' ',''),
length(REPLACE('  hello world  ',' ','')) from dual;

--去掉右边的空格
select 'abc'||'  hello   world  '||'jack' from dual;
select 'abc'||rtrim('  hello   world  ')||'jack' from dual;

--去掉左边的空格
select 'abc'||'  hello   world  '||'jack' from dual;
select 'abc'||ltrim('  hello   world  ')||'jack' from dual;

--去掉首尾空格
select 'abc'||trim('  hello   world  ')||'jack' from dual;

--统计字符串中某个字符出现的次数   统计你身份证号码中1出现的次数
-- ABCDEAA的长度7---ABCDEAA,A,-BCDE
select 
length('430101199811113335')- 
length(replace('430101199811113335','0','')) 
from dual;
--6）chr()和ascii() 字符和ASCII码的转换
select chr(97),ascii('b') from dual;


--7）lpad()和rpad() 左右补全 
select lpad('hello',10,'#') from dual;
select rpad('hello',10,'#') from dual;
select rpad(lpad('hello',10,'#'),15,'#') from dual;

--initcap--将首字母边成大写
select initcap('hello')||initcap('world') from dual;

--lower--全小写
select lower('HELLOWORLD') FROM DUAL;

--upper-全大写
select UPPER('helloWorld') FROM DUAL;

--连接concat
SELECT CONCAT('HELLO','world') from dual;

--3、数学函数
--abs取绝对值
select abs(-11.5),abs(11.6) from dual;

--ceil(number) 向上取整，返回大于等于该数的最小整数
select ceil(100.5631) from dual;
select ceil(-99.5631) from dual;

--cos()取角度的余弦值
select cos(180) from dual;

--cosh反余弦值
select cosh(0) from dual;
--floor(number) 向下取整，返回小于等于该数的最大整数
select floor(123.12) from dual;
select floor(-99.98) from dual;

3）round(number[,number]) 四舍五入
select round(99.9873,3), round(99.9873,2) from dual;

select  round(92.9873,-1) from dual;
select  round(99.9873,-2) from dual;
4）trunc(number[,number]) 截断数字
select  trunc(92.9873,1) from dual;
select  trunc(99.9873,2) from dual;

--表示将小数点左边指定位数后面的部分截去，即均以0记;
select  trunc(92.9873,0) from dual;
select  trunc(99.9873,-1) from dual;
select  trunc(99.9873,-2) from dual;


--取数字n的符号,大于0返回1,小于0返回-1,等于0返回0
select sign(123),sign(0),sign(-56) from dual;

select 10%3 from dual;

select mod(10,3) from dual;
select power(3,4) from dual;
select sqrt(16) from dual;






---4、转换函数
1）to_char(date[,fmt]) 将日期转换为字符串
--默认格式
select to_char(sysdate) from dual;
--指定格式：年yyyy，月mm，日dd，时hh/hh24，分mi，秒ss，星期day
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from dual;
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from dual;

select to_char(sysdate,'yyyy"年"mm"月"dd"日" hh24"时"mi"分"ss"秒" day') from dual;

--fm 表示去掉前缀0
select to_char(sysdate,'yyyy-fmmm-dd hh24:mi:ss day') from dual;

--查询1982年入职的员工 EXTRACT|TO_CHAR
select * from emp where extract(year from hiredate)='1982'
select * from emp where to_char(hiredate,'yyyy')='1981'


2）to_char(number[,fmt]) 将数字转换为字符串，用于货币的显示($CL)
select sal, to_char(sal,'$99,999,999.99') from emp;
select sal, to_char(sal,'L99,999,999.99') from emp;
select sal, to_char(sal,'L00,000,000.00') from emp;

3）to_date(char[,fmt]) 将字符串转换为日期
--默认格式
SELECT SYSDATE FROM DUAL; 

--指定格式
SELECT TO_cHAR(SYSDATE) FROM DUAL; 

SELECT TO_DATE('2023-12-14','yyyy-mm-dd')-sysdate from dual;
SELECT TO_DATE('2023/12/14','yyyy/mm/dd')-sysdate from dual;
f

4）to_number()
select to_number('12.88')*0.88 from dual;
select '88.88'*0.88 from dual;

--5、其他函数
1）nvl(exp1,exp2) 空值替换函数，如果exp1为null则返回exp2
   nvl2(exp1,exp2,exp3),nullif(exp1,exp2)如果exp1=exp2则为null
a-如果表达式中包含null计算，则返回null
b-Oracle排序时，将null值理解为最大
--查询每个员工的年薪（(月薪+提成)*12）
select sal,comm,(sal*13+comm) "年薪" from emp;
select sal,comm,(sal*13+nvl(comm,0)) "年薪" from emp;

--Nvl2(exp1,exp2,exp3)
--如果exp1不为null，则返回exp2，否则返回exp3
select sal,comm,(sal*13+nvl2(comm,comm,0)) "年薪" from emp;

--Nullif(exp1,exp2)
--如果exp1=exp2，则返回null，否则返回exp1
select ename,sal ,sal*13+nullif(sal,3000) from emp;
--查询员工信息并按提成降序，没有提成的按薪水降序
select * from emp order by nvl(comm,-1) desc,sal desc;

2）decode() 条件判断函数，相当于case...when...then...end
--查询部门信息，并将部门名称翻译成中文
SELECT * FROM dept;
    select deptno,dname,case deptno
		  when 10 then '财务部'
			when 20 then '研发部'
			when 30 then '后勤部'
      else  '打杂部'
			end "部门名称"
			from dept
			
select deptno,dname,decode(deptno,10,'财务部',20,'研发部',30,'后勤部','打杂部') "部门名称"
from dept


--在包含Group by子句的查询中，select子句中列表的项只能是
--聚合函数、常量、Group by表达式（分组字段或表达式）、
--常数或包含上述项之一的表达式。
--不能包含其他的列 ename,
select  123,avg(sal),deptno from emp group by deptno

--分析函数  -统计每个部门的人数



--分析函数 按照部门分区 按照薪水降序 order by：开窗函数，partition by：指定分区（组）
select empno,ename,sal,deptno,
row_number() over(partition by deptno order by sal desc) as "row_number",
rank() over(partition by deptno order by sal desc) as "rank",
DENSE_RANK() over(partition by deptno order by sal desc) as "DENSE_RANK"
from emp;








---
select empno,ename,sal,deptno,
row_number() over( order by sal desc) as "row_number",
rank() over( order by sal desc) as "rank",
DENSE_RANK() over( order by sal desc) as "DENSE_RANK"
from emp;
--row_number:自然排序，不跳跃
--rank:遇到相同的排序相同，后面跳跃
--densrank:遇到相同的排序相同，后面不跳跃


---采用rownum关键字(三层嵌套)

SELECT * FROM (
  SELECT A.*,ROWNUM  num FROM   ( 
         SELECT * FROM emp  ORDER BY empno) A  
         WHERE  ROWNUM<=5 ) 
  WHERE num>=1;--返回第1-5行数据

--采用row_number解析函数进行分页(效率更高)
select t.* from (
   select e.*,row_number() over(order by empno asc) as pageNums from emp e
) t where pageNums between 6 and 10



select * from emp order by empno
 --返回第1-5行数据  
 
--drop table
---行列转换
select * from emp_info;
--列转行:
select * from emp_info 
pivot(max(email) for sex in('男' as NAND,'女' as NVD ,'中' as ZHONGD))

--查询表2
select * from emp_info1 

--行转列
select * from emp_info1
unpivot(email for sex in(NAND as '男' ,NVD as '女' ,ZHONGED as '中' ))



--列出各部门的工资总和
SELECT * FROM (SELECT sal,deptno from emp) 
pivot(sum(sal) for deptno in(10 as 部门10,20 as 部门20,30 as 部门30))

--这里deptno是有限的、可穷举的，
--如果是变化的、随机添加的，则可在in后面使用any或者子查询，此时查询的结果是XML格式串 
select * 
  from ((select sal, deptno from emp) pivot 
        xml(sum(sal) for deptno in (any)));
        
 ---子查询
 select * 
  from ((select sal, deptno from emp) pivot 
        xml(sum(sal) for deptno in 
        (select deptno from emp where deptno in (10, 20, 30))));


<PivotSet>
	<item>
		<column name = "DEPTNO">10</column>
		<column name = "SUM(SAL)">8750</column>
	</item>
<item><column name = "DEPTNO">20</column>
<column name = "SUM(SAL)">11675</column>
</item>
<item>
<column name = "DEPTNO">30</column>
<column name = "SUM(SAL)">9400</column>
</item>
</PivotSet>
