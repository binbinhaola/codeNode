��sys��  ����oracle�������ֵ�Ļ������ͼ�������sys�û��У���Щ�������ͼ����oracle��������������Ҫ�ģ�
�����ݿ��Լ�ά�����κ��û��������ֶ����ġ�sys�û�ӵ��dba��sysdba��sysoper�Ƚ�ɫ��Ȩ�ޣ���oracleȨ����ߵ��û���
��system��  �û����ڴ�Ŵ�һ�����ڲ����ݣ���oracle��һЩ���Ի򹤾ߵĹ�����Ϣ��system�û�ӵ����ͨdba��ɫȨ�ޡ�

/*
��������һ����ռ�����ݿ�ģʽ������ɡ����ģʽ�Ƕ���ļ��ϣ���ģʽ������ֱ���������ݿ����ݵ��߼��ṹ��
ģʽ�����������һЩ�ṹ������ͼ�����С��洢���̡�ͬ��ʡ��������غ����ݿ����ȡ�
�߼��洢�ṹ������ռ䡢�κͷ�Χ��������������ʹ�����ݿ������ռ䡣
��֮,�߼��ṹ
���߼��洢�ṹ(��ռ�,��,��Χ,��)��
�߼����ݽṹ(����ͼ�����С��洢���̡�ͬ��ʡ��������غ����ݿ�����)���
,�����е�ģʽ����(�߼����ݽṹ)�͹�ϵ�γ������ݿ�Ĺ�ϵ��ơ�*/
--�鿴��ǰ�û���
show user
--�鿴�û��µ����б�
select* from tab;   mysql--show tables;
--����ÿҳ��ʾ��80����¼�ĸ߶�
set pagesize 80
--�����п������������9 ���м�����ʾ��λ��������ַ���/A����ֱ�Ӹ�λ��12
column empno format 9999
--����
host cls
--ִ����һ�εĴ���
--�鿴��ռ�
select * from user_tablespaces


--��d�̴�����ռ�
create tablespace kgc57_tablespace
datafile 'D:\Software\TableSpace\kgc57.dbf'
size 1m

--�����ռ�ķ���һ:����ԭ���Ĵ�С
alter database datafile 'D:\Software\TableSpace\kgc57.dbf'
resize 2m


---�����ռ䷽���������ռ�����������ļ�
alter tablespace  kgc57_tablespace add datafile
'D:\Software\TableSpace\kgc5702.dbf' 
size 1m autoextend on

----�����û�--����ʹ��Ĭ�ϱ�ռ��Ĭ����ʱ��ռ�
create user kgc57
identified by 123
default tablespace users
temporary tablespace temp

--��Ȩ��ɫ
grant connect,resource to kgc57


--��Ȩ���:grant connect ,resource,dba to user with admin option;
--ע�⣺���еġ�with admin option��ѡ��ĺ�����Ȩ��ת�ڣ����û�user�ܰ����õ������Ȩ����ת�ڸ������û�user����

--����Ȩ��--���Դ���������������
revoke connect,resource from kgc57

--����ָ����Ĳ�ѯ��Ȩ��
--�����ѯȨ��
grant select on scott.emp to kgc57
--����ָ����Ĳ�ѯ��Ȩ��
revoke select on scott.emp from kgc57


/*
rownum��rowid����α�У��������ߵĸ����ǲ�ͬ�ģ�
rownum�Ǹ���sql��ѯ���Ľ����ÿ�з���һ���߼���ţ�
�������sql��ͬҲ�ͻᵼ������rownum��ͬ��
����rowid������ṹ�ϵģ���ÿ����¼insert�����ݿ���ʱ��������һ��Ψһ�������¼ ��
����  AAAMgzAAEAAAAAgAAB 7499 ALLEN SALESMAN 7698 1981/2/20 1600.00 300.00 30
�����AAAMgzAAEAAAAAgAAB����λ�ö�Ӧ��������¼�������¼�ǲ�������sql�ĸı���ı䡣
��ˣ���͵��������ǵ�ʹ�ó�����ͬ�ˣ�ͨ����sql��ҳʱ���ǲ���ĳһ��Χ�ڵļ�¼ʱ�����ǻ�ʹ��rownum��
select * from emp a where rownum < 3����������Ҫע�⣬ֱ����rownum���ҵķ�Χ����Ҫ����1��
��Ϊrownum�Ǵ�1��ʼ��¼�ģ���Ȼ����԰�rownum����������һ���������Ϊ��������ֶ��ٸ���������ѯ��
*/ 
--dual:α��
--select now();
--��ѯԱ�������rowid
select rowid from dual;
select * from dual;
select rowid,ename,sal from scott.emp;
--����ָ����rowid��ѯ
select * from scott.emp where rowid='AAAR3sAAEAAAACWAAA'
--��β�ѯstuInfo������Ȼ����ĵ�3����¼��
select t.*,rownum from scott.emp t;
select rownum from dual;

select t.*,rownum from scott.emp t where rownum<3
--rownum:rownum�Ǹ���sql��ѯ���Ľ����ÿ�з���һ���߼����,��ͬ��sql����rownum��ֵ��һ��
--��ѯrownumС��5��Ԫ��
select t.*,rownum from scott.emp t where rownum<=5

