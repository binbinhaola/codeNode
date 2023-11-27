<<<<<<< HEAD
# HIVE-概述

​	Hive本质上是一个hadoop客户端，用于将HQL（hiveSqL)转换为MapReduce程序

  （1）HIve的表数据储存在HDFS

  （2）Hive分析数据底层的实现是MapReduce

  （3）执行程序运行在Yarn上

 

# Hive服务部署

安装hive

配置环境变量

lib目录添加数据库驱动jar包

配置hive-site.xml



## hiverserver2服务

部署在能直接访问hadoop集群的节点上

用户不会直接访问hadoop集群，而是通过Hiveserver2进行代理访问

**用户模拟功能**：开启以远程客户端用户来进行登录，关闭使用HiveServer2启动用户登录



## metaStore

site-core.xml 配置好4个jdbc参数后

nohup hive --service metastore & 启动服务 

hive节点有meta配置后优先访问meta服务器



## 使用技巧

hive -e statement #使用非交互模式调度任务 

hive -f  filePath #读取文件中的sql语句



# SQL语句

## 数据库操作

```hive
create database name 
describe databse [extended] name
alter database name set dbpropertis("attr"='val')
```

## 数据表操作

![image-20230704194101741](F:\markdownImg\image-20230704194101741.png)

Create Table As Select (CTAS) 建表 (利用select查询语句返回的结果，直接建表)

![image-20230710142533229](F:\markdownImg\image-20230710142533229.png)

create Table Like (允许用户复制一张已经存储在的表结构，表不含数据)

![image-20230710142520794](F:\markdownImg\image-20230710142520794.png)



### hive基本数据类型

![image-20230704195538307](F:\markdownImg\image-20230704195538307.png)

### hive复杂数据类型

![image-20230704195902349](F:\markdownImg\image-20230704195902349.png)

![image-20230704202108435](F:\markdownImg\image-20230704202108435.png)

![image-20230704202452490](F:\markdownImg\image-20230704202452490.png)

 

### Json数据的存储读取

json map: {"values":{"value1":1,"value2":2}}

json struct: {"attr1":"content","attr2","content","attr3":123}

```sql
create table teacher
( 
	name string, //数据为字符串
	friends array<string>, //数据为字符串数组
	students map<string,int>, //数据为map类型
	address struct<city:string,street:string,postal_code:int> //struct类型
)
row format serde 'org.apache.hadoop.hive.serde2.JsonSerDe' //json解析格式
location '/user/hive/warehouse/teacher'; //数据路径

```



## DDL语句

### 查看表

``` sql
show tables [in database_name] like ['identifier_with_wildcards'];

describe [extended|formatted] [db_name.] table_name
```



### 修改表

```sql
--修改表名
alter table table_name rename to new_table_name

--修改列信息（只会修改表的元数据信息)
--增加列
alter table table_name add columns (col_name data_type [comment col_comment], ....)

--更新列 可以修改列名,数据类型,注释信息以及在表中的位置
alter table table_name change [column] col_old_name col_new_name column_type [comment col_comment] [first|after column_name]

--替换列 允许用户用新的列集替换表中原有的全部列。
alter table table_name replace columns (col_name data_type[comment col_comment], ...)
```



## DML语句

### load语句，可将文件导入到hive表中

```sql
load data local inpath 'filepath' [overwrite] into table tablename[partition (partcol1=val1,partcol2=val2 ...)];
```

local:表示从本地加载数据到hive表，否则从hdfs加载数据到hive表。（本地为访问的客户端节点)

into 表示追加，在表的末尾添加数据



### insert语句，将查询结果插入表中

将给定values插入表中

```sql
insert (into | overwrite) table tablename [partition (partcol1=val1,partcol2=val2...)] values values_row [,values_row...]
```

将查询结果写入到路径

```sql
insert overwrite [local] directory directory [row format row_format] [stored as file_format] select_statement;
```



### export&Import

​	Export导出语句可将表的数据和元数据信息一并到处的HDFS路径，Import可将Export
导出的内容导入Hive,表的数据和元数据信息都会恢复。Expot和Import可用于两个Hive
实例之间的数据迁移。



export 和 import 需要配合使用，import导入路径为export路径

```sql
--导出
export table tablename TO 'export_target_path'

--导入
import [external] table new_or_original_tablename from 'source_path' [location 'import_target_path']
```



## 查询语句

![image-20230710192514007](F:\markdownImg\image-20230710192514007.png)

as 关键词，为查询字段设置别名（可以省略)

```sql
select emp_no as col1 from emp
```

