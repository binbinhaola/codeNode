# 背景

本文介绍了网站应用的演进

随着互联网的发展，网站应用的规模不断扩大，常规的垂直应用架构已无法应对，分布式服务架构以及流动计算架构势在必行，亟需一个治理系统确保架构有条不紊的演进。

![image](https://dubbo.apache.org/imgs/user/dubbo-architecture-roadmap.jpg)

#### 单一应用架构

当网站流量很小时，只需一个应用，将所有功能都部署在一起，以减少部署节点和成本。此时，用于简化增删改查工作量的数据访问框架(ORM)是关键。

#### 垂直应用架构

当访问量逐渐增大，单一应用增加机器带来的加速度越来越小，提升效率的方法之一是将应用拆成互不相干的几个应用，以提升效率。此时，用于加速前端页面开发的Web框架(MVC)是关键。

#### 分布式服务架构

当垂直应用越来越多，应用之间交互不可避免，将核心业务抽取出来，作为独立的服务，逐渐形成稳定的服务中心，使前端应用能更快速的响应多变的市场需求。此时，用于提高业务复用及整合的分布式服务框架(RPC)是关键。

#### 流动计算架构

当服务越来越多，容量的评估，小服务资源的浪费等问题逐渐显现，此时需增加一个调度中心基于访问压力实时管理集群容量，提高集群利用率。此时，用于提高机器利用率的资源调度和治理中心(SOA)是关键。





# 需求

本文介绍了 Dubbo 要解决的需求

![image](https://dubbo.apache.org/imgs/user/dubbo-service-governance.jpg)

在大规模服务化之前，应用可能只是通过 RMI 或 Hessian 等工具，简单的暴露和引用远程服务，通过配置服务的URL地址进行调用，通过 F5 等硬件进行负载均衡。

**当服务越来越多时，服务 URL 配置管理变得非常困难，F5 硬件负载均衡器的单点压力也越来越大。** 此时需要一个服务注册中心，动态地注册和发现服务，使服务的位置透明。并通过在消费方获取服务提供方地址列表，实现软负载均衡和 Failover，降低对 F5 硬件负载均衡器的依赖，也能减少部分成本。

**当进一步发展，服务间依赖关系变得错踪复杂，甚至分不清哪个应用要在哪个应用之前启动，架构师都不能完整的描述应用的架构关系。** 这时，需要自动画出应用间的依赖关系图，以帮助架构师理清关系。

**接着，服务的调用量越来越大，服务的容量问题就暴露出来，这个服务需要多少机器支撑？什么时候该加机器？** 为了解决这些问题，第一步，要将服务现在每天的调用量，响应时间，都统计出来，作为容量规划的参考指标。其次，要可以动态调整权重，在线上，将某台机器的权重一直加大，并在加大的过程中记录响应时间的变化，直到响应时间到达阈值，记录此时的访问量，再以此访问量乘以机器数反推总容量。

以上是 Dubbo 最基本的几个需求。





# 架构

Dubbo 架构

![dubbo-architucture](https://dubbo.apache.org/imgs/user/dubbo-architecture.jpg)

##### 节点角色说明

| 节点        | 角色说明                               |
| ----------- | -------------------------------------- |
| `Provider`  | 暴露服务的服务提供方                   |
| `Consumer`  | 调用远程服务的服务消费方               |
| `Registry`  | 服务注册与发现的注册中心               |
| `Monitor`   | 统计服务的调用次数和调用时间的监控中心 |
| `Container` | 服务运行容器                           |

##### 调用关系说明

1. 服务容器负责启动，加载，运行服务提供者。
2. 服务提供者在启动时，向注册中心注册自己提供的服务。
3. 服务消费者在启动时，向注册中心订阅自己所需的服务。
4. 注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者。
5. 服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。
6. 服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

Dubbo 架构具有以下几个特点，分别是连通性、健壮性、伸缩性、以及向未来架构的升级性。

## 连通性

- 注册中心负责服务地址的注册与查找，相当于目录服务，服务提供者和消费者只在启动时与注册中心交互，注册中心不转发请求，压力较小
- 监控中心负责统计各服务调用次数，调用时间等，统计先在内存汇总后每分钟一次发送到监控中心服务器，并以报表展示
- 服务提供者向注册中心注册其提供的服务，并汇报调用时间到监控中心，此时间不包含网络开销
- 服务消费者向注册中心获取服务提供者地址列表，并根据负载算法直接调用提供者，同时汇报调用时间到监控中心，此时间包含网络开销
- 注册中心，服务提供者，服务消费者三者之间均为长连接，监控中心除外
- 注册中心通过长连接感知服务提供者的存在，服务提供者宕机，注册中心将立即推送事件通知消费者
- 注册中心和监控中心全部宕机，不影响已运行的提供者和消费者，消费者在本地缓存了提供者列表
- 注册中心和监控中心都是可选的，服务消费者可以直连服务提供者

## 健壮性

- 监控中心宕掉不影响使用，只是丢失部分采样数据
- 数据库宕掉后，注册中心仍能通过缓存提供服务列表查询，但不能注册新服务
- 注册中心对等集群，任意一台宕掉后，将自动切换到另一台
- 注册中心全部宕掉后，服务提供者和服务消费者仍能通过本地缓存通讯
- 服务提供者无状态，任意一台宕掉后，不影响使用
- 服务提供者全部宕掉后，服务消费者应用将无法使用，并无限次重连等待服务提供者恢复

## 伸缩性

- 注册中心为对等集群，可动态增加机器部署实例，所有客户端将自动发现新的注册中心
- 服务提供者无状态，可动态增加机器部署实例，注册中心将推送新的服务提供者信息给消费者

## 升级性

当服务集群规模进一步扩大，带动IT治理结构进一步升级，需要实现动态部署，进行流动计算，现有分布式服务架构不会带来阻力。下图是未来可能的一种架构：

![dubbo-architucture-futures](https://dubbo.apache.org/imgs/user/dubbo-architecture-future.jpg)

##### 节点角色说明

| 节点         | 角色说明                               |
| ------------ | -------------------------------------- |
| `Deployer`   | 自动部署服务的本地代理                 |
| `Repository` | 仓库用于存储服务应用发布包             |
| `Scheduler`  | 调度中心基于访问压力自动增减服务提供者 |
| `Admin`      | 统一管理控制台                         |
| `Registry`   | 服务注册与发现的注册中心               |
| `Monitor`    | 统计服务的调用次数和调用时间的监控中心 |





# 用法

Dubbo 的简单实用入门

## 本地服务 Spring 配置

local.xml:

```xml
<bean id=“xxxService” class=“com.xxx.XxxServiceImpl” />
<bean id=“xxxAction” class=“com.xxx.XxxAction”>
    <property name=“xxxService” ref=“xxxService” />
</bean>
```

## 远程服务 Spring 配置

在本地服务的基础上，只需做简单配置，即可完成远程化：

- 将上面的 `local.xml` 配置拆分成两份，将服务定义部分放在服务提供方 `remote-provider.xml`，将服务引用部分放在服务消费方 `remote-consumer.xml`。
- 并在提供方增加暴露服务配置 `<dubbo:service>`，在消费方增加引用服务配置 `<dubbo:reference>`。

remote-provider.xml:

```xml
<!-- 和本地服务一样实现远程服务 -->
<bean id=“xxxService” class=“com.xxx.XxxServiceImpl” /> 
<!-- 增加暴露远程服务配置 -->
<dubbo:service interface=“com.xxx.XxxService” ref=“xxxService” /> 
```

remote-consumer.xml:

```xml
<!-- 增加引用远程服务配置 -->
<dubbo:reference id=“xxxService” interface=“com.xxx.XxxService” />
<!-- 和本地服务一样使用远程服务 -->
<bean id=“xxxAction” class=“com.xxx.XxxAction”> 
    <property name=“xxxService” ref=“xxxService” />
</bean>
```





# 快速开始

快速开始使用 Dubbo

Dubbo 采用全 Spring 配置方式，透明化接入应用，对应用没有任何 API 侵入，只需用 Spring 加载 Dubbo 的配置即可，Dubbo 基于 [Spring 的 Schema 扩展](https://docs.spring.io/spring/docs/4.2.x/spring-framework-reference/html/xsd-configuration.html) 进行加载。

如果不想使用 Spring 配置，可以通过 [API 的方式](https://dubbo.apache.org/zh/docs/v2.7/user/configuration/api) 进行调用。

## 服务提供者

完整安装步骤，请参见：[示例提供者安装](https://dubbo.apache.org/zh/docs/v2.7/admin/install/provider-demo)

### 定义服务接口

DemoService.java [1](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fn:1)：

```java
package org.apache.dubbo.demo;

public interface DemoService {
    String sayHello(String name);
}
```

### 在服务提供方实现接口

DemoServiceImpl.java [2](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fn:2)：

```java
package org.apache.dubbo.demo.provider;
 
import org.apache.dubbo.demo.DemoService;
 
public class DemoServiceImpl implements DemoService {
    public String sayHello(String name) {
        return "Hello " + name;
    }
}
```

### 用 Spring 配置声明暴露服务

provider.xml：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dubbo="http://dubbo.apache.org/schema/dubbo"
    xsi:schemaLocation="http://www.springframework.org/schema/beans        http://www.springframework.org/schema/beans/spring-beans-4.3.xsd        http://dubbo.apache.org/schema/dubbo        http://dubbo.apache.org/schema/dubbo/dubbo.xsd">
 
    <!-- 提供方应用信息，用于计算依赖关系 -->
    <dubbo:application name="hello-world-app"  />
 
    <!-- 使用multicast广播注册中心暴露服务地址 -->
    <dubbo:registry address="multicast://224.5.6.7:1234" />
 
    <!-- 用dubbo协议在20880端口暴露服务 -->
    <dubbo:protocol name="dubbo" port="20880" />
 
    <!-- 声明需要暴露的服务接口 -->
    <dubbo:service interface="org.apache.dubbo.demo.DemoService" ref="demoService" />
 
    <!-- 和本地bean一样实现服务 -->
    <bean id="demoService" class="org.apache.dubbo.demo.provider.DemoServiceImpl" />
</beans>
```

### 加载 Spring 配置

Provider.java：

```java
import org.springframework.context.support.ClassPathXmlApplicationContext;
 
public class Provider {
    public static void main(String[] args) throws Exception {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"META-INF/spring/dubbo-demo-provider.xml"});
        context.start();
        System.in.read(); // 按任意键退出
    }
}
```

## 服务消费者

完整安装步骤，请参见：[示例消费者安装](https://dubbo.apache.org/zh/docs/v2.7/admin/install/consumer-demo)

### 通过 Spring 配置引用远程服务

consumer.xml：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dubbo="http://dubbo.apache.org/schema/dubbo"
    xsi:schemaLocation="http://www.springframework.org/schema/beans        http://www.springframework.org/schema/beans/spring-beans-4.3.xsd        http://dubbo.apache.org/schema/dubbo        http://dubbo.apache.org/schema/dubbo/dubbo.xsd">
 
    <!-- 消费方应用名，用于计算依赖关系，不是匹配条件，不要与提供方一样 -->
    <dubbo:application name="consumer-of-helloworld-app"  />
 
    <!-- 使用multicast广播注册中心暴露发现服务地址 -->
    <dubbo:registry address="multicast://224.5.6.7:1234" />
 
    <!-- 生成远程服务代理，可以和本地bean一样使用demoService -->
    <dubbo:reference id="demoService" interface="org.apache.dubbo.demo.DemoService" />
</beans>
```

### 加载Spring配置，并调用远程服务

Consumer.java [3](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fn:3)：

```java
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.apache.dubbo.demo.DemoService;
 
public class Consumer {
    public static void main(String[] args) throws Exception {
       ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"META-INF/spring/dubbo-demo-consumer.xml"});
        context.start();
        DemoService demoService = (DemoService)context.getBean("demoService"); // 获取远程服务代理
        String hello = demoService.sayHello("world"); // 执行远程方法
        System.out.println( hello ); // 显示调用结果
    }
}
```

------

1. 该接口需单独打包，在服务提供方和消费方共享 [↩︎](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fnref:1)
2. 对服务消费方隐藏实现 [↩︎](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fnref:2)
3. 也可以使用 IoC 注入 [↩︎](https://dubbo.apache.org/zh/docs/v2.7/user/quick-start/#fnref:3)





# SpringBoot+dubbo+zookeerper项目搭建

1.下载安装zookeeper

 https://zookeeper.apache.org/releases.html

![image-20210413100536004](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413100536004.png)

![image-20210413100616092](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413100616092.png)

2.解压到全英文路径下

![image-20210413100710420](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413100710420.png)

![image-20210413100819924](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413100819924.png)

3.添加配置文件，进入到conf中，复制zoo_sample.cfg文件，修改名字为zoo.cfg

![image-20210413100957122](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413100957122.png)

4.修改配置文件信息

![image-20210413101123138](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413101123138.png)

5.进入bin中，启动zookeeper服务和客户端

![image-20210413101225434](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413101225434.png)

6.在客户端执行相关命令

![image-20210413101338599](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413101338599.png)





二：创建springboot项目搭建架构

![image-20210413101520914](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413101520914.png)

2.1 创建公共接口-创建普通maven项目，内容无需依赖其他内容，只要创建公共实体类，和提供者的接口

![image-20210413101650992](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413101650992.png)

2.2 实体类

```java
package com.cssl.pojo;

import java.io.Serializable;
import java.util.Date;

public class Users implements Serializable {
    private Integer usid;
    private String uname;
    private String upwd;
    private String email;
    private Date borndate;
    private String sex;

    public Users() {
    }

    public Users(Integer usid, String uname, String upwd, String email, Date borndate, String sex) {
        this.usid = usid;
        this.uname = uname;
        this.upwd = upwd;
        this.email = email;
        this.borndate = borndate;
        this.sex = sex;
    }

    @Override
    public String toString() {
        return "Users{" +
                "usid=" + usid +
                ", uname='" + uname + '\'' +
                ", upwd='" + upwd + '\'' +
                ", email='" + email + '\'' +
                ", borndate=" + borndate +
                ", sex='" + sex + '\'' +
                '}';
    }

    public Integer getUsid() {
        return usid;
    }

    public void setUsid(Integer usid) {
        this.usid = usid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBorndate() {
        return borndate;
    }

    public void setBorndate(Date borndate) {
        this.borndate = borndate;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
```



2.3 创建接口

```java
package com.cssl.service;

import com.cssl.pojo.Users;

import java.util.List;

public interface UsersService {


    public Users login(String uname, String upwd);

    public List<Users> showAll();
}
```



3.1 创建公共依赖父项目-没有实际代码，只要在pom.xml中导入相关依赖

![image-20210413102017417](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413102017417.png)

3.2 pom.xml文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <packaging>pom</packaging>
    <modules>
        <module>../boot-dubbo-api</module>
    </modules>

    <!--父工程引入springboot依赖-->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.2.10.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>


    <!--本项目坐标-->
    <groupId>com.cssl</groupId>
    <artifactId>boot-dubbo-parent</artifactId>
    <version>1.0-SNAPSHOT</version>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <!--dubbo依赖-->
        <dependency>
            <groupId>org.apache.dubbo</groupId>
            <artifactId>dubbo-spring-boot-starter</artifactId>
            <version>2.7.3</version>
        </dependency>
        <dependency>
            <groupId>org.apache.dubbo</groupId>
            <artifactId>dubbo</artifactId>
            <version>2.7.3</version>
        </dependency>
        <dependency>
            <groupId>org.apache.dubbo</groupId>
            <artifactId>dubbo-dependencies-zookeeper</artifactId>
            <version>2.7.3</version>
            <type>pom</type>
        </dependency>



    </dependencies>

</project>
```





4.1  创建提供者

![image-20210413102347805](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413102347805.png)



4.2 pom.xml依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.cssl</groupId>
        <artifactId>boot-dubbo-parent</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>boot-dubbo-users-provider</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>boot-dubbo-users-provider</name>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <!--引入公共依赖 api  获取实体类和接口-->
        <dependency>
            <groupId>com.cssl</groupId>
            <artifactId>boot-dubbo-api</artifactId>
            <version>0.0.1-SNAPSHOT</version>

        </dependency>

        <!-- mysql-connector-java -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>


        <!--分页插件 -->
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>[1.2.5,)</version>
        </dependency>


        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.1.3</version>
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



4.3 application.yml

```yaml
server:
  port: 9080
dubbo:
  application:
    name: users-provider9080
  registry:
    address: zookeeper://127.0.0.1:2181
  metadata-report:
    address: zookeeper://127.0.0.1:2181
  scan:
    base-packages: com.cssl.service.impl
  protocol:
    name: dubbo
    port: 20888

spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/dubbodb?characterEncoding=utf8&useSSL=false&serverTimezone=UTC
    username: root
    password: ROOT

  jackson:
    date-format: yyyy-MM-dd HH:mm
    time-zone: GMT+8

mybatis:
  type-aliases-package: com.cssl.pojo
  configuration:
    auto-mapping-behavior: full
    use-generated-keys: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
pagehelper:
  auto-dialect: true
  page-size-zero: true
  reasonable: true
```



4.4 Mapper接口

```java
package com.cssl.mapper;

import com.cssl.pojo.Users;

import java.util.List;

public interface UsersMapper {


    public Users userLogin(String uname, String upwd);


    public List<Users> showAll();
}
```



4.5 Mapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper SYSTEM "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="com.cssl.mapper.UsersMapper">

 <select id="userLogin" resultType="users">

   select  * from users where uname=#{uname} and upwd=#{upwd}
 </select>

 <select id="showAll" resultType="users">

  select  * from users
 </select>

</mapper>
```

4.6 业务逻辑层 注意@Service 是dubbo的

```java
package com.cssl.service.impl;

import com.cssl.mapper.UsersMapper;
import com.cssl.pojo.Users;
import com.cssl.service.UsersService;
import org.apache.dubbo.config.annotation.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
@Service  //dubbbo的注解
public class UsersServiceImpl implements UsersService {

    @Autowired
     private UsersMapper usersMapper;
    @Override
    public Users login(String uname, String upwd) {
        return usersMapper.userLogin(uname,upwd);
    }

    @Override
    public List<Users> showAll() {
        return usersMapper.showAll();
    }
}
```



4.7 启动类

```java
package com.cssl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.cssl.mapper")
public class BootDubboUsersProviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(BootDubboUsersProviderApplication.class, args);
    }

}
```





5.1创建消费

![image-20210413103613237](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413103613237.png)



5.2 pom.xml依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <!--父工程引入springboot依赖-->
    <parent>
        <groupId>com.cssl</groupId>
        <artifactId>boot-dubbo-parent</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>

    <groupId>com.cssl</groupId>
    <artifactId>boot-dubbo-users-consumer</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>boot-dubbo-users-consumer</name>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <!--引入公共依赖 api  获取实体类和接口-->
        <dependency>
            <groupId>com.cssl</groupId>
            <artifactId>boot-dubbo-api</artifactId>
            <version>0.0.1-SNAPSHOT</version>

        </dependency>

        <dependency>
            <groupId>com.cssl</groupId>
            <artifactId>common-bean</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
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



5.3 application.yml

```yaml
server:
  port: 6060
  servlet:
    context-path: /users-consumer
dubbo:
  application:
    name: users-consumer6060
  registry:
    address: zookeeper://127.0.0.1:2181
  metadata-report:
    address: zookeeper://127.0.0.1:2181
  protocol:
    name: dubbo
    port: 20889

spring:
  thymeleaf:
    cache: false
    prefix: classpath:/templates/
    suffix: .html
    encoding: UTF-8
  mvc:
    static-path-pattern: /**
  resources:
    static-locations: classpath:/templates/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/
```





5.4 Controller控制器

```java
package com.cssl.controller;

import com.cssl.pojo.Users;
import com.cssl.service.UsersService;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UsersController {

    @Reference
    private UsersService  usersService;

    @RequestMapping("/login")
    public boolean login(String name,String pass){
        return usersService.login(name,pass)==null?false:true;
    }


    @RequestMapping("/showAll")
  public List<Users> showAll(){

        return usersService.showAll();
    }


}
```





5.5 启动类  注意加注解 @EnableDubbo

```java
package com.cssl;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableDubbo
public class BootDubboUsersConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BootDubboUsersConsumerApplication.class, args);
    }

}
```





6.监控类

![image-20210413104325031](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413104325031.png)

直接将jar包，运行 ,在cmd中  java   -jar  dubbo-admin-server-0.2.0.jar  ，观察控制台的端口9898，访问http://127.0.0.1:9898

![image-20210413104549659](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413104549659.png)



另外一版的简化版：

![image-20210413104704330](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413104704330.png)

在conf文件下配置端口

![image-20210413104904692](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413104904692.png)



在bin目录下启动监控服务

![image-20210413104946493](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413104946493.png)

![image-20210413105044039](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210413105044039.png)