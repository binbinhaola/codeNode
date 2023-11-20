# Spark概述

spark是一种**基于内存**的快速、通用、可拓展的大数据分析引擎



## spark核心模块

![image-20231113154312042](F:\markdownImg\image-20231113154312042.png)

![image-20231113154334175](F:\markdownImg\image-20231113154334175.png)

**Spark Core**

​	提供了Spark最基础，最核心的功能。其他模块都是基于Spark Core进行的扩展

**Spark SQL**

​	是Spark用来操作结构化数据的组件，通过Spark SQL,用户可以使用SQL或HQL来查询数据

**Spark Streaming**

​	是Spark平台上针对实时数据进行流式计算的组件，提供了丰富的处理数据流API

**Spark MLlib**

​	Spark提供的一个机器学习算法库

**Spark GraphX**

​	面向图形计算挖掘的一个库



# Spark-WordCount案例

添加Spark-core依赖

```xml
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-core_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>
```

**基本配置**

```scala
    //TODO  建立和Spark框架的连接
    val sparConf = new SparkConf().setMaster("local").setAppName("WordCount") //spark配置
    val sc = new SparkContext(sparConf) //spark操作主题
```

**实现**

```scala
    //Application
    //Spark框架
    //TODO  建立和Spark框架的连接
    val sparConf = new SparkConf().setMaster("local").setAppName("WordCount")
    val sc = new SparkContext(sparConf)

    //TODO  执行业务操作

    //1.读取文件,获取一行一行的数据
    // hello world
    val lines:RDD[String] = sc.textFile("datas")

    //2.将一行数据进行拆分，形成一个一个的单词(分词)
    // 扁平化：将整体拆分成个体的操作
    // "hello world" => hello,world,hello,world
    val words = lines.flatMap(_.split(" "))


    //3.将数据根据单词进行分组，便于统计
    // (hello,hello,hello),(world,world)
    val wordGroup = words.groupBy(word => word)

    //4.对分组后的数据进行转换
    // (hello,hello,hello),(world,world)
    // (hello,3),(world,2)
    val wordToCount = wordGroup.map{
      case(word,list)=>{
        (word,list.size)
      }
    }

    //5.将转换结果采集到控制台打印出来
    val array = wordToCount.collect()
    array.foreach(println)

    //TODO  关闭连接
    sc.stop()
```

**实现2**

```scala
//3.将数据根据单词进行分组，便于统计
val mapToOne = words.map((_,1)).groupBy(_._1) //将每个词以元组(word,1)的形式保存(打标）,然后通过词分组

//4.对分组后的数据进行转换
//使用map,对格式(hello,Iterator(Heelo,1))进行匹配 
//(Hello,Iterator(Hello,1)) 迭代其中有多个(Hello,1)
//将Iterator的元素，进行reduce,返回一个元组(Hello,sum)
//最后将元组作为map后的值进行返回
    val wordToCount = mapToOne.map{
      case(word,list)=>{
        list.reduce(
          (t1,t2)=>{
            (t1._1,t1._2+t2._2)
          }
        )
      }
    }
```

**Spark方法实现相同效果**

```scala
    //Spark框架提供了更多的功能，可以将分组和聚合使用一个方法实现
    //reduceByKey:相同的key的数据，可以对value进行reduce聚合
    val list = wordToOne.reduceByKey(_ + _)
```



# Spark运行环境



## Standalone模式

![image-20231113193333672](F:\markdownImg\image-20231113193333672.png)

### 集群的配置

![image-20231113195930495](F:\markdownImg\image-20231113195930495.png)

注：1.各节点需要scala环境来运行spark

2.使用scp -r 执行分发文件



**进行jar引用的运行**

```shell
bin/spark-submit \
--class org.apache.spark.examples.SparkPi \
--master spark://linux1:7077 \
./examples/jars/spark-examples_2.12-3.0.0.jar \
10

## --class 表示要执行程序的主类
## --master spark://node:7077 独立部署模式，连接到spark集群
## spark-examples_2.12-3.0.0.jar 运行类所在jar包
## 10表示程序入口参数
```