### 分组

group by和聚合函数一起使用 (只能选择聚合函数和分组字段)



### join语句

join 可以等值链接和不等值链接

左外连接

右外连接

全连接



#### 多表关联

join语句后面继续join



#### join的笛卡尔积

m*n

1.省略了连接条件

2.连接条件无效

3.所有表中的所有行互相连接



### 联合union

union将表数据纵向拼接，join为横向拼接

union 连接的是select查询语句

union去重，union all 不去重



### 全局排序(order by)

所有数据只能在一个reduce中进行运算



### Reduce内部排序(Sort By)



### 分区(Distribute By)



# 函数

## **相关命令**

```sql
show functions like "*string*"; --展示函数
desc function substring;  --函数描述
desc function extended substring; --函数实例，实现
ANALYZE TABLE  table1 compute sTATISTICS --手动更新表元数据信息
```



## 单行函数

输入一行数据，输出一行数据



### 算数运算函数（运算符）

| 运算符 | 描述           |
| ------ | -------------- |
| a&b    | 按位取与       |
| a\|b   | 按位取或       |
| a^b    | a和b按位取异或 |
| ~a     | a按位取反      |



### 数值函数

round() 四舍五入

ceil() 向上取整

floor() 向下取整



### 字符串函数

(1) substring（str,start,[len]）:截取字符串

(2) replace(str a,str b, str c): 替换字符串

(3) regexp_replace(str a,str b,str c):正则替换  --b为正则表达式

(4) regexp 返回boolean值，判断字段是否符合正则表达式

(5) repeat(str a,int b) 重复b次a字符串

(6) split(str a,str b) 返回 arry值 按照正则表达式，切割字符串

(7) nvl(a,b) 若a不为null ，则返回a，否则返回b

(8) concat(str a,str b,.....) 拼接字符串

(9) concat_ws(var sep, str a, str b...) 使用特定分割符分割字符串(也能传递数组 )

(10) get_json_object(str json_str, string path): 解析json字符串,json_str:需要解析的json字符串，path类似于取值的key



### 日期函数

**unix_timestamp(str time,str formata):** 返回当前或指定时间的时间戳 （unix时间戳指 UTC1970-1-1 00:00:00至今所经过的秒数，返回的时间戳后3位为毫秒)

**from_unixtime(bigint unixtime,[str format]):** 转化时间戳

**from_utc_timestamp(timestamp, str GMT):**将传入时间戳转换为指定时区字符串

**current_date:**返回当前的日期

**cuurent_timestamp**: 返回当前时间戳

**month,day,hour**: 获取月，日，时

**datediff：** 两个日期相差的天数

**date_add：**日期加天数

**date_sub：**日期减天数

**date_format：**将字符串转换为指定格式

**dayofweek:** 将日期的星期返回出来(星期日为1) 

**add_months(date,num)**增加月份 *接受日期格式

![image-20230920174253010](F:\markdownImg\image-20230920174253010.png)

有bug 最好单独使用



### 流程控制函数

**case when 条件判断**

```sql
select
    s_id,
    c_id,
    CASE 
    	when s_score>=90 then 'A'
    	when s_score>=80 and s_score<90 then 'B'
    	when s_score>=70 then 'C'
    	when s_score>=60 then 'D'
    	else 'F'
    END
from school.score;
```

**if:条件判断**

语法：if(boolean testCondition,T valueTrue,T valueFalseOrNull)



### 集合函数

**array函数**：声明集合

**array_contains**：判断array中是否包含某个元素

array_contains(array array,T element)

------

**sort_array**：将array中的元素排序

**size**：计算集合的元素数量

**map**：创建map集合

**map_keys:**返回map中的key

**map_values:**返回map中的value

**struct:**声明struct中的各属性，只接受值

**named_struct:**声明struct中的属性名和值



### 高级聚合函数

多进一出(多行传入，一个行输出)

1.普通聚合**count /sum**

**2.collect_list**收集并形成list集合，结果不去重

**3.collect_set**收集并形成set集合，结果去重



## 炸裂函数

UDTF(Table-Generation Functions),接受一行数据，输出一行或多行数据

**exploded(array<T\>() a)** //返回元素

**exploded(Map<K,V> m)** //返回键值对

**posexplode(ARRAY<T\> a)** //返回元素和元素的索引

**inline(ARRAY<STRUCT\<f1 : T1,...,fn : Tn>> a)** //返回结构体属性和值

![image-20230723144512219](F:\markdownImg\image-20230723144512219.png)

  ![image-20230723144825617](F:\markdownImg\image-20230723144825617.png)



