�α꣺ָ���ѯ�������ָ�루�Բ�ѯ����������ã�
�ṹ�����ڴ���SQL��һ����������
Ŀ�ģ����Ƶ���������ݽ���Ч�ʵ͵�����

һ����ʽ�α�(����ɾ���ģ��鵥�е����)
1��Oracle�Զ�Ϊ��ɾ�Ĳ���������ʽ�α꣬����ͳһΪSQL
2�����ڻ�ȡ�������ɾ�Ĳ��������ݿ��Ӱ�죨���ύ��ع�֮ǰ��
3���α�����
1��%rowcount ִ����ɾ�ĳɹ���������Ӱ�������()
2��%found ����ɹ��ˣ�Ӱ�������ݣ��򷵻�true���򷵻�false
3��%notfound ���ûӰ�����ݣ��򷵻�true���򷵻�false
4��%isopen ����α�򿪣�����ִ����ɾ�ĵĹ��̣����򷵻�true���򷵻�false
����ʽ�α�ʼ�շ���false��
��ʽ�α������ ����ֵ����   ��    ��  
SQL%ROWCOUNT    ����  ����DML���ɹ�ִ�е���������  
SQL%FOUND   ������ ֵΪTRUE������롢ɾ�������»��в�ѯ�����ɹ�  
SQL%NOTFOUND    ������ ��SQL%FOUND���Է���ֵ�෴  
SQL%ISOPEN  ������ DMLִ�й�����Ϊ�棬������Ϊ��  

--��ʽ�α갸��
--eg ������30��Ա����н100���жϸ����Ƿ�ɹ�����ͳ�Ƹ����˼�����¼
select  ename,sal from emp where deptno=30
begin
	 update emp set sal=sal+1 where deptno=30;
   if SQL%FOUND THEN
		 dbms_output.put_line('���³ɹ��ˣ���Ŀ��'||SQL%ROWCOUNT);
   ELSE
		 dbms_output.put_line('����ʧ��');
   end if;
	 
	 if SQL%ISOPEN THEN
		 dbms_output.put_line('�α��');
   else
		 dbms_output.put_line('�α�ر�');
	 end if;
	end;



select * from emp where deptno=30

������ʽ�α�
1����ʾ�α����������������ʽ����
   declare
     cursor �α���
     is
     ��ѯ�����;
2�����α꣺�൱�����select��ѯ�������װ���α��ڴ���
     open �α���
3����ȡ���ݣ����ո�ʽ���α��ڴ���������ȡ�������У������û����д�������
     fetch �α��� into ������1��������2������
4���ر��α꣺
     close �α���

4���α�����
1��%rowcount �����α����ڵ��к�
2��%found ����ҵ������ݣ�fetch�ɹ������򷵻�true���򷵻�false
3��%notfound ���û�ҵ����ݣ�fetchʧ�ܣ����򷵻�true���򷵻�false
4��%isopen ����α�򿪣��򷵻�true���򷵻�false

--eg ��ѯ���������Ա��������нˮ
--Loop
declare
  --1.�����α�--�����������
	cursor c_emp is select ename,sal from emp;
	--2.�������� �������ֺ�нˮ
	v_ename emp.ename%type;
	v_sal emp.sal%type;
begin
	--3.���α�
	open c_emp;
	--4.ѭ����ȡ�α�������
	loop 
		fetch c_emp into v_ename,v_sal;
		exit when c_emp%notfound;
		dbms_output.put_line(v_ename||',,,'||v_sal);
	end loop;
	--5.�ر��α�
	close c_emp;
end;





--While
declare
  --1.�����α�--�����������
  cursor c_emp is select * from emp;
  --2.�������� �������ֺ�нˮ
  v_emp emp%rowtype;
begin
  --3.���α�
  open c_emp;
	
	fetch c_emp into v_emp;
  --4.ѭ����ȡ�α�������
  while  c_emp%found loop
    fetch c_emp into v_emp;
   
    dbms_output.put_line(v_emp.ename||',,,'||v_emp.sal);
  end loop;
	if c_emp%isopen then
	   dbms_output.put_line('�α꿪��'||'�ܹ��ж��٣�'||c_emp%rowcount);
	end if;
  --5.�ر��α�
  close c_emp;
	
	if c_emp%isopen then
	   dbms_output.put_line('�α����');
	else
		 dbms_output.put_line('�α����2');
	end if;
	
end;