**配置历史服务**

![image-20231113201034904](F:\markdownImg\image-20231113201034904.png)

**配置高可用**

​	所谓的高可用是因为当前集群中的 Master 节点只有一个，所以会存在单点故障问题。所以 为了解决单点故障问题，需要在集群中配置多个 Master 节点，一旦处于活动状态的 Master 发生故障时，由备用 Master 提供服务，保证作业可以继续执行。这里的高可用一般采用 Zookeeper 设置



## Window模式

解压，然后运行spark-shell.cmd



## 部署模式对比

![image-20231113204153925](F:\markdownImg\image-20231113204153925.png)



# Spark运行架构

Spark框架的核心是一个计算引擎，整体来说，它采用了标准master-slave的结构

![image-20231113213830558](F:\markdownImg\image-20231113213830558.png)

### **Driver**

将用户程序转化为作业（job） 

在 Executor 之间调度任务(task) 

跟踪 Executor 的执行情况 

通过 UI 展示查询运行情况



###  Executor

​	Spark Executor 是集群中工作节点（Worker）中的一个 JVM 进程，负责在 Spark 作业 中运行具体任务（Task），任务彼此之间相互独立

​	**Executor 有两个核心功能：** 

​	负责运行组成 Spark 应用的任务，并将结果返回给驱动器进程 

​	它们通过自身的块管理器（Block Manager）为用户程序中要求缓存的 RDD 提供内存 式存储。RDD 是直接缓存在 Executor 进程内的，因此任务可以在运行时充分利用缓存 数据加速运算。



![image-20231113214107981](F:\markdownImg\image-20231113214107981.png)



# Spark核心编程

​	spark计算框架为了能够进行高并发和高吞吐的数据处理，封装了三大数据结构，用于处理不同的应用场景，

RDD：弹性分布式数据集

累加器：分布式共享只写变量

广播变量：反不是共享只读变量



## RDD

Resilient Distributed Dataset(弹性分布式数据集)，spark中最基本，最小的处理模型

在程序中有不止一个RDD，复杂的逻辑需要将多个RDD关联在一起



```scala
val lines:RDD[String] = sc.textFile("datas")
val words:RDD[String] = lines.flatMap(_.split(" "))
val wordToOne = words.map((_,1))
val wordToSum = wordToOne.reduceByKey(_+_) 
val array:Array[String,Int] = wordToSum.collect()
```

![image-20231116103403498](F:\markdownImg\image-20231116103403498.png)

RDD的数据处理方式类似于IO流,也有装饰者模式,只有调用collect方法时，才会真正执行业务逻辑操作，之前的封装都是功能的扩展

![image-20231116110035524](F:\markdownImg\image-20231116110035524.png)



### 五大配置

![image-20231116111131373](F:\markdownImg\image-20231116111131373.png)

**1.分区列表**

RDD数据结构总存在分区列表，用于执行任务时并行计算，是实现分布式计算的重要属性

**2.分区计算函数**

Spark在计算时，是使用分区函数对每一个分区进行计算

**3.RDD之间的依赖关系**

RDD是计算模型的封装，当需求中需要将多个计算模型进行组合时i，就需要将多个RDD建立依赖关系

**4.分区器**

数据分区靠分区器

**5.首选位置**

选择运算效率最高的节点

### 执行原理

1.启动Yarn集群环境

![image-20231116111758059](F:\markdownImg\image-20231116111758059.png)

2.Spark通过申请资源创建调度节点和计算节点

![image-20231116111834114](F:\markdownImg\image-20231116111834114.png)

3.Spark框架根据需求，将计算逻辑根据分区划分成不同的任务

![image-20231116111947066](F:\markdownImg\image-20231116111947066.png)

4.调度节点将任务根据计算节点状态发送到对应的计算节点进行计算