## **窗口函数（开窗函数）**

定义：窗口函数，能为每行数据划分一个窗口，然后对窗口范围内的数据进行计算，最后将计算结果返回给该行

<img src="F:\markdownImg\image-20230723152144323.png" alt="image-20230723152144323" style="zoom:67%;" />

基本语法：

​    窗口函数的语法中主要包括”窗口“和”函数“两部分。其中”窗口“用于定义计算范围，”函数“用于定义计算逻辑

```sql
select
    order_id,
    order_date,
    amount,
    function(amount) over(窗口范围) total_amount
from order_info
```

**语法-函数**

​    绝大多数的聚合函数都可以配合窗口使用，例如max(),min()... 

**语法-窗口**

​    窗口范围的定义分为两种类型，一种时基于行的，一种时基于值的

**语法-窗口-基于行**

![image-20230723154215736](F:\markdownImg\image-20230723154215736.png)  

![image-20230723154810966](F:\markdownImg\image-20230723154810966.png)

基于值的order by控制了通过哪一个字段的值进行窗口划分

------

**语法-窗口-分区**

​    定义窗口范围时，可以指定分区字段，每个分区单独划分窗口

![image-20230723210327871](F:\markdownImg\image-20230723210327871.png)

------

**语法-窗口-缺省**

![image-20230723210604801](F:\markdownImg\image-20230723210604801.png)

### 跨行取值函数

**(1) lead和lag**

功能：获取当前行的下/上边某行，某个字段的值(lead下方值，lag上方值)

 ![image-20230724200915390](F:\markdownImg\image-20230724200915390.png)

函数不支持自定义窗口

**(2) first_value和last_value**

功能：获取窗口内某一列的第一个值/最后一个值

![image-20230724211336013](F:\markdownImg\image-20230724211336013.png)

函数支持自定义窗口



### 排名函数

功能：计算排名,不支持自定义窗口

常用排序函数--rank,dense_rank,row_number

![image-20230724223157095](F:\markdownImg\image-20230724223157095.png)

```sql
--distinct关键字默认多列去重
select 
    DISTINCT
    user_id,
    create_date
from order_info

--加括号后返回一个struct对象
select 
    DISTINCT
    (user_id,
    create_date)
from order_info
```





## 自定义函数

**自定义UDF(user definition function)函数**

引入依赖

```xml
        <dependency>
            <groupId>org.apache.hive</groupId>
            <artifactId>hive-exec</artifactId>
            <version>3.1.3</version>
        </dependency>
```

继承抽象类，实现抽象方法

```java
public class MyLenth extends GenericUDF {
	
    //执行函数类时会调用此方法，可以用于做数据校验
    @Override
    public ObjectInspector initialize(ObjectInspector[] objectInspectors) throws UDFArgumentException {
        if(arguments.length!=1){
            throw new UDFArgumentException("只接受一个参数");
        }

        ObjectInspector argument = arguments[0];
        if(argument.getCategory()!=ObjectInspector.Category.PRIMITIVE){
            throw new UDFArgumentException("只接受基本数据类型的参数");
        }

        PrimitiveObjectInspector poi = (PrimitiveObjectInspector) argument;
        if(poi.getPrimitiveCategory()!= PrimitiveObjectInspector.PrimitiveCategory.STRING){
            throw new UDFArgumentException("只接受String类型的参数");
        }

        //返回当前函数的输出结果的对象检查器
        return PrimitiveObjectInspectorFactory.javaIntObjectInspector;
    }

    //每处理一行数据，就会调用此方法
    @Override
    public Object evaluate(DeferredObject[] deferredObjects) throws HiveException {
        DeferredObject argument = arguments[0];
        //懒加载，获取数据
        Object obj = argument.get();

        if(obj == null){
            return 0;
        }else{
            return obj.toString().length();
        }
    }

    @Override
    public String getDisplayString(String[] strings) {
        return null;
    }
}
```

### 创建临时函数

临时函数只在当前会话有效。

（1）将jar包上传到服务器 /opt/module/hive/datas目录

（2）将jar包添加到hive的classpath,临时生效

> **add** jar /opt/module/hive/datas/myLenth.jar

（3）创建临时函数与开发好的java class 关联

```sql
create temporary function my_len
as "org.example.com.atguigu.hive.udtf.MyLenth"; //方法类的全类名
```



## 创建永久函数

(1)创建永久函数

先将jar包上传至hdfs目录

