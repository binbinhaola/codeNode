--���к���
--1.���ں���
select sysdate from dual; -- 2023/2/14 8:54:19
select to_char(sysdate) from dual; --14-2�� -23


--���ں��� d-����  n-����
--Add_Months(d,n):���ظ�ָ�����ڼ���ָ�������������ֵ
select add_months('14-2�� -22',12) from dual;
select add_months(2023/2/14 8:54:19,12) from dual;


--Months_Between(d1,d2):������������֮�������
select months_between('14-2�� -21',sysdate) from dual;
select months_between('14-3�� -21','14-2�� -21') from dual;


--Last_Day(d):����ָ������  ���µ����һ�������ֵ
select last_day(sysdate) from dual;
select last_day('14-3�� -21') from dual;


--Round(d[,fmt]):������������������ֵ
--�µ�����������ÿ�µ�15��Ϊ��׼
--�������������ÿ���6��Ϊ��׼MONTH
select SYSDATE, round(sysdate,'YEAR') AS "��",round(sysdate,'MONTH') FROM DUAL;


--Next_Day(d,day):����ָ������֮������ڼ�(day-1)������
--������=1������һ=2��*****������=5 ������==7
select next_day(sysdate,6) from dual;

--Extract(fmt from d):��ȡ����ʱ�������е��ض�����
select sysdate,
extract(YEAR FROM SYSDATE) ��,
extract(MONTH FROM SYSDATE) ��,
extract(DAY FROM SYSDATE) ��

from dual;
select * from emp where extract(YEAR FROM hiredate)='1981'
--�ַ�����
--1��length(char) �����ַ�����
--2��lengthb(char) �����ֽڸ���
select length('hello'),lengthb('hello') from dual;
select length('�й�'),lengthb('�й�') from dual;


--�ַ����±��1��ʼ��0Ҳ��ʾ��1���ַ�
--3��substr(�ַ���,��ʼ�±�[,��ȡ����]) --��ȡ�ַ���
--cssl@126.com ��ȡ�����û�������վ��
select substr('hello@xx.com.cn',7,6) from dual;
select substr('hello@xx.com.cn',6,6) from dual;


--4��instr(�ַ���,Ҫ�ҵ��ַ�) �����ַ��������ض�Ӧ���±꣬δ�ҵ�����0
select instr('hello world','o') from dual;
select instr('hello world','x') from dual;


--Ҳ����˵��
select instr('hello world,hello python','o',6) from dual; ---�ӵ�6λ��ʼ��
select instr('hello world,hello python','o',6,2) from dual;--�ӵ�6λ��ʼ�ң���2�γ��ֵ�λ��

--��ѯ'S'��ͷ��Ա����Ϣ
select * from emp where instr(ename,'S')=1

--&����������ʾ�����û�����  1685496@qq.com
select substr('&s',instr('&s','@')+1) from dual;


--5��replace(�ַ���,���ַ�[,���ַ�]) �滻�ַ���
--���ո�ʹ��*�滻
select replace(ename,'S','*') FROM EMP;

--ȥ��ָ���ұ߱�Ԫ��
select rtrim('helloadmin','admin') from dual;

--ȥ�����пո�
SELECT length('  hello world  '), 
REPLACE('  hello world  ',' ',''),
length(REPLACE('  hello world  ',' ','')) from dual;

--ȥ���ұߵĿո�
select 'abc'||'  hello   world  '||'jack' from dual;
select 'abc'||rtrim('  hello   world  ')||'jack' from dual;

--ȥ����ߵĿո�
select 'abc'||'  hello   world  '||'jack' from dual;
select 'abc'||ltrim('  hello   world  ')||'jack' from dual;

--ȥ����β�ո�
select 'abc'||trim('  hello   world  ')||'jack' from dual;

--ͳ���ַ�����ĳ���ַ����ֵĴ���   ͳ�������֤������1���ֵĴ���
-- ABCDEAA�ĳ���7---ABCDEAA,A,-BCDE
select 
length('430101199811113335')- 
length(replace('430101199811113335','0','')) 
from dual;
--6��chr()��ascii() �ַ���ASCII���ת��
select chr(97),ascii('b') from dual;


--7��lpad()��rpad() ���Ҳ�ȫ 
select lpad('hello',10,'#') from dual;
select rpad('hello',10,'#') from dual;
select rpad(lpad('hello',10,'#'),15,'#') from dual;

--initcap--������ĸ�߳ɴ�д
select initcap('hello')||initcap('world') from dual;

--lower--ȫСд
select lower('HELLOWORLD') FROM DUAL;

--upper-ȫ��д
select UPPER('helloWorld') FROM DUAL;

--����concat
SELECT CONCAT('HELLO','world') from dual;

--3����ѧ����
--absȡ����ֵ
select abs(-11.5),abs(11.6) from dual;

--ceil(number) ����ȡ�������ش��ڵ��ڸ�������С����
select ceil(100.5631) from dual;
select ceil(-99.5631) from dual;

--cos()ȡ�Ƕȵ�����ֵ
select cos(180) from dual;

--cosh������ֵ
select cosh(0) from dual;
--floor(number) ����ȡ��������С�ڵ��ڸ������������
select floor(123.12) from dual;
select floor(-99.98) from dual;

3��round(number[,number]) ��������
select round(99.9873,3), round(99.9873,2) from dual;

select  round(92.9873,-1) from dual;
select  round(99.9873,-2) from dual;
4��trunc(number[,number]) �ض�����
select  trunc(92.9873,1) from dual;
select  trunc(99.9873,2) from dual;

--��ʾ��С�������ָ��λ������Ĳ��ֽ�ȥ��������0��;
select  trunc(92.9873,0) from dual;
select  trunc(99.9873,-1) from dual;
select  trunc(99.9873,-2) from dual;