![image-20231116112023701](F:\markdownImg\image-20231116112023701.png)



### RDD-创建-内存

```scala
    //TODO 准备环境
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("RDD")
    val sc = new SparkContext(sparkConf)

    //TODO 创建RDD
    //从内存中创建RDD，将内存中的集合的数据作为处理的处理预案
    val seq = Seq[Int](1,2,3,4)

    //parallelize:并行
    //val rdd:RDD[Int] = sc.parallelize(seq)
    //底层是现实时其实调用了rdd对象的parallelize方法
    val rdd = sc.makeRDD(seq)

    rdd.collect().foreach(println)

    //TODO 关闭环境
    sc.stop()
```



### RDD-创建-外部储存

读取硬盘上的文件

```scala
  def main(args: Array[String]): Unit = {

    //TODO 准备环境
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("RDD")
    val sc = new SparkContext(sparkConf)

    //TODO 创建RDD
    //从文件中创建RDD，将文件中的集合的数据作为处理的处理预案
    //path路径默认以当前环境的根路径为基准，可以写绝对路径，也可以写相对路径
    //val rdd:RDD[String] = sc.textFile("datas/1.txt")
    //path路径可以是文件路径，也可以目录名称
    //val rdd:RDD[String] = sc.textFile("datas")
    //path路径还可以使用通配符‘*’
    //val rdd = sc.textFile("datas/2*.txt")
    //path还可以是分布式存储系统路径：HDFS
    val rdd = sc.textFile("hdfs://node1;8020/datas/text.txt")

    rdd.collect().foreach(println)

    //TODO 关闭环境
    sc.stop()
  }
```

```scala
//textFile:以行为单位来读取数据
//wholeTextFiles：以文件为的单位读取数据
val rdd= sc.wholeTextFiles("datas")
```



### RDD并行度和分区

分区和并行数有关

**内存创建RDD**

```scala
    //TODO 准备环境
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("RDD")
    val sc = new SparkContext(sparkConf)

    //TODO 创建RDD
    //RDD的并行度 & 分区
    //makeRDD方法可以传入第二个参数，这个参数表示分区的数量
    //分区参数可以不传递，会使用默认值: defaultParallelism(默认值)
    /*
    override def defaultParallelism(): Int =
      scheduler.conf.getInt("spark.default.parallelism", totalCores)
     */
     //spark在默认情况下，从配置对象中获取配置参数：spark.default.parallelism
     //如果获取不到，那么使用totalCores属性，这个属性取当前运行环境最大可用核数
    val rdd = sc.makeRDD(
      List(1, 2, 3, 4)
    )

    //将处理的数据保存成分区文件
    rdd.saveAsTextFile("output")

    //TODO 关闭环境
    sc.stop()
  }
```



**文件创建RDD**

```scala
    //TODO 准备环境
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("RDD")
    val sc = new SparkContext(sparkConf)

    //TODO 创建RDD
    //textFile可以将文件作为数据处理的数据原，默认也可以设定分区
    //minPartitions:最小分区数量
    //math.min(defaultParallelism,2)
    //spark读取文件，底层其实使用的是Hadoop的读取方式
    //分区数量的计算方式:
    // totalSize = 7
    // goalSize =  7/2 = 3(byte)
    // 7/3 = 2...1 (1.1) + 1 =3(分区)
    val rdd = sc.textFile("hdfs://node1;8020/datas/text.txt",2)

    rdd.collect().foreach(println)

    //TODO 关闭环境
    sc.stop()
```



#### 分区数据的分配

**内存RDD获取每个分区的元素数量**

![image-20231116170319782](F:\markdownImg\image-20231116170319782.png)

获取数据

![image-20231116170420642](F:\markdownImg\image-20231116170420642.png)



**文件RDD获取每个分区的元素数量**

1.首先注意偏移量

2.只要一行被读到数据，spark就会将一行数据读完(hadoop的机制)