```sql
--创建永久函数
create function my_len
as "org.example.com.atguigu.hive.udtf.MyLenth"
using jar "hdfs://node1:8020/udf/myLenth.jar"
```

创建的函数和对应的数据库绑定

(2)删除永久函数

> drop function my_lenth;



# 分区和分桶表

​    Hive中的分区时把一张大表的数据按照业务需求分散的储存在多个目录下，每个目录就称为该表的一个分区。在查询时通过where字句可以查询指定分区，提高查询效率



## 分区表基本语法

创建分区表

```sql
create table dept_partition
(
    deptno int,
    dname string,
    loc string
)
    partitioned by (day string)  --设定分区字段，作为表中的字段
    row format delimited fields terminated by '\t';
```

写入数据

```sql
--load
load data local inpath '/opt/module/hive/datas/dept_20220401.log'
into table dept_partition
partition(day='20220401');
```

```sql
--insert
INSERT  overwrite table partition_buket.dept_partition partition(day='20220402')
select 
   deptno,
   dname,
   loc
from partition_buket.dept_partition
where day='20220401'
```

读数据

   查询分区表数据时，可以将分区字段看作表的伪列，当作其他表字段使用

```sql
select deptno,dname,loc,day
from dept_partition
where day = '2020-04-01'
```

### 储存

![image-20230728100629839](F:\markdownImg\image-20230728100629839.png)

分区表文件存在多个路径，路径名等于分区字段的值



### 分区表基本操作

```sql
show partiontions table_name --显示所有分区

alter table dept_partition add partition(day=partition_name); --增加单个分区

alter table dept_partition add partition(day=partition_name),partition(2); --添加多个分区

alter table table_name drop partition(day=partition_name);--删除单个分区

alter table table_name drop partition(day=partition_name),partition(par2); --删除多个分区
```

分区表也分内部表和外部表



### 修复分区

![image-20230728110727359](F:\markdownImg\image-20230728110727359.png)

![image-20230728111201162](F:\markdownImg\image-20230728111201162.png)

 (3) msck(meta store check)

   若分区元数据和HDFS的分区路径不一致，还可使用msck命令进行修复

```sql
msck repair table table_name [add/drop/sync partitions];
```

**修复都是以hdfs数据路径为基础。**



### 二级分区表

```sql
--分区语句
create table dept_partition2(
    deptno int,
    dname string,
    loc string
)
partitioned by (day string,hour string)
row format delimited fields terminated by '\t';

--数据装载语句
和一级分区一致，只有分区项更多
partition(day='202012',hour='12')
```



### 动态分区

![image-20230728115923030](F:\markdownImg\image-20230728115923030.png)

![image-20230728120408192](F:\markdownImg\image-20230728120408192.png)



# HQL实例

**筛选语句**

​	**like** 对字符串进行模糊匹配

**子查询**

  ()用小括号括上子查询的语句，获取结果

**分组查询**

  聚合函数无法直接和普通列一起查询，需要将普通列分组group by,或者写上常量

**distinct去重**

```sql
--distinct 单列去重
SELECT 
  count(DISTINCT si.stu_id)
from 
score_info si 
```



**先过滤数据，再统计数据可以提高效率**

**先链接再过滤，用来保证数据准确性**

**先统计再join可以提高效率**

**自链接：行数据主体和自己其他行数据比较时，可以使用表的自连接**(行数据部分列相同时，求不同的部分)

**where in 可以匹配一列数据**



**类型转换**

hive中0为long类型，不能通过decimal直接转换,需要强制转换



**Union**

可以通过union将表的列位置进行替换

**Join**

通过与单列外部join获取笛卡尔积，来为表中没有的数据创建null数据

```sql
SELECT 
 t1.*
from(
	select
	  t1.*
	from(
		select
		  t1.sku_id,
		  t1.sku_num,
		  rank() over(order by t1.sku_num desc) sku_rk
		from(
		SELECT 
			  od.sku_id,
			  sum(od.sku_num) sku_num
			from shopping_list.order_detail od 
			group by sku_id
		)t1	
	)t1
	where t1.sku_rk=20
)t1 
right join(
 select 1
)t4
```

![image-20230921171126067](F:\markdownImg\image-20230921171126067.png)



**使用等差数列来过滤出连续多少天的数据**

通过rank()或rownumbe()排序，来求出等差数列的日期

![image-20230925102819186](F:\markdownImg\image-20230925102819186.png)

**打标签**

在每行打标签来为数据分组



**hive code2**

java heap space 解决方法:**set** io.sort.mb=10







进度：zuihouyige











​	

