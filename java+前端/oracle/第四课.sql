--首先要有查询权限
select * from scott.emp;


--1、同义词
--CREATE OR REPLACE [PUBLIC] SYNONYM 同义词名 FOR 模式名.对象名;
--创建私有同义词（默认没有创建权限）
create or replace synonym kgc57_syn_emp for scott.emp;

--访问私有同义词
select * from kgc57_syn_emp

--查看同义词
select * from user_synonyms

--删除私有同义词
drop synonym kgc57_syn_emp


--创建公有同义词（默认没有创建权限,可以和现有对象重名）
create or replace public synonym kgc57_public_syn_emp for scott.emp;

--访问公有同义词
select * from kgc57_public_syn_emp


--删除公有同义词(默认也没有权限)
drop public synonym kgc57_public_syn_emp

--2、序列(主键自增)
select * from dept;
insert into dept(deptno,dname,loc) values(45,'吹牛部','2101教室')
--创建序列
create  sequence kgc57_dept_deptno_seq
start with 50
increment by 10
maxvalue 50000
minvalue 50
cycle
cache 50


--修改序列
alter sequence kgc57_dept_deptno_seq maxvalue 2000 nocycle

--无法修改起始值


--直接创建
;

--访问序列(第一次必须先nextval)
select kgc57_dept_deptno_seq.nextval from dual;
select kgc57_dept_deptno_seq.currval from dual;

--插入操作使用序列
insert into dept(deptno,dname,loc) 
values(kgc57_dept_deptno_seq.nextval,'西门庆','2101教室')
select * from dept;
--删除序列
drop sequence kgc57_dept_deptno_seq


--3、视图
语法：CREATE OR REPLACE VIEW 视图名
         AS
      查询语句 
      [with check option]
      [read only]
--创建视图1:显示员工编号，姓名，职位(不显示薪水)
create or replace view kgc57_emp_view
as
select empno,ename,job from emp
with read only

--查询视图
select * from kgc57_emp_view

--修改视图(read only无法修改)
update kgc57_emp_view set ename='love baby' where empno=5566
select * from emp;
--创建视图2:显示员工和部门信息
create or replace view kgc57_emp_dept_view
as 
select empno,ename,sal,e.deptno,dname from emp e
inner join dept d on e.deptno=d.deptno

--查询视图 
select * from kgc57_emp_dept_view

--无法通过视图 修改多个基表 报错，修改单表可以成功
update kgc57_emp_dept_view set
ename='love baby' ,dname='随便部'
where empno=5566      
--创建视图3:查询薪水2000以下的员工
create or replace view kgc57_emp2_view
as
select 250 as sb, deptno from emp e group by deptno 

select * from kgc57_emp2_view

--修改视图(check option)
update kgc57_emp2_view set sb=360 where deptno=30

--无法修改与非键值保存表对应的列



--创建视图分页

select * from (
  select t.*,rownum as rn from (
	 select * from emp order by sal
	)t where rownum<=10
)where rn>5


--使用视图分页
create or replace view kgc57_view4_page
as
select * from (
  select t.*,rownum as rn from (
	 select * from emp order by sal
	)t where rownum<=5
)where rn>0


select * from kgc57_view4_page
drop view kgc57_view4_page
--4、索引           
--创建索引（默认B树索引）
CREATE INDEX kgc57_emp2_index1 on emp2(ename)
select * from emp2 where ename like '%S%'
SELECT * FROM EMP3 
--唯一索引
CREATE unique INDEX kgc57_emp2_index2 on emp2(empno)
select * from emp2 where empno>5555

--组合索引
select ename,sal from emp2
CREATE INDEX kgc57_emp2_index3 on emp2(ename,sal)

--位图索引
create bitmap index kgc57_emp_index4 on emp2(job)

--删除索引
drop index  kgc57_emp_index4

--查看索引
select * from user_indexes

--mysql查看索引
show index from emp2
show key   from emp