```scala
    //TODO 创建RDD
    //TODO 数据分区的分配
    //1.数据以行为单位进行读取
    //    spark读取文件，采用的是hadoop的方式读取，所以一行一行读取，和字节数没有关系
    //2.数据读取时以偏移量为单位,偏移量不会被重复读取
    /*	文件数据
        1@@ =>012
        2@@ =>345
        3   =>6
     */
     //3.数据分区的偏移量范围的计算
     //0 => [0, 3]  =>12
     //1 => [3, 6]  =>3
     //2 => [6, 7]  =>()
```



## 算子

 RDD方法 => RDD算子

![image-20231117203844630](F:\markdownImg\image-20231117203844630.png)



### 转换算子

#### 分区不变

经过转换算子计算后，分区内的数据位置不会变化

![image-20231120090731964](F:\markdownImg\image-20231120090731964.png)

#### Map

**通过分割字符串的方法，取出特定字段**

![image-20231117212810689](F:\markdownImg\image-20231117212810689.png)

```scala
    //TODO 算子——map
    val rdd = sc.textFile("datas/apache.log")
    
    //长的字符串
    //转换为
    //短的字符串
    val link = rdd.map(_.split(" ")(6))

    link.collect().foreach(println)
```

**Map的并行运算**

```scala
    //TODO 算子——map
    //1.rdd的计算一个分区内的数据是一个一个执行的
    // 只有前面一个数据的全部逻辑执行完毕后，才会执行下一个数
    // 分区内数据的执行是有序的
    //2.不同分区的数据执行是无序的
    val rdd = sc.makeRDD(List(1,2,3,4),2)

    val mapRDD = rdd.map(num => {
      println(">>>>>>> =" + num); num
    })

    val mapRDD1 = mapRDD.map(num => {
      println("######## =" + num); num
    })

    mapRDD1.collect()

```



#### MapPartitions

程序结束了才会释放内存

```scala
    //TODO 算子——maPartions
    val rdd = sc.makeRDD(List(1, 2, 3, 4), 2)

    //mapPartitions:可以以分区为单位进行数据转换操作
    //              但是会将整个分区的数据加载到内存进行引用
    //              如果处理完的数据是不会被释放掉，存在对象的引用
    //              仔内存较小，数据量较大的场合下，容易出现内存溢出
    val mapRDD = rdd.mapPartitions(
      iter => {
        println(">>>>>>>>.")
        iter.map(_ * 2)
      }
    )

    mapRDD.collect().foreach(println)

    sc.stop()
```

求每个分区数据的最大值

```scala
    //TODO 算子——maPartions
    val rdd = sc.makeRDD(List(1, 2, 3, 4), 2)

    //[1,2],[3,4]
    val mmpRdd = rdd.mapPartitions(iter => List(iter.max).iterator)
    mmpRdd.collect().foreach(println)
```



#### mapValues

在不动key的情况下，对值进行操作



#### map & mapPartitoin的区别

map分区内一个数据一个数据的执行，类似于串行。对数据进行转换和改变，不改变数据量

mappartition以分区为单位进行批处理操作。返回迭代器，可以修改数据量



#### mapPartitionsWithIndex

获取分区编号和数据

```scala
    val rdd = sc.makeRDD(List(1, 2, 3, 4), 2)

    val value = rdd.mapPartitionsWithIndex(
      (index, iter) => {
        if (index == 1) iter else Nil.iterator
      }
    )
```



#### flatMap

```scala
    //TODO 算子——flatMap
    val rdd:RDD[String] = sc.makeRDD(List("Hello World","Hello Scala"))

    val value = rdd.flatMap(list=>list.split(" ")) //返回一个可迭代的集合
```

```scala
    //TODO 算子——flatMap
    val rdd:RDD[Any] = sc.makeRDD(List(List(1,2),3,List(1,2)))

    val value = rdd.flatMap { //使用偏函数来处理不同类型的数据
      case list: List[_] => list
      case data => List(data)
    }
```



#### **glom**

