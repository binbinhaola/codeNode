# 数据模型

## DataFrame

​	在Spark中，DataFrame是一种以RDD为基础的分布式数据集，类似于传统数据库中的二维表格。

​	DataFrame和RDD的主要区别在于，前者带有schema信息，所表示的数据集的每一列都带有名称和类型，能让SparkSql能够洞察更多的结构信息。

​	DataFrame为数据提供了schema的视图。可以当作数据库的一张表来处理

​	DataFrame也是懒加载，但性能上比RDD高

![image-20231124085008803](F:\markdownImg\image-20231124085008803.png)

### SQL的基本使用

​	如果从内存中获取数据，spark可以知道数据类型具体是什么。但是从文件中读取的数字，不能确定是什么类型，所以用bigInt接受，可以和Long类型转换换，但是和Int不能进行转换

```shell
val df = spark.read.json("data/user.json")	#创建DataFrame，spark可以读取多种文件
df.createOrReplaceTempView("people") #对DataFram创建一个临时视图
val sqlDF = spark.sql("select * from people ") #通过SQL进行查询
sqlDF.show #展示查询结果
```

**注意：**普通临时表是Session范围内的，如果全局有效可以使用全局临时表。使用全局临时表路径访问

**"global_temp.tableName"**

```shell
df.createOrReplaceGlobalTempView("table") #创建全局表
```



### DSL语法

DataFrame提供一个特定领域语言(domain-specific language,DSL)去管理结构化的数据

```shell
df.select("age").show()  #使用dataFrame直接通过DSL来查询数据
df. + tab #查询DSL指令
```

涉及运算时，列数据要加上“$"或" ' '"来表示数据引用

```shell
df.select($"line" + 1).show()
df.select('line + 1).show()
```



### RDD转换DataFrame

df和rdd的互相转换

<img src="F:\markdownImg\image-20231124100358879.png" alt="image-20231124100358879" style="zoom:67%;" />



## DataSet

​	DataSet是分布式数据集合。DataSet是Spark1.6中添加的一个新抽象，是DataFrame的一个扩展。提供了RDD的优势(强类型，lambda函数的能力)以及Spark Sql优化执行引擎的优点。

还可以使用功能性转换（map,flatMap,filter)

**三层关系**

![image-20231124104454198](F:\markdownImg\image-20231124104454198.png)

### 样例类创建DataSet

```shell
case class Person(name:String,age:Long)	#声明样式类
List(Person("zhangsan",30)).toDS	#转换类列表
```



### DataFrame转换DataSet

```shell
case class Emp(age:Long,username:String)
val ds = df.as[Emp] #df转为ds，df的列名要和类的属性名一致
```



### RDD转换DataSet

用样例类创建的rdd可以直接转换为DS

```cmd
sc.makeRDD(List(Emp(30,"name"),Emp(40,"lisi"))) #用样例类创建rdd
rdd.toDs #转换为DS
```



# Idea创建speakSQL项目



## 创建环境

引入依赖

```xml
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-sql_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>
```



## DataForm的创建

spark创建配置，获取sparksession

```scala
    //TODO 创建SparkSQL的运行环境
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("sparkSQL")

    val spark = SparkSession.builder()
      .config(sparkConf)
      .getOrCreate()
```

```scala
    //读取json文件，创建DataFrame
    val df = spark.read.json("datas/user.json")

    //DataFrame => DSL
    //在使用DataFrame时，如果涉及转换操作，需要引入转换规则
    import spark.implicits._
    df.select("age","username").show
    df.select($"age"+1).show
    df.select(Symbol("age")+1).show

    //DataFrame => SQL
    df.createOrReplaceTempView("user")

    spark.sql("select * from user").show
```



## DataSet的创建

```scala
    //TODO DataSet
    //DataFrame其实是特定泛型的DataSet DataFrame=DataSet[Row]
    val seq = Seq(1,2,3,4)
    val ds = seq.toDS()
```



## RDD<=>DataFrame<=>DataSet的互相转换

