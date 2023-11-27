# Spark-合并筛选排序案例

## 需求1：求出前十点击数商品

```scala
object Spark01_Req1_HotCategoryTop10Analysis {

  def main(args: Array[String]): Unit = {

    //TODO:Top10热门品类
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    //1.读取原始的日志数据
    val actionRdd = sc.textFile("datas/user_visit_action.txt")

    //2.统计品类的点击数量（品类ID，点击数量）
    val clickCountRdd = actionRdd.filter(_.split("_")(6)!="-1")
      .map(action=>(action.split("_")(6),1))
      .reduceByKey(_+_)


    //3.统计品类的下单数量（品类ID，下单数量）
    val orderCountRdd = actionRdd.filter(_.split("_")(8) != "null")
      .flatMap(_.split("_")(8).split(",").map(id => (id, 1)))
      .reduceByKey(_ + _)

    //4.统计品类的支付数量（品类[ID，支付数量）
    val payCountRdd = actionRdd.filter(_.split("_")(10) != "null")
      .flatMap(_.split("_")(10).split(",").map(id => (id, 1)))
      .reduceByKey(_ + _)

    //5.将品类进行排序，并且取前10名
    //  点击数量排序，下单数量排序，支付数量的排序
    //  元组排序：先比较第一个，再比较第二个，再比较第三个，一依次类推
    //  （品类ID，（点击数量，下单数量，支付数量））
    // cogroup
    val cogroupRdd: RDD[(String, (Iterable[Int], Iterable[Int], Iterable[Int]))] =
      clickCountRdd.cogroup(orderCountRdd, payCountRdd)

    val value = cogroupRdd.mapValues {
      case (click, order, pay) => {
        var clickCnt = 0
        val iter1 = click.iterator
        if (iter1.hasNext) {
          clickCnt = iter1.next()
        }

        var orderCnt = 0
        val iter2 = order.iterator
        if (iter2.hasNext) {
          orderCnt = iter2.next()
        }

        var payCnt = 0
        val iter3 = pay.iterator
        if (iter3.hasNext) {
          payCnt = iter3.next()
        }

        (clickCnt, orderCnt, payCnt)
      }
    }

    //将结果采集到控制台打印出来
    //使用元组的比较方法来比较多个值
    val datas = value.sortBy(_._2, ascending = false).take(10)
    datas.foreach(println)
  }

}
```



**优化1**

不使用cogroup，用union+reduceByKey来代替

```scala
    //5.将品类进行排序，并且取前10名
    //  点击数量排序，下单数量排序，支付数量的排序
    //  元组排序：先比较第一个，再比较第二个，再比较第三个，一依次类推
    //  （品类ID，（点击数量，下单数量，支付数量））
    // cogroup
    val rdd1 = clickCountRdd.map {
      case (cid, cnt) => (cid, (cnt, 0, 0))
    }

    val rdd2 = orderCountRdd.map {
      case (cid, cnt) => (cid, (0, cnt, 0))
    }

    val rdd3 = payCountRdd.map {
      case (cid, cnt) => (cid, (0, 0, cnt))
    }

    //将三个数据源合并在一起，统计进行聚合计算
    val sourceRdd = rdd1.union(rdd2).union(rdd3)

    val analysisRdd = sourceRdd.reduceByKey(
      (t1, t2) => {
        (t1._1 + t2._1, t1._2 + t2._2, t1._3 + t2._3)
      }
    )
```



**优化2**

将数据格式一开始就转换为：

```scala
//（品类ID，（点击数量，0，0））
//（品类ID，（0，下单数量，0））
//（品类ID，（0，0，支付数量））
```

之后只需要一次reduceByKey就可以完成聚合，减少了数据来源，避免了多次的shuffle

![image-20231122153634061](F:\markdownImg\image-20231122153634061.png)



**优化3**

使用累加器，手动排序，直接跳过所有shuffle阶段。

优点：性能极强，速度快

缺点：数据会全部传到driver端，对driver的内存要求较高