=======
# HIVE-概述

​	Hive本质上是一个hadoop客户端，用于将HQL（hiveSqL)转换为MapReduce程序

  （1）HIve的表数据储存在HDFS

  （2）Hive分析数据底层的实现是MapReduce

  （3）执行程序运行在Yarn上

 

# Hive服务部署

安装hive

配置环境变量

lib目录添加数据库驱动jar包

配置hive-site.xml



## hiverserver2服务

部署在能直接访问hadoop集群的节点上

用户不会直接访问hadoop集群，而是通过Hiveserver2进行代理访问

**用户模拟功能**：开启以远程客户端用户来进行登录，关闭使用HiveServer2启动用户登录



## metaStore

site-core.xml 配置好4个jdbc参数后

nohup hive --service metastore & 启动服务 

hive节点有meta配置后优先访问meta服务器



## 使用技巧

hive -e statement #使用非交互模式调度任务 

hive -f  filePath #读取文件中的sql语句



# SQL语句

## 数据库操作

```hive
create database name 
describe databse [extended] name
alter database name set dbpropertis("attr"='val')
```

## 数据表操作

![image-20230704194101741](F:\markdownImg\image-20230704194101741.png)

Create Table As Select (CTAS) 建表 (利用select查询语句返回的结果，直接建表)

![image-20230710142533229](F:\markdownImg\image-20230710142533229.png)

create Table Like (允许用户复制一张已经存储在的表结构，表不含数据)

![image-20230710142520794](F:\markdownImg\image-20230710142520794.png)



### hive基本数据类型

![image-20230704195538307](F:\markdownImg\image-20230704195538307.png)

### hive复杂数据类型

![image-20230704195902349](F:\markdownImg\image-20230704195902349.png)

![image-20230704202108435](F:\markdownImg\image-20230704202108435.png)

![image-20230704202452490](F:\markdownImg\image-20230704202452490.png)

 

### Json数据的存储读取

json map: {"values":{"value1":1,"value2":2}}

json struct: {"attr1":"content","attr2","content","attr3":123}

```sql
create table teacher
( 
	name string, //数据为字符串
	friends array<string>, //数据为字符串数组
	students map<string,int>, //数据为map类型
	address struct<city:string,street:string,postal_code:int> //struct类型
)
row format serde 'org.apache.hadoop.hive.serde2.JsonSerDe' //json解析格式
location '/user/hive/warehouse/teacher'; //数据路径

```



## DDL语句

### 查看表

``` sql
show tables [in database_name] like ['identifier_with_wildcards'];

describe [extended|formatted] [db_name.] table_name
```



### 修改表

```sql
--修改表名
alter table table_name rename to new_table_name

--修改列信息（只会修改表的元数据信息)
--增加列
alter table table_name add columns (col_name data_type [comment col_comment], ....)

--更新列 可以修改列名,数据类型,注释信息以及在表中的位置
alter table table_name change [column] col_old_name col_new_name column_type [comment col_comment] [first|after column_name]

--替换列 允许用户用新的列集替换表中原有的全部列。
alter table table_name replace columns (col_name data_type[comment col_comment], ...)
```



## DML语句

### load语句，可将文件导入到hive表中

```sql
load data local inpath 'filepath' [overwrite] into table tablename[partition (partcol1=val1,partcol2=val2 ...)];
```

local:表示从本地加载数据到hive表，否则从hdfs加载数据到hive表。（本地为访问的客户端节点)

into 表示追加，在表的末尾添加数据



### insert语句，将查询结果插入表中

将给定values插入表中

```sql
insert (into | overwrite) table tablename [partition (partcol1=val1,partcol2=val2...)] values values_row [,values_row...]
```

将查询结果写入到路径

```sql
insert overwrite [local] directory directory [row format row_format] [stored as file_format] select_statement;
```



### export&Import

​	Export导出语句可将表的数据和元数据信息一并到处的HDFS路径，Import可将Export
导出的内容导入Hive,表的数据和元数据信息都会恢复。Expot和Import可用于两个Hive
实例之间的数据迁移。



export 和 import 需要配合使用，import导入路径为export路径

```sql
--导出
export table tablename TO 'export_target_path'

--导入
import [external] table new_or_original_tablename from 'source_path' [location 'import_target_path']
```



## 查询语句

![image-20230710192514007](F:\markdownImg\image-20230710192514007.png)

as 关键词，为查询字段设置别名（可以省略)

```sql
select emp_no as col1 from emp
```

### 分组

group by和聚合函数一起使用 (只能选择聚合函数和分组字段)



