游标：指向查询结果集的指针（对查询结果集的引用）
结构：是内存中SQL的一个工作区域
目的：解决频繁磁盘数据交换效率低的问题

一、隐式游标(增，删，改，查单行的情况)
1、Oracle自动为增删改操作创建隐式游标，名称统一为SQL
2、用于获取最近的增删改操作对数据库的影响（在提交或回滚之前）
3、游标属性
1）%rowcount 执行增删改成功，返回受影响的行数()
2）%found 如果成功了，影响了数据，则返回true否则返回false
3）%notfound 如果没影响数据，则返回true否则返回false
4）%isopen 如果游标打开（正在执行增删改的过程），则返回true否则返回false
（隐式游标始终返回false）
隐式游标的属性 返回值类型   意    义  
SQL%ROWCOUNT    整型  代表DML语句成功执行的数据行数  
SQL%FOUND   布尔型 值为TRUE代表插入、删除、更新或单行查询操作成功  
SQL%NOTFOUND    布尔型 与SQL%FOUND属性返回值相反  
SQL%ISOPEN  布尔型 DML执行过程中为真，结束后为假  

--隐式游标案例
--eg 给部门30的员工加薪100，判断更新是否成功，并统计更新了几条记录
select  ename,sal from emp where deptno=30
begin
	 update emp set sal=sal+1 where deptno=30;
   if SQL%FOUND THEN
		 dbms_output.put_line('更新成功了，数目：'||SQL%ROWCOUNT);
   ELSE
		 dbms_output.put_line('更新失败');
   end if;
	 
	 if SQL%ISOPEN THEN
		 dbms_output.put_line('游标打开');
   else
		 dbms_output.put_line('游标关闭');
	 end if;
	end;



select * from emp where deptno=30

二、显式游标
1、显示游标必须在声明部分显式声明
   declare
     cursor 游标名
     is
     查询结果集;
2、打开游标：相当上面的select查询结果集封装到游标内存中
     open 游标名
3、提取数据：按照格式将游标内存中数据提取到变量中，便于用户逐行处理数据
     fetch 游标名 into 变量名1，变量名2···
4、关闭游标：
     close 游标名

4、游标属性
1）%rowcount 返回游标所在的行号
2）%found 如果找到了数据（fetch成功），则返回true否则返回false
3）%notfound 如果没找到数据（fetch失败），则返回true否则返回false
4）%isopen 如果游标打开，则返回true否则返回false

--eg 查询并输出所有员工姓名、薪水
--Loop
declare
  --1.声明游标--处理多行数据
	cursor c_emp is select ename,sal from emp;
	--2.声明变量 接收名字和薪水
	v_ename emp.ename%type;
	v_sal emp.sal%type;
begin
	--3.打开游标
	open c_emp;
	--4.循环提取游标中数据
	loop 
		fetch c_emp into v_ename,v_sal;
		exit when c_emp%notfound;
		dbms_output.put_line(v_ename||',,,'||v_sal);
	end loop;
	--5.关闭游标
	close c_emp;
end;





--While
declare
  --1.声明游标--处理多行数据
  cursor c_emp is select * from emp;
  --2.声明变量 接收名字和薪水
  v_emp emp%rowtype;
begin
  --3.打开游标
  open c_emp;
	
	fetch c_emp into v_emp;
  --4.循环提取游标中数据
  while  c_emp%found loop
    fetch c_emp into v_emp;
   
    dbms_output.put_line(v_emp.ename||',,,'||v_emp.sal);
  end loop;
	if c_emp%isopen then
	   dbms_output.put_line('游标开着'||'总共有多少：'||c_emp%rowcount);
	end if;
  --5.关闭游标
  close c_emp;
	
	if c_emp%isopen then
	   dbms_output.put_line('游标关着');
	else
		 dbms_output.put_line('游标关着2');
	end if;
	
end;






4、for循环游标：简化游标的操作 for游标变量默认为游标%ROWTYPE
自动打开、自动提取、自动关闭，变量自动为行对象
--eg 查询并输出所有部门名称、员工姓名、薪水
declare
  cursor c_emp is select dname,ename,sal from 
	emp e inner join dept d on e.deptno=d.deptno;
begin
	for v_emp in c_emp loop
		dbms_output.put_line(v_emp.dname||','||v_emp.ename||','||v_emp.sal);
  end loop;
end;




5、带参数的游标：提高游标的灵活性(注意参数名不用和列名相同)
--eg 根据部门编号查询员工信息
declare
  cursor c_emp(dno number) is select * from emp where deptno=dno;
begin
	for v_emp in c_emp(&dno) loop
		dbms_output.put_line(v_emp.empno||','||v_emp.ename||','||v_emp.sal);
  end loop;
end;	





6、使用游标更新数据
1）使用select..for update nowait;给游标加锁，当别的会话操作改数据会抛出异常
                ORA-00054错误，内容是资源正忙
2）使用where current of 游标名;限定更新游标所在行
--这个子句让你容易地进行update和delete操作对最近fetch的行进行操作。 
--eg 给员工加薪 少于1000的+500 少于3000的+1000 其他的删除
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
三、REF游标（动态游标）
1、用于处理运行时才能确定的查询结果集
2、REF游标必须在声明部分：
1）声明REF游标类型，type 类型名 is ref cursor;
2）声明REF游标变量，变量名 类型名;
3）不能使用for游标
3、或者直接使用SYS_REFCURSOR
1）声明REF游标变量，变量名 SYS_REFCURSOR