```scala
object Spark01_Req1_HotCategoryTop10Analysis2 {

  def main(args: Array[String]): Unit = {

    //TODO:Top10热门品类
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    //1.读取原始的日志数据
    val actionRdd = sc.textFile("datas/user_visit_action.txt")
    actionRdd.cache()

    val acc =new HotCategoryAccumulator
    sc.register(acc,"hotCategory")

    //2.将数据转换结构
    actionRdd.foreach(
      action => {
        val datas = action.split("_")
        if (datas(6) != "-1") {
          acc.add((datas(6), "click"))
        } else if (datas(8) != "null") {
          val ids = datas(8).split(",")
          ids.foreach(
            id => {
              acc.add((id, "order"))
            }
          )
        } else if (datas(10) != "null") {
          val ids = datas(10).split(",")
          ids.foreach(
            id => {
              acc.add((id, "pay"))
            }
          )
        }
      }
    )

    val accVal: mutable.Map[String, HotCategory] = acc.value
    val categories = accVal.values

    val sort = categories.toList.sortWith(
      (left, right) => {
        if (left.clickCnt < right.clickCnt) {
          false
        } else if (left.clickCnt == right.clickCnt) {
          if (left.orderCnt < right.orderCnt) {
            false
          } else if (left.orderCnt == right.orderCnt) {
            left.payCnt > right.payCnt
          } else {
            true
          }
        } else {
          true
        }
      }
    )

    sort.take(10).foreach(println)
    sc.stop()
  }

  case class HotCategory(cid:String,var clickCnt:Int,var orderCnt:Int,var payCnt:Int)
  /*
    自定义累加器
    1.继承Accumulator，定义泛型
      In:(品类ID，行为类型)
      out:mutable.Map[String,HotCategory]
   */
  class HotCategoryAccumulator extends AccumulatorV2[(String,String),mutable.Map[String,HotCategory]]{

    private val hcMap = mutable.Map[String,HotCategory]()

    override def isZero: Boolean={
      hcMap.isEmpty
    }

    override def copy(): AccumulatorV2[(String, String), mutable.Map[String, HotCategory]]={
      new HotCategoryAccumulator()
    }

    override def reset(): Unit = {
      hcMap.clear()
    }
    override def add(v: (String, String)): Unit = {
      val cid = v._1
      val actionType = v._2

      val category = hcMap.getOrElse(cid, HotCategory(cid, 0, 0, 0))
      if(actionType=="click"){
        category.clickCnt +=1
      }else if(actionType=="order"){
        category.orderCnt +=1
      } else if(actionType=="pay"){
        category.payCnt +=1
      }
      hcMap.update(cid,category)
    }

    override def merge(other: AccumulatorV2[(String, String), mutable.Map[String, HotCategory]]): Unit = {
      val map1 = this.hcMap
      val map2 = other.value

      map2.foreach{
        case(cid,hc)=>{
          val category = map1.getOrElse(cid, HotCategory(cid, 0, 0, 0))
          category.clickCnt += hc.clickCnt
          category.orderCnt += hc.orderCnt
          category.payCnt += hc.payCnt

          map1.update(cid,category)
        }
      }
    }

    override def value: mutable.Map[String, HotCategory] = hcMap
  }
}
```



## **需求2**：求出前10商品，访问最多的sessionID(前10名)

