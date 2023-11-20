## HDFS读写流程

**写入**

1.客户端通过dfs模块，向NameNode发送上传文件请求，NameNode对要上传的文件进行检查，查看文件和父目录是否存在。可以上传返回消息，不能则返回异常

2.确认可以上传后，客户端向NameNode请求dataNode地址,NameNode返回服务器的dataNode服务器地址

3.客户端通过FSDataOutputStream模块，向第一个dataNode发送上传请求

4.第一个dataNode收到请求后回继续调用集群内的其他dataNode，建立通信管道

5.建立完成后，dataNode逐级向客户端返回应答信息。

6.收到应答后客户端向第一个dataNode上传block(从磁盘读取数据放到本地内存缓存),以packet(64kb)为单位进行传输，dataNode节点会依次进行packet的传输。传输时会将packet放入应答队列等待应答

7.当一个block传输完成后，客户端再次请求nameNode上传第二个block的服务器



**读取**

1.客户端通过dfs模块，向NameNode发起RPC（远程过程调用）请求获得文件的开始部分或全部block列表。通过block来获取所在的DataNode地址。如果客户端本身是个dataNode，则会从本地读取文件。

2.dfs会向客户端返回一个支持文件定位的输入流对象'FSDatainputStream',用于客户端读取数据，其中有一个DFSInputStream对象，用于管理dataNode和NameNode之间的 I/O.

3.客户端调用read()方法，DFSInputStream会找到离客户端最近的包含文件第一个block的dataNode并连接dataNode,随后在数据流中重复调用read()函数，直到这个block读取完毕。如果第一个block的数据读完了，就会关闭指向第一个block快的datanode的连接，接着读取下一个block块。

4.当第一批blocks读取完毕，DFSInputSteam会向NameNode请求下一批blocks的地址，继续读取，直到所有的blocks都被读取完，这是就会关闭所有的流.



## NameNode

​    充当管理员的角色，也是hdfs的元数据节点。集群中只能有一个active的NameNode对外提供服务。

   1.管理HDFS的命名空间（文件目录树):为用户提供与window和linux文件系统类似的目录结构

​    2.管理数据块(Block)映射信息及副本信息：一个文件对应的块的名字以及块的存储地址，和文件备份多少都是由NameNode来管理的

​    3.处理客户端的读写请求

## DataNode

​    充当成员的角色(slave).实际存储数据块的节点，NameNode下达命令，DataNode实行实际的操作。

​    1.存储实际的数据块

​    2.执行数据块的读/写操作。

## SceondaryNameNode的作用？和启动过程

SecondaryNameNode两个作用：

1.作为镜像备份

2.合并NameNode的edit logs 到fsimage文件中。(将日志与镜像定期合并)



启动过程

第一阶段：NameNode启动

1.第一次启动NameNode格式化后，创建fsimage和edits文件。如果不是第一次启动，直接加载编辑日志和镜像文件到内存

2.客户端对元数据进行增删改的请求

3.NameNode记录操作日志，更新滚动日志

4.NameNode在内存中对数据进行增删改查。



第二阶段：Secondary NameNode工作

1.Secondary NameNode询问NameNode是否需要checkpoint，从NameNode中带回请求结果

2.Secondary NameNode 请求执行checkpoint

3.NameNode滚动正在写的edits日志

4.将滚动前的编辑日志和镜像文件拷贝到Secondary NameNode。

5.Secondary NameNode 加载编辑日志和镜像文件到内存，并合并

6.生成新的镜像文件fsimage.

 chkpoint

7.拷贝fsimage.chkpoint到NameNode.

8.NameNode 将 fsimage.chkpoint 重新命名成fsimage		



## 集群安全模式？什么情况下会进入到安全模式？安全模式的解决方法

### 1.进入安全模式的情况

集群启动时必定会进入安全模式：

NameNode启动时，首先将映像文件(fsimage)载入内存，并执行编辑日志(edits)中的各项操作。一旦在内存中成功建立文件系统元数据的映像，则创建一个新的fsimage文件和一个空的编辑日志。此时，NameNode开始监听DataNode请求。但是此刻，NameNode运行在安全模式，即NameNode的文件系统对于客户端来说是只读的。

如果满足“最小副本条件”，NameNode会在30秒钟之后就退出安全模式。意思是在整个文件系统中99.9%的块满足最小副本级别（默认值：dfs.replication.min=1)。在启动一个刚刚格式化的HDFS集群时，因为系统中还没有任何块，所以NameNode不会进入安全模式。



### 2.异常情况下导致的安全模式