### join语句

join 可以等值链接和不等值链接

左外连接

右外连接

全连接



#### 多表关联

join语句后面继续join



#### join的笛卡尔积

m*n

1.省略了连接条件

2.连接条件无效

3.所有表中的所有行互相连接



### 联合union

union将表数据纵向拼接，join为横向拼接

union 连接的是select查询语句

union去重，union all 不去重



### 全局排序(order by)

所有数据只能在一个reduce中进行运算



### Reduce内部排序(Sort By)



### 分区(Distribute By)



# 函数

## **相关命令**

```sql
show functions like "*string*"; --展示函数
desc function substring;  --函数描述
desc function extended substring; --函数实例，实现
ANALYZE TABLE  table1 compute sTATISTICS --手动更新表元数据信息
```



## 单行函数

输入一行数据，输出一行数据



### 算数运算函数（运算符）

| 运算符 | 描述           |
| ------ | -------------- |
| a&b    | 按位取与       |
| a\|b   | 按位取或       |
| a^b    | a和b按位取异或 |
| ~a     | a按位取反      |



### 数值函数

round() 四舍五入

ceil() 向上取整

floor() 向下取整



### 字符串函数

(1) substring（str,start,[len]）:截取字符串

(2) replace(str a,str b, str c): 替换字符串

(3) regexp_replace(str a,str b,str c):正则替换  --b为正则表达式

(4) regexp 返回boolean值，判断字段是否符合正则表达式

(5) repeat(str a,int b) 重复b次a字符串

(6) split(str a,str b) 返回 arry值 按照正则表达式，切割字符串

(7) nvl(a,b) 若a不为null ，则返回a，否则返回b

(8) concat(str a,str b,.....) 拼接字符串

(9) concat_ws(var sep, str a, str b...) 使用特定分割符分割字符串(也能传递数组 )

(10) get_json_object(str json_str, string path): 解析json字符串,json_str:需要解析的json字符串，path类似于取值的key



### 日期函数

**unix_timestamp(str time,str formata):** 返回当前或指定时间的时间戳 （unix时间戳指 UTC1970-1-1 00:00:00至今所经过的秒数，返回的时间戳后3位为毫秒)

**from_unixtime(bigint unixtime,[str format]):** 转化时间戳

**from_utc_timestamp(timestamp, str GMT):**将传入时间戳转换为指定时区字符串

**current_date:**返回当前的日期

**cuurent_timestamp**: 返回当前时间戳

**month,day,hour**: 获取月，日，时

**datediff：** 两个日期相差的天数

**date_add：**日期加天数

**date_sub：**日期减天数

**date_format：**将字符串转换为指定格式

**dayofweek:** 将日期的星期返回出来(星期日为1) 

**add_months(date,num)**增加月份 *接受日期格式

![image-20230920174253010](F:\markdownImg\image-20230920174253010.png)

有bug 最好单独使用



### 流程控制函数

**case when 条件判断**

```sql
select
    s_id,
    c_id,
    CASE 
    	when s_score>=90 then 'A'
    	when s_score>=80 and s_score<90 then 'B'
    	when s_score>=70 then 'C'
    	when s_score>=60 then 'D'
    	else 'F'
    END
from school.score;
```

**if:条件判断**

语法：if(boolean testCondition,T valueTrue,T valueFalseOrNull)



### 集合函数

**array函数**：声明集合

**array_contains**：判断array中是否包含某个元素

array_contains(array array,T element)

------

**sort_array**：将array中的元素排序

**size**：计算集合的元素数量

**map**：创建map集合

**map_keys:**返回map中的key

**map_values:**返回map中的value

**struct:**声明struct中的各属性，只接受值

**named_struct:**声明struct中的属性名和值



### 高级聚合函数

多进一出(多行传入，一个行输出)

1.普通聚合**count /sum**

**2.collect_list**收集并形成list集合，结果不去重

**3.collect_set**收集并形成set集合，结果去重



## 炸裂函数

UDTF(Table-Generation Functions),接受一行数据，输出一行或多行数据

**exploded(array<T\>() a)** //返回元素

**exploded(Map<K,V> m)** //返回键值对

**posexplode(ARRAY<T\> a)** //返回元素和元素的索引

**inline(ARRAY<STRUCT\<f1 : T1,...,fn : Tn>> a)** //返回结构体属性和值

![image-20230723144512219](F:\markdownImg\image-20230723144512219.png)

  ![image-20230723144825617](F:\markdownImg\image-20230723144825617.png)



