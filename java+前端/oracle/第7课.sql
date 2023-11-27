PL/SQL中查看编译错误：
Reports->PL SQL->Compilation errors
或
直接右键->edit

一、子程序：已命名的PL/SQL块，编译好之后存储在数据库中
1、分类
1）过程 procedure，用于执行特定操作
2）函数 function，用于执行特定操作并返回1个结果

2、组成
1）声明部分（必须的）          create or replace...
2）可执行部分（必须的）        begin...end;
3）异常处理部分（可选的）      exception...

3、优点
1）模块化，用于封装业务逻辑
2）重用性高，易于维护
3）执行效率高，减少网络流量的占用
4）安全性高（涉及权限管理）

4、强调：过程和函数的参数/返回值类型，不能指定类型长度
语法：
  create [or replace]
  procedure 过程名[(参数列表)]
  as | is
    [变量列表...;]
  begin
    业务功能代码;
    [exception
     when others then ...;]
  end;
----过程 procedure----
create or replace procedure kgc57_p1(eno number)
is
  v_ename emp.ename%type;
begin
	select emp.ename into v_ename from emp where emp.empno=eno;
	dbms_output.put_line('你输入的参数是：'||eno||'，查询的结果是：'||v_ename);
end;
---过程
select ename from emp;

--调用存储过程
call kgc57_p1(7788)

--使用pl/sql调用
declare
  eno emp.empno%type;
begin
	 eno:=&eno;
	 kgc57_p1(eno);
end;


3、参数模式
1）输入参数，in
a- 接收用户输入，不允许在过程中修改(赋值)
b- 默认为输入参数，in 可以省略
2）输出参数，out 
a- 向用户返回结果
b- 必须声明变量传参
c- 不能传值进去(即使传了也是null)
3) 输入输出参数 in out
---带参数 in  out  in out
--根据员工编号查询员工信息
create or replace procedure kgc57_p2(eno in number)
is
  v_emp emp%rowtype;
begin
	select * into v_emp from emp where emp.empno=eno;
	dbms_output.put_line('你输入的参数是：'||eno||'，查询的结果是：'||v_emp.ename||v_emp.sal||v_emp.hiredate);
	exception 
		when no_data_found then
				dbms_output.put_line('查无此人');
end;
---在cmd执行
set serveroutput on;
execute kgc57_p2(7788);




--out
--根据员工编号查询姓名
create or replace procedure kgc57_p3(eno in number,v_name out varchar2)
as
begin
	dbms_output.put_line('执行前--输入参数eno:'||eno||',输出参数v_name:'||v_name);
  select ename into v_name from emp where empno=eno;
	dbms_output.put_line('执行后--输入参数eno:'||eno||',输出参数v_name:'||v_name);
end;

--call kgc57_p3(7788,xxx)
declare
  eno emp.empno%type;
	v_ename emp.ename%type;
begin
	eno:=&eno;
	dbms_output.put_line('PLSQL执行前,v_ename:'||v_ename);
	kgc57_p3(eno,v_ename);
	dbms_output.put_line('PLSQL执行后,v_ename:'||v_ename);
end;

--inout  数据交换  a=10  b=20  ==>b=10 a=20
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

--调用
declare
  n number:=10;
	m number:=20;
begin
	dbms_output.put_line('交换前：'||n||','||m);
	kgc57_p4(n,m);
	dbms_output.put_line('交换后：'||n||','||m);
end;

---删除存储过程
drop procedure kgc57_p4

--查看全部过程
select * from user_procedures


--函数--可以带返回值
create or replace function 函数名（[参数列表]）
return 返回值类型
as/is
声明变量
begin
   执行sql
   return 返回值；
exception
  处理异常
end;

--定义函数
create or replace function kgc57_f1
return varchar2
as
begin
	return 'hello sb';
end;

--调用函数
select kgc57_f1() from dual;

--pl/sql
declare
 v_mess varchar2(200);
begin
	v_mess:=kgc57_f1();
	dbms_output.put_line(v_mess);
end;



--根据员工编号查询 sal
create or replace 
function kgc57_f2(eno in number)
return emp.sal%type
as
v_sal emp.sal%type;
begin
	select sal into v_sal from emp where empno=eno;
	return v_sal;
end;

--调用
select kgc57_f2(7788) from dual;

--pl/sql
declare
 v_sal number;
begin
	v_sal:=kgc57_f2(7839);
	dbms_output.put_line(v_sal);
end;