将同一个分区的数据直接转换为相同类型的内存数组进行处理，分区不变

```scala
    //TODO 算子——glom
    val rdd = sc.makeRDD(List(1, 2, 3, 4), 2)

    val value = rdd.glom() //Array(1,2),Array(3,4) 将分区数据变成数组
```



#### groupBy

会将数据打乱，重新组合，这个操作称之为shuffle

```scala
    //TODO 算子——groupBy
    val rdd = sc.makeRDD(List(1, 2, 3, 4), 2)

    //groupBy会将数据源中的每一个数据进行分组判断，根据返回的分组key进行分组
    //相同的key值的数据会放置在一个组中
    val value:RDD[(Int,Iterable[Int])] = rdd.groupBy(_ % 2)

    value.collect().foreach(println)
```

```scala
    //TODO 算子——groupBy
    val rdd = sc.makeRDD(List("Hello","Spark","Scala","Hadoop"), 2)

    //分组和分区没有必然的关系
    val value = rdd.groupBy(_.charAt(0))

    value.collect().foreach(println)
```

一个组的数据会放在一个分区中，但一个分区中不只有一个组的数据

![image-20231120092253549](F:\markdownImg\image-20231120092253549.png)



#### Filter

​	根据指定的规则进行筛选过滤，数据筛选过后分区不变，但分区内数据可能不均很，生产环境下可能会出现**数据倾斜**



#### Sample

用于抽数据来做判断

```scala
    //TODO 算子——Sample
    val rdd = sc.makeRDD(List(1,2,3,4,5,6,7,8,9,10))

    //sample算子需要传输三个参数
    //1.第一个参数表示，抽取数据后是否将数据返回true(放回),false(丢弃)
    //2.第二个参数表示，不放回： 数据源中每条数据被抽取的概率，基准值的概念（相当于每个数据被选出来的概率)
    //               放回：  表示数据源每条数据被抽取的可能次数
    //3.第三个参数表示，抽取数据时随机算法的种子
    //                不提供就使用系统时间
    println(rdd.sample(
      true,
      2
    ).collect().mkString(","))
```



#### **Distinct**

去重



#### coalesce

根据数据量缩减分区，用于大数据集过滤后，提高小数据集的执行效率。

当存在过多的小任务时，可以使用coalesce方法，收缩合并分区，减少分区的个数,减少任务调度成本

```scala
    //TODO 算子——Sample
    val rdd = sc.makeRDD(List(1,2,3,4),4)

    //coalesce方法默认情况下不会将分区的数据打乱重新组合
    //可能导致数据不均衡，出现数据倾斜
    //如果想要数据均衡，可以进行shuffle处理
	//可以扩大分区，但是需要执行shuffle操作
    val value = rdd.coalesce(2,true)
```



#### Repartition

可以扩大分区,底层为coalesce(),shuffle固定为true



#### SortBy

```scala
    //TODO 算子——SortBy
    val rdd = sc.makeRDD(List(("1",2),("11",2),("2",3)),2)

    //sortBy可以根据指定的规则对数据源中的数据进行排序，默认为升序
    //sortBy默认情况下，不会改变分区，但是油shuffle操作
    val value = rdd.sortBy(t => t._1,ascending = false)
```



#### 双Value类型

除了zip，其他操作需要保持rdd的数据类型一致

```scala
    //TODO 算子——双Value类型
    val rdd1 = sc.makeRDD(List(1,2,3,4))
    val rdd2 = sc.makeRDD(List(2,3,4,5))

    //交集
    val rdd3 = rdd1.intersection(rdd2)
    println(rdd3.collect().mkString(","))

    //并集
    val rdd4 = rdd1.union(rdd2)
    println(rdd4.collect().mkString(","))

    //差集
    val rdd5 = rdd1.subtract(rdd2)
    println(rdd5.collect().mkString(","))

    //拉链
	//两个数据源要求分区数量要保持一致
	//两个数据源要求分区中数据量保持一致
    val rdd6 = rdd1.zip(rdd2)
    println(rdd6.collect().mkString(","))
```