## **窗口函数（开窗函数）**

定义：窗口函数，能为每行数据划分一个窗口，然后对窗口范围内的数据进行计算，最后将计算结果返回给该行

<img src="F:\markdownImg\image-20230723152144323.png" alt="image-20230723152144323" style="zoom:67%;" />

基本语法：

​    窗口函数的语法中主要包括”窗口“和”函数“两部分。其中”窗口“用于定义计算范围，”函数“用于定义计算逻辑

```sql
select
    order_id,
    order_date,
    amount,
    function(amount) over(窗口范围) total_amount
from order_info
```

**语法-函数**

​    绝大多数的聚合函数都可以配合窗口使用，例如max(),min()... 

**语法-窗口**

​    窗口范围的定义分为两种类型，一种时基于行的，一种时基于值的

**语法-窗口-基于行**

![image-20230723154215736](F:\markdownImg\image-20230723154215736.png)  

![image-20230723154810966](F:\markdownImg\image-20230723154810966.png)

基于值的order by控制了通过哪一个字段的值进行窗口划分

------

**语法-窗口-分区**

​    定义窗口范围时，可以指定分区字段，每个分区单独划分窗口

![image-20230723210327871](F:\markdownImg\image-20230723210327871.png)

------

**语法-窗口-缺省**

![image-20230723210604801](F:\markdownImg\image-20230723210604801.png)

### 跨行取值函数

**(1) lead和lag**

功能：获取当前行的下/上边某行，某个字段的值(lead下方值，lag上方值)

 ![image-20230724200915390](F:\markdownImg\image-20230724200915390.png)

函数不支持自定义窗口

**(2) first_value和last_value**

功能：获取窗口内某一列的第一个值/最后一个值

![image-20230724211336013](F:\markdownImg\image-20230724211336013.png)

函数支持自定义窗口



### 排名函数

功能：计算排名,不支持自定义窗口

常用排序函数--rank,dense_rank,row_number

![image-20230724223157095](F:\markdownImg\image-20230724223157095.png)

```sql
--distinct关键字默认多列去重
select 
    DISTINCT
    user_id,
    create_date
from order_info

--加括号后返回一个struct对象
select 
    DISTINCT
    (user_id,
    create_date)
from order_info
```





## 自定义函数

**自定义UDF(user definition function)函数**

引入依赖

```xml
        <dependency>
            <groupId>org.apache.hive</groupId>
            <artifactId>hive-exec</artifactId>
            <version>3.1.3</version>
        </dependency>
```

继承抽象类，实现抽象方法

```java
public class MyLenth extends GenericUDF {
	
    //执行函数类时会调用此方法，可以用于做数据校验
    @Override
    public ObjectInspector initialize(ObjectInspector[] objectInspectors) throws UDFArgumentException {
        if(arguments.length!=1){
            throw new UDFArgumentException("只接受一个参数");
        }

        ObjectInspector argument = arguments[0];
        if(argument.getCategory()!=ObjectInspector.Category.PRIMITIVE){
            throw new UDFArgumentException("只接受基本数据类型的参数");
        }

        PrimitiveObjectInspector poi = (PrimitiveObjectInspector) argument;
        if(poi.getPrimitiveCategory()!= PrimitiveObjectInspector.PrimitiveCategory.STRING){
            throw new UDFArgumentException("只接受String类型的参数");
        }

        //返回当前函数的输出结果的对象检查器
        return PrimitiveObjectInspectorFactory.javaIntObjectInspector;
    }

    //每处理一行数据，就会调用此方法
    @Override
    public Object evaluate(DeferredObject[] deferredObjects) throws HiveException {
        DeferredObject argument = arguments[0];
        //懒加载，获取数据
        Object obj = argument.get();

        if(obj == null){
            return 0;
        }else{
            return obj.toString().length();
        }
    }

    @Override
    public String getDisplayString(String[] strings) {
        return null;
    }
}
```

### 创建临时函数

临时函数只在当前会话有效。

（1）将jar包上传到服务器 /opt/module/hive/datas目录

（2）将jar包添加到hive的classpath,临时生效

> **add** jar /opt/module/hive/datas/myLenth.jar

（3）创建临时函数与开发好的java class 关联

```sql
create temporary function my_len
as "org.example.com.atguigu.hive.udtf.MyLenth"; //方法类的全类名
```



## 创建永久函数

(1)创建永久函数

先将jar包上传至hdfs目录

```sql
--创建永久函数
create function my_len
as "org.example.com.atguigu.hive.udtf.MyLenth"
using jar "hdfs://node1:8020/udf/myLenth.jar"
```

