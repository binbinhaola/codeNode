# 什么是redis

### 	官网介绍：

Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache, and message broker. Redis 	provides data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs, geospatial 	  indexes, and streams. Redis has built-in replication, Lua scripting, LRU eviction, transactions, and different levels of on-disk  	persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster

翻译：

Redis是一个开源(BSD许可)的内存数据结构存储，被用作数据库、缓存和消息代理。Redis提供数据结构，如字符串，散列，列表，集合，排序集合，范围查询，位图，hyperloglog，地理空间索引和流。Redis内置了复制、Lua脚本、LRU驱逐、事务和不同级别的磁盘持久化，并通过Redis Sentinel和Redis Cluster自动分区提供了高可用性

### 	通俗定义：

- 2008年，意大利的一家创业公司Merzia推出了一款基于MySQL的网站实时统计系统LLOOGG，然而没过多久该公司的创始人 Salvatore Sanfilippo便 对MySQL的性能感到失望，于是他决定亲自为LLOOGG量身定做一个数据库，并于2009年开发完成，这个数据库就是Redis。 不过Salvatore Sanfilippo并不满足只将Redis用于LLOOGG这一款产品，而是希望更多的人使用它，于是在同一年Salvatore Sanfilippo将Redis开源发布，并开始和Redis的另一名主要的代码贡献者Pieter Noordhuis一起继续着Redis的开发，直到今天。Salvatore Sanfilippo自己也没有想到，短短的几年时间，Redis就拥有了庞大的用户群体。Hacker News在2012年发布了一份数据库的使用情况调查，结果显示有近12%的公司在使用Redis。国内如新浪微博、街旁网、知乎网，国外如GitHub、Stack Overflow、Flickr等都是Redis的用户。
- VMware公司从2010年开始赞助Redis的开发， Salvatore Sanfilippo和Pieter Noordhuis也分别在3月和5月加入VMware，全职开发Redis。
- redis是一个nosql(not only sql不仅仅只有sql)数据库.翻译成中文叫做非关系型型数据库
  关系型数据库:以二维表形式存储数据**
  非关系型数据库: 以键值对形式存储数据(key, value形式)
- redis是将数据存放到内存中,由于内容存取速度快所以redis被广泛应用在互联网项目中,

**优点:存取速度快,官方称读取会达到30万次每秒,写在10万次每秒,具体限制于硬件。**

**缺点：对持久化支持不是很友好**
**所以redis一般不作为数据的主数据库存储,一般配合传统的关系型数据库使用.**



### 常见的非关系型数据

