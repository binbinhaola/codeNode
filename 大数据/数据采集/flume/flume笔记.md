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

2.删除lib目录下的guava工具包，兼容hadoop 3.1.3



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

**配置文件步骤：**

1.声明需要的sources，sinks，channels,设置agent的标识符

2.sources配置，定义类型，绑定ip和监听端口

3.sinks配置，定义类型，和输出的文件路径

4.channel配置，设置缓冲类型（内存，磁盘），设置channel总容量和事务的容量大小

5.绑定source 和 sink 到 channel上

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
bin/flume-ng agent -c conf/ -n a1 -f job/net-flume-logger.conf -Dflume.root.logger=INFO,console
```

 bin/flume-ng agent 启动agent

--name agent的名字

-c conf  指定flume的conf路径

-f 指定要启动的agent的配置文件

-Dflume.root.logger=INFO,console 把日志信息打印到控制台



## Flume监控本地文件上传HDFS

![image-20231126175500260](F:\markdownImg\image-20231126175500260.png)

```shell
# Name the components on this agent
a1.sources = r1 
a1.sinks = k1
a1.channels = c1

#Dscribe/configure the source
a1.sources.r1.type = exec
a1.sources.r1.command = tail -F /opt/hive/logs/hive.log

# Use a channel which buffers events in memory
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100

#Describe the sink
a1.sinks.k1.type = hdfs
a1.sinks.k1.hdfs.path = hdfs://node1:8020/flume/%Y%m%d/%H

#上传文件的前缀
a1.sinks.k1.hdfs.filePrefix = logs-

#三项配置控制多久生成新文件夹
#是否按照时间滚动文件夹
a1.sinks.k1.hdfs.round = true
#多少时间单位创建一个新的文件夹
a1.sinks.k1.hdfs.roundValue = 1
#重新定义时间单位
a1.sinks.k1.hdfs.roundUnit = hour


#是否使用本地时间戳(默认文件没有时间戳，必须加)
a1.sinks.k1.hdfs.useLocalTimeStamp = true
#积攒多少个Event才flush到HDFS一次
a1.sinks.k1.hdfs.batchSize = 100
#设置文件类型，可支持压缩
#CompressDStream支持压缩，需要配置参数codeC
a1.sinks.k1.hdfs.fileType = DataStream

#控制是否生成新文件
#多久生成一个新的文件
a1.sinks.k1.hdfs.rollInterval = 30 #时间为单位生成新文件
#设置每个文件的滚动大小
a1.sinks.k1.hdfs.rollSize = 134217700 #大小为单位生成新文件
#文件滚动于Event数量无关
a1.sinks.k1.hdfs.rollCount = 0	#Event数量为单位生成新文件

#Bind the source and sink to the channel
a1.sources.r1.channels = c1
a1.sinks.k1.channel = c1

```



## 实时监控目录下多个新文件

![image-20231126193810992](F:\markdownImg\image-20231126193810992.png)

```shell
# Name the components on this agent
a1.sources = r1 
a1.sinks = k1
a1.channels = c1

# Describe/configure the source
a1.sources.r1.type = spooldir
a1.sources.r1.spoolDir = /opt/flume/upload
a1.sources.r1.fileSuffix = .COMPLETED
a1.sources.r1.fileHeader = true
#忽略所有以.tmp结尾的文件
a1.sources.r1.ignorePattern = ([^ ]*\.tmp)

# Use a channel which buffers events in memory
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100

#Describe the sink
a1.sinks.k1.type = hdfs
a1.sinks.k1.hdfs.path = hdfs://node1:8020/flume/upload/%Y%m%d/%H
#上传文件的前缀
a1.sinks.k1.hdfs.filePrefix = upload-
#是否按照时间滚动文件夹
a1.sinks.k1.hdfs.round = true
#多少时间单位创建一个新的文件夹
a1.sinks.k1.hdfs.roundValue = 1
#重新定义时间单位
a1.sinks.k1.hdfs.roundUnit = hour
#是否使用本地时间戳
a1.sinks.k1.hdfs.useLocalTimeStamp = true
#积攒多少个Event才flush到HDFS一次
a1.sinks.k1.hdfs.batchSize = 100
#设置文件类型，可支持压缩
a1.sinks.k1.hdfs.fileType = DataStream
#多久生成一个新的文件
a1.sinks.k1.hdfs.rollInterval = 60
#设置每个文件的滚动大小
a1.sinks.k1.hdfs.rollSize = 134217700
#文件滚动于Event数量无关
a1.sinks.k1.hdfs.rollCount = 0

#Bind the source and sink to the channel
a1.sources.r1.channels = c1
a1.sinks.k1.channel = c1