#### key-Value



**partitionBy**

rdd数据类型为k,v类型时才能调用这个方法

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(1,2,3,4),2)

    val mapRdd:RDD[(Int,Int)] = rdd.map((_, 1))

    //RDD=>PairRDDFunctions
    //隐式转换(二次编译)

    //partitionBy根据指定得分区规则对数据进行重分区
    mapRdd.partitionBy(new HashPartitioner(2)) //有多种分区器
      .saveAsTextFile("ouput")
```



#### **reduceByKey**

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(("a",1),("a",2),("a",3),("b",4)))

    //reduceByKey:相同的key的数据，进行value数据的聚合操作
    //scala语言中一般的聚合操作时两两聚合，spark基于scala，所以也是两两聚合
    //如果key的数据只有一个，是不会参与运算的
    val value = rdd.reduceByKey(_ + _)
```

![image-20231120163315695](F:\markdownImg\image-20231120163315695.png)

reduceByKey支持分区内预聚合功能，可以有效减少shuffle落盘数据，提升性能



**groupByKey**

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(("a",1),("a",2),("a",3),("b",4)))

    //groupByKey:将数据源中的数据，相同key的数据分在一个组中，形成一个对偶元组
    //            元组第一个元素是key，第二个元素是相同key的value的集合
    val groupRD:RDD[(String,Iterable[Int])] = rdd.groupByKey()

    groupRD.collect().foreach(println)
```

![image-20231120162326646](F:\markdownImg\image-20231120162326646.png)

groupByKey会导致数据打乱重组，存在shuffle操作

Spark中，shuffle操作必须落盘处理，不能再内存中数据登录，否则会导致内存溢出。shuffle性能会很低



#### aggregateByKey

能同时处理分区内的操作，和分区间的数据操作

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(("a",1),("a",2),("a",3),("b",4)),2)

    //aggregateByKey存在函数柯里化，有两个参数列表
    //第一个参数列表,需要传递一个参数，表示为初始值
    //    主要用于当碰见第一个key的时候，和value进行分区内计算
    //第二个参数列表需要传递两个参数
    //  第一个函数表示分区内计算规则
    //  第二个函数表示分区间操作规则
    rdd.aggregateByKey(0)(
      (x,y)=>math.max(x,y), //求出每个区间中，每个key最大的值
      (x,y)=> x + y		//将每个区间的最大值的key的值相加
    )
```

算子练习，使用了抽象控制

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(
      ("a",1),("a",2),("b",3),
      ("b",4),("b",5),("a",6)
    ),2)

    //aggregateByKey最终的返回结果应该和初始值的类型保持一致
    //val aggRDD: RDD[(String, String)] = rdd.aggregateByKey("")(_ + _, _ + _)

    //获取相同key的数据的平均值=>(a,3),(b,4)
    val rddAgg = rdd.aggregateByKey((0, 0))(
      (t, v) => (t._1 + v, t._2 + 1),
      (t, v) => (t._1 + v._1, t._2 + v._2)
    )
    
    //    val value = rddAgg.mapValues {
    //      case (num, cnt) => {
    //        num / cnt
    //      }
    //    }
    val value = rddAgg.mapValues(
      x => x._1 / x._2
    )
```



#### foldByKey

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(("a",1),("a",2),("a",3),("b",4)),2)

    //如果聚合计算时，分区内和分区间计算规则相同，spark提供了简化的方法
    rdd.foldByKey(0)(_+_).collect.foreach(println)
```



#### CombineKey

能够将相同key的第一个数据进行格式转换，并做计算

