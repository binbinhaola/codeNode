--������ѯ
select * from emp;
select * from dept;
select grade ,losal,hisal from salgrade;



--��ѯָ���е�����
select grade ,losal from salgrade;
select empno,ename,hiredate,sal from emp;


--��ѯ�Ҳ������ظ�������
select empno,ename,job from emp;
select distinct job  from emp;
select * from emp;
select job,max(sal),avg(sal),152 from emp group by job

--ָ������
--ע�⣬����ʹ��˫���ţ�as����ʡ��
select * from emp;
select empno,ename ,sal*12 as "��н" from emp;
select empno,ename ,sal*12  "��н" from emp;
select empno,ename ,sal*12 ��н2 from emp;
select empno,ename ,sal*12 "�� н 3" from emp;
--�����������||���������ַ�����ƴ��
select concat('hello','world')||'java' from dual;
select concat(concat('hello','world'),'python') from dual;
select 'hello'||'world'||'java'||'hi' from dual;



---�������+ - * / mod �����ڼӼ��˳�ģ
select 1+2 from dual;

select 2/1.0,1/2.0 from dual;

select mod(10,3) from dual;

--where����ɸѡscott
select * from emp where ename like concat(concat('%','C'),'%')


--α��
select rowid,rownum from emp;


--���� oder by  asc����desc����
select empno,ename,sal from emp ;
select empno, ename,sal  from emp order by sal asc;


--��������
select empno,ename,sal  from emp order by sal desc,empno desc;



--������ 


--������
select * from emp e
inner join dept d
on e.deptno=d.deptno


--��������--�����Ϊ���������ұ��Ƿ����
select * from emp e
left join dept d
on e.deptno=d.deptno


--��������--���ұ�Ϊ��
select * from emp e
right join dept d
on e.deptno=d.deptno



--ȫ���ӣ������ұ��Ƿ������֮ƥ�����
select * from emp e full join dept d 
on e.deptno=d.deptno

--��������,��ʹ���κ�ƥ������������ÿһ�к��ұ�ÿһ�ж�ƥ��--�����ѿ�����
select * from emp e cross join dept d 


--��ѯ���Ľ���� 4*15=60��
select * from dept;

select * from emp e ,dept d  where e.deptno=d.deptno

select * from emp e cross join dept d 
where e.deptno=d.deptno


---һ��ӹ�������where
--��ѯԱ��������Ա��нˮ�����ڲ��ŵ�����
select ename,sal,dname from emp e
,dept d where e.deptno=d.deptno

select ename,sal,dname from emp e
inner join dept d on e.deptno=d.deptno

--��ѯÿ��Ա����нˮ�ȼ� ��׼92SQL
select * from salgrade

select empno,ename,sal,grade as "нˮ�ȼ�"
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal

--�Ǳ�д������Щ���ݿⲻ֧��
select empno,ename,sal,grade as "нˮ�ȼ�"
from emp e, salgrade s
where e.sal between s.losal and s.hisal




---��������ӣ���1�ű����Ϊ2�ű�
--��ѯԱ����SMITH�� ���ϼ��쵼������
SELECT  
e1.EMPNO "�ϼ��쵼���",e1.ENAME "�ϼ��쵼����",
e2.empno "Ա������",e2.ename "Ա������"
from emp e1,emp e2 
where e1.empno  = e2.mgr and e2.ename='SMITH'

select * from emp;


--�Ӳ�ѯ����SQL���Ƕ�ײ�ѯ
1�������Ӳ�ѯ��=,<,>,<=,>=,<>
--��ѯ��SMITHͬ���ŵ�Ա��,�����Ȳ�smith���ڵĲ��ű��-��Ϊɸѡ����

SELECT * FROM EMP WHERE DEPTNO=(select deptno from emp where ename='SMITH')


2�������Ӳ�ѯ��in,not in
--��ѯ�벿��20Ա��ͬ��λ��Ա��

SELECT * FROM EMP
 WHERE JOB IN (SELECT distinct JOB FROM EMP WHERE DEPTNO=20)


--exists�Ӳ�ѯ 
select sysdate from dual;
--select now() from dual;
select * from emp  --if(�Ӳ�ѯ�Ƿ��н��){ ִ������ѯ}else{����ѯʲôҲ����ѯ}
where exists (select sysdate from dual where 1=2)


3�������Ӳ�ѯ�������ж��
--��ѯ��SMITHͬ����ͬ��λ��Ա��
select deptno,job from emp where ename='SMITH'
SELECT * FROM EMP WHERE DEPTNO=20