```scala
object Spark01_Req2_HotCategoryTop10Analysis {

  def main(args: Array[String]): Unit = {

    //TODO:Top10热门品类
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    //1.读取原始的日志数据
    val actionRdd = sc.textFile("datas/user_visit_action.txt")
    actionRdd.cache()

    val top10: Array[String] = to10Category(actionRdd)

    //1.过滤原始数据,保留点击和前10的品类ID
    val filterActionRdd = actionRdd.filter(
      action => {
        val datas = action.split("_")
        if (datas(6) != "-1") {
          top10.contains(datas(6))
        } else {
          false
        }
      }
    )

    //2.根据品类ID和sessionid进行点击量的统计
    val reduceRdd = filterActionRdd.map(
      action => {
        val datas = action.split("_")
        ((datas(6), datas(2)), 1)
      }
    ).reduceByKey(_ + _)

    //3.将统计的结果进行结构的转换
    //((品类ID，sessionId）,sum)=>(品类ID，(sessionId,sum))
    val mapRdd = reduceRdd.map {
      case ((cid, sid), sum) => (cid, (sid, sum))
    }

    //4.相同的品类进行分组
    val groupRdd = mapRdd.groupByKey()

    //5.将分组后的数据进行点击量的排序，取前10名
    val resultRdd = groupRdd.mapValues(
      iter => iter.toList.sortBy(_._2)(Ordering.Int.reverse).take(10)
    )

    resultRdd.collect().foreach(println)

    sc.stop()
  }

  def to10Category(actionRdd:RDD[String])={
    actionRdd.cache()

    val clickCountRdd = actionRdd.filter(_.split("_")(6) != "-1")
      .map(action => (action.split("_")(6), 1))
      .reduceByKey(_ + _)


    val orderCountRdd = actionRdd.filter(_.split("_")(8) != "null")
      .flatMap(_.split("_")(8).split(",").map(id => (id, 1)))
      .reduceByKey(_ + _)

    val payCountRdd = actionRdd.filter(_.split("_")(10) != "null")
      .flatMap(_.split("_")(10).split(",").map(id => (id, 1)))
      .reduceByKey(_ + _)

    val rdd1 = clickCountRdd.map {
      case (cid, cnt) => (cid, (cnt, 0, 0))
    }

    val rdd2 = orderCountRdd.map {
      case (cid, cnt) => (cid, (0, cnt, 0))
    }

    val rdd3 = payCountRdd.map {
      case (cid, cnt) => (cid, (0, 0, cnt))
    }

    val sourceRdd = rdd1.union(rdd2).union(rdd3)

    val analysisRdd = sourceRdd.reduceByKey(
      (t1, t2) => {
        (t1._1 + t2._1, t1._2 + t2._2, t1._3 + t2._3)
      }
    )

    analysisRdd.sortBy(_._2,ascending=false).take(10).map(_._1)
  }

}
```



## 需求3：页面单挑转换率统计

![image-20231122165445690](F:\markdownImg\image-20231122165445690.png)



![image-20231122165458583](F:\markdownImg\image-20231122165458583.png)

实现代码

```scala
package com.atguigu.bigdata.spark.core.req

import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

object Spark01_Req3_Jump {
  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    val actionRdd = sc.textFile("datas/user_visit_action.txt")

    val actionDateRdd = actionRdd.map(
      action => {
        val datas = action.split("_")
        UserVisitAction(
          datas(0),
          datas(1).toLong,
          datas(2),
          datas(3).toLong,
          datas(4),
          datas(5),
          datas(6).toLong,
          datas(7).toLong,
          datas(8),
          datas(9),
          datas(10),
          datas(11),
          datas(12).toLong
        )
      }
    )

    actionDateRdd.cache()
    //TODO 计算分母
    val pageIdToCountMap:Map[Long,Long] = actionDateRdd.map(
      action => {
        (action.page_id, 1L)
      }
    ).reduceByKey(_ + _).collect().toMap

    //TODO 计算分子

    //根据session进行分组
    val sessionRdd = actionDateRdd.groupBy(_.session_id)

    //分组后，根据访问事件进行排序（升序）
    val mvRdd: RDD[(String, List[((Long, Long), Int)])] = sessionRdd.mapValues(
      iter => {
        val sortList = iter.toList.sortBy(_.action_time)

        //[1,2,3,4]
        //[1,2],[2,3],[3,4]
        //[1-2,2-3,3-4]
        //Sliding:滑窗
        //[1,2,3,4]
        //[2,3,4]
        //zip
        val flowIds = sortList.map(_.page_id)
        val pageflowIds: List[(Long, Long)] = flowIds.zip(flowIds.tail)
        pageflowIds.map(
          t => {
            (t, 1)
          }
        )
      }
    )

    //((1,2),1)
    val flatRdd: RDD[((Long, Long), Int)] = mvRdd.map(_._2).flatMap(list => list)

    val dataRdd = flatRdd.reduceByKey(_ + _)

    //TODO 计算单跳转换率
    //分子除以分母
    dataRdd.foreach {
      case ((pageid1,pageid2),sum)=>{
        val long = pageIdToCountMap.getOrElse(pageid1, 0L)

        println(s"页面${pageid1}跳转到也买你${pageid2}单挑转换率为:"+(sum.toDouble/long))
      }
    }

    sc.stop()
  }

  //用户访问动作表
  case class UserVisitAction(
            data:String,//用户点击行为日期
            user_id:Long,//用户ID
            session_id:String,
            page_id:Long,
            action_time:String,
            search_keyword:String,
            click_category_id:Long,
            click_product_id:Long,
            order_category_ids:String,
            order_product_ids:String,
            pay_category_ids:String,
            pay_product_ids:String,
            city_id:Long
          )
}

```