```scala
    //RDD <=> DataFrame
    val rdd = spark.sparkContext.makeRDD(List((1,"zhangsan",43),(2,"lisi",23),(3,"wangwu",30)))
    val df1:sql.DataFrame = rdd.toDF("id", "name", "age")
    val rowRDD = df1.rdd

    //DataFrame <=> DataSet
    val ds = df.as[User]
    val df2 = ds.toDF()

    //RDD <=> DataSet
    val ds2 = rdd.map {
      case (id, name, age) => User(id, name, age)
    }.toDS()

    val userRdd: RDD[User] = ds2.rdd

    //TODO 关闭环境
    spark.close()
  }
  case class User(id:Int, name:String,age:Int)
```



## UDF(User Defined function)函数

```scala
    val df = spark.read.json("datas/user.json")
    df.createOrReplaceTempView("user")

    spark.udf.register("prefixName",(name:String)=>{
      "Name:"+name
    })

    spark.sql("select age, prefixName(username) from user").show
```



## UDAF(User Defined  Aggregate function)函数

**流程图**

![image-20231124161145594](F:\markdownImg\image-20231124161145594.png)



### 弱类型（已弃用）

因为数据是弱类型函数，数据只能通过顺序来获取，获取不方便

```scala
  /*
     自定义聚合函数类，计算年龄的平均值
     1.继承类
     2.重写方法
  */
  class MyAvgUDAF extends UserDefinedAggregateFunction{
    //输入数据的结构
    override def inputSchema: StructType = {
      StructType(
        Array(
          StructField("age",LongType)
        )
      )
    }

    //缓冲区数据结构
    override def bufferSchema: StructType = {
      StructType(
        Array(
          StructField("total", LongType),
          StructField("count", LongType)
        )
      )
    }

    //函数计算结果的数据类型：Out
    override def dataType: DataType = LongType

    //函数的稳定性
    override def deterministic: Boolean = true

    //缓冲区初始化
    override def initialize(buffer: MutableAggregationBuffer): Unit = {
      buffer(0) = 0L
      buffer(1) = 0L
    }

    //根据输入的值更新缓冲区数据
    override def update(buffer: MutableAggregationBuffer, input: Row): Unit = {
        buffer.update(0,buffer.getLong(0)+input.getLong(0))
        buffer.update(1,buffer.getLong(1)+1)
    }

    //缓冲区数据合并
    override def merge(buffer1: MutableAggregationBuffer, buffer2: Row): Unit = {
      buffer1.update(0,buffer1.getLong(0)+buffer2.getLong(0))
      buffer1.update(1,buffer1.getLong(1)+buffer2.getLong(1))
    }

    //计算平均值
    override def evaluate(buffer: Row): Any = {
      buffer.getLong(0)/buffer.getLong(1)
    }
  }
```



### 强类型

```scala
    val df = spark.read.json("datas/user.json")
    df.createOrReplaceTempView("user")

	//函数的注册
    spark.udf.register("ageAvg",functions.udaf(new MyAvgUDAF))


    spark.sql("select ageAvg(age) from user").show

    //TODO 关闭环境
    spark.close()
  }

  /*
     自定义聚合函数类，计算年龄的平均值
     1.继承类otg.apache.spark.sql.expressions.Aggregator, 定义泛型
        IN: 输入的数据类型
        BUF:  缓冲区的数据类型 Buff
        OUT: 输出的数据类型
     2.重写方法(6)
  */
  case class Buff(var total:Long,var count:Long)

  class MyAvgUDAF extends Aggregator[Long,Buff,Long]{
    //z&zero: 初始值或零值
    override def zero: Buff = {
      Buff(0L,0L)
    }

    //根据输入的数据更新缓冲区的数据
    override def reduce(b: Buff, a: Long): Buff = {
      b.total +=a
      b.count +=1

      b
    }

    //合并缓冲区
    override def merge(b1: Buff, b2: Buff): Buff = {
      b1.total = b1.total + b2.total
      b1.count = b1.count + b2.count
      b1
    }

    //计算结果
    override def finish(reduction: Buff): Long = {
      reduction.total/reduction.count
    }

    //缓冲区的编码操作
    override def bufferEncoder: Encoder[Buff] = Encoders.product

    //输出的编码操作
    override def outputEncoder: Encoder[Long] = Encoders.scalaLong
  }
```



**早期实现方式**

将自定义聚合函数作为ds的列来进行查询