block确实有缺失，当NameNode发现集群中的block丢失数量达到一个阈值时，nameNode就进入安全模式状态，不再接受客户段的数据更新请求。

**解决方法**

1.调低阈值

hdfs.site.xml中

```xml
<name>dfs.namenode.safemode.threshold-pct</name>
<value>0.999f</value>
```

2.强制离开。

hdfs dfsadmin -safemode leave

3.重新格式化集群。

4.修复损坏的块文件

**基本语法**

集群处于安全模式，不能执行重要操作（写操作）。集群启动完成成功后，自动退出安全模式

1.hdfs dfsadmin -safemode get 查看安全模式状态

2--- enter 进入安全模式状态

3--- leave 离开安全模式状态

4.--- wait 等待安全模式状态



## 为什么HDFS不适合存小文件

​	HDFS天生就是为大文件而生的，一个块的元数据大叫大概在150字节左右，存储一个小文件就要占用NameNode 150字节的内存。如果存储大量的小文件很快就会将NameNode内存耗尽，而整个集群的数据量很小，失去了HDFS的意义，同时也会影响NameNode的寻址时间，导致寻址时间过长。

​	可以将数据合并上传，或者将文件append形式追加再HDFS文件末尾。



## HDFS支持的存储格式和压缩算法？

**1.存储格式**

------

(1)SequenceFile

以二进制键值对的形式存储数据，支持三种记录存储方式

- 无压缩：io效率较差，无优势
- 记录级压缩：对每条记录都压缩，压缩效率一般。
- 块级压缩：将指定块大小的二进制数据压缩为一个块

(2)Avro

​    将数据定义和数据一起存储在一条消息中，数据定义以JSON格式存储，数据以二进制格式存储。Avro标记用于将大型数据集分割成适合MapReduce处理的子集。

(3)RCFile

​    以列格式保存每个行组数据。将数据的列按照顺序转换为行。

（4）Parquet

​    是Hadoop的一种列存储格式，提供了高效的编码和压缩方案

**2.压缩算法**

------

**（1）Gzip压缩**

​	优点：压缩比率高，解压缩速度较快：hadoop本身支持。大部分linux系统自带gzip命令，使用方便

​	缺点：不支持split

​	应用场景：在每个文件压缩后在130M以内的（1个块大小内），都可以考虑用gzip压缩格式。程序无需任何修改

**(2)  Bzip2压缩**

​    优点：支持split；具有很高的压缩率，比gzip压缩率高；hadoop本身支持；linux系统自带bzip2命令。

​    缺点：解压缩速度慢，不支持native。

​    应用场景：适合对速度要求不高，但需要较高压缩率的场景，可以作为MapReduce作业的输出格式。

**(3)  Lzo压缩**

​    优点:解压缩速度较快，合理的压缩率；支持split，是hadoop中最流行的压缩格式，可以在linux系统中安装lzop命令。

​    缺点：压缩率比gzip要低一些，hadoop本身不支持，需要安装：在应用中lzo格式的文件需要做特殊处理(为支持spilt需要建立索引)

​    应用场景：一个很大的文本文件，压缩之后大于200M以上可以考虑，而且单个文件越大，lzo优点越明显。

**（4）Snappy压缩**

​    优点：高速压缩速度和合理的压缩率。

​    缺点：不支持split；压缩率比gzip低；hadoop本身不支持，需要安装；

​    应用场景：当MapReduce作业的Map输出的数据比较大的时候，作为Map到Reduce的中间数据的压缩格式；



## HDFS的可靠性策略

**1.文件完整性**

- 文件建立时，每个数据块都产生校验和，校验和会保存在.meta文件内
- 客户端获取数据时可以检查校验和是否相同，判断文件是否损坏
- 如读取的数据块损坏，则读取其他副本。NameNode会标记损坏块，然后复制备份block达到预期设置的文件备份数。
- DataNode在文件创建后三周验证其checksum

**2.网络或者机器失效时**

- 副本冗余
- 机架感知策略（副本防止策略）
- 心跳机制策略

**3.NameNode挂掉时**

- 主备切换（高可用）
- 镜像文件和操作日志磁盘存储
- 镜像文件和操作日志可多磁盘，多副本存储

**4.其他保障可靠机制**

- 快照（可以还原到某个时间点）
- 回收站机制
- 安全模式



## HDFS的优缺点

**1.HDFS优点**

**高容错：**数据自动保存多个副本，副本丢失后会自动恢复

**适合批处理**：移动计算而非数据，数据位置暴露给计算框架

**适合大数据处理**：GB，TB，甚至PB级数据，百万规模以上的文件数量，1000以上节点规模

