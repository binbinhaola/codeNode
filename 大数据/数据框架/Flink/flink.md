# Flink是什么

Flink核心目标是“**数据流上的有状态计算**” (Stateful Computations over Data Streams)

是一个框架和分布式处理引擎



## 有界流和无界流

### 1.无界流：

有定义流的开始，但没有定义流的结束

会无限产生数据，必须持续处理数据,数据摄取后需要立刻处理



### 2.有界流：

有定义流的开始，也定义流的结束

有界流可以摄取所有数据后再计算

数据可以被排序

通常被称为批处理



## 有状态的流

把流处理需要的额外数据保存成一个“状态”，然后针对这条数据进行处理，并且更新状态。这就是所谓的“有状态的流处理”

状态可以理解为，可以实时更新的有关数据的额外信息

![image-20231128114200749](F:\markdownImg\image-20231128114200749.png)

![image-20231128114812456](F:\markdownImg\image-20231128114812456.png)



## Flink 和 SparkStreaming的区别

Spark以批处理为根本

Flink以流处理为根本。



# Flink快速上手

## 导入依赖

```xml
    <dependencies>
        <!-- https://mvnrepository.com/artifact/org.apache.flink/flink-streaming-java -->
        <dependency>
            <groupId>org.apache.flink</groupId>
            <artifactId>flink-streaming-java</artifactId>
            <version>1.17.0</version>
        </dependency>
        <!-- https://mvnrepository.com/artifact/org.apache.flink/flink-clients -->
        <dependency>
            <groupId>org.apache.flink</groupId>
            <artifactId>flink-clients</artifactId>
            <version>1.17.0</version>
        </dependency>

    </dependencies>
```



## **WordCount代码**

代码使用的Dataset API （已过时）所以不做记录



### 使用DataStream API实现流处理(有界流)

```java
    public static void main(String[] args) throws Exception {
        //TODO 1.创建执行环境
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        //TODO 2.读取数据
        DataStreamSource<String> lineDS = env.readTextFile("data/word.txt");

        //TODO 3.处理数据: 切分，转换，分组，聚合
        SingleOutputStreamOperator<Tuple2<String, Integer>> sumDs = lineDS.flatMap(new FlatMapFunction<String, Tuple2<String, Integer>>() {
            @Override
            public void flatMap(String value, Collector<Tuple2<String, Integer>> collector) throws Exception {
                String[] words = value.split(" ");
                for (String word : words) {
                    //转换成tuple2
                    Tuple2<String, Integer> wordAndOne = Tuple2.of(word, 1);
                    //通过 采集器向下游发送数据
                    collector.collect(wordAndOne);
                }
            }
        }).keyBy(
                // 参数1：传入的数据的类型 参数2：key的类型
                new KeySelector<Tuple2<String, Integer>, String>() {
                    @Override
                    public String getKey(Tuple2<String, Integer> value) throws Exception {
                        return value.f0;
                    }
                }
        ).sum(1);

        //TODO 4.输出数据
        sumDs.print();

        //TODO 5.执行：类似SparkStream最后ssc.start()
        env.execute();
    }
```



### 使用DataStream API实现流处理(无界流)

因为Java有泛型擦除的存在，仔lambda表达式中，自动提取的信息不够精细

需要手动的指定类型

```java
    public static void main(String[] args) throws Exception {

        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        //TODO 读取数据 socket
        DataStreamSource<String> socketDs = env.socketTextStream("node1", 7777);

        //TODO 处理数据
        SingleOutputStreamOperator<Tuple2<String, Integer>> sum = socketDs
                .flatMap(
                        (String value, Collector<Tuple2<String, Integer>> out) -> {
                            String[] words = value.split(" ");
                            for (String word : words) {
                                out.collect(Tuple2.of(word, 1));
                            }
                        }
                )
                .returns(Types.TUPLE(Types.STRING,Types.INT))
                .keyBy(value -> value.f0)
                .sum(1);
        //输出
        sum.print();

        env.execute();
    }
```



### 批处理和流处理的结果差别

**流处理**

有一条数据就处理一条，所以Hello会多次出现，之前hello的统计会作为状态保存

![image-20231128162201541](F:\markdownImg\image-20231128162201541.png)

**批处理**

一次性读取完再进行处理

![image-20231128162209426](F:\markdownImg\image-20231128162209426.png)



# Flink的部署

**集群角色**

![image-20231128165539317](F:\markdownImg\image-20231128165539317.png)

**集群配置**

JobManager端

**flink-conf.yaml**

```shell
# JobManager节点地址.
jobmanager.rpc.address: hadoop102
jobmanager.bind-host: 0.0.0.0
rest.address: hadoop102
rest.bind-address: 0.0.0.0
# TaskManager节点地址.需要配置为当前机器名
taskmanager.bind-host: 0.0.0.0
taskmanager.host: hadoop102
```

**workers**

主机地址

```txt
hadoop102
hadoop103
hadoop104
```

**masters**

```txt
hadoop102:8081
```



TaskManager端

讲taskmanager地址改为本机地址即可

```txt
taskmanager.host: host
```



JobManger:8081可以访问web界面