```scala
    
    //早期版本中，spark不能在sql使用强类型UDAF操作
    //早期的UDAF强类型聚合函数使用DSL语法操作
    val ds: Dataset[User] = df.as[User]

    //将UDAF函数转换为查询的列对象
    val udafCol: TypedColumn[User, Long] = new MyAvgUDAF().toColumn

    ds.select(udafCol).show

    //TODO 关闭环境
    spark.close()
  }

  /*
     自定义聚合函数类，计算年龄的平均值
     1.继承类otg.apache.spark.sql.expressions.Aggregator, 定义泛型
        IN: 输入的数据类型 User
        BUF:  缓冲区的数据类型 Buff
        OUT: 输出的数据类型
     2.重写方法(6)
  */
  case class User(username:String,age:Long)
  case class Buff(var total:Long,var count:Long)

  class MyAvgUDAF extends Aggregator[User,Buff,Long]{
    //z&zero: 初始值或零值
    override def zero: Buff = {
      Buff(0L,0L)
    }

    //根据输入的数据更新缓冲区的数据
    override def reduce(b: Buff, a: User): Buff = {
      b.total +=a.age
      b.count +=1

      b
    }

    //合并缓冲区
    override def merge(b1: Buff, b2: Buff): Buff = {
      b1.total = b1.total + b2.total
      b1.count = b1.count + b2.count
      b1
    }

    //计算结果
    override def finish(reduction: Buff): Long = {
      reduction.total/reduction.count
    }

    //缓冲区的编码操作
    override def bufferEncoder: Encoder[Buff] = Encoders.product

    //输出的编码操作
    override def outputEncoder: Encoder[Long] = Encoders.scalaLong
  }
```



## 数据读取和保存

**读取：**

``` shell
spark.read.load("file://filePath") or ("filePath") #在有hadoop的下，一个是本地路径一个是hdfs路径
spark.read.format("json").load("path") #读取指定格式的文件
```

**保存：**

```shell
df.write.save("path") #分本地和hdsf路径
df.write.format("json").save("path") #自定义文件格式
```

**在查询的同时获取表数据：**

```shell
spark.sql("select * from json.`/data/user.json`").show 
```

**修改保存文件的模式：**

```shell
df.write.format("json").mode("append").save("output")
```

![image-20231125120717385](F:\markdownImg\image-20231125120717385.png)

**CSV文件的读取：**

```shell
spark.read.formate("csv").option("sep",';').option("inferSchema","true").option("header","true").load("filePath")
```



**MySql表数据的读取和保存**

```scala
    //读取MySQL数据
    val df = spark.read.format("jdbc")
      .option("url", "jdbc:mysql://localhost:3306/test")
      .option("user", "root")
      .option("password", "root")
      .option("dbtable", "orders")
      .load()

    df.show()

    //保存数据
    df.write.format("jdbc")
      .option("url", "jdbc:mysql://localhost:3306/test")
      .option("user", "root")
      .option("password", "root")
      .option("dbtable", "orders1")
      .mode(SaveMode.Append)
      .save()
```



### **Hive数据库操作**

```shell
#加载数据到数据表中
spark.sql("load data local inpath 'data/id.txt' into table atguigu")
sparl.sql("show tables") #显示hive所有数据表
```



#### spark如何连接外置hive

1.将hive的hive-site.xml文件，复制到spark的conf文件夹中

2.将mysql-connector 驱动移动到spark jar目录下

```scala
   val spark = SparkSession.builder()
      .enableHiveSupport() //启用hive支持
      .config(sparkConf)
      .getOrCreate()

    //使用SparkSQL连接外置的Hive
    //1.拷贝Hive-size.xml文件到classPath下
    //2.启动Hive的支持
    //3.增加对应的依赖关系（包含MySql的驱动）
    spark.sql("show tables").show
```

**相关依赖**s

```scala
    <dependencies>
        <!-- https://mvnrepository.com/artifact/org.apache.spark/spark-core -->
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-core_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.apache.spark/spark-sql -->
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-sql_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.apache.spark/spark-hive -->
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-hive_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.28</version>
        </dependency>
        

    </dependencies>
```



#### beeline操作hive

```shell
sbin/start-thriftserver.sh #启动服务
bin/beeline -u jdbc:hive2://node1:10000 -n root #使用beeline进行连接
```