**流式文件访问：**一次性写入，多次读取：保证数据一致性

**可构建在廉价机器上：**通过多副本提高可靠性，提供了容错和恢复机制。

**2.HDFS缺点**

**不适合低延迟数据访问：**比如毫秒级，低延迟与高吞吐率

**不适合小文件存取：**占用NameNode大量内存，寻道时间超过读取时间

**不适合并发写入,文件随机修改：**一个文件只能由一个写者，仅支持append



## MR的执行流程



**MR的整体执行流程：（Yarn流程）**

1.在MapReduce程序读取文件的输入目录上存放的相应的文件

2.客户端在submit（）方法执行前，获取待处理的数据信息然后根据集群中的参数的配置形成一个任务分配规划。

3.客户端提交切片信息给Yarn，Yarn中的Resourcemanager启动MRAPPmaster。

4.MRAPPmaster启动后根据本次job的描述信息，计算出需要的maptask实例对象，然后向集群申请机器启动相应数量的maptask进程。

5.Maptask利用客户端指定的inputformat来读取数据，形成输出的KV键值对

6.Maptask将输入KV键值对传递给客户定义的map（）方法，做逻辑运算。

7.Map()方法运算完毕后将KV对收集到maptask缓存。

8.shuffle阶段

1.   maptask收集map（）方法输出的KV对，放到环形缓存区中。
2.   maptask中的KV对按照k分区排序，并不断溢写到本地磁盘文件，可能会溢出多个文件。
3.   多个文件会被合并成大的溢出文件
4.   在溢写过程中，及合并过程中，都会不停的进行分区和针对key的排序操作
5.   Reducetask根据自己的分区号，去各个maptask机器上获取相应的结果分区数据。
6.   Reducetask会取到同一个分区的来自不同maptask的结果文件，reducetask会将这些文件在进行归并排序
7.   合并成大文件后，shuffle结束，进入reducetask的逻辑运算过程(从文件中一个一个取出键值对，调用用户自定义的reduce（）方法)

  9.MRAPPmaster监控到所有的maptask进程任务完成后，会根据客户指定的参数启动对应数量的reducetask进程，并告知reducetask进程要处理的数据分区

  10.reducetask进程启动后，根据MRAPPmaster告知的待处理数据所在位置，从若干台运行maptask的机器上获取若干个maptask输出结果文件，并在本地进行重新归并排序，

然后按照相同key的KV为一个组，调用客户定义的reduce（）方法进行逻辑运算

  11.reducetask运算完毕后，调用客户指定的outputformat将结果数据输出到外部。



## MapReduce有哪些关键类？mapper的方法有那些？setup方法是干嘛的？

### 1.关键类

- GenericOptionParser是为Hadoop框架解析命令行参数的工具类
- InputFormat接口，实现类包括FileInputformat，Composable inputformat等，主要用于文件输入和切割
- Mapper：将输入的kv对映射成中间数据kv对集合。通过maps转换
- Reducer：根据key将中间数据集合处理合并为更小的数据结果集
- Partitioner：对数据按照key进行分区
- OutputController：文件输出
- Combiner：本地聚合，本地化的reduce

### 2.mapper的方法有setup，map，cleanup，run

setup方法用于管理mapper生命周期中的资源，加载初始化工作，每个job执行一次，在map动作前执行

map方法：编写主要方法

cleanup方法：收尾工作，关闭文件或在map执行后的键值对分发等，每个job执行一次。

run方法：用来运行上边的方法，setup->map->cleanup



## 简述几条MapReduce的调优方法？

​    MapReduce优化方法主要从六个方面考虑：数据输入，Map阶段，Reduce阶段，IO传输，数据倾斜问题和常用的调优参数。

###   1.数据输入

  合并小文件，mr会在任务前将小文件进行合并，导致任务增多，增加装载次数，导致MR运行较慢

  采用combinetextinputformat来作为输入

###   2.Map阶段

  1.减少溢写次数，增大触发溢写的内存上限，减少溢写次数，减少磁盘IO

  2.减少合并次数，减少merge次数，缩短mr处理时间

  3.在map后，不影响业务逻辑的前提下，进行combine处理，减少io

###  3.Reduce阶段

  1.合理设置map和reduce的数量，少了处理不过来，多了会导致竞争资源

  2.设置map和reduce共存

  3.规避使用reduce，reduce连接数据集时会产生大量的网络消耗

  4.合理设置reduce端的buffer

##   4.IO传输

  1.采用数据压缩的方式，减少任务的IO时间；

  2.使用seq二进制文件