```

**注意事项：**

1.正则表达式已忽略的后缀，和设定好上传完成的文件的后缀的文件不会被收集

2.不能出现同名文件如1.txt和1.COMPELETE,系统原因不允许文件重名，将会导致任务挂掉



## 动态监控多目录多文件

Taildir Source：支持断点续传，还支持动态监控功能

```shell
#Name the components on this agent
a1.sources = r1
a1.sinks = k1
a1.channels = c1

# Describe/configure the source
a1.sources.r1.type = TAILDIR
a1.sources.r1.positionFile = /opt/flume/tail_dir.json
a1.sources.r1.filegroups = f1 f2
a1.sources.r1.filegroups.f1 = /opt/flume/files1/.*file.*
a1.sources.r1.filegroups.f2 = /opt/flume/files2/.*log.*

# Use a channel which buffers events in memory
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100

#Describe the sink
a1.sinks.k1.type = hdfs
a1.sinks.k1.hdfs.path = hdfs://node1:8020/flume/upload2/%Y%m%d/%H
#上传文件的前缀
a1.sinks.k1.hdfs.filePrefix = upload-
#是否按照时间滚动文件夹
a1.sinks.k1.hdfs.round = true
#多少时间单位创建一个新的文件夹
a1.sinks.k1.hdfs.roundValue = 1
#重新定义时间单位
a1.sinks.k1.hdfs.roundUnit = hour
#是否使用本地时间戳
a1.sinks.k1.hdfs.useLocalTimeStamp = true
#积攒多少个Event才flush到HDFS一次
a1.sinks.k1.hdfs.batchSize = 100
#设置文件类型，可支持压缩
a1.sinks.k1.hdfs.fileType = DataStream
#多久生成一个新的文件
a1.sinks.k1.hdfs.rollInterval = 60
#设置每个文件的滚动大小
a1.sinks.k1.hdfs.rollSize = 134217700
#文件滚动于Event数量无关
a1.sinks.k1.hdfs.rollCount = 0

#Bind the source and sink to the channel
a1.sources.r1.channels = c1
a1.sinks.k1.channel = c1

```

**tail_dir.json数据保存格式**

靠inode（文件唯一标识码）和文件绝对路径来进行断点续传

但是如果日志文件修改名称后，会导致该文件被重复上传，所以需要修改源码只根据“inode”来进行判断

![image-20231126215305242](F:\markdownImg\image-20231126215305242.png)



# Flume进阶



## 事务

![image-20231127094548337](F:\markdownImg\image-20231127094548337.png)

## 内部原理

![image-20231127094603374](F:\markdownImg\image-20231127094603374.png)



## 拓扑结构

![image-20231127094619894](F:\markdownImg\image-20231127094619894.png)

![image-20231127094632944](F:\markdownImg\image-20231127094632944.png)

![image-20231127094641315](F:\markdownImg\image-20231127094641315.png)

![image-20231127094649156](F:\markdownImg\image-20231127094649156.png)



# Flume开发案列



## 复制和多路复用

哪方接受数据，哪方就是服务端

**向多端发送文件副本**



![image-20231127102650284](F:\markdownImg\image-20231127102650284.png)

**配置文件**

**客户端：**发送数据

sink数至少需要登录channel数

本次需要像hdfs和本地存储文件，所以设定了两条channel，发送两个服务器端数据

```shell
# Name the components on this agent
a1.sources = r1
a1.sinks = k1 k2
a1.channels = c1 c2

# 将数据流复制给所有 channel
a1.sources.r1.selector.type = replicating

# Describe/configure the source
a1.sources.r1.type = exec
a1.sources.r1.command = tail -F /opt/hive/logs/hive.log
a1.sources.r1.shell = /bin/bash -c

# Describe the sink
# sink 端的 avro 是一个数据发送者
a1.sinks.k1.type = avro
a1.sinks.k1.hostname = node1
a1.sinks.k1.port = 4141

a1.sinks.k2.type = avro
a1.sinks.k2.hostname = node1 #ip地址，此次都是同一服务器
a1.sinks.k2.port = 4142
# Describe the channel
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100
a1.channels.c2.type = memory
a1.channels.c2.capacity = 1000
a1.channels.c2.transactionCapacity = 100
# Bind the source and sink to the channel
a1.sources.r1.channels = c1 c2
a1.sinks.k1.channel = c1
a1.sinks.k2.channel = c2

```



**服务器端：**接受数据

flume to hdfs

```shell
#Name the components on this agent
a2.sources = r1
a2.sinks = k1
a2.channels = c1

# Describe/configure the source
# source 端的 avro 是一个数据接收服务
a2.sources.r1.type = avro
a2.sources.r1.bind = node1
a2.sources.r1.port = 4141

# Describe the sink
a2.sinks.k1.type = hdfs
a2.sinks.k1.hdfs.path = hdfs://node1:8020/flume2/%Y%m%d/%H