--转换日期函数
select to_Char(sysdate) from dual;;
select kgc57_f3(sysdate) from dual;
create or replace 
function kgc57_f3(now date)
return varchar2
as
 v_date varchar2(200);
begin
	v_date:=to_char(now,'yyyy"年"mm"月"dd"日"');
	return v_date;
end;

--输入一个员工工资，判断工资是否在emp表的最高和最低之间
create or replace function kgc57_f4(v_sal in number)
return varchar2
as
v_max_sal number;
v_min_sal number;
begin
	select max(sal) ,min(sal) into v_max_sal,v_min_sal from emp;
	if v_sal>v_max_sal then
		return '输入工资太高了';
	elsif v_sal<v_min_sal then
		return '输入工资太低了';
	else
		return '正合适';
	end if;
end;

select kgc57_f4(10),kgc57_f4(1001),kgc57_f4(5001) from dual;
 
 
 --程序包：规范（包头），主体（包体）
 二、程序包：用于封装过程、函数、游标等对象
1、组成
1）规范 package，声明公共成员和子程序规范，相当于定义接口
2）主体 package body，声明私有成员和实现子程序规范，相当于定义类实现接口
3）包游标声明：
cursor c(dn number) return emp%rowtype;
cursor c(dn number) return emp%rowtype is select * from emp where deptno=dn;

--eg 创建程序包：
--1-声明带参游标，根据部门编号返回员工表类型
--2-声明带参过程，将参数部门编号传入带参循环游标显示所有员工

   
--创建一个规范

create or replace package kgc57_pac1
as
--声明游标
  cursor c_emp(dno number) return emp%rowtype;

--声明存储过程
  procedure pro_emp(dno number);
end kgc57_pac1;


--创建主体 实现上述规范
create or replace package  body kgc57_pac1
as
--开始实现规范中游标和过程

  cursor c_emp(dno number) return emp%rowtype
	is select * from emp where deptno=dno;
  
--调用包体中过程
  procedure pro_emp(dno number)
	as
	v_emp emp%rowtype;
	begin 
		for v_emp in c_emp(dno) loop
			dbms_output.put_line(v_emp.ename||','||v_emp.sal);
	  end loop;--结束循环
	end pro_emp;--j结束过程
end kgc57_pac1;---结束主体

call kgc57_pac1.pro_emp(20)

--根据用户输入表名 ，返回对应信息
--创建规范
create or replace package kgc57_pac2
as
 type c_ref is ref cursor; 
 procedure pro_result(tab in varchar2, c_cursor out c_ref);
 
 end kgc57_pac2;

--创建主体

--实现过程
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
     dbms_output.put_line('v_emp：'||v_emp.ename||','||v_emp.sal);
    end loop;
	else
		loop 
			fetch cc_cursor into v_dept;
			exit when cc_cursor%notfound;
     dbms_output.put_line('v_dept：'||v_dept.dname||','||v_dept.loc);
    end loop;
  end if;
end;

---
分页 emp%rowtype
select * from(
 select rownum as rn ,t.* from
 (select * from emp where deptno=20 order by sal desc) t
 where rownum<=10 --:1
) where rn>5 --:2
第1页：1  ==》1:=5 , 2:=0  pageIndex=1  pageSize=5
第2页：2  ==》1:=10, 2:=5 pageIndex=2  pageSize=5
第3页：3  ==》1:=15, 2:=10pageIndex=3  pageSize=5
1: 参数 pageIndex*pageSize
2:参数 (pageIndex-1)*pageSize

--创建一个视图  用来匹配存储过程中接受值
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

--创建一个分页存储过程 根据部门分组，薪水降序
create or replace package pk_emp_page
as
type c_ref is ref cursor;
procedure pro_emp(deptno in number,clo in varchar2,
  pageIndex in number,pageSize in number,
  c_out out c_ref,total out number);
end pk_emp_page;
--创建主体
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
  --打开游标
  open c_out for v_sql using 
  deptno,(pageIndex*pageSize),(pageIndex-1)*pageSize;
  
  
  dbms_output.put_line('过程中sql:'||v_sql);
  --close c_out;

  --总记录是
  v_sql:='select count(1) from emp where deptno=:1';
  
  execute immediate v_sql into total using deptno;
  
  end pro_emp;
 end pk_emp_page;
--调用存储过程
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
	dbms_output.put_line('总记录数：'||totalCount);
	loop 
		fetch c_out_cousor into v_emp_view;
		exit when c_out_cousor%notfound;
		dbms_output.put_line(v_emp_view.ename||','||v_emp_view.sal);
  end loop;
end;



select * from emp;
select * from emp;
