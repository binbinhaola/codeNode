PL/SQL�в鿴�������
Reports->PL SQL->Compilation errors
��
ֱ���Ҽ�->edit

һ���ӳ�����������PL/SQL�飬�����֮��洢�����ݿ���
1������
1������ procedure������ִ���ض�����
2������ function������ִ���ض�����������1�����

2�����
1���������֣�����ģ�          create or replace...
2����ִ�в��֣�����ģ�        begin...end;
3���쳣�����֣���ѡ�ģ�      exception...

3���ŵ�
1��ģ�黯�����ڷ�װҵ���߼�
2�������Ըߣ�����ά��
3��ִ��Ч�ʸߣ���������������ռ��
4����ȫ�Ըߣ��漰Ȩ�޹���

4��ǿ�������̺ͺ����Ĳ���/����ֵ���ͣ�����ָ�����ͳ���
�﷨��
  create [or replace]
  procedure ������[(�����б�)]
  as | is
    [�����б�...;]
  begin
    ҵ���ܴ���;
    [exception
     when others then ...;]
  end;
----���� procedure----
create or replace procedure kgc57_p1(eno number)
is
  v_ename emp.ename%type;
begin
	select emp.ename into v_ename from emp where emp.empno=eno;
	dbms_output.put_line('������Ĳ����ǣ�'||eno||'����ѯ�Ľ���ǣ�'||v_ename);
end;
---����
select ename from emp;

--���ô洢����
call kgc57_p1(7788)

--ʹ��pl/sql����
declare
  eno emp.empno%type;
begin
	 eno:=&eno;
	 kgc57_p1(eno);
end;


3������ģʽ
1�����������in
a- �����û����룬�������ڹ������޸�(��ֵ)
b- Ĭ��Ϊ���������in ����ʡ��
2�����������out 
a- ���û����ؽ��
b- ����������������
c- ���ܴ�ֵ��ȥ(��ʹ����Ҳ��null)
3) ����������� in out
---������ in  out  in out
--����Ա����Ų�ѯԱ����Ϣ
create or replace procedure kgc57_p2(eno in number)
is
  v_emp emp%rowtype;
begin
	select * into v_emp from emp where emp.empno=eno;
	dbms_output.put_line('������Ĳ����ǣ�'||eno||'����ѯ�Ľ���ǣ�'||v_emp.ename||v_emp.sal||v_emp.hiredate);
	exception 
		when no_data_found then
				dbms_output.put_line('���޴���');
end;
---��cmdִ��
set serveroutput on;
execute kgc57_p2(7788);




--out
--����Ա����Ų�ѯ����
create or replace procedure kgc57_p3(eno in number,v_name out varchar2)
as
begin
	dbms_output.put_line('ִ��ǰ--�������eno:'||eno||',�������v_name:'||v_name);
  select ename into v_name from emp where empno=eno;
	dbms_output.put_line('ִ�к�--�������eno:'||eno||',�������v_name:'||v_name);
end;

--call kgc57_p3(7788,xxx)
declare
  eno emp.empno%type;
	v_ename emp.ename%type;
begin
	eno:=&eno;
	dbms_output.put_line('PLSQLִ��ǰ,v_ename:'||v_ename);
	kgc57_p3(eno,v_ename);
	dbms_output.put_line('PLSQLִ�к�,v_ename:'||v_ename);
end;

--inout  ���ݽ���  a=10  b=20  ==>b=10 a=20
a=a+b
b=a-b;
a=a-b;
create or replace procedure 
kgc57_p4(a in out number,b in out number)
is
begin
	a:=a+b;
	b:=a-b;
	a:=a-b;
end;	

--����
declare
  n number:=10;
	m number:=20;
begin
	dbms_output.put_line('����ǰ��'||n||','||m);
	kgc57_p4(n,m);
	dbms_output.put_line('������'||n||','||m);
end;

---ɾ���洢����
drop procedure kgc57_p4

--�鿴ȫ������
select * from user_procedures


--����--���Դ�����ֵ
create or replace function ��������[�����б�]��
return ����ֵ����
as/is
��������
begin
   ִ��sql
   return ����ֵ��
exception
  �����쳣
end;

--���庯��
create or replace function kgc57_f1
return varchar2
as
begin
	return 'hello sb';
end;

--���ú���
select kgc57_f1() from dual;

--pl/sql
declare
 v_mess varchar2(200);
begin
	v_mess:=kgc57_f1();
	dbms_output.put_line(v_mess);
end;



--����Ա����Ų�ѯ sal
create or replace 
function kgc57_f2(eno in number)
return emp.sal%type
as
v_sal emp.sal%type;
begin
	select sal into v_sal from emp where empno=eno;
	return v_sal;
end;

--����
select kgc57_f2(7788) from dual;

--pl/sql
declare
 v_sal number;
begin
	v_sal:=kgc57_f2(7839);
	dbms_output.put_line(v_sal);
end;

--ת�����ں���
select to_Char(sysdate) from dual;;
select kgc57_f3(sysdate) from dual;
create or replace 
function kgc57_f3(now date)
return varchar2
as
 v_date varchar2(200);
begin
	v_date:=to_char(now,'yyyy"��"mm"��"dd"��"');
	return v_date;
end;

--����һ��Ա�����ʣ��жϹ����Ƿ���emp�����ߺ����֮��
create or replace function kgc57_f4(v_sal in number)
return varchar2
as
v_max_sal number;
v_min_sal number;
begin
	select max(sal) ,min(sal) into v_max_sal,v_min_sal from emp;
	if v_sal>v_max_sal then
		return '���빤��̫����';
	elsif v_sal<v_min_sal then
		return '���빤��̫����';
	else
		return '������';
	end if;
end;

