# SparkSQL项目实战

**权限问题：添加语句到代码前端**System.*setProperty*("HADOOP_USER_NAME","root")

![image-20231125201136481](F:\markdownImg\image-20231125201136481.png)

```scala
package sql

import org.apache.spark.SparkConf
import org.apache.spark.sql._
import org.apache.spark.sql.expressions.Aggregator

import scala.collection.mutable
import scala.collection.mutable.ListBuffer


object Spark06_SparkSQL_Test3 {
  def main(args: Array[String]): Unit = {
    System.setProperty("HADOOP_USER_NAME","root")
    val sparkConf = new SparkConf().setMaster("local[*]").setAppName("sparkSQL")

    val spark = SparkSession.builder()
      .enableHiveSupport()
      .config(sparkConf)
      .getOrCreate()

    spark.sql("use atguigu")
    //查询基本数据
    spark.sql(
      """
        |select
        |				uva.*,
        |				ci.area ,
        |				ci.city_name,
        |				pi.product_name
        |			FROM atguigu.user_visit_action uva
        |			join atguigu.city_info ci on uva.city_id = ci.city_id
        |			join atguigu.product_info pi on pi.product_id = uva.click_product_id
        |			where uva.click_product_id > -1
        |""".stripMargin).createOrReplaceTempView("t1")

    //根据区域，商品进行数据聚合
    spark.udf.register("cityRemark",functions.udaf(new CityRemarkUDAF))
    spark.sql(
      """
        | SELECT
        |			area,
        |			product_name,
        |			count(*) as clickCnt,
        |     cityRemark(city_name) as city_remark
        |	from t1 group by t1.area,t1.product_name
        |""".stripMargin).createOrReplaceTempView("t2")

    //区域内对点击数量进行排行
    spark.sql(
      """
        |SELECT
        |		*,
        |		rank() over(partition by t2.area ORDER by t2.clickCnt desc) as rk
        |from t2
        |""".stripMargin).createOrReplaceTempView("t3")

    //取前三名
    spark.sql(
      """
        |select
        | *
        |from t3 where rk <=3
        |""".stripMargin).show(false)

    spark.close()
  }

  case class Buffer(var total:Long,var cityMap:mutable.Map[String,Long])
  //自定义聚合函数：实现城市备注功能
  //1.继承aggregator，定义泛型
  //  IN:   城市名称
  //  BUF:  Buffer =>【总点击数量，Map[(city,cnt),(city,cnt)]】
  //  OUT:  备注信息
  class CityRemarkUDAF extends Aggregator[String,Buffer,String]{
    override def zero: Buffer = {
      Buffer(0L,mutable.Map[String,Long]())
    }

    override def reduce(b: Buffer, city: String): Buffer = {
      b.total += 1
      val newCnt = b.cityMap.getOrElse(city,0L) + 1
      b.cityMap.update(city,newCnt)

      b
    }

    override def merge(b1: Buffer, b2: Buffer): Buffer = {
      b1.total += b2.total

      val map1 = b1.cityMap
      val map2 = b2.cityMap

      //两个Map的合并操作
      b1.cityMap =  map2.foldLeft(map1)((m1,m2)=>{
        //Map,m1 和 map2中的键值对进行计算
        val newCnt = m1.getOrElse(m2._1,0l)+m2._2
        map1.update(m2._1,newCnt)

        map1
      })

      b1
    }

    //将统计结果生成字符串信息
    override def finish(buff: Buffer): String = {
      val remarkList = ListBuffer[String]()

      val totalcnt = buff.total
      val cityMap = buff.cityMap

      //降序排列
      val cityCntList = cityMap.toList.sortWith(
        (left, right) => {
          left._2 > right._2
        }
      ).take(2)

      val hasMore = cityMap.size > 2
      var rsum = 0l

      cityCntList.foreach{
        case (city,cnt)=>{
          val r = cnt * 100 / totalcnt
          remarkList.append(s"${city} ${r}%")
          rsum +=r
        }
      }
      if(hasMore){
        remarkList.append(s"其他 ${100 - rsum}%")
      }

      remarkList.mkString(",")
    }

    override def bufferEncoder: Encoder[Buffer] = Encoders.product

    override def outputEncoder: Encoder[String] = Encoders.STRING
  }

}

```

