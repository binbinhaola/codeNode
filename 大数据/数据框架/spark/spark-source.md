# 环境准备



## SparkSubmit



# 通信原理

spark通信框架：Netty（AIO）

BIO：阻塞时IO

NIO：非阻塞式IO

AIO：异步非阻塞式IO

Linux对AIO支持不够好，Windows支持较好

Linux采用Epoll方式模仿AIO操作



# SparkContext

![image-20231123192924998](F:\markdownImg\image-20231123192924998.png)



## RDD依赖

rdd 之间的依赖

![image-20231123193632073](F:\markdownImg\image-20231123193632073.png)



## 阶级的划分

以shuffle依赖，来划分阶段,数量为shuffle数量+1

task数量为每个\阶段最后RDD的分区数量

![image-20231123200330677](F:\markdownImg\image-20231123200330677.png)



## 任务的调度

任务的默认调度规则式：FIFO

Task被包装在TaskSet中，TaskSet包装在TaskSetManger中

<img src="F:\markdownImg\image-20231123203200198.png" alt="image-20231123203200198" style="zoom: 67%;" />

放入任务池中

![image-20231123203321757](F:\markdownImg\image-20231123203321757.png)



![image-20231123202800947](F:\markdownImg\image-20231123202800947.png)

计算和数据的位置存在不同的级别，这个级别称之为本地化级别

![image-20231123202937093](F:\markdownImg\image-20231123202937093.png)

**进程本地化**：数据和计算在同一个进程中

**节点本地化：**数据和计算在同一个节点中

**机架本地化**：数据和计算在同一个机架中

**任意**



p144
