## 1.Redis的使用

### 1.使用java直接整合redis

1. 使用maven项目在pom.xml中需要依赖jedis
2. 具体pom.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.cssl</groupId>
    <artifactId>kgc47usejava4redis</artifactId>
    <version>1.0-SNAPSHOT</version>

    <dependencies>
        <!-- https://mvnrepository.com/artifact/redis.clients/jedis -->
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
            <version>3.5.2</version>
        </dependency>
    </dependencies>
</project>
```

​		3.创建实体类Student

```java
package com.cssl.redis;

import java.io.Serializable;
import java.util.Date;

public class Student implements Serializable {

    private Integer sid;
    private String sname;
    private Date bonrdate;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public Date getBonrdate() {
        return bonrdate;
    }

    public void setBonrdate(Date bonrdate) {
        this.bonrdate = bonrdate;
    }

    @Override
    public String toString() {
        return "Student{" +
                "sid=" + sid +
                ", sname='" + sname + '\'' +
                ", bonrdate=" + bonrdate +
                '}';
    }

    public Student(Integer sid, String sname, Date bonrdate) {
        this.sid = sid;
        this.sname = sname;
        this.bonrdate = bonrdate;
    }

    public Student() {
    }
}

```

​	4.测试类

```java
package com.cssl.redis;

import redis.clients.jedis.Jedis;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//简单使用redis连接方式
public class Test01 {

    public static void main(String[] args) {
        Jedis jedis=new Jedis("192.168.88.146",6379);
        jedis.auth("123456");
        //jedis.set("userName", "李四");
        //System.out.println("输出："+jedis.get("kk"));
        doObject( jedis);
    }
    //测试存对象
    public static void  doObject(Jedis jedis){
        Student stu=new Student(102,"张三",new Date());
        Map<String,String> map=new HashMap<String,String>();
        map.put("sid",stu.getSid().toString());
        map.put("sname",stu.getSname());
        map.put("borndate",stu.getBonrdate().toString());
        //String stu1 = jedis.hmset("stu", map);
        //jedis.hmse
        //jedis.hmset()
        //System.out.println("stusss:"+stu1);
        List<String> hmget = jedis.hmget("stu", "sname", "borndate");
        for (String s:hmget){
            System.out.println("ss:"+s);
        }
    }
}

```

![](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210401114622581.png)

​			![](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210401114717677.png)

​		



### 2.使用连接池的方式连接redis

```java
package com.cssl.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class Test02 {

    public static void main(String[] args) {
        //创建连接池对象
        JedisPool jedispool = new JedisPool("192.168.88.146",6381);
        //从连接池中获取一个连接
        Jedis jedis = jedispool.getResource();
        jedis.auth("123456");
        //使用jedis操作redis
        jedis.set("userName", "张飞真好看"); //从服务器
        String str = jedis.get("userName");
        System.out.println(str);
        //使用完毕 ，关闭连接，连接池回收资源
        jedis.close();
        //关闭连接池
        jedispool.close();
    }
}
```

测试结果：

![image-20210401114858098](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210401114858098.png)



![image-20210401114920196](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210401114920196.png)



### 3.使用java连接redis集群

```java
package com.cssl.redis;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
import redis.clients.jedis.JedisPoolConfig;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