​	![img](file:///C:\Users\20936\AppData\Local\Temp\ksohtml14484\wps1.jpg)

### 非关系型数据库分类

##### 	1.键值(Key-Value)存储数据库

​	相关产品： Tokyo Cabinet/Tyrant、Redis、Voldemort、Berkeley DB

​	典型应用： 内容缓存，主要用于处理大量数据的高访问负载。 

​	数据模型： 一系列键值对

​	优势： 快速查询

​	劣势： 存储的数据缺少结构化

#####    2.列存储数据库

​	相关产品：Cassandra, HBase, Riak

​	典型应用：分布式的文件系统

​	数据模型：以列簇式存储，将同一列数据存在一起

​	优势：查找速度快，可扩展性强，更容易进行分布式扩展

​	劣势：功能相对局限

##### 3.文档型数据库

​	相关产品：CouchDB、MongoDB

​	典型应用：Web应用（与Key-Value类似，Value是结构化的）

​	数据模型： 一系列键值对

​	优势：数据结构要求不严格

​	劣势： 查询性能不高，而且缺乏统一的查询语法

##### 4.图形(Graph)数据库

​	相关数据库：Neo4J、InfoGrid、Infinite Graph

​	典型应用：社交网络

​	数据模型：图结构

​	优势：利用图结构相关算法。

​	劣势：需要对整个图做计算才能得出结果，不容易做分布式的集群方案。





# redis应用领域

### redis的主要使用场景：

- 分布式缓存（数据查询、短连接、新闻内容、商品内容等等）
- 分布式session（分布式集群架构中的session分离）
- 论坛、评论首页或前几页（聊天室的在线好友列表）
- 秒杀，抢购.（任务队列）
- 总之是用在数据访问量大,并发量高的情况下
- 应用排行榜
- 网站访问统计
- 数据过期处理（可以精确到毫秒）

# redis的使用

### 	1.使用方式：

​			1.直接使用命令在redis-cli进行操作，需要记住大量命令

​			2.使用开发语言间接操作，例如使用java通过jedis操作

### 	2.redis数据类型

Redis是用C语言开发的一个开源的高性能键值对（key-value）数据库，目前为止Redis支持的键值数据类型：

​	1.字符串：string
​	2.列表list：  redis中使用的是双向循环链表来实现的list,在redis中更像栈
​	3.散列Hash：  一般应用于将redis作为分布式缓存,存储数据库中的数据对象
​	4.集合set：   set中数据是无序的并且不允许重复
​	5.有序集合zset： redis会根据分数自动排序,这里可以使用在学生成绩排序,或者是手机应用商店流行软件排名等需求中

### 3.redis持久化方案:

##### rdb:

原理是：可以设置间隔多长时间保存一次(Redis不用任何配置默认的持久化方案)(dump.rdb)
​	优点:让redis的数据存取速度变快
​	缺点:服务器断电时会丢失部分数据(数据的完整性得不到保证)

##### aof:

原理是：可以设置实时保存(修改配置文件将appendonly改为yes)(appendonly.aof)
	优点:持久化良好,能保证数据的完整性
	缺点:大大降低了redis系统的存取速度

### 4.redis的事务:

### 5.使用jedis连接redis

​	5.1 创建普通maven项目，导入依赖

```xml
<dependencies>
        <!-- https://mvnrepository.com/artifact/redis.clients/jedis -->
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
            <version>3.6.3</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/com.alibaba/fastjson -->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
            <version>1.2.76</version>
        </dependency>


    </dependencies>

```

5.2 测试

```java
package com.cssl;
import redis.clients.jedis.Jedis;
public class TestRedis {
    public static void main(String[] args) {
        //1.创建jedis对象
        Jedis jedis=new Jedis("127.0.0.1",6379);
		System.out.println("测试连接："+jedis.ping());
        //2.执行redis命令
        jedis.set("k1","admin");

        //3.测试结果
        String k1 = jedis.get("k1");
        System.out.println("k1:"+k1);
    }
}
```

```java
package com.cssl;

import redis.clients.jedis.Jedis;

import java.util.Set;

public class TestDemo {
    public static void main(String[] args) {
        //1.创建jedis对象
        Jedis jedis = new Jedis("127.0.0.1", 6379);
        System.out.println("清空数据:" + jedis.flushDB());
        System.out.println("判断某个键是否存在: " + jedis.exists("username"));
        System.out.println("新增< 'username' ,  jack'>的键值对:" + jedis.set("username", "jack"));
        System.out.println("新增< 'password' , ' password '>的键值对:" + jedis.set("password", "pass"));
        System.out.print("系统中所有的键如下:");
        Set<String> keys = jedis.keys("*");
        System.out.println(keys);
        System.out.println("删除键password : " + jedis.del("password"));
        System.out.println("判断password是否存在:" + jedis.exists("password"));
        System.out.println("查看键username所存储的值的类型:" + jedis.type("username"));
        System.out.println("随机返回key空间的一个:" + jedis.randomKey());
        System.out.println("重命名key: " + jedis.rename("username", "name"));
        System.out.println("取出改后的name: " + jedis.get("name"));
        System.out.println("按索引查询: " + jedis.select(0));
        System.out.println("删除当前选择数据库中的所有key: " + jedis.flushDB());
        System.out.println("返回当前数据库中key的数目: " + jedis.dbSize());
        System.out.println("删除所有数据库中的所有key: " + jedis.flushAll());
    }
}


```

实体类：Student

```java
package com.lg26;

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

使用jedis保存对象

```java
package com.lg26;

import redis.clients.jedis.Jedis;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//简单使用redis连接方式
public class Test01 {

    public static void main(String[] args) {
        //Jedis jedis=new Jedis("192.168.88.146",6379);
        Jedis jedis=new Jedis("127.0.0.1",6379);
        //jedis.auth("123456");
        //jedis.set("xx","admin");

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
        String stu1 = jedis.hmset("stu2", map);
        //jedis.hmse
        //jedis.hmset()
        //System.out.println("stusss:"+stu1);
        List<String> hmget = jedis.hmget("stu2", "sname", "borndate");
        for (String s:hmget){
            System.out.println("ss:"+s);
        }
    }
}

```

使用连接池

```java
package com.lg26;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class Test02 {

    public static void main(String[] args) {
        //创建连接池对象
        JedisPool jedispool = new JedisPool("127.0.0.1",6379);
        //从连接池中获取一个连接
        Jedis jedis = jedispool.getResource();
        //jedis.auth("123456");
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

连接redis集群

```java
package com.lg26;

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
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7000));
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7001));
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7002));
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7003));
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7004));
        hostAndPortsSet.add(new HostAndPort("192.168.88.146", 7005));

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



### 6.使用springboot整合redis

6.1 项目依赖pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.2.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>redisboot01</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>redisboot01</name>
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
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.junit.vintage</groupId>
                    <artifactId>junit-vintage-engine</artifactId>
                </exclusion>
            </exclusions>
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



6.2 项目核心配置文件application.yml

```yaml
server:
  port: 8088
  servlet:
    context-path: /redis

spring:
  mvc:
    static-path-pattern: /**
  resources:
    static-locations: classpath:/templates/,classpath:/static/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/public/,classpath:/upload
  thymeleaf:
    encoding: UTF-8
    cache: false
    prefix: classpath:/templates/
    suffix: .html
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8


#redis配置
  redis:
    database: 0
    host: 192.168.88.146
    port: 6379
    password: 123456
    timeout: 10s
    jedis:
      pool:
        max-active: 8
        max-wait: -1
        max-idle: 5
        min-idle: -1
    #集群
#    cluster:
#      nodes:
#      - 192.168.88.146:7000
#      - 192.168.88.146:7001
#      - 192.168.88.146:7002
#      - 192.168.88.146:7003
#      - 192.168.88.146:7004
#      - 192.168.88.146:7005
#
#    #哨兵
#    sentinel:
#      master: mymaster
#      nodes:
#        - 192.168.88.144:26379
#        - 192.168.88.144:26380
#        - 192.168.88.144:26380
```

6.3 项目redis工具类

```java
package com.cssl.utils;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
//@Configuration
//@EnableCaching
public class RedisConfig {
    //默认缓存管理器
    @Bean 
    public CacheManager cacheManager(RedisConnectionFactory factory) {
        RedisCacheManager cacheManager = RedisCacheManager.create(factory);
        return cacheManager;
    }

    //缓存管理器
    //@Bean
   /* public CacheManager cacheManager(RedisConnectionFactory connectionFactory) {

        //反序列化 效率更高些
        ObjectMapper om = new ObjectMapper();
        om.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        om.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        *//*GenericJackson2JsonRedisSerializer serializer = new GenericJackson2JsonRedisSerializer(om);*//*
        Jackson2JsonRedisSerializer<Object> serializer = new Jackson2JsonRedisSerializer<>(Object.class);
        serializer.setObjectMapper(om);

        //设置缓存配置
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig();
        config = config.serializeValuesWith(
                RedisSerializationContext.SerializationPair.fromSerializer(serializer))
                .entryTtl(Duration.ofSeconds(300))   //缓存时间,秒
                .disableCachingNullValues()         //不缓存空值
                .prefixKeysWith("user");            //缓存区间

        //其他
        RedisCacheConfiguration config2 = RedisCacheConfiguration.defaultCacheConfig();
        config2 = config.serializeValuesWith(
                RedisSerializationContext.SerializationPair.fromSerializer(serializer))
                .entryTtl(Duration.ofSeconds(300))   //缓存时间,秒
                .disableCachingNullValues()         //不缓存空值
                .prefixKeysWith("ww");            //缓存区间

        //对每个缓存空间应用不同的配置
        Map<String, RedisCacheConfiguration> configMap = new HashMap<>();
        configMap.put("user", config);
        configMap.put("ww", config2);

        //初始化一个RedisCacheWriter
        RedisCacheWriter redisCacheWriter = RedisCacheWriter.nonLockingRedisCacheWriter(connectionFactory);

        //初始化RedisCacheManager
        RedisCacheManager cacheManager = new RedisCacheManager(redisCacheWriter, config, configMap);
        return cacheManager;
    }*/
}

```

6.4 项目redis自定义模板

```java
package com.cssl.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@Component
public class RedisUtil {

    //引入专门处理redis字符串的模板 直接注入即可
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    //引入通用类型的redis模板 直接注入即可
    @Autowired
    private RedisTemplate redisTemplate;


    @PostConstruct
    public void init(){
        System.out.println("这个方法时测试是否正确获取到模板");
        System.out.println("stringRedisTemplate："+stringRedisTemplate);
        System.out.println("stringRedisTemplateValue："+stringRedisTemplate.getValueSerializer());
        System.out.println("redisTemplate："+redisTemplate);
        System.out.println("redisTemplateValue："+redisTemplate.getValueSerializer());
    }

    /**
     * 写入缓存
     * @param key
     * @param value
     * @return
     */
    public boolean set(final String key, Object value) {
        boolean result = false;
        try {
            ValueOperations<Serializable, Object> operations = redisTemplate.opsForValue();
            operations.set(key, value);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    /**
     * 写入缓存设置失效时间
     * @param key
     * @param value
     * @return
     */
    public boolean set(final String key, Object value, Long expireTime) {
        boolean result = false;
        try {
            ValueOperations<Serializable, Object> operations = redisTemplate.opsForValue();
            operations.set(key, value);
            redisTemplate.expire(key, expireTime, TimeUnit.SECONDS);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    /**
     * 批量删除对应的value
     * @param keys
     */
    public void remove(final String... keys) {
        for (String key : keys) {
            remove(key);
        }
    }

    /**
     * 批量删除key
     * @param pattern
     */
    public void removePattern(final String pattern) {
        Set<Serializable> keys = redisTemplate.keys(pattern);
        if (keys.size() > 0)
            redisTemplate.delete(keys);
    }
    /**
     * 删除对应的value
     * @param key
     */
    public void remove(final String key) {
        if (exists(key)) {
            redisTemplate.delete(key);
        }
    }
    /**
     * 判断缓存中是否有对应的value
     * @param key
     * @return
     */
    public boolean exists(final String key) {
        return redisTemplate.hasKey(key);
    }
    /**
     * 读取缓存
     * @param key
     * @return
     */
    public Object get(final String key) {
        Object result = null;
        ValueOperations<Serializable, Object> operations = redisTemplate.opsForValue();
        result = operations.get(key);
        return result;
    }
    /**
     * 哈希 添加
     * @param key
     * @param hashKey
     * @param value
     */
    public void hmSet(String key, Object hashKey, Object value){
        HashOperations<String, Object, Object> hash = redisTemplate.opsForHash();
        hash.put(key,hashKey,value);
    }

    /**
     * 哈希获取数据
     * @param key
     * @param hashKey
     * @return
     */
    public Object hmGet(String key, Object hashKey){
        HashOperations<String, Object, Object>  hash = redisTemplate.opsForHash();
        return hash.get(key,hashKey);
    }

    /**
     * 列表添加
     * @param k
     * @param v
     */
    public void lPush(String k,Object v){
        ListOperations<String, Object> list = redisTemplate.opsForList();
        list.rightPush(k,v);
    }

    /**
     * 列表获取
     * @param k
     * @param l
     * @param l1
     * @return
     */
    public List<Object> lRange(String k, long l, long l1){
        ListOperations<String, Object> list = redisTemplate.opsForList();
        return list.range(k,l,l1);
    }

    /**
     * 集合添加
     * @param key
     * @param value
     */
    public void add(String key,Object value){
        SetOperations<String, Object> set = redisTemplate.opsForSet();
        set.add(key,value);
    }

    /**
     * 集合获取
     * @param key
     * @return
     */
    public Set<Object> setMembers(String key){
        SetOperations<String, Object> set = redisTemplate.opsForSet();
        return set.members(key);
    }

    /**
     * 有序集合添加
     * @param key
     * @param value
     * @param scoure
     */
    public void zAdd(String key,Object value,double scoure){
        ZSetOperations<String, Object> zset = redisTemplate.opsForZSet();
        zset.add(key,value,scoure);
    }

    /**
     * 有序集合获取
     * @param key
     * @param scoure
     * @param scoure1
     * @return
     */
    public Set<Object> rangeByScore(String key, double scoure, double scoure1){
        ZSetOperations<String, Object> zset = redisTemplate.opsForZSet();
        return zset.rangeByScore(key, scoure, scoure1);
    }
}

```



6.5 项目实体类

```java
package com.cssl.entity;

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



6.6 项目业务接口

```java
package com.cssl.service;

import com.cssl.entity.Student;

import java.util.List;

public interface StudentService {

    public List<Student> showAll();

    public Student findById(Integer sid);
    public Student findById2(Integer sid);
}

```

6.7 接口实现类：

```java
package com.cssl.service.impl;

import com.cssl.entity.Student;
import com.cssl.service.StudentService;
import com.cssl.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class StudentServiceImpl implements StudentService {


    //引入redis模板
    @Autowired
    private RedisUtil redisUtil;

    @Override
    public List<Student> showAll() {
        List<Student> ls=null;
        if(redisUtil.exists("lst")){
            System.out.println("redis中有lst缓存");
            ls=( List<Student>)redisUtil.get("lst");
            for (Student s:ls) {
                System.out.println(s.getSid()+":"+s.getSname());
            }
        }else{
            System.out.println("redis中不存在");
            ls=studentDaoAllData();
            //保存到redis缓存中30秒
            redisUtil.set("lst",ls,30L);
        }

        return ls;
    }

    @Override
    public Student findById(Integer sid) {
        Student stu=null;
        if(redisUtil.exists("student")){
            System.out.println("redis中有student缓存");
            stu=( Student)redisUtil.get("student");

            System.out.println("从缓存中查询："+stu.getSid()+":"+stu.getSname());

        }else{
            System.out.println("redis中不存在student");
            stu=studentDaoOne();
            //保存到redis缓存中
            redisUtil.set("student",stu);
        }

        return stu;
    }


    @Override
    //@CachePut(value="user", key="#id", condition="#id%2==1", unless="#result==null")
    @Cacheable(value="ss", key="#id", condition="#id%2==0", unless="#result==null")
    public Student findById2(Integer id) {
        System.out.println("StudentServiceImpl缓存findById2");
        Student    stu=studentDaoOne();

        return stu;
    }


    //模拟数据访问层 查询出的数据
    public List<Student> studentDaoAllData(){
        try {
            Thread.sleep(1000);
            System.out.println("模拟数据查询延时....");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        List<Student> list=new ArrayList<Student>();
        list.add(new Student(101,"宋江",new Date()));
        list.add(new Student(102,"晁盖",new Date()));
        list.add(new Student(103,"林冲",new Date()));
        list.add(new Student(104,"花荣",new Date()));
        list.add(new Student(105,"鲁智深",new Date()));
        list.add(new Student(106,"武松",new Date()));
        System.out.println("从数据库查询返回对象集合："+list);
        return list;

    }

    //模拟数据访问层 查询出的数据
    public Student studentDaoOne(){
        try {
            Thread.sleep(1000);
            System.out.println("模拟数据查询延时....");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Student student = new Student(106, "武松", new Date());
        System.out.println("从数据库查询返回一个对象："+student);

        return student ;

    }
}

```

6.8  项目控制器

```java
package com.cssl.controller;

import com.cssl.entity.Student;
import com.cssl.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class StudentController {

    @Autowired
    private StudentService studentService;


    @RequestMapping("/getAll")
    public List<Student> getAll(){

      return     studentService.showAll();

    }


    @RequestMapping("/getOne")
    public Student getOne(){

        return     studentService.findById(1);

    }

    @RequestMapping("/getOne2")
    @ResponseBody
    public Student getOne2(Integer id){
        System.out.println("Controller中getOne2:"+id);
        return     studentService.findById2(id);

    }

}

```



6.9 项目启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class Redisboot01Application {

    public static void main(String[] args) {
        SpringApplication.run(Redisboot01Application.class, args);
    }

}

```