--����нˮ�����ѯ
select t.*,rownum from scott.emp t where rownum<=3 order by sal desc 

--������rownum,�����������

--ע��--rownum����ʹ��=  1.rownumֻ����< ����<=


-- ʹ�ô��� ���鲻�����         
select t.*,rownum from scott.emp t where rownum>3 order by sal desc 


--�Ľ�
select t.*,rownum as rn from 
(
  select emp.* from scott.emp  order by sal desc
) t where rownum>3


--�ڸĽ������������濴��һ�ű�
select * from (
select t.*,rownum as rn from 
(
  select emp.* from scott.emp  order by sal desc
) t where rownum<=5
) where rn>0


--����
create table testkgc57(kid number(4),kname varchar2(50))

---���ڽ���
select * from testkgc57

--������
alter table testkgc57 add ksex varchar(4)

--�޸���
alter table testkgc57 modify kage varchar(30)

--ɾ����
alter table testkgc57 drop column kage 

--����������
rename testkgc57 to kgc57test


--ɾ����
drop table kgc57test



---Լ��
--�������Լ��
alter table testkgc57 add constraint pk_kid primary key(kid) 
--Ψһ
alter table testkgc57 add constraint uk_kname unique (kname) 

--�ǿ�
alter table testkgc57 modify kname not null


---���Լ��
alter table testkgc57 add constraint sex_check check(ksex in('��','Ů'))
insert into testkgc57(kid,kname,ksex) values(11,'����','��')
insert into testkgc57(kid,kname,ksex) values(12,'������','��')
select * from testkgc57;
--���ƾɱ�����-ȫ���У�ȫ������
create table bigsb as (select * from dept)
--���ڱ�  �ձ� 
select * from bigsb3;

--������
create table bigsb2 
as
select deptno,dname from dept


--���Ʊ�ṹ,��������
create table bigsb3
as
select * from emp where 1=2


--��ѯ

select * from bigsb2;
--�����������
insert into bigsb2 values(13,'��ˮ��'),(12,'������')--����
insert into bigsb2 (select empno,ename from emp)
--ɾ������ д����־
delete from bigsb2

--ɾ���� ��������־
truncate table bigsb2;



/*
1.delete from�������д������truncate�����ԡ�

2.delete from��¼��һ����ɾ�ģ���ɾ����ÿ�м�¼�������־����truncateһ����ɾ������ҳ�������������ֻ��¼ҳ�ͷţ�����֮��delete from������־��truncate�����������õ�������־�ռ���١�

3.delete fromɾ�ձ�󣬻ᱣ��һ���յ�ҳ��truncate�ڱ��в��������κ�ҳ��

4.��ʹ������ִ�� DELETE ���ʱ�����������и����Ա�ɾ����truncateʼ���������ҳ���������������С�

5.�����identity����������id�У�delete from����Ȼ���ϴε�����ʼ���ӣ������Ӳ��䣬��truncate�����ӻ�ָ���ʼ��

6.truncate���ᴥ��delete�Ĵ���������Ϊtruncate��������¼������ɾ��
*/

---�����ʹ�� 100 99 0
--commit,rollback to ,savepoint
--�������Ա�
select * from bigsb2;
--�����������
insert into bigsb2 values(10,'��ˮ��')
savepoint aa
insert into bigsb2 values(11,'��ѩ��')
savepoint bb
insert into bigsb2 values(12,'��ѩ��')
rollback to bb

commit




/*
���Լ����FOREIGN KEY��

���Լ�������ھ��и��ӹ�ϵ���ӱ��У����Լ��ʹ���ӱ��е��ж�Ӧ����������У�����ά�����ݿ�������ԡ������������ܺͺ��ڵ�ҵ��ϵͳ����չ�Ŀ��ǣ��ܶ�ʱ�����Լ�������������ݿ������У�ʵ�ʻ����ҵ������н��д������Լ��ע�����¼��㣺

�������Լ�����ӱ��е��кͶ�Ӧ�����е����������ͱ�����ͬ���������Բ�ͬ
������Ӧ�ĸ����б����������Լ����PRIMARY KEY����ΨһԼ����UNIQUE��
�������Լ��������NULLֵ����Ӧ���оͳ��˹�����
������ʵ�ܶ�ʱ��ʹ��������ܶ�����Ϊ����ɾ�������Ƚ��鷳������Ҫɾ�������е�ĳ�����ݣ���ĳ���ӱ������жԸ������ݵ����ã���ʱ�ͻᵼ��ɾ��ʧ�ܡ����������ַ�ʽ���Ż����ֳ�����

������һ�ַ�ʽ�򵥴ֱ���ɾ����ʱ�򣬼���ɾ�����ӱ��е�����ƥ���У��ڴ������ʱ��ͨ�� on delete cascade �Ӿ�ָ��������пɼ���ɾ����
SQL> alter table emp add constraint emp_deptno_fk foreign key(deptno) references dept (deptno) on delete cascade;
����
�ڶ��ַ�ʽ��ɾ�������еĶ�Ӧ�У��Ὣ��Ӧ�ӱ��е�����ƥ���е����Լ������ΪNULL��ͨ�� on delete set null �Ӿ�ʵʩ��
SQL> alter table emp add constraint emp_deptno_fk foreign key(deptno) references dept(deptno) on delete set null;
 */
