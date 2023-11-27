PL/SQL Developer是一个集成开发环境，专门开发面向Oracle数据库的应用。
PL/SQL也是一种程序语言，叫做过程化SQL语言（Procedural Language/SQL）。
PL/SQL是Oracle数据库对SQL语句的扩展。
一、PL/SQL块：组成PL/SQL语言的基本单元
1、分类
1）匿名PL/SQL块
2）命名PL/SQL块（过程、函数）

2、组成
1）声明部分（可选的）         declare...
2）可执行部分（必须的）       begin...end;
3）异常处理部分（可选的）     exception...

3、语法
[declare
  声明变量、类型、游标...;]
begin
  实现功能的代码...;
  [exception
  when 异常类型 then 异常处理;]
end;
--注意：分号不能丢（每句代码必须以分号结束、包括最后的end）

4、输出示例
--dbms_output程序包，封装了用于输出的过程
可以使用DBMS_OUTPUT.PUT_LINE('HELLO');
或者BEGIN   DBMS_OUTPUT.PUT('HELLO');   

begin
	DBMS_OUTPUT.PUT('python1'); 
	DBMS_OUTPUT.new_line();
	dbms_output.put_line('hello');
	DBMS_OUTPUT.new_line();
	dbms_output.put_line('world');
end;


二、变量，在声明部分声明(不和列同名，注意长度)
1、语法 name String="admin"
declare
  变量名 数据类型;
  变量名 数据类型 := 初始值;  
--注意：变量名不能是关键字，且不要与表中的字段同名

--PL/SQL基本用法
--根据员工编号计算并显示该员工的姓名及税费 税率0.1，注意异常处理
--接收用户输入：'&变量名'，如果变量名一致表示接收同一参数
varchar2    存放可变长字符数据，最大长度为4000字符

PL/SQL代码块

declare  ---声明部分
   v_ename varchar2(200);
	 v_empno number(4);
	 v_sal   number(7,2);
	 v_tax   number(7,2);
	 v_rate  constant number:=0.1;
begin  ---可执行部分
	 v_empno:=&eno;--从键盘接收值，赋给变量
	 select ename,  sal,  sal*v_rate 
	 into   v_ename,v_sal,v_tax from emp
	 where empno=v_empno;
   dbms_output.put_line(v_ename||'的工资是'
	 ||v_sal||'，需要缴纳税：'||v_tax);
 ---异常部分
exception
	 when no_data_found then
		  dbms_output.put_line('查无此人');
   when others then
		  dbms_output.put_line('异常了');
end;







--%TYPE %ROWTYPE
语法：
表名.列名%TYPE  -- 为了使一个新定义的变量与另一个已经定义了的变量(通常是表的某一列)的数据类型保持一致
表名.%ROWTYPE-- 一如果一个表有较多的列，使用%ROWTYPE来定义一个表示表中一行记录的变量，比分别使用%TYPE来定义表示表中各个列的变量要简洁得多，并且不容易遗漏、出错。这样会增加程序的可维护性
注意：属性类型和布尔类型仅用于PL/SQL中，不能用于建表
1、属性类型：引用表结构的类型
1）应用场合
a- 不知道表结构
b- 已知表结构，但不确定是否会发生改变
--将上题用伪类型改写
declare  ---声明部分
   v_ename emp.ename%type;
   v_empno emp.empno%type;
   v_sal   emp.sal%type;
   v_tax   emp.sal%type;
   v_rate  constant number:=0.1;
begin  ---可执行部分
   v_empno:=&eno;--从键盘接收值，赋给变量
   select ename,  sal,  sal*v_rate 
   into   v_ename,v_sal,v_tax from emp --;
   where empno=v_empno;
   dbms_output.put_line(v_ename||'的工资是'
   ||v_sal||'，需要缴纳税：'||v_tax);
 ---异常部分
exception
   when no_data_found then
      dbms_output.put_line('查无此人');
	 when too_many_rows then
		  dbms_output.put_line('返回多行数据'); 
   when others then
      dbms_output.put_line('异常了');
end;




--rowtype
declare  ---声明部分
   v_emp   emp%rowtype;
   v_tax   emp.sal%type;
   v_rate  constant number:=0.1;