4��forѭ���α꣺���α�Ĳ��� for�α����Ĭ��Ϊ�α�%ROWTYPE
�Զ��򿪡��Զ���ȡ���Զ��رգ������Զ�Ϊ�ж���
--eg ��ѯ��������в������ơ�Ա��������нˮ
declare
  cursor c_emp is select dname,ename,sal from 
	emp e inner join dept d on e.deptno=d.deptno;
begin
	for v_emp in c_emp loop
		dbms_output.put_line(v_emp.dname||','||v_emp.ename||','||v_emp.sal);
  end loop;
end;




5�����������α꣺����α�������(ע����������ú�������ͬ)
--eg ���ݲ��ű�Ų�ѯԱ����Ϣ
declare
  cursor c_emp(dno number) is select * from emp where deptno=dno;
begin
	for v_emp in c_emp(&dno) loop
		dbms_output.put_line(v_emp.empno||','||v_emp.ename||','||v_emp.sal);
  end loop;
end;	





6��ʹ���α��������
1��ʹ��select..for update nowait;���α����������ĻỰ���������ݻ��׳��쳣
                ORA-00054������������Դ��æ
2��ʹ��where current of �α���;�޶������α�������
--����Ӿ��������׵ؽ���update��delete���������fetch���н��в����� 
--eg ��Ա����н ����1000��+500 ����3000��+1000 ������ɾ��
declare
   cursor c_emp is select * from emp for update nowait ;
begin
	 for v_emp in c_emp loop
		 if v_emp.sal<1000 then
			 update emp set sal=sal+500 where current of c_emp;
     elsif v_Emp.sal<3000 then
			 update emp set sal=sal+1000 where current of c_emp;
		 else
			 delete from emp where current of c_emp;
     end if;
		end loop;
	end;
	
	select * from emp 
����REF�α꣨��̬�α꣩
1�����ڴ�������ʱ����ȷ���Ĳ�ѯ�����
2��REF�α�������������֣�
1������REF�α����ͣ�type ������ is ref cursor;
2������REF�α������������ ������;
3������ʹ��for�α�
3������ֱ��ʹ��SYS_REFCURSOR
1������REF�α������������ SYS_REFCURSOR

--eg �����û�����ı����Ͳ��ű�ţ����ض�Ӧ�Ľ����
declare
 v_sql varchar2(200);
 v_tab varchar2(50);
 v_emp emp%rowtype;
 v_dept dept%rowtype;
 
 --��̬�α� class Student
 type t_ref is ref cursor;
 c_ref t_ref; --Student stu;
 --c_ref sys_refcursor;
 
begin
	v_tab :='&tb';
	v_sql:='select * from  '||v_tab||'  where deptno=:dno';
  --�ȴ��α�
	open c_ref for v_sql using &dno;
  --execute immediate v_sql into xx using xx
	if v_tab='emp' then
		loop 
		 fetch c_ref into v_emp;
		 exit when c_ref%notfound;
		 dbms_output.put_line(v_emp.ename||',,,'||v_emp.sal||','||v_emp.deptno);
	  end loop;
	else
		loop 
		 fetch c_ref into v_dept;
		 exit when c_ref%notfound;
		 dbms_output.put_line(v_dept.dname||',,,'||v_dept.loc||','||v_dept.deptno);
	  end loop;
  end if;
end;

�ġ�������
1���﷨��
��������ɣ�
1.��������䣨�¼���
2.���������ƣ�ִ��������
3.���������������壩

CREATE [OR REPLACE] TRIGGER trigger_name
AFTER | BEFORE | INSTEAD OF
[INSERT] [[OR] UPDATE [OF column_list]] [[OR] DELETE]
ON table_or_view_name
[REFERENCING {OLD [AS] old / NEW [AS] new}]
[FOR EACH ROW]
[WHEN (condition)]
pl/sql_block;


 
--��伶(��) ÿִ��һ��sql��䶼ִ�д�����
--ey ������־��¼���¼�û����ĸ�ʱ���emp���������ɾ��
create or replace trigger kgc57_trigger_1
after 
insert or update or delete
on emp
begin
	if inserting then
		insert into mylog(username,mytime,action) values(user,sysdate,'������');
  elsif updating then
		insert into mylog(username,mytime,action) values(user,sysdate,'�޸���');
  else
		insert into mylog(username,mytime,action) values(user,sysdate,'ɾ����');
  end if;
end;