select kgc57_f4(10),kgc57_f4(1001),kgc57_f4(5001) from dual;
 
 
 --��������淶����ͷ�������壨���壩
 ��������������ڷ�װ���̡��������α�ȶ���
1�����
1���淶 package������������Ա���ӳ���淶���൱�ڶ���ӿ�
2������ package body������˽�г�Ա��ʵ���ӳ���淶���൱�ڶ�����ʵ�ֽӿ�
3�����α�������
cursor c(dn number) return emp%rowtype;
cursor c(dn number) return emp%rowtype is select * from emp where deptno=dn;

--eg �����������
--1-���������α꣬���ݲ��ű�ŷ���Ա��������
--2-�������ι��̣����������ű�Ŵ������ѭ���α���ʾ����Ա��

   
--����һ���淶

create or replace package kgc57_pac1
as
--�����α�
  cursor c_emp(dno number) return emp%rowtype;

--�����洢����
  procedure pro_emp(dno number);
end kgc57_pac1;


--�������� ʵ�������淶
create or replace package  body kgc57_pac1
as
--��ʼʵ�ֹ淶���α�͹���

  cursor c_emp(dno number) return emp%rowtype
	is select * from emp where deptno=dno;
  
--���ð����й���
  procedure pro_emp(dno number)
	as
	v_emp emp%rowtype;
	begin 
		for v_emp in c_emp(dno) loop
			dbms_output.put_line(v_emp.ename||','||v_emp.sal);
	  end loop;--����ѭ��
	end pro_emp;--j��������
end kgc57_pac1;---��������

call kgc57_pac1.pro_emp(20)

--�����û�������� �����ض�Ӧ��Ϣ
--�����淶
create or replace package kgc57_pac2
as
 type c_ref is ref cursor; 
 procedure pro_result(tab in varchar2, c_cursor out c_ref);
 
 end kgc57_pac2;

--��������

--ʵ�ֹ���
create or replace package body kgc57_pac2
as
 procedure pro_result(tab in varchar2, c_cursor out c_ref)
 as
 v_sql varchar2(200);
 begin
	v_sql:='select * from '||tab;	
  open c_cursor for v_sql;
	end pro_result;
 end kgc57_pac2;




--pl/sql
declare
 v_tab varchar2(200);
 v_emp emp%rowtype;
 v_dept dept%rowtype;
 cc_cursor kgc57_pac2.c_ref;
begin
	v_tab:='&tab';
	kgc57_pac2.pro_result(v_tab,cc_cursor);
  if v_tab='emp' then
		loop 
			fetch cc_cursor into v_emp;
			exit when cc_cursor%notfound;
     dbms_output.put_line('v_emp��'||v_emp.ename||','||v_emp.sal);
    end loop;
	else
		loop 
			fetch cc_cursor into v_dept;
			exit when cc_cursor%notfound;
     dbms_output.put_line('v_dept��'||v_dept.dname||','||v_dept.loc);
    end loop;
  end if;
end;

---
��ҳ emp%rowtype
select * from(
 select rownum as rn ,t.* from
 (select * from emp where deptno=20 order by sal desc) t
 where rownum<=10 --:1
) where rn>5 --:2
��1ҳ��1  ==��1:=5 , 2:=0  pageIndex=1  pageSize=5
��2ҳ��2  ==��1:=10, 2:=5 pageIndex=2  pageSize=5
��3ҳ��3  ==��1:=15, 2:=10pageIndex=3  pageSize=5
1: ���� pageIndex*pageSize
2:���� (pageIndex-1)*pageSize

--����һ����ͼ  ����ƥ��洢�����н���ֵ
drop view emp_view
create view emp_view
as(
select * from(
 select rownum as rn ,t.* from
 (select * from emp group by deptno order by sal desc) t
 where rownum<=5  --:1
) where rn>0 and 1=2
)
select count(1) from emp
select * from emp_view;
emp_view%rowtype

--����һ����ҳ�洢���� ���ݲ��ŷ��飬нˮ����
create or replace package pk_emp_page
as
type c_ref is ref cursor;
procedure pro_emp(deptno in number,clo in varchar2,
  pageIndex in number,pageSize in number,
  c_out out c_ref,total out number);
end pk_emp_page;
--��������
create or replace package body  pk_emp_page
as

procedure pro_emp(deptno in number,clo in varchar2,
  pageIndex in number,pageSize in number,
  c_out out c_ref,total out number)
  as
   v_sql varchar2(500);
  begin
    v_sql:='select * from(
 select rownum as rn ,t.* from
 (select * from emp where deptno=:3  order by ' ||clo|| ' desc) t
 where rownum<=:1  
) where rn>:2 ';
  --���α�
  open c_out for v_sql using 
  deptno,(pageIndex*pageSize),(pageIndex-1)*pageSize;
  
  
  dbms_output.put_line('������sql:'||v_sql);
  --close c_out;

  --�ܼ�¼��
  v_sql:='select count(1) from emp where deptno=:1';
  
  execute immediate v_sql into total using deptno;
  
  end pro_emp;
 end pk_emp_page;
--���ô洢����
declare
v_dno number:=20;
clo varchar2(50):='sal';
pageIndex number:=3;
pageSize number:=2;
c_out_cousor pk_emp_page.c_ref;
totalCount number;
v_emp_view emp_view%rowtype;
begin
	pk_emp_page.pro_emp(v_dno,clo,pageIndex,pageSize,c_out_cousor,totalCount);
	dbms_output.put_line('�ܼ�¼����'||totalCount);
	loop 
		fetch c_out_cousor into v_emp_view;
		exit when c_out_cousor%notfound;
		dbms_output.put_line(v_emp_view.ename||','||v_emp_view.sal);
  end loop;
end;



select * from emp;
select * from emp;
