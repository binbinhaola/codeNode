--����Ҫ�в�ѯȨ��
select * from scott.emp;


--1��ͬ���
--CREATE OR REPLACE [PUBLIC] SYNONYM ͬ����� FOR ģʽ��.������;
--����˽��ͬ��ʣ�Ĭ��û�д���Ȩ�ޣ�
create or replace synonym kgc57_syn_emp for scott.emp;

--����˽��ͬ���
select * from kgc57_syn_emp

--�鿴ͬ���
select * from user_synonyms

--ɾ��˽��ͬ���
drop synonym kgc57_syn_emp


--��������ͬ��ʣ�Ĭ��û�д���Ȩ��,���Ժ����ж���������
create or replace public synonym kgc57_public_syn_emp for scott.emp;

--���ʹ���ͬ���
select * from kgc57_public_syn_emp


--ɾ������ͬ���(Ĭ��Ҳû��Ȩ��)
drop public synonym kgc57_public_syn_emp

--2������(��������)
select * from dept;
insert into dept(deptno,dname,loc) values(45,'��ţ��','2101����')
--��������
create  sequence kgc57_dept_deptno_seq
start with 50
increment by 10
maxvalue 50000
minvalue 50
cycle
cache 50


--�޸�����
alter sequence kgc57_dept_deptno_seq maxvalue 2000 nocycle

--�޷��޸���ʼֵ


--ֱ�Ӵ���
;

--��������(��һ�α�����nextval)
select kgc57_dept_deptno_seq.nextval from dual;
select kgc57_dept_deptno_seq.currval from dual;

--�������ʹ������
insert into dept(deptno,dname,loc) 
values(kgc57_dept_deptno_seq.nextval,'������','2101����')
select * from dept;
--ɾ������
drop sequence kgc57_dept_deptno_seq


--3����ͼ
�﷨��CREATE OR REPLACE VIEW ��ͼ��
         AS
      ��ѯ��� 
      [with check option]
      [read only]
--������ͼ1:��ʾԱ����ţ�������ְλ(����ʾнˮ)
create or replace view kgc57_emp_view
as
select empno,ename,job from emp
with read only

--��ѯ��ͼ
select * from kgc57_emp_view

--�޸���ͼ(read only�޷��޸�)
update kgc57_emp_view set ename='love baby' where empno=5566
select * from emp;
--������ͼ2:��ʾԱ���Ͳ�����Ϣ
create or replace view kgc57_emp_dept_view
as 
select empno,ename,sal,e.deptno,dname from emp e
inner join dept d on e.deptno=d.deptno

--��ѯ��ͼ 
select * from kgc57_emp_dept_view

--�޷�ͨ����ͼ �޸Ķ������ �����޸ĵ�����Գɹ�
update kgc57_emp_dept_view set
ename='love baby' ,dname='��㲿'
where empno=5566      
--������ͼ3:��ѯнˮ2000���µ�Ա��
create or replace view kgc57_emp2_view
as
select 250 as sb, deptno from emp e group by deptno 

select * from kgc57_emp2_view

--�޸���ͼ(check option)
update kgc57_emp2_view set sb=360 where deptno=30

--�޷��޸���Ǽ�ֵ������Ӧ����



--������ͼ��ҳ

select * from (
  select t.*,rownum as rn from (
	 select * from emp order by sal
	)t where rownum<=10
)where rn>5


--ʹ����ͼ��ҳ
create or replace view kgc57_view4_page
as
select * from (
  select t.*,rownum as rn from (
	 select * from emp order by sal
	)t where rownum<=5
)where rn>0


select * from kgc57_view4_page
drop view kgc57_view4_page
--4������           
--����������Ĭ��B��������
CREATE INDEX kgc57_emp2_index1 on emp2(ename)
select * from emp2 where ename like '%S%'
SELECT * FROM EMP3 
--Ψһ����
CREATE unique INDEX kgc57_emp2_index2 on emp2(empno)
select * from emp2 where empno>5555

--�������
select ename,sal from emp2
CREATE INDEX kgc57_emp2_index3 on emp2(ename,sal)

--λͼ����
create bitmap index kgc57_emp_index4 on emp2(job)

--ɾ������
drop index  kgc57_emp_index4

--�鿴����
select * from user_indexes

--mysql�鿴����
show index from emp2
show key   from emp