begin  ---可执行部分
   v_emp.empno:=&eno;--从键盘接收值，赋给变量
   select ename,  sal,  sal*v_rate 
   into  v_emp.ename,v_emp.sal , v_tax from emp --;
   where empno=v_emp.empno;
   dbms_output.put_line(v_emp.ename||'的工资是'
   ||v_emp.sal||'，需要缴纳税：'||v_tax);
 ---异常部分
exception
   when no_data_found then
      dbms_output.put_line('查无此人');
	 when too_many_rows then
		  dbms_output.put_line('返回多行数据'); 
   when others then
      dbms_output.put_line('异常了');
end;






--RECORD--记录 理解成数组 或map
--Student stu ---sid sname age
--Student xx=new Student()
语法：
TYPE 类型名 IS RECORD(
    变量名 表名.列名%TYPE,
    变量名 表名%ROWTYPE
);
变量名 类型名;
declare
  --声明一个记录类型 Student{  }
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
	  dbms_output.put_line(v_r_emp.r_ename||'的工资是'
   ||v_r_emp.r_sal||'，需要缴纳税：'||v_tax);
 ---异常部分
exception
   when no_data_found then
      dbms_output.put_line('查无此人');
	 when too_many_rows then
		  dbms_output.put_line('返回多行数据'); 
   when others then
      dbms_output.put_line('异常了');
end;




--选择结构

--CASE WHEN结构:case when..then..else..end case;
--根据员工薪水值显示其薪水等级
--SQL  
select empno,ename,sal,
case 
	when sal<1000 then '码畜'
	when sal<2000 then '码农'
	when sal<3000 then '码工'
	when sal<4000 then '码师'
	when sal<5000 then '码神'
	else 'boss' end "等级"
	from emp;

--7 组长leader 1高级 2中级 3初级
--10万   5-6万  1-2  1     1



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
  





--IF结构:if..then..[else..]end if;
--根据指定员工编号的员工薪水值显示其薪水等级 
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




--循环
--输出1到10
--无限循环loop..end loop;
declare 
  i number:=1;
begin
	loop 
		 dbms_output.put_line(i);
		 i:=i+1;
		 exit when i>10;--循环终止条件
	end loop;
end;


declare 
  i number:=10;
begin
	loop 
		 dbms_output.put_line(i);
		 i:=i-1;
		 exit when i<1;--循环终止条件
	end loop;
end;




--while条件循环
declare
  i number:=1;
begin
	while i<=10 loop
		dbms_output.put_line(i);
		 i:=i+1;
  end loop;
end;






--for循环(自动声明变量)
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

--使用for循环根据员工薪水值显示其薪水等级 
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
			 



--动态sql
select * from emp3;

declare
 v_sql varchar2(200);
begin
	v_sql:='delete from emp3 where empno=:1';
  execute immediate v_sql using 5566
	commit;
end;




EXECUTE IMMEDIATE dynamic_sql_string 
 [INTO  define_variable_list]--被赋值对象  
 [USING bind_argument_list]; --入參 
 
--根据用户输入的v_empno查询员工信息保存到v_emp，要求使用动态sql语句v_sql
declare 
  v_sql varchar2(200);
	v_emp emp%rowtype;
begin
	 v_sql:='select * from emp where empno=:1';
	 execute immediate v_sql into v_emp using &eno;
   dbms_output.put_line(v_emp.empno||v_emp.ename||v_emp.sal);
end;
  


--根据用户输入的表名v_tbl查询,
--(员工信息保存到v_emp,部门信息保存到v_dep)，要求使用动态sql语句v_sql
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





--自定义异常
--根据用户输入empno查询对应的sal，判断薪水低于1800抛出自定义异常
declare 
  myexception exception;
	v_sal emp.sal%type;
begin
	select sal into v_sal from emp where empno=&eno;
	if v_sal<1000 then
		raise myexception;
	else
		dbms_output.put_line('工资水平正常');
  end if;
exception
	when myexception then
		dbms_output.put_line('工资水平太低了，打发叫花子');
end;


--抛出应用程序错误，让事务回滚raise_application_error(sqlcode,sqlerrm)