优化代码：对数据进行了过滤保留需要的数据

```scala
package com.atguigu.bigdata.spark.core.req

import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

object Spark01_Req3_Jump {
  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf().setMaster("local[8]").setAppName("Operator")
    val sc = new SparkContext(sparkConf)

    val actionRdd = sc.textFile("datas/user_visit_action.txt")

    val actionDateRdd = actionRdd.map(
      action => {
        val datas = action.split("_")
        UserVisitAction(
          datas(0),
          datas(1).toLong,
          datas(2),
          datas(3).toLong,
          datas(4),
          datas(5),
          datas(6).toLong,
          datas(7).toLong,
          datas(8),
          datas(9),
          datas(10),
          datas(11),
          datas(12).toLong
        )
      }
    )

    actionDateRdd.cache()

    //TODO 对指定的页面连续跳转进行统计
    // 1-2,2-3,3-4,4-5,5-6,6-7
    val ids = List(1,2,3,4,5,6,7)
    val okFlow = ids.zip(ids.tail)

    //TODO 计算分母
    //过滤数据
    val pageIdToCountMap = actionDateRdd.filter(
      action => {
        ids.init.contains(action.page_id)
      }
    ).map(
      action => {
        (action.page_id, 1L)
      }
    ).reduceByKey(_ + _).collect().toMap

    //TODO 计算分子

    //根据session进行分组
    val sessionRdd = actionDateRdd.groupBy(_.session_id)

    //分组后，根据访问事件进行排序（升序）
    val mvRdd: RDD[(String, List[((Long, Long), Int)])] = sessionRdd.mapValues(
      iter => {
        val sortList = iter.toList.sortBy(_.action_time)

        //[1,2,3,4]
        //[1,2],[2,3],[3,4]
        //[1-2,2-3,3-4]
        //Sliding:滑窗
        //[1,2,3,4]
        //[2,3,4]
        //zip
        val flowIds = sortList.map(_.page_id)
        val pageflowIds: List[(Long, Long)] = flowIds.zip(flowIds.tail)

        //将不合法的页面跳转进行过滤
        pageflowIds.filter(
          t=>{
            okFlow.contains(t)
          }
        ).map(
          t => {
            (t, 1)
          }
        )
      }
    )

    //((1,2),1)
    val flatRdd: RDD[((Long, Long), Int)] = mvRdd.map(_._2).flatMap(list => list)

    val dataRdd = flatRdd.reduceByKey(_ + _)

    //TODO 计算单跳转换率
    //分子除以分母
    dataRdd.foreach {
      case ((pageid1,pageid2),sum)=>{
        val long = pageIdToCountMap.getOrElse(pageid1, 0L)

        println(s"页面${pageid1}跳转到也买你${pageid2}单挑转换率为:"+(sum.toDouble/long))
      }
    }

    sc.stop()
  }

  //用户访问动作表
  case class UserVisitAction(
            data:String,//用户点击行为日期
            user_id:Long,//用户ID
            session_id:String,
            page_id:Long,
            action_time:String,
            search_keyword:String,
            click_category_id:Long,
            click_product_id:Long,
            order_category_ids:String,
            order_product_ids:String,
            pay_category_ids:String,
            pay_product_ids:String,
            city_id:Long
          )
}

```



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



# Spark优化思路

1.尽量减少RDD的重复使用次数

  解决办法：使用cache或checkPoint来缓存Rdd数据



2.减少Spark执行shuffle操作的次数