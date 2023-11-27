PL/SQL Developer��һ�����ɿ���������ר�ſ�������Oracle���ݿ��Ӧ�á�
PL/SQLҲ��һ�ֳ������ԣ��������̻�SQL���ԣ�Procedural Language/SQL����
PL/SQL��Oracle���ݿ��SQL������չ��
һ��PL/SQL�飺���PL/SQL���ԵĻ�����Ԫ
1������
1������PL/SQL��
2������PL/SQL�飨���̡�������

2�����
1���������֣���ѡ�ģ�         declare...
2����ִ�в��֣�����ģ�       begin...end;
3���쳣�����֣���ѡ�ģ�     exception...

3���﷨
[declare
  �������������͡��α�...;]
begin
  ʵ�ֹ��ܵĴ���...;
  [exception
  when �쳣���� then �쳣����;]
end;
--ע�⣺�ֺŲ��ܶ���ÿ���������ԷֺŽ�������������end��

4�����ʾ��
--dbms_output���������װ����������Ĺ���
����ʹ��DBMS_OUTPUT.PUT_LINE('HELLO');
����BEGIN   DBMS_OUTPUT.PUT('HELLO');   

begin
	DBMS_OUTPUT.PUT('python1'); 
	DBMS_OUTPUT.new_line();
	dbms_output.put_line('hello');
	DBMS_OUTPUT.new_line();
	dbms_output.put_line('world');
end;


������������������������(������ͬ����ע�ⳤ��)
1���﷨ name String="admin"
declare
  ������ ��������;
  ������ �������� := ��ʼֵ;  
--ע�⣺�����������ǹؼ��֣��Ҳ�Ҫ����е��ֶ�ͬ��

--PL/SQL�����÷�
--����Ա����ż��㲢��ʾ��Ա����������˰�� ˰��0.1��ע���쳣����
--�����û����룺'&������'�����������һ�±�ʾ����ͬһ����
varchar2    ��ſɱ䳤�ַ����ݣ���󳤶�Ϊ4000�ַ�

PL/SQL�����

declare  ---��������
   v_ename varchar2(200);
	 v_empno number(4);
	 v_sal   number(7,2);
	 v_tax   number(7,2);
	 v_rate  constant number:=0.1;
begin  ---��ִ�в���
	 v_empno:=&eno;--�Ӽ��̽���ֵ����������
	 select ename,  sal,  sal*v_rate 
	 into   v_ename,v_sal,v_tax from emp
	 where empno=v_empno;
   dbms_output.put_line(v_ename||'�Ĺ�����'
	 ||v_sal||'����Ҫ����˰��'||v_tax);
 ---�쳣����
exception
	 when no_data_found then
		  dbms_output.put_line('���޴���');
   when others then
		  dbms_output.put_line('�쳣��');
end;







--%TYPE %ROWTYPE
�﷨��
����.����%TYPE  -- Ϊ��ʹһ���¶���ı�������һ���Ѿ������˵ı���(ͨ���Ǳ��ĳһ��)���������ͱ���һ��
����.%ROWTYPE-- һ���һ�����н϶���У�ʹ��%ROWTYPE������һ����ʾ����һ�м�¼�ı������ȷֱ�ʹ��%TYPE�������ʾ���и����еı���Ҫ���ö࣬���Ҳ�������©���������������ӳ���Ŀ�ά����
ע�⣺�������ͺͲ������ͽ�����PL/SQL�У��������ڽ���
1���������ͣ����ñ�ṹ������
1��Ӧ�ó���
a- ��֪����ṹ
b- ��֪��ṹ������ȷ���Ƿ�ᷢ���ı�
--��������α���͸�д
declare  ---��������
   v_ename emp.ename%type;
   v_empno emp.empno%type;
   v_sal   emp.sal%type;
   v_tax   emp.sal%type;
   v_rate  constant number:=0.1;
begin  ---��ִ�в���
   v_empno:=&eno;--�Ӽ��̽���ֵ����������
   select ename,  sal,  sal*v_rate 
   into   v_ename,v_sal,v_tax from emp --;
   where empno=v_empno;
   dbms_output.put_line(v_ename||'�Ĺ�����'
   ||v_sal||'����Ҫ����˰��'||v_tax);
 ---�쳣����
