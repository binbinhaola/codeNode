# 数据概念

**//数据处理的方式**

流式（Streaming）数据处理

批量（batch）数据处理



**// 数据处理延迟的长短**

实时数据处理：毫秒级别

离线数据处理：小时 or 天



SparkStreaming：准实时（秒，分钟），微批次的数据处理框架

SparkStreaming 支持的数据输入源很多例如：kafka，flume，Twitter，ZeroMQ，

数据输入后可以使用原语（类似于RDD的算子）如：map，reduce，join等进行运算



在内部，每个时间区间收到的数据都作为RDD存在，而DStream是由这些RDD所组成的序列（得名“离散化”）,简单来说DStrea是对RDD在实时数据处理场景的一种封装

**流程图**

![image-20231125211325551](F:\markdownImg\image-20231125211325551.png)



**背压机制**（Spark Stream BackPressure）：更具JobScheduler反馈的作业执行信息来动态调整Receiver数据接收率



# WordCount实现

```scala
package streaming

import org.apache.spark.SparkConf
import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.streaming.{Seconds, StreamingContext}

object SparkStreaming_01WordCount {

  def main(args: Array[String]): Unit = {

      //TODO 创建环境对象
      //StreamingContext创建时，需要传递两个参数
      val sparkConf = new SparkConf().setMaster("local[*]").setAppName("SparkStreaming")
      //第二个参数表示批量处理的周期(采集周期）
      val ssc = new StreamingContext(sparkConf,Seconds(3))

    //TODO 处理逻辑
    //获取端口数据
    val lines: ReceiverInputDStream[String] = ssc.socketTextStream("localhost", 9999)

    val words = lines.flatMap(_.split(" "))
    val wordToOne = words.map((_, 1))

    val wordToCount: DStream[(String, Int)] = wordToOne.reduceByKey(_ + _)

    wordToCount.print()

      //TODO 关闭环境
      //由于SparkStreaming采集器是长期执行的任务，所以不能直接关闭
      //如果main方法执行完毕，应用程序也会自动结束。
      //ssc.stop()
      //1.启动采集器
      ssc.start()
      //2.等待采集器的关闭
      ssc.awaitTermination()
  }

}

```

**依赖**

```xml
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-streaming_2.13</artifactId>
            <version>3.2.4</version>
        </dependency>
```



# **Queue模拟Dstream**

```scala
      //TODO 创建环境对象
      //StreamingContext创建时，需要传递两个参数
      val sparkConf = new SparkConf().setMaster("local[*]").setAppName("SparkStreaming")
      //第二个参数表示批量处理的周期(采集周期）
      val ssc = new StreamingContext(sparkConf,Seconds(3))

      val rdds = new mutable.Queue[RDD[Int]]()

      val inputStream = ssc.queueStream(rdds,oneAtATime = false)

      val reducedStream = inputStream.map((_, 1)).reduceByKey(_ + _)

      reducedStream.print()

      ssc.start()

    for(i <- 1 to 5) {
      rdds += ssc.sparkContext.makeRDD(1 to 300,10)
      Thread.sleep(2000)
    }
    ssc.awaitTermination()
```



# 自定义数据采集器

```scala
object SparkStreaming_03_DIY {

  def main(args: Array[String]): Unit = {

      val sparkConf = new SparkConf().setMaster("local[*]").setAppName("SparkStreaming")
      val ssc = new StreamingContext(sparkConf,Seconds(3))

      val messageDS: ReceiverInputDStream[String] = ssc.receiverStream(new MyReciver)
      messageDS.print()


    ssc.start()
    ssc.awaitTermination()
  }
  /*
    自定义数据采集器
    1.继承Receiver，定义泛型
    2.重写方法
  */
  class MyReciver extends Receiver[String](StorageLevel.MEMORY_ONLY){
    private var flag = true
    override def onStart(): Unit = {

      new Thread(() => {
        while (flag) {
          val message = "采集的数据为：" + new Random().nextInt(10).toString
          store(message)	//储存数据，原理未知
          Thread.sleep(500)
        }
      }).start()
    }

    override def onStop(): Unit = {
      flag = false;
    }

  }
}
```



# Kafka数据源

p192