```scala
    //TODO 算子——Key-Value类型
    val rdd = sc.makeRDD(List(
      ("a",1),("a",2),("b",3),
      ("b",4),("b",5),("a",6)
    ),2)

    //aggregateByKey最终的返回结果应该和初始值的类型保持一致
    //val aggRDD: RDD[(String, String)] = rdd.aggregateByKey("")(_ + _, _ + _)

    //combineByKey:方法需要三个参数
    //第一个参数表示：将相同key的第一个数据进行结构的转换，实现操作
    //第二个参数表示：分区内的计算规则
    //第三个参数表示：分区间的计算规则
    val rddAgg = rdd.combineByKey(
      v=>(v,1),
      (t:(Int,Int),v)=>{
        (t._1+v,t._2+1)
      },
      (t1:(Int,Int),t2:(Int,Int))=>{
        (t1._1+t2._1,t1._2+t2._2)
      }
    )

    val value = rddAgg.mapValues(
      x => x._1 / x._2
    )
```



#### Join

```scala
    //TODO 算子——Key-Value类型
    val rdd1 = sc.makeRDD(List(
      ("a",1),("b",2),("c",3)
    ))

    val rdd2 = sc.makeRDD(List(
      ("a", 4), ("b", 5), ("c", 6)
    ))

    //join:两个不同数据源的数据，相同的key的value会连接在一起，形成元组
    //      如果两个数据源中的key没有匹配上，那么数据不会出现在结果中
    //      如果两个数据源中有多个相同的key，key会依次匹配，可能会出现笛卡尔积
    val value = rdd1.join(rdd2)
```



#### leftOuterJoin & rightOuterJoin

效果和sql outerjoin类似。有匹配的值返回some，没有则返回none

```scala
    //TODO 算子——Key-Value类型
    val rdd1 = sc.makeRDD(List(
      ("a",1),("b",2),("c",3)
    ))

    val rdd2 = sc.makeRDD(List(
      ("a", 4), ("b", 5)//, ("c", 6)
    ))
    
    val leftjoin = rdd1.leftOuterJoin(rdd2)
```



#### cogroup

先在rdd内将相同key数据分组，然后再和其他rdd进行连接，没有的值就返回一个空seq()

```scala
    //TODO 算子——Key-Value类型
    val rdd1 = sc.makeRDD(List(
      ("a",1),("b",2),("c",3)
    ))

    val rdd2 = sc.makeRDD(List(
      ("a", 4), ("b", 5)//, ("c", 6)
    ))

    //cogroup: connect + group(分组+连接)
    val cgRdd = rdd1.cogroup(rdd2)

    cgRdd.collect().foreach(println)
```

![image-20231120210455010](F:\markdownImg\image-20231120210455010.png)



### 转换算子案例实操

```scala
package com.atguigu.bigdata.spark.core.rdd.builder.operator.transform

import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

object Spark24_RDD_Req {
  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    //TODO 案例实操

    //1.获取原始数据：时间戳，省份，城市，用户，广告
    val rdd = sc.textFile("datas/agent.log")

    //2.将原始数据进行结构的转换。方便统计
    // ((省份，广告),1)
    val mapRdd: RDD[((String, String), Int)] = rdd.map(_.split(" ")) //分割字符串
      .map(line => ((line(1), line(4)), 1))

    //3.将转换结构后的数据，进行分组聚合
    //((省份,广告),1) => ((省份,广告),sum)
    val reduceRdd = mapRdd.reduceByKey(_ + _)

    //4.将聚合的结果进行结构的转换
    //((省份,广告),sum)=>(省份,(广告,sum))
    val reduceMapRdd = reduceRdd.map {
      case ((prv, adv), sum) => (prv, (adv, sum))
    }

    //5.将转换结构后的数据根据省份进行分组
    //(省份,[(广告A,sumA),....])
    val gruopRdd = reduceMapRdd.groupByKey()

    //6.将分组后的数据组内排序（降序），取前三名
    val resultRdd = gruopRdd.mapValues(_.toList.sortBy(_._2)(Ordering.Int.reverse).take(3))

    //7.采集数据打印在控制台
    resultRdd.collect().foreach(println)


    sc.stop()
  }
}

```



p80