update emp set sal=sal+1 where deptno=20
select * from emp where deptno=20;
select * from mylog;
--�м�
--ey �������Ϊ�м�������
create or replace trigger kgc57_trigger_2
after 
insert or update or delete
on emp
for each row --�м�����
begin
	if inserting then
		insert into mylog(username,mytime,action) values(user,sysdate,'������');
  elsif updating then
		insert into mylog(username,mytime,action) values(user,sysdate,'�޸���');
  else
		insert into mylog(username,mytime,action) values(user,sysdate,'ɾ����');
  end if;
end;



--ֻ��ʹ��before��after�ǲ����޸�:new.deptno��ֵ��
--���ݵ�ȷ��
--�Ǻ�Ĺ��ʲ��ܵ�����ǰ�Ĺ���3000 2800
create or replace trigger kgc57_trigger_3
before
update
on emp
for each row
begin
	--�ж��ǹ���ǰ��
	if :new.sal<:old.sal then
		raise_application_error(-20066,'�ǹ��ʺ��Ǯ���ܵ����ǹ���ǰ');
	end if;
end;

update emp set sal=sal-1 where deptno=20
--ey ʹ����ǰ--����ʵ�ֲ��ű��deptno����
select * from dept;
insert into dept(deptno,dname,loc) values(45,'xx','yy')
insert into dept(deptno,dname,loc) values(studet_seq.nextval,'xx','yy')
insert into dept(dname,loc) values('xx','yy')

create or replace trigger kgc57_trigger_4
before
insert
on dept
for each row
begin
	 select studet_seq.nextval into :new.deptno from dual;
end;


--�޸Ĵ�������״̬-���û򲻿���

 --����
 alter trigger kgc57_trigger_4 disable

--���
alter trigger kgc57_trigger_4 enable

--ɾ��������
drop trigger  kgc57_trigger_1

--�׳��쳣���������в���ʹ��DCL��䣩
--ey ʹ���º󴥷�ʵ�ֲ�����ɾ��for����

select * from dept;
delete from dept where deptno=40

create or replace trigger kgc57_trigger_5
after
delete
on dept
for each row
WHEN(old.deptno=40)
begin
	raise_application_error(-20066,'���40�Ų��Ų���ɾ��');
end;






---���ӵİ�ȫ��飬���ϰ�ʱ�䲻�����������
�ϰ�ʱ��Ķ��壺007 996 18.00  7.00 9.00 11.00
���� ������ 
to_char(sysdate,'day') in ('������','������')
select (to_char(sysdate,'day')) ss from dual 
where (to_char(sysdate,'day')) in ('������','������') ;
9-18���ϰ�ʱ�䣺to_number(to_char(sysdate,'hh24')) not between 9 and 17
--������ȫ��鴥����
create or replace trigger kgc57_trigger_6
before
insert or update or delete
on emp
for each row
begin
	if to_char(sysdate,'day') in ('������','������')
		 or 
		 to_number(to_char(sysdate,'hh24')) not between 9 and 17
   then
		 raise_application_error(-20077,'���ϰ�ʱ���ֹ�������ݿ�');
  end if;
end;
--��ֹinsert--�׳��쳣Ӧ�ó���
update emp set sal=sal+1 ;
--��������
select * from emp;
------------------------------------instand of �޸���ͼ
CREATE OR REPLACE VIEW v_emp20
 AS
SELECT e.empno,e.ename,e.job,e.sal,d.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno;
--�鿴��ͼ
SELECT * FROM v_emp20;

create or replace trigger view_insert_tigger
  instead of insert on v_emp20  
  for each row
declare
    v_empCount       NUMBER;
    v_deptCount      NUMBER;
begin
    --�ж�Ҫ���ӵ�Ա���Ƿ����
    SELECT COUNT(empno) INTO v_empCount FROM emp WHERE empno=:NEW.empno;
    
    --�ж�Ҫ�����Ƿ����
    SELECT COUNT(deptno) INTO v_deptCount FROM dept WHERE deptno=:new.deptno;
  --���Ա��������
  IF v_empCount=0 THEN
      INSERT INTO emp(empno,ename,job,sal,deptno)
      VALUES(:new.empno,:new.ename,:new.job,:new.sal,:new.deptno);
    END IF;
    --������Ų�����
    IF v_deptCount=0 THEN
      INSERT INTO dept(deptno,dname,loc)VALUES(:new.deptno,:new.dname,:new.loc);
    END IF;
end view_insert_tigger;
--�������
INSERT INTO v_emp20(empno,ename,job,sal,deptno,dname,loc)
VALUES(7934,'������','CLERK',800,240,'���','����');
select * from emp








