## **Hadoop介绍**

hadoop软件允许用户使用简单的编程模型实现跨机器集群对海量数据进行分布式计算

### 核心组件

Hadoop HDFS(分布式文件**储存**系统):负责海量数据存储

Hadoop YARN(集群**资源管理**系统和任务调度框架):解决资源任务调度

Hadoop MapReduce(分布式**计算**框架)：解决海量数据计算

## 集群组成

**HDFS集群**

<img src="C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230625151637066.png" alt="image-20230625151637066" style="zoom:150%;" />

NN = NameNode 主角色

DN = DataNode  从角色

SNN =  SecondaryNameNode 主角色辅助角色

 

**YARN集群**

![image-20230625151820669](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230625151820669.png)

RM=Resource Manager

NM=Node Manager



**Hadoop集群=HDFS集群+YARN集群**

MapReduce是计算框架，属于代码层面的组件



## Hadoop集群的安装



## HDFS系统

![image-20230625153926419](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230625153926419.png)

### 1.**主从架构**

HDFS集群是标准的master/slave主从架构集群

一般由一个Namenode和多个Datanode组成

### 2.分块存储

![image-20230625154240290](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230625154240290.png)

HDFS的文件在物理上是分块存储(block),默认大小是128M,不足128M则占本身大小。

块的大小，可通过hdfs-default.xml中：dfs.blocksize来修改

### 3.副本机制

所有block都会有副本。

副本参数由dfs.replication控制，默认值是3,计算副本时会计算本身 1+2=3

### 4.元数据管理

元数据相当于记录数据的数据，描述数据的数据，也可叫做”**解释性数据**“

### 5.namespace

![image-20230625162259785](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230625162259785.png)

### 6.数据块存储

文件的各个block的储存股管理由DataNode节点承担

每一个block都可以在多个DataNode上储存



## Hadoop集群安装配置



## Shell命令行

命令行界面 CLI (英语：command-line interface)

### 文件系统协议

  HDSF Shell CLI支持操作多种文件系统，包括本地文件系统(file:///),分布式文件系统(hdfs://nn:8020)等

  操作的系统取决于命令中的**url前缀协议**，未指定选取环境变量(**core-site.xml**)中fs.defaultFS属性，作为默认系统



### 常用操作

**hadoop fs -mkdir [-p] <path>** #创建一个文件夹 

  path 为到创建目录，-p 选项会沿着路径创建父目录



**hadoop fs -ls [-h] [-R] [<path>...]**

 path 指定目录路径

-h 人性化显示文件size

-R 递归查看指定目录以及其子目录



**hadoop fs -put [-f] [-p] <localsrc>... <dst>**

 -f 覆盖目标文件(已存在下)

 -p 保留访问和修改时间，所有权和权限

  localsrc 本地文件系统

  dst 目标文件系统(HDFS)



**hadoop fs -cat <src>...**



**hadoop fs -get [-f] [-p] <src>...<localsrc>**



**hadoop fs -cp [-f] <src>...<dst>**

​	-f 覆盖目标文件



**hadoop fs -appendToFile<localsrc>...<dst>**

​    讲所有给定本地文件的内容追加到给定dst文件。

​    dst如果文件不存在，将创建该文件。

​    如果<localSrc>为-,则输入为从标准输入中读取



**hadoop fs -mv<src>...<dst>**

​    移动文件,可以重命名文件



## HDFS 命令

### shell命令

hadoop fs -mkdir /itcast #创建一个文件夹

hadoop fs -put zookeeper.out /itcast #上传文件到指定的目录

hadoop fs -ls / #查看目录文件



### MapReduce+Yarn

在hadoop share/mapreduce中可以运行样例

hadoop jar [jarName] (params)



## 分布式文件系统的优点

分布式存储，容易扩展，没有上线

元数据记录，使用元数据记录数据存储信息，可以快速定位文件

分块存储，方便存放文件，并行处理提高文件处理速度

副本机制，冗余存储，保证文件安全



## HDFS角色

**主角色**

namenode,架构总的主角色，

维护管理文件系统元数据，包括空间目录树结构，文件和块位置信息，访问权限等信息



**从角色**

datanode,HDFS中的从角色，负责具体的数据块储存。

数量决定了HDFS集群的数据存储能力，和NameNode配合维护着数据块



**主角色辅助角色**

secondarynamenode

Seconday NameNode充当NameNode的辅助节点，但不能代替NameNode。

主要是帮助主角色进行元数据文件的合并动作。 



## HDFS写数据流程

### Pipeline管道

![image-20230626173749229](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230626173749229.png)

![image-20230626173906549](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230626173906549.png)

  

## Hadoop MapReduce官方示例

![image-20230626201817601](F:\markdownImg\image-20230626201817601.png)

## Map阶段执行过程

![image-20230626211436745](F:\markdownImg\image-20230626211436745.png)

![image-20230626211659221](F:\markdownImg\image-20230626211659221.png)

## Reduce阶段执行过程

主动从map中获取数据