#上传文件的前缀
a2.sinks.k1.hdfs.filePrefix = flume2-
#是否按照时间滚动文件夹
a2.sinks.k1.hdfs.round = true
#多少时间单位创建一个新的文件夹
a2.sinks.k1.hdfs.roundValue = 1
#重新定义时间单位
a2.sinks.k1.hdfs.roundUnit = hour
#是否使用本地时间戳
a2.sinks.k1.hdfs.useLocalTimeStamp = true
#积攒多少个 Event 才 flush 到 HDFS 一次
a2.sinks.k1.hdfs.batchSize = 100
#设置文件类型，可支持压缩
a2.sinks.k1.hdfs.fileType = DataStream
#多久生成一个新的文件
a2.sinks.k1.hdfs.rollInterval = 30
#设置每个文件的滚动大小大概是 128M
a2.sinks.k1.hdfs.rollSize = 134217700
#文件的滚动与 Event 数量无关
a2.sinks.k1.hdfs.rollCount = 0
# Describe the channel
a2.channels.c1.type = memory
a2.channels.c1.capacity = 1000
a2.channels.c1.transactionCapacity = 100
# Bind the source and sink to the channel
a2.sources.r1.channels = c1
a2.sinks.k1.channel = c1

```

flume to file

```shell
# Name the components on this agent
a3.sources = r1
a3.sinks = k1
a3.channels = c2
# Describe/configure the source
a3.sources.r1.type = avro
a3.sources.r1.bind = node1	#接受端服务器ip地址
a3.sources.r1.port = 4142
# Describe the sink
a3.sinks.k1.type = file_roll
a3.sinks.k1.sink.directory = /opt/data/flume3
# Describe the channel
a3.channels.c2.type = memory
a3.channels.c2.capacity = 1000
a3.channels.c2.transactionCapacity = 100
# Bind the source and sink to the channel
a3.sources.r1.channels = c2
a3.sinks.k1.channel = c2

```



## 负载均衡和故障转移

使用flume1 监控一个端口，其sink组中的sink分别对接flume2 和 flume3，采用FailoverSinkProcessor，实现故障转移的功能

![image-20231127120033317](F:\markdownImg\image-20231127120033317.png)

在正常情况下，只有优先级最高的agent才会进行抓取，其他节点不做动作

**客户端配置**

需要sinkgroups来为sink做分配规则

```shell
# Name the components on this agent
a1.sources = r1
a1.channels = c1
a1.sinkgroups = g1
a1.sinks = k1 k2
# Describe/configure the source
a1.sources.r1.type = netcat
a1.sources.r1.bind = localhost
a1.sources.r1.port = 44444
a1.sinkgroups.g1.processor.type = failover
a1.sinkgroups.g1.processor.priority.k1 = 5	#每个sink的规则
a1.sinkgroups.g1.processor.priority.k2 = 10
a1.sinkgroups.g1.processor.maxpenalty = 10000
# Describe the sink
a1.sinks.k1.type = avro
a1.sinks.k1.hostname = node1
a1.sinks.k1.port = 4141

a1.sinks.k2.type = avro
a1.sinks.k2.hostname = node1
a1.sinks.k2.port = 4142
# Describe the channel
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100
# Bind the source and sink to the channel
a1.sources.r1.channels = c1
a1.sinkgroups.g1.sinks = k1 k2
a1.sinks.k1.channel = c1
a1.sinks.k2.channel = c1

```



**服务器端配置**

```shell
# Name the components on this agent
a2.sources = r1
a2.sinks = k1
a2.channels = c1
# Describe/configure the source
a2.sources.r1.type = avro
a2.sources.r1.bind = node1
a2.sources.r1.port = 4141
# Describe the sink
a2.sinks.k1.type = logger
# Describe the channel
a2.channels.c1.type = memory
a2.channels.c1.capacity = 1000
a2.channels.c1.transactionCapacity = 100
# Bind the source and sink to the channel
a2.sources.r1.channels = c1
a2.sinks.k1.channel = c1

```



### 负载均衡

只需要将客户端的failover 更改去掉权重配置即可，

服务端无需改动

```shell
a1.sinkgroups.g1.processor.type = load_balance
```

**负载轮询机制：**指的是sink轮流拉取数据，所以可能导致一个sink一段时间内接受不到数据的现象





## Flume聚合

客户端配置avro类型sink，并将ip改为服务端ip

![image-20231127164150691](F:\markdownImg\image-20231127164150691.png)

服务器端source配置avro类型，并监听本机的对应端口

![image-20231127164230683](F:\markdownImg\image-20231127164230683.png)



## 自定义拦截器

### Multiplexing Channel Selector

```shell
a1.sources = r1
a1.channels = c1 c2 c3 c4
a1.sources.r1.selector.type = multiplexing	#原则器类型
a1.sources.r1.selector.header = state	#取表头的key
a1.sources.r1.selector.mapping.CZ = c1	#（k，v）的值，放在对应的channel
a1.sources.r1.selector.mapping.US = c2 c3
a1.sources.r1.selector.default = c4		#匹配不到用默认值
```