public class Test03 {
    private static JedisCluster jedis;
    static {
        // 添加集群的服务节点Set集合
        Set<HostAndPort> hostAndPortsSet = new HashSet<HostAndPort>();
        // 添加节点
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7000));
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7001));
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7002));
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7003));
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7004));
        hostAndPortsSet.add(new HostAndPort("192.168.88.144", 7005));

        // Jedis连接池配置
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        // 最大空闲连接数, 默认8个
        jedisPoolConfig.setMaxIdle(100);
        // 最大连接数, 默认8个
        jedisPoolConfig.setMaxTotal(20);
        //最小空闲连接数, 默认0
        jedisPoolConfig.setMinIdle(0);
        // 获取连接时的最大等待毫秒数(如果设置为阻塞时BlockWhenExhausted),如果超时就抛异常, 小于零:阻塞不确定的时间,  默认-1
        jedisPoolConfig.setMaxWaitMillis(6000); // 设置2秒
        //对拿到的connection进行validateObject校验
        jedisPoolConfig.setTestOnBorrow(true);
        //jedis.auth()
        jedis = new JedisCluster(hostAndPortsSet,60000,60000,60000,"123456", jedisPoolConfig);
    }

    public static void main(String[] args) throws InterruptedException {
        String id=jedis.get("id");
        System.out.println("id:"+id);
        System.out.println("jedis:"+jedis);


        //dolist();

        //=================
        // ==================
        //jedis.flushDB();
        //doString();
    }

    private static void doString() throws InterruptedException {
        System.out.println("===========增加数据===========");
        System.out.println(jedis.set("key1","value1"));
        System.out.println(jedis.set("key2","value2"));
        System.out.println(jedis.set("key3", "value3"));
        System.out.println("删除键key2:"+jedis.del("key2"));
        System.out.println("获取键key2:"+jedis.get("key2"));
        System.out.println("修改key1:"+jedis.set("key1", "value1Changed"));
        System.out.println("获取key1的值："+jedis.get("key1"));
        System.out.println("在key3后面加入值："+jedis.append("key3", "End"));
        System.out.println("key3的值："+jedis.get("key3"));
        //命令的时候才会去连接连接，集群中连接是对一个节点连接，不能判断多个key经过crc16算法所对应的槽在一个节点上，不支持多key获取、删除
        //System.out.println("增加多个键值对："+jedis.mset("key01","value01","key02","value02"));
        //System.out.println("获取多个键值对："+jedis.mget("key01","key02","key03"));
        //System.out.println("获取多个键值对："+jedis.mget("key01","key02","key03","key04"));
        //System.out.println("删除多个键值对："+jedis.del(new String[]{"key01","key02"}));
        //System.out.println("获取多个键值对："+jedis.mget("key01","key02","key03"));

        //jedis.flushDB();
        System.out.println("===========新增键值对防止覆盖原先值==============");
        System.out.println(jedis.setnx("key1", "value1"));
        System.out.println(jedis.setnx("key2", "value2"));
        System.out.println(jedis.setnx("key2", "value2-new"));
        System.out.println(jedis.get("key1"));
        System.out.println(jedis.get("key2"));

        System.out.println("===========新增键值对并设置有效时间=============");
        System.out.println(jedis.setex("key3", 2, "value3"));
        System.out.println(jedis.get("key3"));
        TimeUnit.SECONDS.sleep(3);
        System.out.println(jedis.get("key3"));

        System.out.println("===========获取原值，更新为新值==========");//GETSET is an atomic set this value and return the old value command.
        System.out.println(jedis.getSet("key2", "key2GetSet"));
        System.out.println(jedis.get("key2"));
        System.out.println("获得key2的值的字串："+jedis.getrange("key2", 2, 4)); // 相当截取字符串的第二个位置-第四个位置的字符串
    }

    private static void dolist() throws InterruptedException {
        //System.out.println("清空数据："+jedis.flushDB());
        System.out.println("判断某个键是否存在："+jedis.exists("username"));
        System.out.println("新增<'username','wukong'>的键值对："+jedis.set("username", "xiaohai"));
        System.out.println("是否存在:"+jedis.exists("username"));
        System.out.println("新增<'password','password'>的键值对："+jedis.set("password", "123456"));
        //Set<String> keys = jedis.keys("*");
        // System.out.println("系统中所有的键如下："+keys);
        System.out.println("删除键password:"+jedis.del("password"));
        System.out.println("判断键password是否存在："+jedis.exists("password"));
        System.out.println("设置键username的过期时间为10s:"+jedis.expire("username", 10));
        TimeUnit.SECONDS.sleep(2); // 线程睡眠2秒System.out.println("查看键username的剩余生存时间："+jedis.ttl("username"));
        System.out.println("查看键username的剩余生存时间："+jedis.ttl("username"));
        System.out.println("移除键username的生存时间："+jedis.persist("username"));
        System.out.println("查看键username的剩余生存时间："+jedis.ttl("username"));
        System.out.println("查看键username所存储的值的类型："+jedis.type("username"));
    }


}
```





## 2.springboot整合redis

1.创建springboot项目

![image-20210401115815015](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210401115815015.png)

2.项目的pom.xml文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.4.4</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47bootredis01</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47bootredis01</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
```

3.项目的yml.xml文件

```yaml
server:
  servlet:
    context-path: /redis
  port: 8083

#redis配置
spring:
  redis:
    database: 0
    password: 123456
    port: 6379
    timeout: 20s
    jedis:
      pool:
        max-idle: 8
        max-active: 8
        max-wait: -1
        min-idle: 0
    host: 192.168.88.146
```



4.实体类

```java
package com.cssl.pojo;

import java.io.Serializable;
import java.util.Date;

public class Student /*implements Serializable */{

    private Integer sid;
    private String sname;
    private Date birthDay;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    public Student() {
    }

    public Student(Integer sid, String sname, Date birthDay) {
        this.sid = sid;
        this.sname = sname;
        this.birthDay = birthDay;
    }
}
```



5.测试的controller

```java
package com.cssl.controller;

import com.cssl.pojo.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
public class TestController {

    @Autowired
    StringRedisTemplate stringRedisTemplate; //处理字符串

    @Autowired
    RedisTemplate redisTemplate;//处理对象

    @ResponseBody
    @RequestMapping("/test")
    public String test1(){
        System.out.println("测试");

        //保存字符串
        stringRedisTemplate.opsForValue().set("sb","保存点数据，放在redis玩下");
        
        //取出数据看看
        String sb = stringRedisTemplate.opsForValue().get("sb");
        return sb;
    }

    @RequestMapping("/test2")
    @ResponseBody
    public Student test2(){
        System.out.println("test2  .......");
        Student stu=new Student();
        stu.setSid(101);
        stu.setSname("张三");
        stu.setBirthDay(new Date());

        redisTemplate.opsForValue().set("stu2",stu);

        return (Student) redisTemplate.opsForValue().get("stu");

    }
}
```



https://blog.csdn.net/whatlookingfor/article/details/51833378

https://blog.csdn.net/hello_list/article/details/124893755