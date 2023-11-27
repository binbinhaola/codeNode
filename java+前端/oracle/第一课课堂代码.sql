【sys】  所有oracle的数据字典的基表和视图都存放在sys用户中，这些基表和视图对于oracle的运行是至关重要的，
由数据库自己维护，任何用户都不能手动更改。sys用户拥有dba，sysdba，sysoper等角色或权限，是oracle权限最高的用户。
【system】  用户用于存放次一级的内部数据，如oracle的一些特性或工具的管理信息。system用户拥有普通dba角色权限。

/*
它由至少一个表空间和数据库模式对象组成。这里，模式是对象的集合，而模式对象是直接引用数据库数据的逻辑结构。
模式对象包括这样一些结构：表、视图、序列、存储过程、同义词、索引、簇和数据库链等。
逻辑存储结构包括表空间、段和范围，用于描述怎样使用数据库的物理空间。
总之,逻辑结构
由逻辑存储结构(表空间,段,范围,块)和
逻辑数据结构(表、视图、序列、存储过程、同义词、索引、簇和数据库链等)组成
,而其中的模式对象(逻辑数据结构)和关系形成了数据库的关系设计。*/
--查看当前用户：
show user
--查看用户下的所有表
select* from tab;   mysql--show tables;
--设置每页显示的80条记录的高度
set pagesize 80
--设置列宽度数字类型用9 ，有几个表示几位，如果是字符串/A后面直接跟位数12
column empno format 9999
--清屏
host cls
--执行上一次的代码
--查看表空间
select * from user_tablespaces


--在d盘创建表空间
create tablespace kgc57_tablespace
datafile 'D:\Software\TableSpace\kgc57.dbf'
size 1m

--扩充表空间的方法一:更改原来的大小
alter database datafile 'D:\Software\TableSpace\kgc57.dbf'
resize 2m


---扩充表空间方法二：向表空间中添加数据文件
alter tablespace  kgc57_tablespace add datafile
'D:\Software\TableSpace\kgc5702.dbf' 
size 1m autoextend on

----创建用户--建议使用默认表空间和默认临时表空间
create user kgc57
identified by 123
default tablespace users
temporary tablespace temp

--授权角色
grant connect,resource to kgc57


--授权语句:grant connect ,resource,dba to user with admin option;
--注意：其中的“with admin option”选项的含义是权限转授，该用户user能把他得到的这个权限再转授给其他用户user。）

--撤销权利--可以创建表，不插入数据
revoke connect,resource from kgc57

--授予指定表的查询的权限
--授予查询权限
grant select on scott.emp to kgc57
--撤销指定表的查询的权限
revoke select on scott.emp from kgc57


/*
rownum和rowid都是伪列，但是两者的根本是不同的，
rownum是根据sql查询出的结果给每行分配一个逻辑编号，
所以你的sql不同也就会导致最终rownum不同，
但是rowid是物理结构上的，在每条记录insert到数据库中时，都会有一个唯一的物理记录 ，
例如  AAAMgzAAEAAAAAgAAB 7499 ALLEN SALESMAN 7698 1981/2/20 1600.00 300.00 30
这里的AAAMgzAAEAAAAAgAAB物理位置对应了这条记录，这个记录是不会随着sql的改变而改变。
因此，这就导致了他们的使用场景不同了，通常在sql分页时或是查找某一范围内的记录时，我们会使用rownum。
select * from emp a where rownum < 3；这里我们要注意，直接用rownum查找的范围必须要包含1；
因为rownum是从1开始记录的，当然你可以把rownum查出来后放在一个虚表中作为这个虚表的字段再根据条件查询。
*/ 
--dual:伪表
--select now();
--查询员工表的中rowid
select rowid from dual;
select * from dual;
select rowid,ename,sal from scott.emp;
--根据指定的rowid查询
select * from scott.emp where rowid='AAAR3sAAEAAAACWAAA'
--如何查询stuInfo表中自然排序的第3条记录？
select t.*,rownum from scott.emp t;
select rownum from dual;

select t.*,rownum from scott.emp t where rownum<3
--rownum:rownum是根据sql查询出的结果给每行分配一个逻辑编号,不同的sql可能rownum的值不一样
--查询rownum小于5的元素
select t.*,rownum from scott.emp t where rownum<=5

--根据薪水排序查询
select t.*,rownum from scott.emp t where rownum<=3 order by sal desc 