创建的函数和对应的数据库绑定

(2)删除永久函数

> drop function my_lenth;



# 分区和分桶表

​    Hive中的分区时把一张大表的数据按照业务需求分散的储存在多个目录下，每个目录就称为该表的一个分区。在查询时通过where字句可以查询指定分区，提高查询效率



## 分区表基本语法

创建分区表

```sql
create table dept_partition
(
    deptno int,
    dname string,
    loc string
)
    partitioned by (day string)  --设定分区字段，作为表中的字段
    row format delimited fields terminated by '\t';
```

写入数据

```sql
--load
load data local inpath '/opt/module/hive/datas/dept_20220401.log'
into table dept_partition
partition(day='20220401');
```

```sql
--insert
INSERT  overwrite table partition_buket.dept_partition partition(day='20220402')
select 
   deptno,
   dname,
   loc
from partition_buket.dept_partition
where day='20220401'
```

读数据

   查询分区表数据时，可以将分区字段看作表的伪列，当作其他表字段使用

```sql
select deptno,dname,loc,day
from dept_partition
where day = '2020-04-01'
```

### 储存

![image-20230728100629839](F:\markdownImg\image-20230728100629839.png)

分区表文件存在多个路径，路径名等于分区字段的值



### 分区表基本操作

```sql
show partiontions table_name --显示所有分区

alter table dept_partition add partition(day=partition_name); --增加单个分区

alter table dept_partition add partition(day=partition_name),partition(2); --添加多个分区

alter table table_name drop partition(day=partition_name);--删除单个分区

alter table table_name drop partition(day=partition_name),partition(par2); --删除多个分区
```

分区表也分内部表和外部表



### 修复分区

![image-20230728110727359](F:\markdownImg\image-20230728110727359.png)

![image-20230728111201162](F:\markdownImg\image-20230728111201162.png)

 (3) msck(meta store check)

   若分区元数据和HDFS的分区路径不一致，还可使用msck命令进行修复

```sql
msck repair table table_name [add/drop/sync partitions];
```

**修复都是以hdfs数据路径为基础。**



### 二级分区表

```sql
--分区语句
create table dept_partition2(
    deptno int,
    dname string,
    loc string
)
partitioned by (day string,hour string)
row format delimited fields terminated by '\t';

--数据装载语句
和一级分区一致，只有分区项更多
partition(day='202012',hour='12')
```



### 动态分区

![image-20230728115923030](F:\markdownImg\image-20230728115923030.png)

![image-20230728120408192](F:\markdownImg\image-20230728120408192.png)



# HQL实例

**筛选语句**

​	**like** 对字符串进行模糊匹配

**子查询**

  ()用小括号括上子查询的语句，获取结果

**分组查询**

  聚合函数无法直接和普通列一起查询，需要将普通列分组group by,或者写上常量

**distinct去重**

```sql
--distinct 单列去重
SELECT 
  count(DISTINCT si.stu_id)
from 
score_info si 
```



**先过滤数据，再统计数据可以提高效率**

**先链接再过滤，用来保证数据准确性**

**先统计再join可以提高效率**

**自链接：行数据主体和自己其他行数据比较时，可以使用表的自连接**(行数据部分列相同时，求不同的部分)

**where in 可以匹配一列数据**



**类型转换**

hive中0为long类型，不能通过decimal直接转换,需要强制转换



**Union**

可以通过union将表的列位置进行替换

**Join**

通过与单列外部join获取笛卡尔积，来为表中没有的数据创建null数据

```sql
SELECT 
 t1.*
from(
	select
	  t1.*
	from(
		select
		  t1.sku_id,
		  t1.sku_num,
		  rank() over(order by t1.sku_num desc) sku_rk
		from(
		SELECT 
			  od.sku_id,
			  sum(od.sku_num) sku_num
			from shopping_list.order_detail od 
			group by sku_id
		)t1	
	)t1
	where t1.sku_rk=20
)t1 
right join(
 select 1
)t4
```

![image-20230921171126067](F:\markdownImg\image-20230921171126067.png)



**使用等差数列来过滤出连续多少天的数据**

通过rank()或rownumbe()排序，来求出等差数列的日期

![image-20230925102819186](F:\markdownImg\image-20230925102819186.png)

**打标签**

在每行打标签来为数据分组



**hive code2**

java heap space 解决方法:**set** io.sort.mb=10







进度：zuihouyige











​	

>>>>>>> e6f9c7032619ea760d965be70abd78cafff1d124