exception
   when no_data_found then
      dbms_output.put_line('���޴���');
	 when too_many_rows then
		  dbms_output.put_line('���ض�������'); 
   when others then
      dbms_output.put_line('�쳣��');
end;




--rowtype
declare  ---��������
   v_emp   emp%rowtype;
   v_tax   emp.sal%type;
   v_rate  constant number:=0.1;
begin  ---��ִ�в���
   v_emp.empno:=&eno;--�Ӽ��̽���ֵ����������
   select ename,  sal,  sal*v_rate 
   into  v_emp.ename,v_emp.sal , v_tax from emp --;
   where empno=v_emp.empno;
   dbms_output.put_line(v_emp.ename||'�Ĺ�����'
   ||v_emp.sal||'����Ҫ����˰��'||v_tax);
 ---�쳣����
exception
   when no_data_found then
      dbms_output.put_line('���޴���');
	 when too_many_rows then
		  dbms_output.put_line('���ض�������'); 
   when others then
      dbms_output.put_line('�쳣��');
end;






--RECORD--��¼ �������� ��map
--Student stu ---sid sname age
--Student xx=new Student()
�﷨��
TYPE ������ IS RECORD(
    ������ ����.����%TYPE,
    ������ ����%ROWTYPE
);
������ ������;
declare
  --����һ����¼���� Student{  }
  type r_emp is record(
	   r_ename emp.ename%type,
		 r_sal emp.sal%type,
	   r_empno emp.empno%type
	);
	v_r_emp r_emp; --Student xx
	v_tax   emp.sal%type;
  v_rate  constant number:=0.1;
begin
	 v_r_emp.r_empno:=&eno;
	 select ename,sal,sal*v_rate
	 into  v_r_emp.r_ename,v_r_emp.r_sal,v_tax
	 from emp where empno= v_r_emp.r_empno;
	  dbms_output.put_line(v_r_emp.r_ename||'�Ĺ�����'
   ||v_r_emp.r_sal||'����Ҫ����˰��'||v_tax);
 ---�쳣����
exception
   when no_data_found then
      dbms_output.put_line('���޴���');
	 when too_many_rows then
		  dbms_output.put_line('���ض�������'); 
   when others then
      dbms_output.put_line('�쳣��');
end;




--ѡ��ṹ

--CASE WHEN�ṹ:case when..then..else..end case;
--����Ա��нˮֵ��ʾ��нˮ�ȼ�
--SQL  
select empno,ename,sal,
case 
	when sal<1000 then '����'
	when sal<2000 then '��ũ'
	when sal<3000 then '�빤'
	when sal<4000 then '��ʦ'
	when sal<5000 then '����'
	else 'boss' end "�ȼ�"
	from emp;

--7 �鳤leader 1�߼� 2�м� 3����
--10��   5-6��  1-2  1     1



--PL/SQL
declare
  v_emp emp%rowtype;
begin
	select empno,ename,sal into v_emp.empno,v_emp.ename,v_emp.sal
	from emp where empno=&eno;
	case when v_emp.sal <1000 then
	        dbms_output.put_line('111');
	     when v_emp.sal<2000 then
				   dbms_output.put_line('22');
	     when v_emp.sal<3000 then 
				    dbms_output.put_line('333');
	     when v_emp.sal<4000 then 
				   dbms_output.put_line('444');
	     when v_emp.sal<5000 then 
				 dbms_output.put_line('555');
	     else 
					 dbms_output.put_line('boss' );
			end case;
	end;
  





--IF�ṹ:if..then..[else..]end if;
--����ָ��Ա����ŵ�Ա��нˮֵ��ʾ��нˮ�ȼ� 
 declare
  v_emp emp%rowtype;