--eg 根据用户输入的表名和部门编号，返回对应的结果集
declare
 v_sql varchar2(200);
 v_tab varchar2(50);
 v_emp emp%rowtype;
 v_dept dept%rowtype;
 
 --动态游标 class Student
 type t_ref is ref cursor;
 c_ref t_ref; --Student stu;
 --c_ref sys_refcursor;
 
begin
	v_tab :='&tb';
	v_sql:='select * from  '||v_tab||'  where deptno=:dno';
  --先打开游标
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

四、触发器
1）语法：
触发器组成：
1.触发器语句（事件）
2.触发器限制（执行条件）
3.触发器操作（主体）

CREATE [OR REPLACE] TRIGGER trigger_name
AFTER | BEFORE | INSTEAD OF
[INSERT] [[OR] UPDATE [OF column_list]] [[OR] DELETE]
ON table_or_view_name
[REFERENCING {OLD [AS] old / NEW [AS] new}]
[FOR EACH ROW]
[WHEN (condition)]
pl/sql_block;


 
--语句级(表级) 每执行一个sql语句都执行触发器
--ey 创建日志记录表记录用户在哪个时间对emp表的做了增删改
create or replace trigger kgc57_trigger_1
after 
insert or update or delete
on emp
begin
	if inserting then
		insert into mylog(username,mytime,action) values(user,sysdate,'新增了');
  elsif updating then
		insert into mylog(username,mytime,action) values(user,sysdate,'修改了');
  else
		insert into mylog(username,mytime,action) values(user,sysdate,'删除了');
  end if;
end;

update emp set sal=sal+1 where deptno=20
select * from emp where deptno=20;
select * from mylog;
--行级
--ey 将上题改为行级触发器
create or replace trigger kgc57_trigger_2
after 
insert or update or delete
on emp
for each row --行级触发
begin
	if inserting then
		insert into mylog(username,mytime,action) values(user,sysdate,'新增了');
  elsif updating then
		insert into mylog(username,mytime,action) values(user,sysdate,'修改了');
  else
		insert into mylog(username,mytime,action) values(user,sysdate,'删除了');
  end if;
end;



--只能使用before，after是不能修改:new.deptno的值的
--数据的确认
--涨后的工资不能低于涨前的工资3000 2800
create or replace trigger kgc57_trigger_3
before
update
on emp
for each row
begin
	--判断涨工资前后
	if :new.sal<:old.sal then
		raise_application_error(-20066,'涨工资后的钱不能低于涨工资前');
	end if;
end;

update emp set sal=sal-1 where deptno=20
--ey 使用事前--触发实现部门表的deptno自增
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


--修改触发器的状态-可用或不可用

 --禁用
 alter trigger kgc57_trigger_4 disable

--解除
alter trigger kgc57_trigger_4 enable

--删除触发器
drop trigger  kgc57_trigger_1

--抛出异常（触发器中不能使用DCL语句）
--ey 使用事后触发实现不允许删除for部门

select * from dept;
delete from dept where deptno=40

create or replace trigger kgc57_trigger_5
after
delete
on dept
for each row
WHEN(old.deptno=40)
begin
	raise_application_error(-20066,'这个40号部门不能删除');
end;






---复杂的安全检查，非上班时间不允许插入数据
上班时间的定义：007 996 18.00  7.00 9.00 11.00
周六 ，周日 
to_char(sysdate,'day') in ('星期六','星期天')
select (to_char(sysdate,'day')) ss from dual 
where (to_char(sysdate,'day')) in ('星期六','星期天') ;
9-18点上班时间：to_number(to_char(sysdate,'hh24')) not between 9 and 17
--创建安全检查触发器
create or replace trigger kgc57_trigger_6
before
insert or update or delete
on emp
for each row
begin
	if to_char(sysdate,'day') in ('星期六','星期天')
		 or 
		 to_number(to_char(sysdate,'hh24')) not between 9 and 17
   then
		 raise_application_error(-20077,'非上班时间禁止操作数据库');
  end if;
end;
--禁止insert--抛出异常应用程序
update emp set sal=sal+1 ;
--更新数据
select * from emp;
------------------------------------instand of 修改视图
CREATE OR REPLACE VIEW v_emp20
 AS
SELECT e.empno,e.ename,e.job,e.sal,d.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno;
--查看视图
SELECT * FROM v_emp20;

create or replace trigger view_insert_tigger
  instead of insert on v_emp20  
  for each row
declare
    v_empCount       NUMBER;
    v_deptCount      NUMBER;
begin
    --判断要增加的员工是否存在
    SELECT COUNT(empno) INTO v_empCount FROM emp WHERE empno=:NEW.empno;
    
    --判断要部门是否存在
    SELECT COUNT(deptno) INTO v_deptCount FROM dept WHERE deptno=:new.deptno;
  --如果员工不存在
  IF v_empCount=0 THEN
      INSERT INTO emp(empno,ename,job,sal,deptno)
      VALUES(:new.empno,:new.ename,:new.job,:new.sal,:new.deptno);
    END IF;
    --如果部门不存在
    IF v_deptCount=0 THEN
      INSERT INTO dept(deptno,dname,loc)VALUES(:new.deptno,:new.dname,:new.loc);
    END IF;
end view_insert_tigger;
--添加数据
INSERT INTO v_emp20(empno,ename,job,sal,deptno,dname,loc)
VALUES(7934,'张三丰','CLERK',800,240,'活动部','深圳');
select * from emp