--ȡ����n�ķ���,����0����1,С��0����-1,����0����0
select sign(123),sign(0),sign(-56) from dual;

select 10%3 from dual;

select mod(10,3) from dual;
select power(3,4) from dual;
select sqrt(16) from dual;






---4��ת������
1��to_char(date[,fmt]) ������ת��Ϊ�ַ���
--Ĭ�ϸ�ʽ
select to_char(sysdate) from dual;
--ָ����ʽ����yyyy����mm����dd��ʱhh/hh24����mi����ss������day
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from dual;
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from dual;

select to_char(sysdate,'yyyy"��"mm"��"dd"��" hh24"ʱ"mi"��"ss"��" day') from dual;

--fm ��ʾȥ��ǰ׺0
select to_char(sysdate,'yyyy-fmmm-dd hh24:mi:ss day') from dual;

--��ѯ1982����ְ��Ա�� EXTRACT|TO_CHAR
select * from emp where extract(year from hiredate)='1982'
select * from emp where to_char(hiredate,'yyyy')='1981'


2��to_char(number[,fmt]) ������ת��Ϊ�ַ��������ڻ��ҵ���ʾ($CL)
select sal, to_char(sal,'$99,999,999.99') from emp;
select sal, to_char(sal,'L99,999,999.99') from emp;
select sal, to_char(sal,'L00,000,000.00') from emp;

3��to_date(char[,fmt]) ���ַ���ת��Ϊ����
--Ĭ�ϸ�ʽ
SELECT SYSDATE FROM DUAL; 

--ָ����ʽ
SELECT TO_cHAR(SYSDATE) FROM DUAL; 

SELECT TO_DATE('2023-12-14','yyyy-mm-dd')-sysdate from dual;
SELECT TO_DATE('2023/12/14','yyyy/mm/dd')-sysdate from dual;
f

4��to_number()
select to_number('12.88')*0.88 from dual;
select '88.88'*0.88 from dual;

--5����������
1��nvl(exp1,exp2) ��ֵ�滻���������exp1Ϊnull�򷵻�exp2
   nvl2(exp1,exp2,exp3),nullif(exp1,exp2)���exp1=exp2��Ϊnull
a-������ʽ�а���null���㣬�򷵻�null
b-Oracle����ʱ����nullֵ���Ϊ���
--��ѯÿ��Ա������н��(��н+���)*12��
select sal,comm,(sal*13+comm) "��н" from emp;
select sal,comm,(sal*13+nvl(comm,0)) "��н" from emp;

--Nvl2(exp1,exp2,exp3)
--���exp1��Ϊnull���򷵻�exp2�����򷵻�exp3
select sal,comm,(sal*13+nvl2(comm,comm,0)) "��н" from emp;

--Nullif(exp1,exp2)
--���exp1=exp2���򷵻�null�����򷵻�exp1
select ename,sal ,sal*13+nullif(sal,3000) from emp;
--��ѯԱ����Ϣ������ɽ���û����ɵİ�нˮ����
select * from emp order by nvl(comm,-1) desc,sal desc;

2��decode() �����жϺ������൱��case...when...then...end
--��ѯ������Ϣ�������������Ʒ��������
SELECT * FROM dept;
    select deptno,dname,case deptno
		  when 10 then '����'
			when 20 then '�з���'
			when 30 then '���ڲ�'
      else  '���Ӳ�'
			end "��������"
			from dept
			
select deptno,dname,decode(deptno,10,'����',20,'�з���',30,'���ڲ�','���Ӳ�') "��������"
from dept


--�ڰ���Group by�Ӿ�Ĳ�ѯ�У�select�Ӿ����б����ֻ����
--�ۺϺ�����������Group by���ʽ�������ֶλ���ʽ����
--���������������֮һ�ı��ʽ��
--���ܰ����������� ename,
select  123,avg(sal),deptno from emp group by deptno

--��������  -ͳ��ÿ�����ŵ�����



--�������� ���ղ��ŷ��� ����нˮ���� order by������������partition by��ָ���������飩
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
--row_number:��Ȼ���򣬲���Ծ
--rank:������ͬ��������ͬ��������Ծ
--densrank:������ͬ��������ͬ�����治��Ծ


---����rownum�ؼ���(����Ƕ��)

SELECT * FROM (
  SELECT A.*,ROWNUM  num FROM   ( 
         SELECT * FROM emp  ORDER BY empno) A  
         WHERE  ROWNUM<=5 ) 
  WHERE num>=1;--���ص�1-5������

--����row_number�����������з�ҳ(Ч�ʸ���)
select t.* from (
   select e.*,row_number() over(order by empno asc) as pageNums from emp e
) t where pageNums between 6 and 10



select * from emp order by empno
 --���ص�1-5������  
 
--drop table
---����ת��
select * from emp_info;
--��ת��:
select * from emp_info 
pivot(max(email) for sex in('��' as NAND,'Ů' as NVD ,'��' as ZHONGD))

--��ѯ��2
select * from emp_info1 

--��ת��
select * from emp_info1
unpivot(email for sex in(NAND as '��' ,NVD as 'Ů' ,ZHONGED as '��' ))



--�г������ŵĹ����ܺ�
SELECT * FROM (SELECT sal,deptno from emp) 
pivot(sum(sal) for deptno in(10 as ����10,20 as ����20,30 as ����30))

--����deptno�����޵ġ�����ٵģ�
--����Ǳ仯�ġ������ӵģ������in����ʹ��any�����Ӳ�ѯ����ʱ��ѯ�Ľ����XML��ʽ�� 
select * 
  from ((select sal, deptno from emp) pivot 
        xml(sum(sal) for deptno in (any)));
        
 ---�Ӳ�ѯ
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