begin
  select empno,ename,sal into v_emp.empno,v_emp.ename,v_emp.sal
  from emp where empno=&eno;
   if v_emp.sal <1000 then
          dbms_output.put_line('111');
   elsif v_emp.sal<2000 then
           dbms_output.put_line('22');
   elsif v_emp.sal<3000 then 
            dbms_output.put_line('333');
   elsif v_emp.sal<4000 then 
           dbms_output.put_line('444');
   elsif v_emp.sal<5000 then 
         dbms_output.put_line('555');
   else 
           dbms_output.put_line('boss' );
   end if;
  end;




--ѭ��
--���1��10
--����ѭ��loop..end loop;
declare 
  i number:=1;
begin
	loop 
		 dbms_output.put_line(i);
		 i:=i+1;
		 exit when i>10;--ѭ����ֹ����
	end loop;
end;


declare 
  i number:=10;
begin
	loop 
		 dbms_output.put_line(i);
		 i:=i-1;
		 exit when i<1;--ѭ����ֹ����
	end loop;
end;




--while����ѭ��
declare
  i number:=1;
begin
	while i<=10 loop
		dbms_output.put_line(i);
		 i:=i+1;
  end loop;
end;






--forѭ��(�Զ���������)
begin
	for i in 1..100  loop
			dbms_output.put_line(i);
  end loop;
end;

begin
	for i in reverse 1..50  loop
			dbms_output.put_line(i);
  end loop;
end;

--ʹ��forѭ������Ա��нˮֵ��ʾ��нˮ�ȼ� 
begin
	 for v_emp in (select * from emp) loop
		 if v_emp.sal <1000 then
          dbms_output.put_line('111');
     elsif v_emp.sal<2000 then
           dbms_output.put_line('22');
     elsif v_emp.sal<3000 then 
            dbms_output.put_line('333');
     elsif v_emp.sal<4000 then 
           dbms_output.put_line('444');
     elsif v_emp.sal<5000 then 
         dbms_output.put_line('555');
     else 
           dbms_output.put_line('boss' );
     end if;
		end loop;
	end;
			 



--��̬sql
select * from emp3;

declare
 v_sql varchar2(200);
begin
	v_sql:='delete from emp3 where empno=:1';
  execute immediate v_sql using 5566
	commit;
end;




EXECUTE IMMEDIATE dynamic_sql_string 
 [INTO  define_variable_list]--����ֵ����  
 [USING bind_argument_list]; --�녢 
 
--�����û������v_empno��ѯԱ����Ϣ���浽v_emp��Ҫ��ʹ�ö�̬sql���v_sql
declare 
  v_sql varchar2(200);
	v_emp emp%rowtype;
begin
	 v_sql:='select * from emp where empno=:1';
	 execute immediate v_sql into v_emp using &eno;
   dbms_output.put_line(v_emp.empno||v_emp.ename||v_emp.sal);
end;
  


--�����û�����ı���v_tbl��ѯ,
--(Ա����Ϣ���浽v_emp,������Ϣ���浽v_dep)��Ҫ��ʹ�ö�̬sql���v_sql
declare
 v_sql varchar2(200);
 v_tab varchar2(50);
 v_emp  emp%rowtype;
 v_dept dept%rowtype;
begin
	v_tab :='&tn';
  v_sql:='select * from '||v_tab;
  if v_tab='emp' then
		v_sql:=v_sql||' where empno=:1';
    execute immediate v_sql into v_emp using &eno;
    dbms_output.put_line(v_emp.empno||v_emp.ename||v_emp.sal);
  else
		v_sql:=v_sql||' where deptno=:1';
    execute immediate v_sql into v_dept using &dno;
    dbms_output.put_line(v_dept.deptno||v_dept.dname||v_dept.loc);
  end if;
end;





--�Զ����쳣
--�����û�����empno��ѯ��Ӧ��sal���ж�нˮ����1800�׳��Զ����쳣
declare 
  myexception exception;
	v_sal emp.sal%type;
begin
	select sal into v_sal from emp where empno=&eno;
	if v_sal<1000 then
		raise myexception;
	else
		dbms_output.put_line('����ˮƽ����');
  end if;
exception
	when myexception then
		dbms_output.put_line('����ˮƽ̫���ˣ��򷢽л���');
end;


--�׳�Ӧ�ó������������ع�raise_application_error(sqlcode,sqlerrm)