--先生产rownum,后排序就乱了

--注意--rownum不能使用=  1.rownum只能用< 或者<=


-- 使用大于 ，查不出结果         
select t.*,rownum from scott.emp t where rownum>3 order by sal desc 


--改进
select t.*,rownum as rn from 
(
  select emp.* from scott.emp  order by sal desc
) t where rownum>3


--在改进，继续将上面看作一张表
select * from (
select t.*,rownum as rn from 
(
  select emp.* from scott.emp  order by sal desc
) t where rownum<=5
) where rn>0


--建表
create table testkgc57(kid number(4),kname varchar2(50))

---关于建表
select * from testkgc57

--增加列
alter table testkgc57 add ksex varchar(4)

--修改列
alter table testkgc57 modify kage varchar(30)

--删除列
alter table testkgc57 drop column kage 

--给表重命名
rename testkgc57 to kgc57test


--删除表
drop table kgc57test



---约束
--添加主键约束
alter table testkgc57 add constraint pk_kid primary key(kid) 
--唯一
alter table testkgc57 add constraint uk_kname unique (kname) 

--非空
alter table testkgc57 modify kname not null


---检查约束
alter table testkgc57 add constraint sex_check check(ksex in('男','女'))
insert into testkgc57(kid,kname,ksex) values(11,'张三','男')
insert into testkgc57(kid,kname,ksex) values(12,'张三丰','公')
select * from testkgc57;
--复制旧表内容-全部列，全部数据
create table bigsb as (select * from dept)
--大哨兵  烧饼 
select * from bigsb3;

--部分列
create table bigsb2 
as
select deptno,dname from dept


--复制表结构,不含数据
create table bigsb3
as
select * from emp where 1=2


--查询

select * from bigsb2;
--插入多行数据
insert into bigsb2 values(13,'吹水部'),(12,'安保部')--错误
insert into bigsb2 (select empno,ename from emp)
--删除数据 写入日志
delete from bigsb2

--删除二 不计入日志
truncate table bigsb2;



/*
1.delete from后面可以写条件，truncate不可以。

2.delete from记录是一条条删的，所删除的每行记录都会进日志，而truncate一次性删掉整个页，因此日至里面只记录页释放，简言之，delete from更新日志，truncate基本不，所用的事务日志空间较少。

3.delete from删空表后，会保留一个空的页，truncate在表中不会留有任何页。

4.当使用行锁执行 DELETE 语句时，将锁定表中各行以便删除。truncate始终锁定表和页，而不是锁定各行。

5.如果有identity产生的自增id列，delete from后仍然从上次的数开始增加，即种子不变，而truncate后，种子会恢复初始。

6.truncate不会触发delete的触发器，因为truncate操作不记录各个行删除
*/

---事务的使用 100 99 0
--commit,rollback to ,savepoint
--创建测试表
select * from bigsb2;
--插入多行数据
insert into bigsb2 values(10,'吹水部')
savepoint aa
insert into bigsb2 values(11,'吹雪部')
savepoint bb
insert into bigsb2 values(12,'吹雪部')
rollback to bb

commit




/*
外键约束（FOREIGN KEY）

外键约束定义在具有父子关系的子表中，外键约束使得子表中的列对应父表的主键列，用以维护数据库的完整性。不过出于性能和后期的业务系统的扩展的考虑，很多时候，外键约束仅出现在数据库的设计中，实际会放在业务程序中进行处理。外键约束注意以下几点：

　　外键约束的子表中的列和对应父表中的列数据类型必须相同，列名可以不同
　　对应的父表列必须存在主键约束（PRIMARY KEY）或唯一约束（UNIQUE）
　　外键约束列允许NULL值，对应的行就成了孤行了
　　其实很多时候不使用外键，很多人认为会让删除操作比较麻烦，比如要删除父表中的某条数据，但某个子表中又有对该条数据的引用，这时就会导致删除失败。我们有两种方式来优化这种场景：

　　第一种方式简单粗暴，删除的时候，级联删除掉子表中的所有匹配行，在创建外键时，通过 on delete cascade 子句指定该外键列可级联删除：
SQL> alter table emp add constraint emp_deptno_fk foreign key(deptno) references dept (deptno) on delete cascade;
　　
第二种方式，删除父表中的对应行，会将对应子表中的所有匹配行的外键约束列置为NULL，通过 on delete set null 子句实施：
SQL> alter table emp add constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete set null;
 */
