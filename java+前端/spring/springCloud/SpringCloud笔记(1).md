# Spring Cloud

​		Spring Cloud provides tools for developers to quickly build some of the common patterns in distributed systems (e.g. configuration management, service discovery, circuit breakers, intelligent routing, micro-proxy, control bus, one-time tokens, global locks, leadership election, distributed sessions, cluster state). Coordination of distributed systems leads to boiler plate patterns, and using Spring Cloud developers can quickly stand up services and applications that implement those patterns. They will work well in any distributed environment, including the developer’s own laptop, bare metal data centres, and managed platforms such as Cloud Foundry.	

Spring Cloud为开发者提供了快速构建分布式系统中一些常见模式的工具（例如配置管理、服务发现、断路器、智能路由、微代理、控制总线、一次性令牌、全局锁、领导选举、分布式会话、集群状态）。分布式系统间的协作产生了一些样板性质的模式，开发者使用 Spring Cloud 就可以快速地构建基于这些模式的服务和应用。它们在任何分布式环境中都能很好地工作，包括开发人员自己的笔记本电脑、裸机数据中心和托管平台，如Cloud Foundry。

Spring Cloud是一系列框架的[有序集合](https://baike.baidu.com/item/有序集合/994839)。它利用Spring Boot的开发便利性巧妙地简化了分布式系统基础设施的开发，如服务发现注册、配置中心、消息总线、负载均衡、断路器、数据监控等，都可以用Spring Boot的开发风格做到一键启动和部署。Spring Cloud并没有重复制造轮子，它只是将各家公司开发的比较成熟、经得起实际考验的服务框架组合起来，通过Spring Boot风格进行再封装屏蔽掉了复杂的配置和实现原理，最终给开发者留出了一套简单易懂、易部署和易维护的分布式系统开发工具包。

官网：https://spring.io/

中文：https://www.springcloud.cc/

版本：https://github.com/alibaba/spring-cloud-alibaba/wiki/%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E

## 1.Spring Cloud组成

​			Spring Cloud的子项目，大致可分成两类，一类是对现有成熟框架”[Spring Boot](https://baike.baidu.com/item/Spring Boot/20249767)化”的封装和抽象，也是数量最多的项目；第二类是开发了一部分分布式系统的基础设施的实现，如Spring Cloud Stream扮演的就是kafka, ActiveMQ这样的角色。对于我们想快速实践微服务的开发者来说，第一类子项目就已经足够使用，如：

- Spring Cloud Netflix　　是对Netflix开发的一套分布式服务框架的封装，包括服务的发现和注册，负载均衡、断路器、REST客户端、请求路由等。
- Spring Cloud Config　　将配置信息中央化保存, 配置Spring Cloud Bus可以实现动态修改配置文件
- Spring Cloud Bus　　分布式消息队列，是对Kafka, MQ的封装
- Spring Cloud Security　　对Spring Security的封装，并能配合Netflix使用
- Spring Cloud Zookeeper　　对Zookeeper的封装，使之能配置其它Spring Cloud的子项目使用
- Spring Cloud Eureka 是 Spring Cloud Netflix 微服务套件中的一部分，它基于Netflix Eureka 做了二次封装，主要负责完成微服务架构中的服务治理功能。

## 2.Spring Cloud前景

​	   Spring Cloud对于中小型互联网公司来说是一种福音，因为这类公司往往没有实力或者没有足够的资金投入去开发自己的分布式系统基础设施，使用Spring Cloud一站式解决方案能在从容应对业务发展的同时大大减少开发成本。同时，随着近几年微服务架构和[Docker](https://baike.baidu.com/item/Docker)容器概念的火爆，也会让Spring Cloud在未来越来越“云”化的软件开发风格中立有一席之地，尤其是在五花八门的分布式解决方案中提供了标准化的、全站式的技术方案，意义可能会堪比当年[Servlet](https://baike.baidu.com/item/Servlet/477555)规范的诞生，有效推进服务端软件系统技术水平的进步。



The distributed nature of microservices brings challenges. Spring helps you mitigate these. With several ready-to-run cloud patterns, [Spring Cloud](https://spring.io/cloud) can help with service discovery, load-balancing, circuit-breaking, distributed tracing, and monitoring. It can even act as an API gateway.

![image-20210416174208125](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416174208125.png)



参考资料：

微服务的概念：https://www.cnblogs.com/liuning8023/p/4493156.html

性能对比：https://mp.weixin.qq.com/s?__biz=MzA5MzQ2NTY0OA==&mid=2650796496&idx=1&sn=a544b76660484b9914b65f038cc39e6d&chksm=88562c8fbf21a5995909ffa9f172f31651b1ebd04897917e43caef3491954e24ed0d0477a5a1&mpshare=1&scene=23&srcid=01245faqrBlQETYK9c7zVmd3#rd





## 3.Sping Cloud组件之Eureka

### 3.1.创建Springboot项目

![image-20210416175026776](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416175026776.png)

![image-20210416175053370](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416175053370.png)

![image-20210416175324818](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416175324818.png)

![image-20210416181007088](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416181007088.png)

### 3.2.项目pom依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47eureka6060</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47eureka6060</name>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>

    <dependencies>
        <!--注册中心服务端依赖-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
        </dependency>
		<!--安全验证-->
        <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-security</artifactId>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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



### 3.3.application.yml配置

```yaml
server:
  port: 6060   #项目端口
spring:
  application:
    name: eureka6060  #应用名称
  security:   #注册到eureka需要用户名和密码
    user:
      name: admin
      password: 123

eureka:
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
  client:
    fetch-registry: false #是否向eureka server获取列表信息
    register-with-eureka: false #是否向自己注册
    service-url:
      defaultZone: http://localhost:6060/eureka/     #注册地址
  instance:
    hostname: localhost 
```



### 3.4.启动类：

```
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class Kgc47eureka6060Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47eureka6060Application.class, args);
    }

}
```



### 3.5.设置csr检查  （坑）

在2.0以后，需要加入这个检查设置，不然eureka-client无法注册到eureka-server上去

```java
package com.cssl.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable(); //禁止使用csr验证
        super.configure(http);
    }
}
```



### 3.6.运行访问

![image-20210416180542855](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416180542855.png)

![image-20210416180604203](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416180604203.png)



### 3.7.创建eureka-client客户端项目

仍然是创建springboot项目，只是在选择组件的注意

![image-20210416181548439](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210416181548439.png)

### 3.8.项目pom依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47consumer8090</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47consumer8090</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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

### 3.9.application.yml配置

```yaml
server:
  port: 8090

spring:
  application:
    name: consumer8090

eureka:
  client:
    service-url:
      defaultZone: http://admin:123@localhost:6060/eureka/   #注意用户名和密码 @
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
```

### 3.10.启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class Kgc47consumer8090Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47consumer8090Application.class, args);
    }

}
```

### 3.11.查看eureka主页

访问 http://127.0.0.1:6060  ，在applications中显示客户端信息

![image-20210417181458695](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210417181458695.png)

## 4.Spring Cloud组件之Eureka集群



### 4.1.创建eureka-server

application.yml配置

```yaml
server:
  port: 6061
spring:
  application:
    name: eureka6061
eureka:
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
  client:
    fetch-registry: false #是否向eureka server获取列表信息
    register-with-eureka: true #是否向eureka
    service-url:
      defaultZone: http://eureka2.com:6062/eureka/  #向另外一台eureka-server注册本机信息
  instance:
    hostname: eureka1.com
```

```yaml
server:
  port: 6062
spring:
  application:
    name: eureka6062
eureka:
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
  client:
    fetch-registry: false #是否向eureka server获取列表信息
    register-with-eureka: true #是否向eureka
    service-url:
      defaultZone: http://eureka1.com:6061/eureka/ #向另外一台eureka-server注册本机信息
  instance:
    hostname: eureka2.com
```

### 4.2.启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class Kgc47eureka6062Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47eureka6062Application.class, args);
    }

}
```

![image-20210417184006177](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210417184006177.png)



客户端向集群注册服务

```yaml
server:
  port: 9091

spring:
  application:
    name: provider9091

eureka:
  client:
    service-url:
      defaultZone: http://eureka1.com:6061/eureka/, http://eureka2.com:6062/eureka/
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
```

## 5.Spring Cloud 组件之Fegin

​	**什么是Fegin,Fegin是一个声明式的Http客户端,它使得写Http客户端变得更简单,使用Fegin只需要创建一个接口并注解,它具有可插拔的注解特性,Nacos很好的兼容了Fegin,默认实现了负载均衡的效果,底层使用了HttpClient作为服务框架**



Feign(提供者和消费者都要有Web，提供者不需要feign)

### 5.1.依赖的jar包

```xml
<dependency>			
	<groupId>org.springframework.boot</groupId>			
	<artifactId>spring-boot-starter-web</artifactId>		
</dependency>
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
<dependency>			
	<groupId>org.springframework.cloud</groupId>			
	<artifactId>spring-cloud-starter-openfeign</artifactId>		
</dependency>
```





```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47consumer8090</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47consumer8090</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR2</spring-cloud.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>

       <!-- 
       <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        -->

		<!--熔断器-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
        </dependency>
        <!-- actuator暴露监控接口 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>

        <dependency>
            <groupId>com.cssl</groupId>
            <artifactId>kgc47commentbean</artifactId>
            <version>1.0-SNAPSHOT</version>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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



### 5.2.创建Fegin接口

注意该接口应该和提供者的controller里面的请求保持一致

```java
package com.cssl.service;

import com.cssl.bean.Users;
import com.cssl.service.impl.UsersFeginServiceImpl;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
@Component
@FeignClient(name="PROVIDER9091",fallback = UsersFeginServiceImpl.class)
public interface UsersFenginService {
    //这些接口注意：要和提供者controller保持一致

    @RequestMapping("/login")
    public Users login(@RequestParam  String uname, @RequestParam String upwd);

    @RequestMapping("/showAll")
    public List<Users> showAll();

    @RequestMapping("/addUsers")
    public int addUsers(@RequestBody Users users);
}
```

### 5.3.提供者的Controller

```java
package com.cssl.controller;

import com.cssl.bean.Users;
import com.cssl.service.UsersService;
import com.netflix.discovery.converters.Auto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UsersController {
    @Autowired
    private UsersService usersService;

    @RequestMapping("/login")
    public Users login(String uname, String upwd){
        System.out.println("提供者9091---login:::"+uname+"::::"+upwd);
      return  usersService.login(uname,upwd);
    }

    @RequestMapping("/showAll")
    public List<Users> showAll(){

       /* System.out.println("提供者9091---showAll:::");
        try {
            System.out.println("提供者休眠10秒");
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }*/


        return usersService.showAll();
    }

    @RequestMapping("/addUsers")
    public int addUsers(@RequestBody Users users){
        System.out.println("提供者9091---addUsers:::"+users);
        return usersService.addUsers(users);
    }
}
```

### 5.4.消费者的启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients //使用fegin
@EnableCircuitBreaker
public class Kgc47consumer8090Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47consumer8090Application.class, args);
    }

}
```

### 5.5.传值注意事项

## 

**传递单个参数：**

单个参数的传值有两种方式，第一种
使用@RequestParam/@PathVariable进行传值

客户端feign调用接口（@RequestParam）

```java
  @RequestMapping("/ct/selectOne")
  public  Customer selectOne(@RequestParam("id") Integer id);

```

服务提供端

```java
 @RequestMapping("selectOne")
    public Customer selectOne(Integer id) {
        return this.customerService.queryById(id);
    }

```

客户端feign调用接口（@PathVariable）

```java
 @GetMapping("/admin/selectOne/{id}")
 public   String selectOne(@PathVariable("id") Integer id);

```

服务提供端

```java
@RequestMapping("selectOne/{id}")
public Admin selectOne(@PathVariable("id") Integer id) {
        Admin bean = adminService.queryById(id);
        if(bean == null){
            throw new RuntimeException("id:"+id+"没有找到该id的用户");
        }
            return bean;
    }

```

**传递多个参数：**

多个参数的传值可以使用多个@RequestParam来进行传参 【不写启动报错】

```java
java.lang.IllegalStateException: Method has too many Body parameters
```

客户端feign调用接口

```java
   @RequestMapping("/ct/upload")
   public Customer upload(
                      @RequestParam("newFileName") String newFileName,
                      @RequestParam("id")  int id);


```

服务提供端

```java
 @RequestMapping("upload")
    public Customer upload(String newFileName,int id) throws IOException {
        System.out.println("进入提供者-图片上传");
        //设置图片上传路径,是目标文件夹的路径
        // 保存到数据库
        Customer  customer=customerService.queryById(id);
        customer.setImage(newFileName);
        customerService.update(customer);
        return customer;
    }

```

**传对象：**

传对象有两种方式

第一种，使用@SpringQueryMap注解实现

客户端feign调用接口

```java
  @RequestMapping("/ev/insert")
  public  Evaluation insert(@SpringQueryMap Evaluation evaluation);

```

服务提供端

```java
@RequestMapping("insert")
public Evaluation insert(Evaluation evaluation) {
        return evaluationService.insert(evaluation);
}

```

第二种，使用@RequestBody传递参数

客户端feign调用接口

```java
@RequestMapping(value = "/admin/save", method = RequestMethod.POST)
public    Object save(@RequestBody Admin admin);

```

服务提供端

```java
 @PostMapping("save")
    public Object save(@RequestBody Admin admin){
        boolean result = false;
        //判断是添加还是编辑
        if(admin.getId()!=null){
            //编辑
          //  System.out.println("编辑管理员信息");
            result = adminService.update(admin)>0;
        } else {
            //添加
            admin.setRegDate(new Date());
        //    System.out.println("添加管理员信息"+admin);
            result = adminService.insert(admin).getId() != null;
        }
        return  result;
    }

```

**重点：多个参数+对象的传值**



注意：
1、传普通值:消费者Feign接口参数前必须加：@RequestParam(name可以省略,新版本不加异常)，控制器都可以不加
2、传Map：  提供者控制器、消费者控制器、Feign接口参数前都要加：@RequestParam，可以用GET请求(最好POST)
3、传对象：  提供者和Feign接口参数前必须加：@RequestBody，消费者控制器如果是Ajax请求也必须加：@RequestBody
4、传对象：  提供者要使用POST请求，因为原生HttpURLConnection发现只要是对象，就会强制的把get请求转换成POST请求

提供者用get除非替换HttpURLConnection

然后配置：feign.httpclient.enabled = true

```xml
    <!--处理too many byte writes 的异常-->
        <dependency>
            <groupId>org.apache.httpcomponents</groupId>
            <artifactId>httpclient</artifactId>
        </dependency>
        <!-- 使用Apache HttpClient替换Feign原生httpclient -->
        <dependency>
            <groupId>io.github.openfeign</groupId>
            <artifactId>feign-httpclient</artifactId>
            <version>11.9.1</version>
        </dependency>


```



### 5.6.上传文件

可以直接在消费者保存，如果想通过rest传递到提供者，则：spring-cloud-starter-openfeign 在2.0.2.RELEASE版本后，
已经集成了feign-form-spring 以及 feign-form，因此此版本以后不需再额外添加依赖包，也不再需要添加 MultipartSupportConfig 配置

```java
//调用方：
@PostMapping(value="/upload")
    public String upload(MultipartFile files, Users user){ ... }

//Feign客户端：
@PostMapping(value="/upload",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public String upload(@RequestPart MultipartFile file,@RequestParam String username);//不能使用@RequestBody传值

//被调用方：
@PostMapping("/upload")
public String upload(@RequestParam MultipartFile file,String username){
        System.out.println(file.getContentType()+":"+file.getOriginalFilename());
        try {
            file.transferTo(new File("e:/"+file.getOriginalFilename()));
        } catch (IOException e) {           
            return "error";
        }
        return "success";
}
//注意：被调用的服务用@RequestParam，不是@RequestPart
```

1、网页测试返回xml解决：produces = {"application/json;charset=UTF-8"}
2、微服务中如果加了context-path，@FeignClient要加path属性映射，否则404
3、注册中心(Eureka)集群要先配置虚拟域名



## 6.Spring Cloud组件之Hystrix

## 

Spring Cloud Hystrix 是一款优秀的服务容错与保护组件，也是 Spring Cloud 中最重要的组件之一。

Spring Cloud Hystrix 是基于 Netflix 公司的开源组件 Hystrix 实现的，它提供了熔断器功能，能够有效地阻止分布式微服务系统中出现联动故障，以提高微服务系统的弹性。Spring Cloud Hystrix 具有服务降级、服务熔断、线程隔离、请求缓存、请求合并以及实时故障监控等强大功能。

> Hystrix [hɪst'rɪks]，中文含义是豪猪，豪猪的背上长满了棘刺，使它拥有了强大的自我保护能力。而 Spring Cloud Hystrix 作为一个服务容错与保护组件，也可以让服务拥有自我保护的能力，因此也有人将其戏称为“豪猪哥”。

在微服务系统中，Hystrix 能够帮助我们实现以下目标：

- **保护线程资源**：防止单个服务的故障耗尽系统中的所有线程资源。
- **快速失败机制**：当某个服务发生了故障，不让服务调用方一直等待，而是直接返回请求失败。
- **提供降级（FallBack）方案**：在请求失败后，提供一个设计好的降级方案，通常是一个兜底方法，当请求失败后即调用该方法。
- **防止故障扩散**：使用熔断机制，防止故障扩散到其他服务。
- **监控功能**：提供熔断器故障监控组件 Hystrix Dashboard，随时监控熔断器的状态。H.SR2

## Hystrix 服务降级

http://www.360doc.com/content/22/0223/20/59494473_1018723888.shtml

Hystrix 提供了服务降级功能，能够保证当前服务不受其他服务故障的影响，提高服务的健壮性。

服务降级的使用场景有以下 2 种：

- 在服务器压力剧增时，根据实际业务情况及流量，对一些不重要、不紧急的服务进行有策略地不处理或简单处理，从而释放服务器资源以保证核心服务正常运作。
- 当某些服务不可用时，为了避免长时间等待造成服务卡顿或雪崩效应，而主动执行备用的降级逻辑立刻返回一个友好的提示，以保障主体业务不受影响。


我们可以通过重写 HystrixCommand 的 getFallBack() 方法或 HystrixObservableCommand 的 resumeWithFallback() 方法，使服务支持服务降级。

Hystrix 服务降级 FallBack 既可以放在服务端进行，也可以放在客户端进行。

Hystrix 会在以下场景下进行服务降级处理：

- 程序运行异常
- 服务超时
- 熔断器处于打开状态
- 线程池资源耗尽



## 

分别演示下 Hystrix 服务端服务降级和客户端服务降级。

#### 服务端服务降级

服务熔断降级：(导了Feign也需要引入hystrix)  在提供者中添加 

```xml

<!--hystrix 依赖-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
```

在消费者的main方法上加上注解

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient // 只支持eureka
//@EnableDiscoveryClient//适配任何注册中心 zookeeper redis nacos eureka
@EnableFeignClients //开启远程调用支持
@EnableCircuitBreaker //开启熔断支持
public class KgcCloudUserConsumer8080Application {

    public static void main(String[] args) {
        SpringApplication.run(KgcCloudUserConsumer8080Application.class, args);
    }

}

```



```yaml
server:
  port: 9090

spring:
  application:
    name: lg33-cloud-provider-9090

eureka:
  client:
    service-url:
      defaultZone: http://root:root@127.0.0.1:6060/eureka/


```

消费者测试案例一：

```java
package com.cssl.controller;

import com.cssl.pojo.Users;
import com.cssl.sevice.UsersServiceFegin;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.*;

@RestController //熔断测试
public class CircuitBreakerController {
    
    @Autowired
    private UsersServiceFegin usersServiceFegin;
    
    @RequestMapping("/breaker/findById/{uid}")
    @HystrixCommand(fallbackMethod = "hystrixMethod")
    @ResponseBody
    public Users breakerFindById(
            @PathVariable("uid") Integer uid){
        System.out.println("这个是消费者8080---breakerFindById:"+uid);
        if(uid%2==0){
            throw  new RuntimeException("uid==>"+uid+"，不存这个id,找不到数据");
        }else{
            return  usersServiceFegin.findById(uid);
        }
        
    }
    
    //备用方法
    public Users hystrixMethod(
            @PathVariable(name = "uid") Integer uid
    ){
        System.out.println("这个是熔断方法hystrixMethod---uid:"+uid);
       Users users=new Users();
       users.setUname("没有值，这个是默认的张三");
       users.setBorndate(new Date());
       users.setEmail("123456@qq.com");
       users.setUpwd("123456");
       users.setSex("男");
       users.setUsid(uid);
      
       return users;
       
    }
}

```









提供者中定义业务逻辑层接口

```java
package com.cssl.service;

public interface UserService {
    
    //测试hystrix熔断器示例
    public String user_ok(Integer id);
    //测试hystrix 熔断器超时
    public String user_TimeOut(Integer id);
}

```

提供者中定义业务逻辑层接口实现类：

```java
package com.cssl.service.imp;

import com.cssl.service.UserService;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixProperty;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements UserService {
    @Override
    public String user_ok(Integer id) {
        
        return "线程池："+Thread.currentThread().getName()+",user_ok,ID:"+id;
        
        
    }
    @HystrixCommand(
            fallbackMethod = "user_TimeOutHandler",
            commandProperties =
                    //规定 5 秒钟以内就不报错，正常运行，超过 5 秒就报错，调用指定的方法
                    {@HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "5000")})
    @Override
    public String user_TimeOut(Integer id) {
        int outTime=3;
        try {
            TimeUnit.SECONDS.sleep(outTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "线程池："+Thread.currentThread().getName()+",user_TimeOut,"+id+",耗时："+outTime;
    }
    
    // 当服务出现故障后，调用该方法给出友好提示
    public String user_TimeOutHandler(Integer id){
    
        return  "后台提醒您，系统繁忙请稍后再试！"+"线程池：" + Thread.currentThread().getName() + "  user_TimeOut,id:   " + id;
    }
     
}

```

提供者中Controller添加测试方法

```java
 @Autowired
    private UserService userService;
    
    @Value("${server.port}")
    private String serverPort;
    
    
    @RequestMapping(value = "/user/hystrix/ok/{id}")
    public String userInfo_Ok(@PathVariable("id") Integer id) {
        String result = userService.user_ok(id);
        System.out.println("端口号：" + serverPort + " result:" + result);
        return result + "，   端口号：" + serverPort;
    }
    // Hystrix 服务超时降级
    @RequestMapping(value = "/user/hystrix/timeout/{id}")
    public String userInfo_Timeout(@PathVariable("id") Integer id) {
        String result = userService.user_TimeOut(id);
        System.out.println("端口号：" + serverPort + " result:" + result);
        return result + "，   端口号：" + serverPort;
    }
    
```

![image-20220724173843596](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724173843596.png)

![image-20220724173824801](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724173824801.png)

![image-20220724173904897](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724173904897.png)



![image-20220724173948904](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724173948904.png)

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableDiscoveryClient
//@EnableEurekaClient

@EnableCircuitBreaker //开启熔断降级

public class Lg32CloudProvider9091Application {

    public static void main(String[] args) {
        SpringApplication.run(Lg32CloudProvider9091Application.class, args);
    }

}
```





#### 客户端服务降级----  springcloud降级的使用

通常情况下，我们都会在客户端进行服务降级，当客户端调用的服务端的服务不可用时，客户端直接进行服务降级处理，避免其线程被长时间、不必要地占用。

1.消费者项目中依赖pom.xml

```xml
 <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
 </dependency>
```

2.消费者项目application.yml 开启降级开关为true

```yaml
feign:
  hystrix:
    enabled: true   #默认false
    
######################### Ribbon 客户端超时控制 ###################################
ribbon:
  ReadTimeout: 6000 #建立连接所用的时间，适用于网络状况正常的情况下，两端两端连接所用的时间
  ConnectionTimeout: 6000 #建立连接后，服务器读取到可用资源的时间
######################配置请求超时时间##########################
hystrix:
  command:
    default:
      execution:
        isolation:
          thread:
            timeoutInMilliseconds: 7000

    ####################配置具体方法超时时间 为 3 秒########################
    DeptHystrixService#deptInfo_Timeout(Integer):
      execution:
        isolation:
          thread:
            timeoutInMilliseconds: 3000
```

消费者Feign接口中定义方法

```java
 //=====================hystrix==============================
    
    @RequestMapping(value = "/user/hystrix/ok/{id}")
    public String user_Ok(@PathVariable("id") Integer id);

    @RequestMapping(value = "/user/hystrix/timeout/{id}")
    public String user_Timeout(@PathVariable("id") Integer id);
```

消费这个Controller中定义测试方法：

```java
//=================================hystrix================
    
    @RequestMapping(value = "/consumer/user/hystrix/ok/{id}")
    public String userInfo_Ok(@PathVariable("id") Integer id) {
        System.out.println("消费者8080--:"+id);
        return userFeignClient.user_Ok(id);
    }
    //在客户端进行降级
    @RequestMapping(value = "/consumer/user/hystrix/timeout/{id}")
    @HystrixCommand(fallbackMethod = "user_TimeoutHandler") //为该请求指定专属的回退方法
    public String userInfo_Timeout(@PathVariable("id") Integer id) {
        String s = userFeignClient.user_Timeout(id);
        System.out.println("测试超时----："+s);
      
        return s;
    }
    // deptInfo_Timeout方法的 专用 fallback 方法
    public String user_TimeoutHandler(@PathVariable("id") Integer id) {
        System.out.println("userInfo_Timeout 出错，服务已被降级！");
        return "提醒您：服务端系统繁忙，请稍后再试！（客户端 userInfo_Timeout 专属的回退方法触发）";
    }
```

主方法：

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients //开启feign调用
@EnableCircuitBreaker //熔断 
public class Lg33CloudConsumer8080Application {

    public static void main(String[] args) {
        SpringApplication.run(Lg33CloudConsumer8080Application.class, args);
    }

}

```

![image-20220724211018103](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724211018103.png)

把提供超时秒数改大7秒，测试之后

![image-20220724211156543](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724211156543.png)

全局配置降级：



```java
package com.cssl.feign.impl;

import com.cssl.feign.UserFeignClient;
import com.cssl.pojo.User;
import org.springframework.stereotype.Component;

import java.util.Map;
//@Component
public class UserFeginClientImpl implements UserFeignClient {
    @Override
    public String hello(String mess) {
        System.out.println("系统降级----hello方法");
        return "系统正忙，请稍后重试";
    }
    
    @Override
    public String login(String name, String password) {
        return null;
    }
    
    @Override
    public String login2(Map map) {
        return null;
    }
    
    @Override
    public String login3(User user) {
        return null;
    }
    
    @Override
    public String user_Ok(Integer id) {
        return null;
    }
    
    @Override
    public String user_Timeout(Integer id) {
        return null;
    }
}

```

```java
//在feign接口上指定fallback =UserFeginClientImpl.class 

@Component //动态代理生产这个feign的实现类
@FeignClient(name = "LG33-CLOUD-PROVIDER-9090",fallback =UserFeginClientImpl.class ) //指定提供者服务名称
public interface UserFeignClient {
    
```

熔断：当下游的服务因为某种原因响应过慢（响应慢），下游服务主动停掉一些不太重要的业务，释放出服务器资源，增加响应速度！
降级：当下游的服务因为某种原因不可用（提供者死亡），上游服务主动调用本地的一些降级逻辑，避免卡顿，迅速返回给用户！
服务降级有很多种降级方式！如开关降级、限流降级、熔断降级!

### 6.1.依赖的jar包

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
<!-- actuator暴露监控接口 -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

### 6.2.注解

@EnableCircuitBreaker：注解启动类(@HystrixCommand也需要该注解支持)
@HystrixCommand(fallbackMethod="callback")：服务请求方法异常后去调用callback方法返回(注意两方法参数要一致)
@FeignClient(name="...",fallback=ClientImpl.class)：消费者调用服务失败或无法调用则改调用ClientImpl类的方法返回
备注：ClientImpl类实现Feign接口并使用@Component注入容器

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients //使用fegin
@EnableCircuitBreaker //熔断
public class Kgc47consumer8090Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47consumer8090Application.class, args);
    }

}
```

### 6.3.yml配置

```yaml
server:
  port: 8090
spring:
  application:
    name: consumer8090
  mvc:
    format:
      date-time: yyyy-MM-dd HH:mm:ss
  jackson:
    time-zone: GMT+8
    date-format: yyyy-MM-dd HH:mm:ss
eureka:
  client:
    service-url:
      #defaultZone: http://admin:123@localhost:6060/eureka/
      defaultZone: http://eureka1.com:6061/eureka/, http://eureka2.com:6062/eureka/
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）

provider9091: #服务名
  ribbon:
    #NFloadBalancerRuleClassName: com.netflix.loadbalancer.RandomRule  #随机策略
    NFloadBalancerRuleClassName: com.netflix.loadbalancer.RoundRobinRule #轮询
    NFLoadBalancerRuleClassName: com.netflix.loadbalancer.WeightedResponseTimeRule #权重
    NFLoadBalancerRuleClassName: com.netflix.loadbalancer.BestAvailableRule #最小连接数
    NFLoadBalancerRuleClassName: com.netflix.loadbalancer.AvailabilityFilteringRul #过滤掉非健康
    NFLoadBalancerRuleClassName: com.netflix.loadbalancer.ZoneAvoidanceRule #区域敏感策略

feign:
  hystrix:
    enabled: true   #默认false
  client:
    config:
      default:
        connectTimeout: 2000
        readTimeout: 2000


management:
  endpoints:
    web:
      exposure:
        include: "*"
        #include: hystrix.stream
  endpoint:
    health:
      show-details: ALWAYS

hystrix:
  command:
    default:
      circuitBreaker:
        sleepWindowInMilliseconds: 5000   	#过多长时间，熔断器再次检测是否开启，默认为5000，即5s钟
        errorThresholdPercentage: 50	#错误率，默认50%
        forceOpen: false			#强制打开断路器，默认false(true打开后会强制断开服务)
```

http://127.0.0.1:8001/actuator

=====================熔断===============

## Hystrix 服务熔断

熔断机制是为了应对雪崩效应而出现的一种微服务链路保护机制。

当微服务系统中的某个微服务不可用或响应时间太长时，为了保护系统的整体可用性，熔断器会暂时切断请求对该服务的调用，并快速返回一个友好的错误响应。这种熔断状态不是永久的，在经历了一定的时间后，熔断器会再次检测该微服务是否恢复正常，若服务恢复正常则恢复其调用链路。

#### 熔断状态

在熔断机制中涉及了三种熔断状态：

- 熔断关闭状态（Closed）：当务访问正常时，熔断器处于关闭状态，服务调用方可以正常地对服务进行调用。
- 熔断开启状态（Open）：默认情况下，在固定时间内接口调用出错比率达到一个阈值（例如 50%），熔断器会进入熔断开启状态。进入熔断状态后，后续对该服务的调用都会被切断，熔断器会执行本地的降级（FallBack）方法。
- 半熔断状态（Half-Open）： 在熔断开启一段时间之后，熔断器会进入半熔断状态。在半熔断状态下，熔断器会尝试恢复服务调用方对服务的调用，允许部分请求调用该服务，并监控其调用成功率。如果成功率达到预期，则说明服务已恢复正常，熔断器进入关闭状态；如果成功率仍旧很低，则重新进入熔断开启状态。

三种熔断状态之间的转化关系如下图：

![熔断状态转换](http://c.biancheng.net/uploads/allimg/211210/10162355X-7.png)

#### Hystrix 实现熔断机制

在 Spring Cloud 中，熔断机制是通过 Hystrix 实现的。Hystrix 会监控微服务间调用的状况，当失败调用到一定比例时（例如 5 秒内失败 20 次），就会启动熔断机制。

Hystrix 实现服务熔断的步骤如下：

1. 当服务的调用出错率达到或超过 Hystix 规定的比率（默认为 50%）后，熔断器进入熔断开启状态。
2. 熔断器进入熔断开启状态后，Hystrix 会启动一个休眠时间窗，在这个时间窗内，该服务的降级逻辑会临时充当业务主逻辑，而原来的业务主逻辑不可用。
3. 当有请求再次调用该服务时，会直接调用降级逻辑快速地返回失败响应，以避免系统雪崩。
4. 当休眠时间窗到期后，Hystrix 会进入半熔断转态，允许部分请求对服务原来的主业务逻辑进行调用，并监控其调用成功率。
5. 如果调用成功率达到预期，则说明服务已恢复正常，Hystrix 进入熔断关闭状态，服务原来的主业务逻辑恢复；否则 Hystrix 重新进入熔断开启状态，休眠时间窗口重新计时，继续重复第 2 到第 5 步。

在提供者UserService中添加：

```java
//==========================// hystrix 熔断器示例 ok==============
    public String userInfo_Ok2(Integer id);
   
    //hystrix 熔断器超时案例
    public String userInfo_Timeout2(Integer id);
    // Hystrix 熔断机制案例
    public String userCircuitBreaker2(Integer id);


```

在UserServiceImp实现类中：

```java
package com.cssl.service.imp;

import com.cssl.service.UserService;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixProperty;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements UserService {
    @Override
    public String user_ok(Integer id) {
        
        return "线程池："+Thread.currentThread().getName()+",user_ok,ID:"+id;
        
        
    }
    @HystrixCommand(
            fallbackMethod = "user_TimeOutHandler",
            commandProperties =
                    //规定 5 秒钟以内就不报错，正常运行，超过 5 秒就报错，调用指定的方法
                    {@HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "5000")})
    @Override
    public String user_TimeOut(Integer id) {
        int outTime=7;
        try {
            TimeUnit.SECONDS.sleep(outTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "线程池："+Thread.currentThread().getName()+",user_TimeOut,"+id+",耗时："+outTime;
    }
    
    
    
    // 当服务出现故障后，调用该方法给出友好提示
    public String user_TimeOutHandler(Integer id){
    
        return  "后台提醒您，系统繁忙请稍后再试！"+"线程池：" + Thread.currentThread().getName() + "  user_TimeOut,id:   " + id;
    }
    
    
    @Override
    @HystrixCommand(fallbackMethod = "userCircuitBreaker_fallback", commandProperties = {
            //以下参数在 HystrixCommandProperties 类中有默认配置
            @HystrixProperty(name = "circuitBreaker.enabled", value = "true"), //是否开启熔断器
            @HystrixProperty(name = "metrics.rollingStats.timeInMilliseconds",value = "1000"), //统计时间窗
            @HystrixProperty(name = "circuitBreaker.requestVolumeThreshold", value = "10"), //统计时间窗内请求次数
            @HystrixProperty(name = "circuitBreaker.sleepWindowInMilliseconds", value = "10000"), //休眠时间窗口期
            @HystrixProperty(name = "circuitBreaker.errorThresholdPercentage", value = "60"), //在统计时间窗口期以内，请求失败率达到 60% 时进入熔断状态
    })
    public String userCircuitBreaker2(Integer id) {
        if (id < 0) {
            //当传入的 id 为负数时，抛出异常，调用降级方法
            throw new RuntimeException("后台系统提醒您，id 不能是负数！");
        }
        String serialNum = UUID.randomUUID().toString().replace("-", "").toLowerCase();
        
        
        return Thread.currentThread().getName() + "\t" + "调用成功，流水号为：" + serialNum;
    }
    
    //deptCircuitBreaker 的降级方法
    public String userCircuitBreaker_fallback(Integer id) {
        return "后台系统提醒您，id 不能是负数,请稍后重试!\t id:" + id;
    }
    

}

```

提供者的Controller中:

```java
 // Hystrix 服务熔断
    @RequestMapping(value = "/user/hystrix/circuit/{id}")
    public String deptCircuitBreaker(@PathVariable("id") Integer id){
        String result = userService.userCircuitBreaker2(id);
        System.out.println("result:"+result);
        return result;
    }
```



![image-20220724214149883](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724214149883.png)

![image-20220724214322075](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220724214322075.png)







在以上代码中，共涉及到了 4 个与 Hystrix 熔断机制相关的重要参数，这 4 个参数的含义如下表。



| 参数                                     | 描述                                                         |
| ---------------------------------------- | ------------------------------------------------------------ |
| metrics.rollingStats.timeInMilliseconds  | 统计时间窗。                                                 |
| circuitBreaker.sleepWindowInMilliseconds | 休眠时间窗，熔断开启状态持续一段时间后，熔断器会自动进入半熔断状态，这段时间就被称为休眠窗口期。 |
| circuitBreaker.requestVolumeThreshold    | 请求总数阀值。  在统计时间窗内，请求总数必须到达一定的数量级，Hystrix 才可能会将熔断器打开进入熔断开启转态，而这个请求数量级就是 请求总数阀值。Hystrix 请求总数阈值默认为 20，这就意味着在统计时间窗内，如果服务调用次数不足 20 次，即使所有的请求都调用出错，熔断器也不会打开。 |
| circuitBreaker.errorThresholdPercentage  | 错误百分比阈值。  当请求总数在统计时间窗内超过了请求总数阀值，且请求调用出错率超过一定的比例，熔断器才会打开进入熔断开启转态，而这个比例就是错误百分比阈值。错误百分比阈值设置为 50，就表示错误百分比为 50%，如果服务发生了 30 次调用，其中有 15 次发生了错误，即超过了 50% 的错误百分比，这时候将熔断器就会打开。 |



## Hystrix 故障监控

Hystrix 还提供了准实时的调用监控（Hystrix Dashboard）功能，Hystrix 会持续地记录所有通过 Hystrix 发起的请求的执行信息，并以统计报表的形式展示给用户，包括每秒执行请求的数量、成功请求的数量和失败请求的数量等。

下面我们就通过一个实例来搭建 Hystrix Dashboard，监控指定程序的运行情况。





## 7.Spring Cloud组件之Ribbon

Spring Cloud Ribbon是一个基于HTTP和TCP的客户端负载均衡工具，它基于Netflix Ribbon实现。通过Spring Cloud的封装，可以让我们轻松地将面向服务的REST模版请求自动转换成客户端负载均衡的服务调用。Spring Cloud Ribbon虽然只是一个工具类框架，它不像服务注册中心、配置中心、API网关那样需要独立部署，但是它几乎存在于每一个Spring Cloud构建的微服务和基础设施中。因为微服务间的调用，API网关的请求转发等内容，实际上都是通过Ribbon来实现的，包括后续我们将要介绍的Feign，它也是基于Ribbon实现的工具。所以，对Spring Cloud Ribbon的理解和使用，对于我们使用Spring Cloud来构建微服务非常重要。



### 7.1客户端负载均衡

负载均衡在系统架构中是一个非常重要，并且是不得不去实施的内容。因为负载均衡是对系统的高可用、网络压力的缓解和处理能力扩容的重要手段之一。我们通常所说的负载均衡都指的是服务端负载均衡，其中分为硬件负载均衡和软件负载均衡。硬件负载均衡主要通过在服务器节点之间按照专门用于负载均衡的设备，比如F5等；而软件负载均衡则是通过在服务器上安装一些用于负载均衡功能或模块等软件来完成请求分发工作，比如Nginx等。不论采用硬件负载均衡还是软件负载均衡，只要是服务端都能以类似下图的架构方式构建起来



![img](https://upload-images.jianshu.io/upload_images/8796251-20be966344ffe722.png?imageMogr2/auto-orient/strip|imageView2/2/w/786/format/webp)

 硬件负载均衡的设备或是软件负载均衡的软件模块都会维护一个下挂可用的服务端清单，通过心跳检测来剔除故障的服务端节点以保证清单中都是可以正常访问的服务端节点。当客户端发送请求到负载均衡设备的时候，该设备按某种算法（比如线性轮询、按权重负载、按流量负载等）从维护的可用服务端清单中取出一台服务端端地址，然后进行转发。

​    而客户端负载均衡和服务端负载均衡最大的不同点在于上面所提到服务清单所存储的位置。在客户端负载均衡中，所有客户端节点都维护着自己要访问的服务端清单，而这些服务端端清单来自于服务注册中心，比如上一章我们介绍的Eureka服务端。同服务端负载均衡的架构类似，在客户端负载均衡中也需要心跳去维护服务端清单的健康性，默认会创建针对各个服务治理框架的Ribbon自动化整合配置



### 7.2客户端yaml配置

客户端配置(这里是针对提供者的负载均衡)无效？

```yaml
users-provider: #服务名
    ribbon:
    	NFloadBalancerRuleClassName: com.netflix.loadbalancer.RandomRule  #随机
   	 	NFloadBalancerRuleClassName: com.netflix.loadbalancer.WeightedResponseTimeRule  #权重
   	 	NFloadBalancerRuleClassName: com.netflix.loadbalancer.RoundRobinRule #轮询
```





## 8.Spring Boot-admin-server监控

### 8.1.创建监控服务（springboot）

![image-20210420151528780](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420151528780.png)



![image-20210420151702924](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420151702924.png)

### 8.2.项目的pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.10.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47adminui</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47adminui</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
        <spring-boot-admin.version>2.3.1</spring-boot-admin.version>

    </properties>
    <dependencies>
        <!--web依赖-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
         <!--springboot admin 监控服务-->
        <dependency>
            <groupId>de.codecentric</groupId>
            <artifactId>spring-boot-admin-starter-server</artifactId>
            <version>2.1.5</version>
        </dependency>
		<!--注册中心客户端-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
            <version>2.2.1.RELEASE</version>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>de.codecentric</groupId>
                <artifactId>spring-boot-admin-dependencies</artifactId>
                <version>${spring-boot-admin.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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

### 8.3.application.yaml配置信息

```yaml
server:
  port: 5052
spring:
  application:
    name: admin-server

eureka:
  client:
    service-url:
      #defaultZone: http://admin:123@localhost:6060/eureka/
      defaultZone: http://eureka1.com:6061/eureka/, http://eureka2.com:6062/eureka/
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）
```

### 8.4.启动类

```java
package com.cssl;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@EnableAdminServer //监控服务端
@SpringBootApplication
public class Kgc47adminuiApplication {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47adminuiApplication.class, args);
    }

}
```

### 8.5.访问主页 

http://127.0.0.1:5052

![image-20210420152220996](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420152220996.png)



## 9.Spring Boot-admin-server-client客户端

### 9.1.创建springcloud项目

### 9.2.pom.xml依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47consumer8090</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47consumer8090</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>

       <!-- <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>-->



        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
        </dependency>

         <!-- spring boot adminclient 客户端-->
        <dependency>
            <groupId>de.codecentric</groupId>
            <artifactId>spring-boot-admin-starter-client</artifactId>
            <version>2.1.5</version>
        </dependency>

        <!-- 注意：导入上面的依赖 需要注释掉该依赖actuator暴露监控接口 -->
       <!-- <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>-->

        <dependency>
            <groupId>com.cssl</groupId>
            <artifactId>kgc47commentbean</artifactId>
            <version>1.0-SNAPSHOT</version>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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

### 9.3.application.yml配置

```yaml
server:
  port: 8090
spring:
  application:
    name: consumer8090
  mvc:
    format:
      date-time: yyyy-MM-dd HH:mm:ss
  jackson:
    time-zone: GMT+8
    date-format: yyyy-MM-dd HH:mm:ss
  #将自己注册到springboot-admin-server
  boot:
    admin:
      client:
        url: http://127.0.0.1:5052   #springboot-admin-server地址
eureka:
  client:
    service-url:
      #defaultZone: http://admin:123@localhost:6060/eureka/
      defaultZone: http://eureka1.com:6061/eureka/, http://eureka2.com:6062/eureka/
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）


provider9091: #服务名
  ribbon:
    #NFloadBalancerRuleClassName: com.netflix.loadbalancer.RandomRule  #随机策略
    NFloadBalancerRuleClassName: com.netflix.loadbalancer.RoundRobinRule #轮询




feign:
  hystrix:
    enabled: true   #默认false

management:
  endpoints:
    web:
      exposure:
        include: "*" #全部监控
        #include: hystrix.stream
  endpoint:
    health:
      show-details: ALWAYS

hystrix:
  command:
    default:
      circuitBreaker:
        sleepWindowInMilliseconds: 5000    #过多长时间，熔断器再次检测是否开启，默认为5000，即5s钟
        errorThresholdPercentage: 50   #错误率，默认50%
        forceOpen: false         #强制打开断路器，默认false(true打开后会强制断开服务)
```

### 9.4.启动类上无需其他注解

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients //使用fegin
@EnableCircuitBreaker
public class Kgc47consumer8090Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47consumer8090Application.class, args);
    }

}
```

### 9.5.监控界面效果

![image-20210420152822650](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420152822650.png)



## 10.Spring Cloud 组件之Zuul

### 10.1. Zuul网关的概念

- **Zuul是spring cloud中的微服务网关。网关： 是一个网络整体系统中的前置门户入口。请求首先通过网关，进行路径的路由，定位到具体的服务节点上。**
- **Zuul是一个微服务网关，首先是一个微服务。也是会在Eureka注册中心中进行服务的注册和发现。也是一个网关，请求应该通过Zuul来进行路由。**
- **Zuul网关不是必要的。是推荐使用的。**
- **使用Zuul，一般在微服务数量较多（多于10个）的时候推荐使用，对服务的管理有严格要求的时候推荐使用，当微服务权限要求严格的时候推荐使用。**

### 10.2. Zuul网关的作用

　　网关有以下几个作用：

- 统一入口：未全部为服务提供一个唯一的入口，网关起到外部和内部隔离的作用，保障了后台服务的安全性。
- 鉴权校验：识别每个请求的权限，拒绝不符合要求的请求。
- 动态路由：动态的将请求路由到不同的后端集群中。
- 减少客户端与服务端的耦合：服务可以独立发展，通过网关层来做映射。
- ![img](https://img2018.cnblogs.com/blog/1010726/201910/1010726-20191017192322879-1876940933.png)



### 10.3. 创建项目配置

#### 10.3.1.创建项目 

![image-20210420153044595](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420153044595.png)

#### 10.3.2.pom.xml依赖配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.10.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47springcloudzuul</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47springcloudzuul</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>
    <dependencies>

        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
		<!--zuul依赖-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-zuul</artifactId>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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

#### 10.3.3.application.yml配置

```yaml
server:
  port: 9002
spring:
  application:
    name: gateway-zuul

eureka:
  client:
    service-url:
       defaultZone: http://127.0.0.1:6001/eureka/

zuul:
  routes:
    users-provider: /provider/*
    users-consumer: /consumer/*
  prefix: /gateway                       #前缀
  ignored-services: '*'                  #禁用服务名访问(内网不受该限制)
  ignored-patterns: /**/cmap/**    #禁用某些路径
  sensitive-headers: '*'                 #解决走网关session变化
```



#### 10.3.4.启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

@SpringBootApplication
@EnableZuulProxy
public class Kgc47springcloudzuulApplication {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47springcloudzuulApplication.class, args);
    }

}
```

![image-20210420155226424](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420155226424.png)

#### 10.3.5.测试网关

![image-20210420155352516](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210420155352516.png)

### 10.4. 使用网关过滤

#### 10.4.1.设置白名单

```java
package com.cssl.filter;

import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import org.springframework.cloud.netflix.zuul.filters.support.FilterConstants;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Component
public class IpFilter extends ZuulFilter {
    @Override
    public String filterType() {
        return FilterConstants.PRE_TYPE; //返回过滤类型
    }

    @Override
    public int filterOrder() {
        return 2; //多个过滤器 设置执行顺序，数字越小，优先级越高
    }

    @Override
    public boolean shouldFilter() {
        RequestContext ctx= RequestContext.getCurrentContext();
        System.out.println("======这是IP过滤器 shouldFilter:"+ctx.sendZuulResponse());
        return ctx.sendZuulResponse();
        //这个方法返回false -程序不会经过下面的run()方法，返回true则会经过
    }

    @Override
    public Object run() {
        //执行业务逻辑代码
        RequestContext ctx= RequestContext.getCurrentContext();
        HttpServletRequest req=ctx.getRequest();
        String ipAddr=this.getIpAddr(req);
        System.out.println("请求IP地址为："+ipAddr);

        //配置本地IP白名单，生产环境可放入数据库或者redis中
        List<String> ips=new ArrayList<String>();
        ips.add("127.0.0.1");
        ips.add("192.168.56.1");

        if(!ips.contains(ipAddr)){
            System.out.println("IP地址校验不通过！！！");
            ctx.setResponseStatusCode(401);
            ctx.setSendZuulResponse(false);
            ctx.getResponse().setContentType("text/html;charset=utf-8");
            ctx.setResponseBody("{\"msg\":\"IP地址不允许访问！\"}");
        }else{
            System.out.println("IP地址校验通过！");
            ctx.setSendZuulResponse(true);
        }

        return null;
    }

    /**
     * 获取Ip地址
     * @param request
     * @return
     */
    public  String getIpAddr(HttpServletRequest request){

        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
```



#### 10.4.2.登录权限设置

```java
package com.cssl.filter;

import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import org.springframework.cloud.netflix.zuul.filters.support.FilterConstants;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class TokenFilter  extends ZuulFilter {
    @Override
    public String filterType() {
        String preType = FilterConstants.PRE_TYPE;
        System.out.println("过滤器的类型："+preType);
        return preType;
    }

    @Override
    public int filterOrder() {
        // 正整数  数字越小，优先级越高
        return 10;
    }

    @Override
    public boolean shouldFilter() {
        //return true:放行往下走 run,false 不执行run方法
        System.out.println("TokenFilter的shouldFilter");
        return true;
    }

    @Override
    public Object run() throws ZuulException {
        //编写过滤代码
        RequestContext ctx= RequestContext.getCurrentContext();
        //获取请求
        HttpServletRequest request = ctx.getRequest();
        //获取访问信息
        String requestURI = request.getRequestURI();
        //请求token
        String token = request.getHeader("token");

        System.out.println("uri:"+requestURI+"::token:"+token);
        //放行基本页面 login
        if(requestURI.contains("clogin")||requestURI.contains("login")){
            ctx.setSendZuulResponse(true);
            System.out.println("你是登录放你过去");
            return "sb";
        }

        //从redis取出token
        if(token==null||token.isEmpty()){
            ctx.setSendZuulResponse(false);
            ctx.setResponseStatusCode(401);
            ctx.getResponse().setContentType("text/html;charset=utf-8");
            //ctx.setResponseBody("text/html;charset=utf8");
            String mess="{\"mess\":\"no token，no pass ,没有token\"}";

            ctx.setResponseBody(mess);
            return "no";
        }else{
            ctx.setSendZuulResponse(true);
            System.out.println("token不为空放行");
        }


        return "success";
    }
}
```



## 11.SpringCloud组件之Config 

### 11.1. Config基本概念

Spring Cloud Config provides server and client-side support for externalized configuration in a distributed system. With the Config Server you have a central place to manage external properties for applications across all environments. The concepts on both client and server map identically to the Spring `Environment` and `PropertySource` abstractions, so they fit very well with Spring applications, but can be used with any application running in any language. As an application moves through the deployment pipeline from dev to test and into production you can manage the configuration between those environments and be certain that applications have everything they need to run when they migrate. The default implementation of the server storage backend uses git so it easily supports labelled versions of configuration environments, as well as being accessible to a wide range of tooling for managing the content. It is easy to add alternative implementations and plug them in with Spring configuration.

Spring Cloud Config为分布式系统中的外部化配置提供了服务器和客户端支持。有了配置服务器，您就有了一个中心位置来管理所有环境中的应用程序的外部属性。客户机和服务器上的概念都映射到Spring环境和PropertySource抽象上，因此它们非常适合Spring应用程序，但也可以用于以任何语言运行的任何应用程序。当应用程序通过部署管道从开发到测试并进入生产时，您可以管理这些环境之间的配置，并确保应用程序在迁移时拥有运行所需的一切。服务器存储后端的默认实现使用git，因此它很容易支持有标签的配置环境版本，并且可以访问各种管理内容的工具。可以很容易地添加替代实现，并使用Spring配置将它们插入。

### 11.2. Config特性

Spring Cloud Config Server features:

- HTTP, resource-based API for external configuration (name-value pairs, or equivalent YAML content)
- Encrypt and decrypt property values (symmetric or asymmetric)
- Embeddable easily in a Spring Boot application using `@EnableConfigServer`

Config Client features (for Spring applications):

- Bind to the Config Server and initialize Spring `Environment` with remote property sources
- Encrypt and decrypt property values (symmetric or asymmetric)

Spring云配置服务器功能:

- HTTP，用于外部配置的基于资源的API(名值对，或等效的YAML内容)

- 加密和解密属性值(对称或非对称)

- 使用@EnableConfigServer很容易嵌入到Spring启动应用程序中

- 配置客户端特性(针对Spring应用程序):

- 绑定到配置服务器并使用远程属性源初始化Spring环境

  

注意：对比多种配置中心性能 ：https://www.cnblogs.com/aixing/p/13327143.html

### 11.3 多环境配置

11.3.1. 补充多环境配置(bootstrap.yml、application.yml、application-dev.yml、application-prod.yml application-test.yml。。。)
	注意：
		1、如果新增的配置文件没有显示成springboot配置(绿叶)：Project Settings->Spring->绿叶->Configuration Files->+

![image-20220801085332029](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220801085332029.png)





​		2、springboot指定环境必须在application.yml配置，bootstrap.yml配置springboot项目无效( springcloud有效)
​			spring:
  				profiles:
   					 active: dev

![image-20210907110106961](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20210907110106961.png)

![image-20210907110118896](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20210907110118896.png)

11.3.2. github|gitee创建仓库(分支)和配置文件：(master分支看不到其他分支创建的目录，其他分支能看到master分支目录)

### 11.4  创建Congfig-Server

#### 11.4.1 创建Spring Cloud项目

![image-20210422152922873](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422152922873.png)

#### 11.4.2 项目的pom.xml依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.10.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47configserver4040</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47configserver4040</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>
    <dependencies>
        <!--需要暴露端口-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-config-server</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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

#### 11.4.3 项目的application.yml配置

![image-20210422153320034](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422153320034.png)

注意：一般服务器配置两个yml文件，bootstrap.yml的优先级高于applicaiton.yml

bootstrap.yml配置

```yaml
encrypt:
  key: FJSKD8FHSD  #加密使用
```

application.yml配置

```yaml
server:
  port: 4040
spring:
  application:
    name: config-server
  #gitee连接信息
  cloud:
    config:
      server:
        git:
          uri: https://gitee.com/bdqn_zhang/kgc47forcloud.git
          #search-paths: config    #dev其他分支
          search-paths: master    #master
          #username: 2093627508@qq.com
          #password: 你的密码
eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:6061/eureka/


```

#### 11.4.4 启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@EnableConfigServer
@SpringBootApplication
@EnableEurekaClient
public class Kgc47configserver4040Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47configserver4040Application.class, args);
    }

}
```



#### 11.4.5 码云仓库配置

![image-20210422161532200](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422161532200.png)



#### 11.4.6 启动测试

![image-20210422161630597](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422161630597.png)

![image-20210422161819647](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422161819647.png)

在gitee的仓库中，如果创建新的分支，且将项目的application.yml配置放在该分支下，例如在xx分支下，保持一个

consumer-dev.yml的文件，注意一般-dev  -test  -pro...表示开发阶段，测试阶段, 生产阶段，必须写上去

直接访问我们写的config-server项目 http://127.0.0.1:4040/配置文件名字出了后缀（不含-dev之类）/开发环境/分支名称

例如：http://127.0.0.1:4040/config-zuul/dev/master

![img](file:///C:\Users\20936\AppData\Roaming\Tencent\Users\2093627508\QQ\WinTemp\RichOle\`%_APJHR]4NDY3]Z7Z[AW4T.png)

### 11.5 创建Config-Client

#### 11.5.1 创建SpringCloud项目

![image-20210422162956290](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422162956290.png)



#### 11.5.2 项目的pom.xml依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.10.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc47configserver3030</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc47configserver3030</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>
    </properties>
    <dependencies>
    	<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-config</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
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
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

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



#### 11.5.3 项目的application.yml 

bootstrap.yml配置文件

```yaml
spring:
  application:
    name: config-client
  cloud:
    config:
      uri: http://localhost:4040   #config server地址
      profile: dev      #环境名 config-dev.yml
      name: config-zuul       #gitee上文件名，不写默认服务名
      label: master       #分支名称，如果不写就是默认主分支
#暴露监控端点
management:
  server:
    port: 3030
  endpoints:
    web:
      exposure:
        include: "*"
      #base-path: / # 2.0以后 默认是 /actuator 前缀，可以在这里修改

eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:6061/eureka/
```



#### 11.5.4. 启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class Kgc47configserver3030Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47configserver3030Application.class, args);
    }

}
```

#### 11.5.5 . 编写测试类获取远程的配置信息

```java
package com.cssl.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RefreshScope //加了这个注解会刷新
public class TestConfig {

    @Value("${spring.application.name}") //配置文件中属性值
    private String info;

    @GetMapping("/getInfo")
    public String getInfo(){

        System.out.println("从config-server服务器上获取配置信息："+info);

        return info;
    }

}
```

![image-20210422165524117](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422165524117.png)

![image-20210422165835849](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422165835849.png)



#### 11.5.6. 修改远程仓库配置

![image-20210422170107102](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422170107102.png)

手动访问 config-server: http://127.0.0.1:3030/actuator/refresh 实现刷新,  注意添加这个注解  在cotnroller @RefreshScope

注意：在客户端暴露刷新3030端口，

![image-20210422184457759](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422184457759.png)

![image-20210422184618502](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422184618502.png)!

![image-20210422184714903](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210422184714903.png)

客户端的数据同步更新了。

https://gitee.com/help/articles/4184#article-header0



## 12.SpringCloud之分布式session共享

### 12.1 分布式架构图

![img](https://img-blog.csdnimg.cn/2018120409295862.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RscGY=,size_16,color_FFFFFF,t_70)



https://blog.csdn.net/Soar_M/article/details/116525048?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1-116525048-blog-95047642.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1-116525048-blog-95047642.pc_relevant_default&utm_relevant_index=1

### 12.2 分布式架构，每个组件都是集群或者主备

**zuul service**:网关，API调用都走zuul service。
**micro service1 & micro service2**:业务功能实现，数据库增删改查。
**eureka**:组件注册，zuul service,micro service等组件都注册到eureka，管理组件调用地址。
**db-master & db-slave**:数据库集群，一主两从。
**redis master & redis slave**:redis集群，缓存。这里主要存储session对象。

### 12.3  组件之间API调用

```
①：网关zuul接收到的API请求，路由至业务实现组件。
②：网关zuul以及业务组件将session对象存储到redis、或从redis获取session对象。
③：业务组件实现数据增删改查。
④：业务组件之间通过springCloud feign组件进行调用。
⑤：网关zuul以及micro service组件注册到eureka组件，或从eureka获取组件调用地址

```

### 12.4 存在的问题

基于如上微服务的分布式架构如果按照传统方式，将session对象存储在内存中。在zuul网关将路由请求至不同的micro service1或者micro service2时，内存中的session对象将不能被共享，无法判断用户的登陆状态，也无法获取session对象存储的全局数据。



### 12.5 解决办法

1.Spring管理session对象通过EnableRedisHttpSession注解支持基于Redis存储session，全局共享session对象。

2.微服务架构下共享session对象实现说明
   1)客户端API请求到zuul，zuul基于spring管理session将session对象存储到redis，并将生成的sessionId返回给客户端。
  2)zuul将请求路由到micro service，将sessionId通过cookie头带给micro service。
  3)micro service通过sessionId从redis获取到已经生成的session对象。
  4)micro servcie1调用micro service2时，将sessionId也通过cookie头带给micro service2，micro service2通过sessionId从redis中获   取session对象。
 5)客户端再次调用时将a)步返回的sessionId增加到cookie头，在redis中存储的session失效之前zuul和micro service一直共享这个session。

1.使用redis共享session
将各个微服务中的session放入redis中，通过读取redis来实现session共享。就获取登陆信息这个场景而言，具体步骤如下：
① 用户请求网关，网关将请求转发到登陆服务，进行用户名密码校验，校验通过后将sessionId和用户id关联存到redis中，并返回登陆前请求的页面；
② 调用其他微服务时，网关服务从redis中获取sessionId关联的用户id，若存在则已登录，则允许调用，否则未登录，重定向到登陆页面。
由于各个微服务都将session存在了redis中，所以这个session是全局共享的。这样做的好处是实现简单，因为Spring session已经集成了redis，可以很容易的将session存到redis，且可以做到单点登陆/登出的效果，但是从微服务的角度来说，会增加系统的耦合度。在实际应用中可以使用一个单独的redis服务器或者集群来用作session共享。

### 12.6  项目pom.xml依赖

在需要session共享的项目中，引入共享session依赖包

```xml
<!-- 使用redis存储session -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
<!-- 分布式session -->
<dependency>
    <groupId>org.springframework.session</groupId>
    <artifactId>spring-session-data-redis</artifactId>
</dependency>
```

### 12.7 项目application.yml配置

```yaml
server:
  port: 8090
spring:
  application:
    name: consumer8090
  mvc:
    format:
      date-time: yyyy-MM-dd HH:mm:ss
  jackson:
    time-zone: GMT+8
    date-format: yyyy-MM-dd HH:mm:ss

  boot:
    admin:
      client:
        url: http://127.0.0.1:5052
  redis:
    host: 127.0.0.1
    port: 6379
    #password: root
    database: 0
    timeout: 10s  # 数据库连接超时时间，2.0 中该参数的类型为Duration，这里在配置的时候需要指明单位
    # 连接池配置，2.0中直接使用jedis或者lettuce配置连接池
    jedis:
      pool:
        max-idle: 50        # 最大空闲连接数
        min-idle: 10        # 最小空闲连接数
        max-wait:  -1s        # 等待可用连接的最大时间，负数为不限制
        max-active: -1        # 最大活跃连接数，负数为不限制
eureka:
  client:
    service-url:
      #defaultZone: http://admin:123@localhost:6060/eureka/
      defaultZone: http://eureka1.com:6061/eureka/, http://eureka2.com:6062/eureka/
    register-with-eureka: true #向eurek server 注册
    fetch-registry: true #获取信息列表
  server:
    enable-self-preservation: false        #禁用保护,默认true
    eviction-interval-timer-in-ms: 10000    #清理间隔（默认是60*1000）

provider9091: #服务名
  ribbon:
    #NFloadBalancerRuleClassName: com.netflix.loadbalancer.RandomRule  #随机策略
    NFloadBalancerRuleClassName: com.netflix.loadbalancer.RoundRobinRule #轮询
#服务降级的开关
feign:
  hystrix:
    enabled: true
management:
  endpoints:
    web:
      exposure:
        include: "*"
        #include: hystrix.stream
  endpoint:
    health:
      show-details: ALWAYS

hystrix:
  command:
    default:
      circuitBreaker:
        sleepWindowInMilliseconds: 5000    #过多长时间，熔断器再次检测是否开启，默认为5000，即5s钟
        errorThresholdPercentage: 50   #错误率，默认50%
        forceOpen: false         #强制打开断路器，默认false(true打开后会强制断开服务)
```

### 12.8 项目启动类

注意：注解@EnableRedisHttpSession 加在消费者这边，提供者不加

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients //使用fegin
@EnableCircuitBreaker
@EnableRedisHttpSession(maxInactiveIntervalInSeconds = 3000)
public class Kgc47consumer8090Application {

    public static void main(String[] args) {
        SpringApplication.run(Kgc47consumer8090Application.class, args);
    }

}
```



### 12.9  项目添加cookie处理

feign调用session丢失(consumer调用provider后session的不一致)
把cookie里面的session id信息放到Header里面，这个Header是动态的，跟HttpRequest相关
编写一个拦截器来实现Header的传递，也就是需要实现RequestInterceptor接口，具体代码如下

```java
package com.cssl.config;

import feign.RequestInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.session.web.http.SessionRepositoryFilter;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
//放cookie
@Configuration
public class FeignHeaderConfiguration {
    @Bean
    public RequestInterceptor requestInterceptor() {
        return requestTemplate -> {

            //通过RequestContextHolder获取本地请求
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            if (requestAttributes == null) {
                return;
            }
            //获取本地线程绑定的请求对象
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            //给请求模板附加本地线程头部信息，主要是cookie信息
            Enumeration headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String name = headerNames.nextElement().toString();
                requestTemplate.header(name, request.getHeader(name));
            }
            if(!request.isRequestedSessionIdValid()){
                request.setAttribute(SessionRepositoryFilter.INVALID_SESSION_ID_ATTR,null);
                requestTemplate.header("cookie","SESSION="+request.getSession().getId());
                System.out.println("apply sessionId:"+request.getSession().getId());
            }
        };
    }

}
```

### 12.10 测试session的方法

消费者直接调用提供者第一次session id不同问题是因为服务器是在方法执行完毕后才写redis，所以调用提供者可以放另一个请求方法中，[重定向]或[转发]过去调用解决！

重定向传参：RedirectAttributes attr
attr.addFlashAttribute("token",token);		//(Model model)model.getAttribute("token");
attr.addAttribute("username",username);		//相当于地址拼接?username"+username

消费者：

```java
    @Autowired
    private UserFegin userFegin;

	//真正的登录方法
    @RequestMapping("/myLogin")
    @ResponseBody
    public User myLogin(String name, String pwd, HttpSession session){
        System.out.println("消费者8081："+name+",sessionId:"+session.getId());
        User user = userFegin.userLogin(name, pwd);
        System.out.println("消费者8081:取出sesion中取值："+session.getAttribute("user"));
       
        return    user;
    }
    
    //解决第一次访问的sessionId不同的方法--调转方法-完成向redis中写入session的操作
    @RequestMapping("/testSession2")
    public String testSession2(String name,String pwd,HttpSession session){
        System.out.println("这是testSession2周转方法."+name+","+pwd+",sessionId:"+session.getId());
        return "redirect:/myLogin?name="+name+"&pwd="+pwd;
        
    }
    
    
    //测试跨项目取出redis-session方法
    @RequestMapping("/testSession3")
    @ResponseBody
    public User testSession3(HttpSession session){
        User user=(User)session.getAttribute("user");
        System.out.println(session.getId()+",消费者8081-testSession3:取出sesion中取值："+user);
        return user;
        
    }
```

提供者：

```java
@Autowired
    private UserService userService;

    @RequestMapping("/userLogin")
    public User userLogin(String username, String password, HttpSession session){
        System.out.println("提供者9091:取出sessionId:"+session.getId());
        
        User user =new User(username,password);
        User login = userService.login(user);
        System.out.println("提供者9091查询返回的user:"+user);
        session.setAttribute("user",login); //保存用户信息
       
        
        return  login;
    }
```

问题三：以上代码在Feign不开启Hystrix支持时可完美运行，当Feign开启Hystrix支持时，requestAttributes为null，原因在于，Hystrix的默认隔离策略是THREAD！(不使用hystrix就不用管)

解决1：关闭hystrix
feign:
  hystrix:
    enabled: false

解决2：调整隔离策略【不能用了】
feign:
  hystrix:
    enabled: true

(写在session保存方，如消费者)
hystrix:
  command:
    default:
      execution:
        isolation:
          strategy: SEMAPHORE

解决3：自定义并发策略(THREAD)

```java
@Component
public class MyHystrixConcurrencyStrategy extends HystrixConcurrencyStrategy {
        public MyHystrixConcurrencyStrategy() {
            HystrixPlugins.reset();
            HystrixPlugins.getInstance().registerConcurrencyStrategy(this);
        }

        @Override
        public <T> Callable<T> wrapCallable(Callable<T> callable) {
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            return new WrappedCallable<>(callable, requestAttributes);
        }

		 static class WrappedCallable<T> implements Callable<T> {

   		 private final Callable<T> target;
    	 private final RequestAttributes requestAttributes;

    	public WrappedCallable(Callable<T> target, RequestAttributes requestAttributes) {
        	this.target = target;
        	this.requestAttributes = requestAttributes;
    	}

    	@Override
    	public T call() throws Exception {
        	try {
            		RequestContextHolder.setRequestAttributes(requestAttributes);
           		 	return target.call();
       		 } finally {
           			 RequestContextHolder.resetRequestAttributes();
        	}
    }
}
```
问题四：方法参数为大对象(数据量小不会)的时候异常：**一般传递对象会出这个问题**
java.io.IOException: too many bytes written|InComplete Output Stream
原因：feign请求传递pojo参数的时候，默认情况下feign通过jdk中的HttpURLConnection向下游服务发起http请求，这种情况下，由于缺乏连接池的支持，在达到一定流量的后服务会出问题，所以要注意的问题就是导入httpclient替换HttpURLConnection

解决：

```xml
<dependency>
	<groupId>io.github.openfeign</groupId>
	<artifactId>feign-httpclient</artifactId>
</dependency>
```

下面配置是默认，可以不配

配置开启httpclient

feign.httpclient.enabled=true

问题五：加入zuul网关后造成session不一致 (Gateway可以不管)
1、@FeignClient(name="GATEWAY-ZUUL",configuration=FeignHeaderConfiguration.class) configuration可以不加

2、通过网关访问，必须加上配置
   sensitiveHeaders: "*" 

问题六：ajax请求
response.reset();这句话会重置用户的session
ajax跨域请求时增加withCredentials: true (不同源传递cookie)

![image-20210425152510874](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210425152510874.png)