SELECT * FROM EMP WHERE 
DEPTNO=(select deptno from emp where ename='SMITH')
AND JOB=(select job from emp where ename='SMITH')

SELECT * FROM EMP WHERE 
(deptno,job)
=(select deptno,job from emp where ename='SMITH')


4�����ж����Ӳ�ѯ��     
--��ѯÿ�����Ź�����ߵ�Ա����Ϣ

select * from emp 
where (deptno,sal) in 
(select deptno,max(sal) from emp e group by deptno)

--����Ӳ�ѯ��������ѯ�У�ÿ��ѯһ����¼����Ҫ������һ���Ӳ�ѯ�����ֳ�Ϊ����Ӳ�ѯ��
--�Ӳ�ѯ�����ⲿ����
select * from emp e where sal=(
select max(sal) from emp  where e.deptno=emp.deptno
)



5��������ͼ�Ӳ�ѯ�����Ӳ�ѯ��Ϊ��1����ѯ������Դ
select * from (select * from xx)

--ͳ�ƹ�˾�м�����λ
select count(1) from (
  select distinct job from emp
)
--ͳ��ÿ����λ���ж���Ա��
select job, count(job) from emp group by job
--��ѯнˮ��͵�5��Ա��
select t.*,rownum from(
select * from emp order by sal
) t where rownum<=5


6������Ӳ�ѯ���Ӳ�ѯ�����ڸ���ѯ������(�Ӳ�ѯֻ�ܷ���һ����¼��һ����������)
--��ѯԱ�������Ͳ�������
select ename, deptno,
(select dname from dept  
where e.deptno=dept.deptno ) as "��������" 
from emp e

 
14����ɾ����ʹ���Ӳ�ѯ
--ɾ��нˮ����ALLEN��Ա��
delete from emp where sal<(select sal from emp where ename='aLLEN')

--��SMITH��нˮ�޸ĳɺ�ALLENһ��
UPDATE EMP SET SAL=(select sal from emp where ename='aLLEN')
WHERE ENAME='smith'


insert into xx(select * from yy)

--��ҳ��ѯ�����Ӳ�ѯ��ʹ��rownum��Ϊ�̶��в�ָ������
select * from(
  select t.*,rownum as rn from (
	 select * from emp order by sal desc
	) t where rownum<=10
)where rn>5

--�ۺ���ϰ����ѯнˮ���ڲ���ƽ��нˮ��Ա��
select deptno,avg(sal) from emp group by deptno;


--�Ӳ�ѯ+���Ӳ�ѯ
select * from emp e,
(select deptno,avg(sal) as pj from emp group by deptno) t
where e.sal>t.pj and e.deptno=t.deptno

select * from emp;
--����Ӳ�ѯ
select * from emp e where sal>(
select avg(sal) from emp where deptno=e.deptno
)


--�Ƚϲ�����
select * from emp where ename like '_S%' 


--IN ��ָ��ֵ��Χ��
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE EMPNO IN(7788,7839,1122)


--is null
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM IS NULL

--between and
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM between 300.00 and 6000


--not ����
SELECT EMPNO,ENAME ,SAL ,COMM FROM EMP WHERE COMM IS not NULL



--�߼�����
--��ѯнˮ����2000���߸�λΪCLERK��Ա����Ϣ��ͬʱ��Ҫ��������������ĸΪ��дJ


17�����ϲ�����
��������ѯ�Ľ����ϳ�һ������� 

--�󲢼�
Union�����ϣ�������������ѯѡ�������еĲ��ظ�����--5�� 
select deptno from emp
UNION
select deptno from dept;

Union all���������У�������������ѯѡ���������У������ظ���--19��


select deptno from emp
UNION ALL
select deptno from dept;

--�󽻼�--���������д���
Intersect��������������������ѯ���е���

select deptno from emp
INTERSECT
select deptno from dept;



--��
--�ӵ�һ�������м�ȥ�ڶ������ϵ�����
--������˵���ڵ�һ�������д��ڣ��ڵڶ��������в����ڵ�
select * from dept
Minus���������������ɵ�1����ѯѡ������û�б���2����ѯѡ�����С�
select deptno from dept
MINUS
select deptno from emp



select sysdate from dual;
ע�⣺���ϲ��������ӵĸ�����ѯҪ������ͬ���������Ҷ�Ӧ�е��������ͱ�����ͬ��
SELECT * FROM emp WHERE hiredate>'1-1��-1981';
SELECT * FROM emp WHERE hiredate>'1986/2/22';
