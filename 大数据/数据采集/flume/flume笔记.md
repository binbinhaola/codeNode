# Flume概述



## 1.1 Flume定义

  flume是cloudera提供的一个高可用，高可靠，分布式的海量日志采集，聚合和传输的系统。基于流式架构，灵活简单

![image-20231007211048561](F:\markdownImg\image-20231007211048561.png)

flume可以对接多个数据源和目的地，并且可以实时读取数据，将数据写入到hdfs中



## 1.2 Flume基础架构

![image-20231007211456899](F:\markdownImg\image-20231007211456899.png)

### 1.2.1 Agent

​	Agent是一个JVM进程，它以事件的形式将数据从源头送至目的，是Flume数据传输的基本单元。

Agent主要有3个部分组成，Source、Channel、Sink。

### 1.2.2 Source

​	Source是负责接收数据到Flume Agent的组件。Source组件可以处理各种类型、各种格式的日志数据，包括avro、thrift、exec、jms、spooling directory、netcat、sequence generator、syslog、http、legacy。

### 1.2.3 Channel

​	Channel是位于Source和Sink之间的缓冲区。因此，Channel允许Source和Sink运作在不同的速率上。Channel是线程安全的，可以同时处理几个Source的写入操作和几个Sink的读取操作。

Flume自带两种Channel：Memory Channel和File Channel。

​	Memory Channel是内存中的队列。Memory Channel在不需要关心数据丢失的情景下适用。如果需要关心数据丢失，那么Memory Channel就不应该使用，因为程序死亡、机器宕机或者重启都会导致数据丢失。

File Channel将所有事件写到磁盘。因此在程序关闭或机器宕机的情况下不会丢失数据。

### 1.2.4 Sink

​	Sink不断地轮询Channel中的事件且批量地移除它们，并将这些事件批量写入到存储或索引系统、或者被发送到另一个Flume Agent。

​	Sink是完全事务性的。在从Channel批量删除数据之前，每个Sink用Channel启动一个事务。批量事件一旦成功写出到存储系统或下一个Flume Agent，Sink就利用Channel提交事务。事务一旦被提交，该Channel从自己的内部缓冲区删除事件。

​	Sink组件目的地包括hdfs、logger、avro、thrift、ipc、file、null、HBase、solr、自定义。

### 1.2.5 Event

​	传输单元，Flume数据传输的基本单元，以Event的形式将数据从源头送至目的地。

Event由Header和Body两部分组成，Header用来存放该event的一些属性，为K-V结构，
Body用来存放该条数据，形式为字节数组。

![image-20231007211927074](F:\markdownImg\image-20231007211927074.png)



# Flume入门

## 2.1 Flume安装部署

1.下载bin包,解压改名

2.删除bin目录下的guava工具包，兼容hadoop 3.1.3



## 2.2 实现官方入门示例

ncat轻量级的通讯工具 可以监听服务器端口，像端口接受或者发送信息

| 命令           | 效果                 |
| -------------- | -------------------- |
| nc -lk portNum | 在指定端口开启服务   |
| nc ip port     | 监听指定ip地址的端口 |
|                |                      |

### flume配置

1.建立"job"文件夹

2.新建文件"net-flume-logger.conf" （根据resource 和 sink 的类型来命名)

```sh
# example.conf: A single-node Flume configuration

# Name the components on this agent
a1.sources = r1 
a1.sinks = k1
a1.channels = c1

# Describe/configure the source
a1.sources.r1.type = netcat
a1.sources.r1.bind = localhost
a1.sources.r1.port = 44444

# Describe the sink
a1.sinks.k1.type = logger

# Use a channel which buffers events in memory
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000  #chanels的容量
a1.channels.c1.transactionCapacity = 100 #事务的容量

# Bind the source and sink to the channel
a1.sources.r1.channels = c1 #source 绑定多个channel
a1.sinks.k1.channel = c1  #sinks只能绑定一个channel

#a1为agent名称
```



### Flume1.10及以上版本实现控制台打印输出

![image-20231007225117723](F:\markdownImg\image-20231007225117723.png)

**重新运行flume监听端口的案例**

```
$ flume-ng agent -c conf/ -n a1 -f job/flume-netcat-logger.conf -Dflume.root.logger=INFO,console
```

 bin/flume-ng agent 启动agent

--name agent的名字

-c conf  指定flume的conf路径

-f 指定要启动的agent的配置文件

-Dflume.root.logger=INFO,console 把日志信息打印到控制台



进度:p8
