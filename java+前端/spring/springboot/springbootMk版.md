官网：http://www.springsource.org/
下载：http://repo.spring.io/release/org/springframework/boot/

# 						SpringBoot入门

## 一、简介

Spring Boot makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run".

We take an opinionated view of the Spring platform and third-party libraries so you can get started with minimum fuss. Most Spring Boot applications need minimal Spring configuration.

If you’re looking for information about a specific version, or instructions about how to upgrade from an earlier release, check out [the project release notes section](https://github.com/spring-projects/spring-boot/wiki#release-notes) on our wiki.


Spring Boot可以轻松创建独立的、基于Spring的生产级应用程序，您可以“直接运行”。

我们对Spring平台和第三方库有自己的看法，这样您就可以以最小的麻烦开始。大多数Spring Boot应用程序只需要最小的Spring配置。

如果您正在寻找关于特定版本的信息，或者关于如何从早期版本升级的说明，请查看我们的wiki上的项目发布说明部分。



## 二、特征

- Create stand-alone Spring applications

- Embed Tomcat, Jetty or Undertow directly (no need to deploy WAR files)

- Provide opinionated 'starter' dependencies to simplify your build configuration

- Automatically configure Spring and 3rd party libraries whenever possible

- Provide production-ready features such as metrics, health checks, and externalized configuration

- Absolutely no code generation and no requirement for XML configuration

  创建独立的Spring应用程序

  直接嵌入Tomcat、Jetty或Undertow(不需要部署WAR文件)

  提供有主见的“启动器”依赖项来简化构建配置

  尽可能地自动配置Spring和第三方库

  提供生产就绪特性，如度量、运行状况检查和外部化配置

  绝对不需要代码生成，也不需要XML配置

## 三、发展

Spring 诞生时是 Java 企业版（Java Enterprise Edition，JEE，也称 J2EE）的

轻量级代替品。无需开发重量级的 Enterprise JavaBean（EJB），Spring 为企业级

Java 开发提供了一种相对简单的方法，通过依赖注入和面向切面编程，用简单的Java 对象（Plain Old Java Object，POJO）实现了 EJB 的功能。

 

虽然 Spring 的组件代码是轻量级的，但它的配置却是重量级的。

 

第一阶段：xml配置

在Spring 1.x时代，使用Spring开发满眼都是xml配置的Bean，随着项目的扩大，我们需要把xml配置文件放到不同的配置文件里，那时需要频繁的在开发的类和配置文件之间进行切换

 

第二阶段：注解配置

在Spring 2.x 时代，随着JDK1.5带来的注解支持，Spring提供了声明Bean的注解（例如@Component、@Service），大大减少了配置量。主要使用的方式是应用的基本配置（如数据库配置）用xml，业务配置用注解

 

第三阶段：java配置

Spring 3.0 引入了基于 Java 的配置能力，这是一种类型安全的可重构配置方式，可以代替 XML。我们目前刚好处于这个时代，Spring4.x和Spring Boot都推荐使用Java配置。

 

所有这些配置都代表了开发时的损耗。 因为在思考 Spring 特性配置和解决业务问题之间需要进行思维切换，所以写配置挤占了写应用程序逻辑的时间。除此之外，项目的依赖管理也是件吃力不讨好的事情。决定项目里要用哪些库就已经够让人头痛的了，你还要知道这些库的哪个版本和其他库不会有冲突，这难题实在太棘手。并且，依赖管理也是一种损耗，添加依赖不是写应用程序代码。一旦选错了依赖的版本，随之而来的不兼容问题毫无疑问会是生产力杀手。

 

Spring Boot 让这一切成为了过去。

Spring Boot 简化了基于Spring的应用开发，只需要“run”就能创建一个独立的、生产级别的Spring应用。Spring Boot为Spring平台及第三方库提供开箱即用的设置（提供默认设置），这样我们就可以简单的开始。多数Spring Boot应用只需要很少的Spring配置。

我们可以使用SpringBoot创建java应用，并使用java –jar 启动它，或者采用传统的war部署方式。


Spring Boot是由Pivotal团队提供的全新[框架](https://baike.baidu.com/item/框架/1212667)，其设计目的是用来[简化](https://baike.baidu.com/item/简化/3374416)新[Spring](https://baike.baidu.com/item/Spring/85061)应用的初始搭建以及开发过程。该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。通过这种方式，Spring Boot致力于在蓬勃发展的快速应用开发领域(rapid application development)成为领导者。

SpringBoot框架中还有两个非常重要的策略：**开箱即用和约定优于配置**。

**开箱即用**，Outofbox，是指在开发过程中，通过在MAVEN项目的pom文件中添加相关依赖包，然后使用对应注解来代替繁琐的XML配置文件以管理对象的生命周期。这个特点使得开发人员摆脱了复杂的配置工作以及依赖的管理工作，更加专注于业务逻辑。

**约定优于配置**，Convention over configuration，是一种由SpringBoot本身来配置目标结构，由开发者在结构中添加信息的软件设计范式。这一特点虽降低了部分灵活性，增加了BUG定位的复杂性，但减少了开发人员需要做出决定的数量，同时减少了大量的XML配置，并且可以将代码编译、测试和打包等工作自动化。

SpringBoot应用系统开发模板的基本架构设计从前端到后台进行说明：前端常使用模板引擎，主要有FreeMarker和Thymeleaf，它们都是用Java语言编写的，渲染模板并输出相应文本，使得界面的设计与应用的逻辑分离，同时前端开发还会使用到Bootstrap、AngularJS、JQuery等；在浏览器的数据传输格式上采用Json，非xml，同时提供RESTfulAPI；SpringMVC框架用于数据到达服务器后处理请求；到[数据访问层](https://baike.baidu.com/item/数据访问层/7279662)主要有Hibernate、MyBatis、JPA等持久层框架；数据库常用[MySQL](https://baike.baidu.com/item/MySQL/471251)；开发工具推荐IntelliJIDEA。 [1] 



## 四、创建SpringBoot项目



1.使用STS 工具创建maven项目

![image-20210721154104167](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721154104167.png)

2.忽略骨架

![image-20210721154148533](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721154148533.png)

3.项目依赖

![image-20210721155253329](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721155253329.png)



4.创建启动类

```java
package com.cssl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {

	public static void main(String[] args) {
		
		SpringApplication.run(App.class, args);
	}

}

```

![image-20210721155828050](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721155828050.png)

5.编写Controller测试

```
package com.cssl.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
	
	@RequestMapping("/test")
	public String test() {
		
		System.out.println("测试spring boot方法");
		return "hello spring boot 你好";
	}

}

```

6.启动主函数，测试页面

![image-20210721160159486](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721160159486.png)

![image-20210721160220953](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721160220953.png)





## 五、在sts中使用springboot整合ssm 

(视图html+jsp 两种)

![image-20210722163032615](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210722163032615.png)

banner.txt

```tex
                   _ooOoo_
                  o8888888o
                  88" . "88
                  (| 0_0 |)
                  O\  =  /O
               ____/`---'\____
             .'  \\|     |//  `.
            /  \\|||  :  |||//  \
           /  _||||| -:- |||||-  \
           |   | \\\  -  /// |   |
           | \_|  ''\---/''  |   |
           \  .-\__  `-`  ___/-. /
         ___`. .'  /--.--\  `. . __
      ."" '<  `.___\_<|>_/___.'  >'"".
     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
     \  \ `-.   \_ __\ /__ _/   .-` /  /
======`-.____`-.___\_____/___.-`____.-'======
                   `=---='
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         	佛祖保佑--头发还在--身体健康---永无BUG
```



pom.xml依赖：

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.3.10.RELEASE</version>
	</parent>

	<groupId>com.cssl</groupId>
	<artifactId>sb01</artifactId>
	<version>0.0.1-SNAPSHOT</version>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>2.1.3</version>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.45</version>
		</dependency>

		<!--添加对jsp的支持,否则不能识别<% %>|JSTL|EL -->
		<dependency>
			<groupId>org.apache.tomcat.embed</groupId>
			<artifactId>tomcat-embed-jasper</artifactId>
		</dependency>
		<!--添加对jstl的支持 -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
		</dependency>

	</dependencies>

</project>
```



application.yml配置

```yaml
server:
  port: 9998
  servlet:
    context-path: /springboot
    
spring:
  application:
    name: myspringboot
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    username: root
    password: ROOT
    url: jdbc:mysql://127.0.0.1:3306/test
  mvc:
    view:
      prefix: /
      suffix: .jsp
     static-path-pattern: /**
  resources:
    static-locations: classpath:/templates/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/
       
mybatis:
  type-aliases-package: com.cssl.pojo
  configuration:
    auto-mapping-behavior: full
    use-generated-keys: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
    #log-impl: org.apache.ibatis.logging.log4j.Log4jImpl
    
```

启动类：

```java
package com.cssl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.cssl.mapper")
public class App {

	public static void main(String[] args) {
		
		SpringApplication.run(App.class, args);
	}

}

```

控制类：

```java
package com.cssl.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cssl.pojo.Student;
import com.cssl.service.StudentService;
@Controller
public class StudentController {
	@Autowired
	private StudentService studentService;
	
	@GetMapping("/show")
	//@PostMapping
	
	public ModelAndView showAll(ModelAndView mv) {
		List<Student> list = studentService.showAll();
		mv.addObject("list",list);
		mv.setViewName("index");
		return mv;
		
	}
	
	@GetMapping("/show2")
	@ResponseBody
	
	public List<Student> showAll2() {
		List<Student> list = studentService.showAll();
		System.out.println("xxxxxxxxxxxxxxxxxxxxx");
		return list;
		
	}
	
}

```



业务类：

```java
package com.cssl.service;
import java.util.List;
import com.cssl.pojo.Student;
public interface StudentService {
	public List<Student> showAll();

	public boolean addStudent(Student stu);
}

```

业务类实现类：

```java
package com.cssl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cssl.mapper.StudentMapper;
import com.cssl.pojo.Student;
import com.cssl.service.StudentService;
//@Component
@Service
@Transactional
public class StudentServiceImpl implements StudentService {
	@Autowired
	private StudentMapper studentMapper;
	
	@Override
	public List<Student> showAll() {
		// TODO Auto-generated method stub
		return studentMapper.showAll();
	}

	@Override
	public boolean addStudent(Student stu) {
		// TODO Auto-generated method stub
		return studentMapper.addStudent(stu)>0?true:false;
	}

}

```



持久层接口：

```java
package com.cssl.mapper;
import java.util.List;
import com.cssl.pojo.Student;
public interface StudentMapper {
	
	public List<Student> showAll();
	
	public int addStudent(Student stu);

}
```



持久层接口实现：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.cssl.mapper.StudentMapper">
<select id="showAll" resultType="student">
select * from student
</select>
<insert id="addStudent" parameterType="student">
insert into student(sname,age,cid) values(#{sname},#{age},#{cid});
</insert>
</mapper>
```

实体类：

```java
package com.cssl.pojo;
import java.io.Serializable;
public class Student implements Serializable {
	private Integer sid;
	private String sname;
	private Integer age;
	private Integer cid;
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
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Student(Integer sid, String sname, Integer age, Integer cid) {
		super();
		this.sid = sid;
		this.sname = sname;
		this.age = age;
		this.cid = cid;
	}
	public Student() {
		super();
	}
	@Override
	public String toString() {
		return "Student [sid=" + sid + ", sname=" + sname + ", age=" + age + ", cid=" + cid + "]";
	}
	
	
}

```

测试index.html+ajax

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mycss.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
</head>

<body>
<h1>测试indeX.html</h1>
<div>嘻嘻嘻</div>
<hr/>
<table border="1" width="800px" id="tb">
	<tr>
		<th>编号</th>
        <th>姓名</th>
        <th>年龄</th>
        <th>操作</th>
	</tr>
</table>
<script type="text/javascript">
$(function(){
	$.getJSON('show2',function(data){
		$(data).each(function(i,e){
			var tr="<tr><td>"+e.sid+"</td><td>"+e.sname+"</td><td>"+e.age+"</td><td><a href=''>修改</a><a href=''>删除</a></td></tr>";
			$("#tb").append(tr);
		})
		
	},"json");
})
</script>
</body>
</html>
```

![image-20210722163848684](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210722163848684.png)

测试jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>显示学生信息</h1>
<table>
	<TR>
		<TH>编号</TH>
		<TH>姓名</TH>
		<TH>年龄</TH>
		<TH>班级编号</TH>
	
	</TR>
	<c:forEach items="${list}" var="stu">
		<tr>
			<td>${stu.sid}</td>
			<td>${stu.sname}</td>
			<td>${stu.age}</td>
			<td>${stu.cid}</td>
			
		</tr>
	
	</c:forEach>
</table>
</body>
</html>
```

![image-20210722163926106](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210722163926106.png)







## 六、使用idea创建sprngboot项目

![image-20210721170028971](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721170028971.png)

![image-20210721170044414](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721170044414.png)

![image-20210721170126776](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721170126776.png)

![image-20210721170153245](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210721170153245.png)





# Spring boot推荐使用java配置(零配置)

Java配置方式主要是通过 @Configuration 和 @Bean 这两个注解实现的：

1. @Configuration 作用于类上，相当于一个xml配置文件,可理解为spring的xml里面的<beans>标签；
2. @Bean 作用于方法上，相当于xml配置中的<bean>；
3. @ComponentScan(basePackages="com.cssl") 扫描包
4. @PropertySource(value="classpath:mysql.properties")|@Value 读取配置文件
5. @EnableTransactionManagement 开启事务支持
6. @MapperScan("com.cssl.dao")	扫描dao包，产生代理对象

## 一、SpringBoot环境要求

SpringBoot2 基于 Spring 5(Java 8)，支持 Java 9+，Maven 3.2+
SpringBoot2 针对Quartz调度器提供了支持。
SpringBoot2 基于Spring5构建，本次SpringBoot的升级，同时也升级了部分其依赖的第三方组件
主要的几个有：
	Tomcat 8.5+
	Flyway 5+	数据库版本控制  
	Hibernate 5.2+	ORM框架
	Thymeleaf 3+	模板引擎


SpringBoot：解决Java开发繁多的配置，低下的开发效率、复杂的部署流程及很难集成第三方技术
优点：
	1、快速构建项目
	2、对主流开发框架无配置集成
	3、独立运行，无需依赖外部容器
	4、极大提高开发、部署效率
	5、与云计算等的天然集成
	6、SpringCloud天然搭档

Maven配置：
1、设置spring boot的parent：包含了大量默认的配置，大大简化了我们的开发

```xml
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>2.x.x.RELEASE</version>
</parent>
```

2.x.x必须jdk1.8+

```xml
<build>  
    <plugins>  
        <plugin>  
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>  
                <version>3.1</version>  
                <configuration>  
                    <source>1.8</source>  
                    <target>1.8</target>  
                </configuration>  
         </plugin>  
     </plugins>  
</build>
```

或者修改settings.xml设置

2、导入spring boot的支持：核心SpringBoot starter，包括自动配置支持，日志和YAML
(可选:可以通过spring-boot-starter-web传递依赖)

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter</artifactId>
</dependency>
```

3、导入spring boot的web支持：包括Tomcat、spring-webmvc,还自动依赖spring-boot-starter

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

4、添加Spring boot的插件：(可选:可以通过插件启动程序)

```xml
<plugin>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-maven-plugin</artifactId>
</plugin>
```

5、添加打war包插件：(可选:可以将项目打成war包发布)

```xml
<plugin>
	<artifactId>maven-war-plugin</artifactId>
	<version>3.0.0</version>
</plugin>
```

6、添加Spring boot对jsp|jstl的支持：(可选)
由于Spring boot使用的内嵌的tomcat，而内嵌的tomcat是不支持jsp页面的，需要导入额外的包才能解决

```xml
<!--添加对jsp的支持,否则不能识别<% %>|JSTL|EL-->
<dependency>
	<groupId>org.apache.tomcat.embed</groupId>
	<artifactId>tomcat-embed-jasper</artifactId>	
</dependency>
<!--添加对jstl的支持-->
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>jstl</artifactId>	
</dependency>
```

![image-20210902123401621](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20210902123401621.png)

![image-20210902123252096](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20210902123252096.png)



注意:控制器没有'.action'页面也不能加

注意:控制器没有'.action'页面也不能加

SpringBoot注解：
@SpringBootApplication：SpringBoot的核心注解，主要目的是开启自动配置，扫描本包及其子包bean
@ConditionalOnXxx：条件注解
@ConfigurationProperties (spring-boot提供该注解将配置文件的值映射到类上)
@SpringBootTest：SpringBoot的测试注解

@SpringBootApplication注解组合了以下注解：
1、@SpringBootConfiguration：继承自@Configuration，二者功能也一致，标注当前类是配置类，
并会将当前类内声明的一个或多个以@Bean注解标记的方法的实例纳入到spring容器中
2、@EnableAutoConfiguration：启用自动配置，该注解会使Spring Boot根据项目中依赖的jar包自动配置项目的配置项，如：我们添加了spring-boot-starter-web的依赖，项目就会引入SpringMVC的依赖，Spring Boot就会自动配置tomcat和SpringMVC
3、@ComponentScan：默认扫描@SpringBootApplication所在类的同级目录以及它的子目录

注意：如果手动添加了@ComponentScan，则原来的默认规则被覆盖，只使用手动添加的规则


如果想关闭某个自动配置：
@SpringBootApplication(exclude=RedisAutoConfiguration.class)

启动SpringBoot：SpringApplication.run(MainApp.class, args);
注意：主类必须放在包中，不能直接放java目录，否则异常


自定义Banner：
1、拷贝生成的字符到一个文本文件中，并且将该文件命名为banner.txt
2、将banner.txt拷贝到项目的resources目录中
3、如果不想看到任何的banner，也是可以将其关闭的：setBannerMode(Banner.Mode.OFF)


全局配置文件：
Spring Boot项目使用一个全局的配置文件application.properties或者是application.yml，在resources目录下


访问静态资源：进入规则为 /
如果进入SpringMVC的规则为/时，Spring Boot的默认静态资源的路径为：
classpath:/META-INF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/

也可以通过Spring指定：

```properties
spring.mvc.static-path-pattern=/**
spring.resources.static-locations=classpath:/templates/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/
```

```yaml
spring:
  application:
    name: myspringboot
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    data-username: root
    data-password: ROOT
    url: jdbc:mysql://127.0.0.1:3306/test
  mvc:
    view:
      prefix: /
      suffix: .jsp
      static-path-pattern: /**
  resources:
    static-locations: classpath:/templates/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/
      
```

注意：
1、指定后默认的就失效了
2、配置了templates则可以直接访问模板文件,否则只能通过controller转发
3、templates下的模板也可以链接static下的css、js等静态资源，反之也可以
4、无论什么时候都不能重定向访问模板文件，因为重定向不使用模板视图解析器
5、没有配置视图解析如果使用post请求，不支持转发只能重定向

热部署（修改代码自动部署）
导入依赖:(加入热部署后main方法中启动语句run()前输出语句会执行两次)

```xml
<dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-devtools</artifactId>
</dependency>
```

修改idea设置(见设置文档)



### 怎么将springboot项目发布到本地tomcat

```
1.pom文件中
<packaging>war</packaging>

2.排除内置tomcat
<!--使用tomcat发布的时候，排除了内置的tomcat-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-tomcat</artifactId>
            <scope>provided</scope>
        </dependency>

3.修改启动主方法
@SpringBootApplication
@MapperScan("com.cssl.dao")
public class App extends SpringBootServletInitializer {

    /*public static void main(String[] args) {
        SpringApplication.run(App.class,args);
    }*/
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(App.class);
    }

}
4.注释掉
     <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
5.发布发自己配置的tomcat中去，自动打成war包。
或者是使用maven命令package，单独打成war包，复制war放到其他服务器上去运行
```

## 二、SpringBoot和Mybatis整合的两种方式：

第一种：使用mybatis-spring整合的方式，也就是我们传统的方式
优点：我们可以手动控制MyBatis的各种配置

导入依赖

```xml
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.5.3</version>
</dependency>	
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis-spring</artifactId>
	<version>2.0.1</version>
</dependency>
```

使用lombok：(jdk9以上版本需要1.16.21以上版本，不写版本自动匹配springboot版本)

```xml
<dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.16.20</version>
</dependency>

1、创建Mybatis的配置
```

类：
@Configuration
public class MyBatisConfiger {

```java
@Autowired
private Environment env;

@Bean
public DataSource dataSource() {
DriverManagerDataSource ds = new DriverManagerDataSource();
ds.setDriverClassName(env.getProperty("jdbc.driver"));
ds.setUrl(env.getProperty("jdbc.url"));
ds.setUsername(env.getProperty("jdbc.username"));
ds.setPassword(env.getProperty("jdbc.password"));
return ds;
}	

@Bean
@ConditionalOnMissingBean 
public SqlSessionFactoryBean sqlSessionFactory(){
SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
factory.setDataSource(dataSource);
ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
Resource resource = resolver.getResource("classpath:mybatis-config.xml");
factory.setConfigLocation(resource);

return factory;
}
```
}

2、创建Mapper接口的扫描类MapperScannerConfig：

```java
@Configuration
@AutoConfigureAfter(MyBatisConfiger.class)
public class MapperScannerConfig {	
    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
	MapperScannerConfigurer mapper = new MapperScannerConfigurer();
	mapper.setBasePackage("com.example.dao");
	return mapper;
    }
}
```

或者直接使用注解扫描dao接口产生代理:@MapperScan(basePackages="com.example.dao")

或者直接使用注解扫描dao接口产生代理:@MapperScan(basePackages="com.example.dao")

事务管理：
在Spring Boot中推荐使用注解来声明事务
@EnableTransactionManagement
@Transactional

首先需要导入依赖：

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
```

当引入jdbc依赖之后，SpringBoot会自动默认分别注入DataSourceTransactionManager或JpaTransactionManager，所以我们不需要任何额外配置就可以用@Transactional注解进行事务的使用


第二种：使用mybatis官方提供的Spring Boot整合包实现

导入依赖
(自动导入mybatis、mybatis-spring、spring-jdbc、spring-tx等包)
(自动读取数据库配置产生DataSource(HikariDataSource)、SqlSessionFactory及事务管理类)

```yaml
<dependency>
      <groupId>org.mybatis.spring.boot</groupId>
      <artifactId>mybatis-spring-boot-starter</artifactId>
      <version>2.1.3</version>
</dependency>

yml:
mybatis:
  config-location: classpath:mybatis-config.xml

或者:
mybatis:
  type-aliases-package: com.cssl.pojo
  configuration:
    auto-mapping-behavior: full
    use-generated-keys: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```



log-impl: org.apache.ibatis.logging.log4j.Log4jImpl:这个不打印查询结果

DAO接口产生代理只需要扫描:@MapperScan(basePackages="com.cssl.dao")
或者在dao接口上使用@Mapper

springboot整合mybatis方式二：

pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.4</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.cssl</groupId>
    <artifactId>kgc50springboot02</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kgc50springboot02</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
    </properties>
    <dependencies>
        <!--springmvc-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>


        <!--mybatis spring的整合包-->
        <!-- https://mvnrepository.com/artifact/org.mybatis.spring.boot/mybatis-spring-boot-starter -->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.2.0</version>
        </dependency>

        <!--mysql驱动-->
        <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.26</version>
        </dependency>


        <!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.20</version>
            <scope>provided</scope>
        </dependency>


        <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper-spring-boot-starter -->
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>1.3.0</version>
        </dependency>

        <!--用于配置application.yml 数据库密码账户加密-->
        <dependency>
            <groupId>com.github.ulisesbocchio</groupId>
            <artifactId>jasypt-spring-boot-starter</artifactId>
            <version>2.0.0</version>
        </dependency>

        <!--springtest-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/*.*</include>
                </includes>
                <filtering>false</filtering>
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>

```

application.yml

```yaml
server:
  port: 9091
  servlet:
    context-path: /sp

spring:
  application:
    name: myspringboot
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    username: root
    password: ROOT
    url: jdbc:mysql://127.0.0.1:3306/mybatis
  mvc:
    view:
      prefix: /
      suffix: .jsp
    static-path-pattern: /**
  resources:
    static-locations: classpath:/templates/,classpath:/META-NF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/

mybatis:
  type-aliases-package: com.cssl.pojo
  configuration:
    auto-mapping-behavior: full
    use-generated-keys: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
    #log-impl: org.apache.ibatis.logging.log4j.Log4jImpl


```

启动类：

```java
package com.cssl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.cssl.mapper")
public class Kgc50springboot01Application {
    
    public static void main(String[] args) {
        SpringApplication.run(Kgc50springboot01Application.class, args);
    }
    
}

```

注意：
新版本2.1+默认使用数据库驱动8.0+
1、**driver：com.mysql.cj.jdbc.Driver(public class Driver extends com.mysql.cj.jdbc.Driver)**
2、**url要加时区：jdbc:mysql:///mydb?serverTimezone=UTC**

--------------------------------------------------------------

## 三、分页插件PageHelper的使用：

方式一：使用原生的PageHelper

```xml
<dependency>
	<groupId>com.github.pagehelper</groupId>
	<artifactId>pagehelper</artifactId>
	<version>[5.1.0,)</version>
</dependency>
```

Java配置代码:
    

```java
	@Bean
   public PageInterceptor pageInterceptor(SqlSessionFactoryBean factory){
		//分页插件5.x
		Properties properties = new Properties();
		properties.setProperty("reasonable", "true");
		properties.setProperty("pageSizeZero", "true");



		PageInterceptor interceptor = new PageInterceptor();
		interceptor.setProperties(properties);
		//添加插件
		factory.setPlugins(new Interceptor[]{interceptor});
		return interceptor;
}
```

方式二：使用PageHelper的starter(PageHelper5.1.x)

```xml
<dependency>
	<groupId>com.github.pagehelper</groupId>
	<artifactId>pagehelper-spring-boot-starter</artifactId>
	<version>[1.2.5,1.4.2]</version>	
</dependency>
```

pagehelper分页插件配置(不是必须)

```yaml
  pagehelper: 
    reasonable: true
    pageSizeZero: true
```

注意：手动加@ComponentScan(basePackages = "com")扫描破坏过滤造成分页不起作用,要excludeFilters
   @ComponentScan(basePackages = "com",excludeFilters = { 
   @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
   @Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class)})



## 四、Web开发的自动配置类：

org.springframework.boot.autoconfigure.web.WebMvcConfigurer 

创建拦截器

```java
package com.cssl.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class MyIntercepter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.err.println("preHandle============>>>>>>>....");
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.err.println("postHandle============>>>>>>>.......");
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.err.println("afterCompletion============>>>>>>>....ompletion");
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}

```







1、Spring Boot添加MVC配置：实现接口WebMvcConfigurer

```java
@Component
public class MyMvcConfig implements WebMvcConfigurer {
    //添加拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
	HandlerInterceptor hi = new HandlerInterceptor() {
	

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)        throws Exception {
        System.out.println("preHandle...");
        return true;
      }			
};
        
@Override
	public void addInterceptors(InterceptorRegistry registry) {
		System.out.println("添加自己定义拦截器");
		registry.addInterceptor(new MyIntercepter()).addPathPatterns("/**").excludePathPatterns("/js/**", "/images/**");

	}

@Override
public void configureViewResolvers(ViewResolverRegistry registry) {
//没有添加默认也是这个视图解析器
//默认配置:org.springframework.boot.autoconfigure.web.WebMvcAutoConfiguration
  registry.viewResolver(new InternalResourceViewResolver("/", ".jsp"));
}

@Override
public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
StringHttpMessageConverter sh = new StringHttpMessageConverter(Charset.forName	("utf-8"));
//没有添加默认也有该消息转换器
converters.add(sh);
}

@Override
    public void addCorsMappings(CorsRegistry registry) {
        // 设置允许跨域的路由
        registry.addMapping("/**")
                // 设置允许跨域请求的域名
                .allowedOriginPatterns("*")
                // 是否允许证书（cookies）
                .allowCredentials(true)
                // 设置允许的方法
                .allowedMethods("*")
                // 跨域允许时间
                .maxAge(3600);
        
    }


}
```

2、SpringBoot使用监听器|过滤器|Servlet：
@ServletComponentScan("com.cssl.web")

或者使用
new ServletRegistrationBean(new XxxServlet)
new FilterRegistrationBean(new XxxFilter)
new ServletListenerRegistrationBean(new XxxListener)

在过滤器中获取业务逻辑层对象：

```java
package com.cssl.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.cssl.service.StudentService;
@WebFilter("/*")
public class MyFilter implements Filter {

	@Autowired
	private StudentService studentServiceImpl; 
	
    public MyFilter() {
       System.err.println("过滤器中studentServiceImpl："+studentServiceImpl);
    }

	
	public void destroy() {
		System.err.println("销毁方法........");
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.err.println("过滤前："+studentServiceImpl);
		chain.doFilter(request, response);
		System.err.println("过滤后："+studentServiceImpl);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		System.err.println("过滤器中init："+studentServiceImpl);

		ServletContext application = fConfig.getServletContext(); //springboot
		ApplicationContext act=WebApplicationContextUtils.getWebApplicationContext(application);
		
		//tomcat启动时，从spring中获取容器，从容器中取出我们要的bean Spring()
		//WebApplicationContext act=ContextLoader.getCurrentWebApplicationContext();
		 this.studentServiceImpl = act.getBean(StudentService.class);
		System.err.println("过滤器中的init---studentService:"+studentServiceImpl);
	}
	

}

```

```java
package com.cssl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;

@SpringBootApplication
@MapperScan("com.cssl.mapper")
@ServletComponentScan("com.cssl.web") //加上这个注解 扫描过滤器
public class Lg26springboot02Application {

    public static void main(String[] args) {
        SpringApplication.run(Lg26springboot02Application.class, args);
    }

}

```

3、MVC异常处理:(和SpringMVC一样)
a、Advice异常处理

```java
package com.cssl.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MyAdvice {
	
	@ExceptionHandler(Exception.class)
	public String doError(Exception e) {
		System.out.println("e:"+e.getMessage());
		return "forward:/error.jsp";
	}

}

```

b、父级Controller异常处理
定义父类 BaseController：

```java
public class BaseController {

@ExceptionHandler(Exception.class)
public String handleException(Exception e) { ... }

}
```

4、自动启动
   在开发中可能会需要在容器启动的时候执行一些内容。比如读取配置文件或读取数据库数据注入redis。SpringBoot给我们提供了两个接口来帮助我们实现这种需求。这两个接口分别为CommandLineRunner和ApplicationRunner。他们的执行时机为容器启动完成的时候。

5.上传文件

![img](file:///C:\Users\20936\AppData\Roaming\Tencent\Users\2093627508\QQ\WinTemp\RichOle\FXT{2`Q~YZU7QFCVMHUZJW0.png)

![image-20220614184114190](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220614184114190.png)

```java
 //文件上传
    @RequestMapping("/file/upload")
    @ResponseBody
    public String upload(@RequestPart MultipartFile file) throws IOException {
        //获取上传的文件名
        String fileName = file.getOriginalFilename();
        //上传后的文件名
        File saveFile = new File( "d:/springbootfile.txt" );
        //调用工具传
        Files.copy(file.getInputStream() ,saveFile.toPath());
        
        return "文件上传已成功，保存路径为: "+saveFile.getAbsolutePath();
    }

```



## 五、配置文件加密

SpringBoot资源文件中的内容通常情况下是明文显示，安全性比较低。打开application.properties或application.yml，mysql登陆密码，以及第三方的密钥等一览无余，这里介绍一个加解密组件，提高属性配置的安全性。
jasypt由一个国外大神写了一个springboot下的工具包

1、首先引入jar

```xml
<dependency>
	<groupId>com.github.ulisesbocchio</groupId>
	<artifactId>jasypt-spring-boot-starter</artifactId>
	<version>2.0.0</version>	
</dependency>
```

如果用2.1.0必须导全三个(没有传递依赖,2.1.1版本不兼容)

```xml
<dependency>
	<groupId>com.github.ulisesbocchio</groupId>
	<artifactId>jasypt-spring-boot-starter</artifactId>
	<version>2.1.0</version>	
</dependency>

<dependency>
	<groupId>com.github.ulisesbocchio</groupId>
	<artifactId>jasypt-spring-boot</artifactId>
	<version>2.1.0</version>
</dependency>
	
<dependency>
	<groupId>org.jasypt</groupId>
	<artifactId>jasypt</artifactId>
	<version>1.9.3</version>
</dependency>
```

2、application.yml配置文件中增加如下内容（加解密时使用）

```yaml
jasypt加密的密匙 盐值

jasypt:
  encryptor:
    password: EbfYkitulv73I2
```

或者是在JVM启动参数中设置

```java
-Djasypt.encryptor.password=EbfYkitulv73I2
```

![image-20210723104322266](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210723104322266.png)

3、在测试用例中生成加密后的秘钥

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-test</artifactId>
	<scope>test</scope>
</dependency>
```

```java
@RunWith(SpringRunner.class)
@SpringBootTest
@WebAppConfiguration
public class JTest {
    @Autowired
    StringEncryptor encryptor;

@Test
public void getPass() {
    String url = encryptor.encrypt("jdbc:mysql:///mydb2?serverTimezone=GMT");
    String name = encryptor.encrypt("你的数据库用户名");
    String password = encryptor.encrypt("你的数据库密码");
    System.out.println(url);
    System.out.println(name);
    System.out.println(password);
}

}
```

```yaml
地址：JcKsB8iGrXlNtX7+L/ldzl8a6Mn3BH4XYDiqmbdvSd5vRTFblpShF47t09B6lT0yk70bY7INfi0pKgH+yB9Vyg==
姓名：03ybwYLnC8Cj88GSoeCIAg==
密码：q45psKASQHwKAaRrqjroZA==
```

4、将上面生成的name和password替换配置文件中的数据库账户和密码，替换后如下：

```yaml
spring:

数据库相关配置

  datasource:
    driver-class-name: com.mysql.jdbc.Driver    
    url: ENC(GBQBRUVmTEqu/zpH33M639Kj0IqXVDMoWahGp70z9vPHH3eASU3ZoFff/80gfZwC)
    username: ENC(1JLSxqte89sAZs9El1u0Pg==)
    password: ENC(otVXGXBVUrebggKOgEKQpA==)
```

1.安装idea
2.创建maven项目，配置自定义tomcat
3.使用springboot整合ssm项目
4.将上述项目打成war包发布外部tomcat上运行
5.配置tomcat管理账户，使用用界面发布

=================================================================

监控面板

```xml
<!--监控的-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
```



```yml
management:
  endpoint:
    health:
      #显示所有健康信息 ，默认never
      show-details: always
  server:
    #监控服务ip
    address: 127.0.0.1
    #监控服务端口
    port: 7777
  endpoints:
    web:
      exposure:
        #设置暴露所有端点
        include: "*"
        #排除
        exclude: env
      #访问的baseUrl（默认为/actuator）
      base-path:  /actuator

```

http://127.0.0.1:7777/actuator/

![image-20220616103747485](C:/Users/20936/AppData/Roaming/Typora/typora-user-images/image-20220616103747485.png)









## 六、日志和模板thymeleaf

注意：
1、SpringBoot默认使用日志:logback

日志配置文件：logback-spring.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<configuration>
    <!-- 控制台显示 -->
    <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
        <layout>
            <pattern>[%p]%d-%msg%n</pattern>
        </layout>
    </appender>
    <!-- 按天显示 -->
    <appender name="ROLLING" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <prudent>true</prudent>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>
                mylog/access.%d{yyyy-MM-dd}.log
            </fileNamePattern>
        </rollingPolicy>
        <layout class="ch.qos.logback.classic.PatternLayout">
            <pattern>
                %d{yyyy-MM-dd HH:mm:ss} -%msg%n
            </pattern>
        </layout>
    </appender>
    <!-- 按天和大小显示 -->
    <!-- <appender name="ROLLING" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>mylog/mylog.txt</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            rollover daily
            <fileNamePattern>demo2/mylog-%d{yyyy-MM-dd}.%i.txt</fileNamePattern>
            each file should be at most 100KB, keep 60 days worth of history, but at most 20GB
            <maxFileSize>10240KB</maxFileSize>
            <maxHistory>60</maxHistory>
            <totalSizeCap>20GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%msg%n</pattern>
        </encoder>
    </appender> -->
    <root level="info">
        <appender-ref ref="console" />
        <appender-ref ref="ROLLING" />
    </root>
</configuration>
```



```java
package com.cssl.controller;

import com.cssl.pojo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @Autowired
    private User user; //导包的快捷键  alt+enter

    private final static Logger logger = LoggerFactory.getLogger(HelloController.class);

    @RequestMapping("/test")
    public String test(){
        logger.info("xxxxxxxxxxxxxxxxxxxxxxxxxxx"); //手写日志
        logger.warn("yyyyyyyyyyyyyyyyyyyyyyyy");

        int i=1/0;

        System.out.println("测试boot"+user);
        return "hello world";
    }
}

```

2、maven项目中，手动创建的webapp目录不能访问，要使用webapp骨架或者手动添加Web资源目录





3、IDEA的maven项目中，默认源代码(src/main/java)目录下的xml等资源文件并不会在编译的时候一块打包进classes文件夹，而是直接舍弃掉(Eclipse打war包也会丢弃java目录下的xml)
    解决这个问题有两种方式:
    第一种是建立src/main/resources文件夹，将xml等资源文件放置到这个目录中。maven工具默认在编译的时候，会将resources文件夹中的资源文件一块打包进classes目录中。

```xml
第二种解决方式是配置maven的pom文件配置，在pom文件中找到<build>节点，添加下列代码：
<build>
<resources>
	<resource>
		<directory>src/main/java</directory>
		<includes>
			<include>**/*.properties</include>
			<include>**/*.xml</include>
		</includes>
		<filtering>false</filtering>
	</resource>
	<!-- 最好加上，避免后面打war包出错 -->
	<resource>
		<directory>src/main/resources</directory>
		<includes>
			<include>**/*.*</include>				
		</includes>
		<filtering>false</filtering>
	</resource>
</resources>
</build>
```



模板引擎 ：https://www.thymeleaf.org/

Spring Boot中推荐使用Thymeleaf作为模板引擎.因为Thymeleaf提供了完美的SpringMVC支持.

Thymeleaf是一个java类库，他是一个xml/xhtml/html5的模板引擎，可以作为mvc的web应用的view层。

hymeleaf是一款用于渲染XML/XHTML/HTML5内容的模板引擎，类似JSP，Velocity，FreeMaker等，它也可以轻易的与Spring MVC等Web框架进行集成作为Web应用的模板引擎

![img](https://img2020.cnblogs.com/blog/1872426/202010/1872426-20201030161548934-2083976790.png)



![img](https://img2020.cnblogs.com/blog/1872426/202010/1872426-20201030161941829-682777087.png)

1.项目依赖

```xml
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

2.页面引入依赖

```html
<html lang="en" xmlns:th="http://www.thymeleaf.org">
```



3.基础语法：

```tex
https://www.jianshu.com/p/d1370aeb0881
```



4.项目案例

实体类：

```java
package com.cssl.entity;

import lombok.*;

import java.io.Serializable;
import java.util.Date;
//@Data
//@Setter
//@Getter
//@AllArgsConstructor()
//@NoArgsConstructor
//@ToString
public class Student implements Serializable {

    private int sid; //编号
    private String sname; //测试
    private Date bornDate;

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public Date getBornDate() {
        return bornDate;
    }

    public void setBornDate(Date bornDate) {
        this.bornDate = bornDate;
    }

    public Student() {
    }

    public Student(int sid, String sname, Date bornDate) {
        this.sid = sid;
        this.sname = sname;
        this.bornDate = bornDate;
    }

    @Override
    public String toString() {
        return "Student{" +
                "sid=" + sid +
                ", sname='" + sname + '\'' +
                ", bornDate=" + bornDate +
                '}';
    }
}

```

控制器：

```java
package com.cssl.controller;

import com.cssl.entity.Student;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class HelloController {

    @RequestMapping("/hello")
    public String hello(Model model,HttpSession session){
        System.out.println("进入hello");
        //测试脚本和p段落显示
        model.addAttribute("mess","测试数据");

        //测试sessionu作用域取值
        System.out.println("进入session");
        session.setAttribute("student",new Student(103,"华莱士",new Date()));

        //测试样式控制百分比
        model.addAttribute("count",60.0);
        model.addAttribute("totalNum",100);

        
        
        //测试集合
        List<Student> list=new ArrayList<Student>();
        list.add(new Student(101,"陈金",new Date()));
        list.add(new Student(102,"陈翔",new Date()));
        list.add(new Student(103,"陈龙",new Date()));
        list.add(new Student(104,"陈坤",new Date()));
        list.add(new Student(105,"陈老李",new Date()));

        //<c:foreach item="${stuList}" var="stu" varstatu=sta
        //<tr th:each="stu,sta:${stuList}">
        model.addAttribute("stuList",list);

        //测试下来框
        List<String> citys=new ArrayList<String>();
        citys.add("北京");
        citys.add("上海");
        citys.add("广州");
        citys.add("深圳");
        citys.add("成都");
        model.addAttribute("citys",citys);
        
        //测试回显下拉框
        Student cx = new Student(103, "陈翔", new Date());
        model.addAttribute("obj",cx);


        //测试图片路径
        model.addAttribute("imagePath","http://127.0.0.1:8080/thy/images/g2.jpg");

        //测试数据格式
        model.addAttribute("num1",1332.56856);//0012.56
        model.addAttribute("num2",12.56);


        //测试连接
        model.addAttribute("url","<a href='http://www.baidu.com'>百度</a>");

        return "index";
    }

}

```

application.yml：

```yaml
server:
  servlet:
    context-path: /thy
#thymeleaf模板引擎
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

![image-20210724151937336](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210724151937336.png)

页面显示：

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .odd{background-color: aqua}
    </style>

    <script th:inline="javascript">
        var message=[[${mess}]];
        alert("后台信息："+message);
    </script>
</head>
<body>
<h1>访问hello/index.html</h1>
<p th:text="${mess}" >张三</p>
<p th:text="'hello'+${mess}+',你是sb吗？'">李四</p>

<h1>访问session:注意如果存在session要求必须写session关键字</h1>
<div th:text="${session.student.sname}"
     th:style="'width:'+@{${count}/${totalNum}*100}+'%;height:30px;border: 1px solid red;background-color: yellow'" >
    默认空div
</div>

<H1>测试集合循环</H1>
<table border="1" width="800px">
    <tr>
        <th>序号</th>
        <th>ID</th>
        <th>姓名</th>
        <th>日期1</th>
        <th>日期2</th>
        <th>判断1</th>
        <th>判断2</th>
    </tr>


    <tr th:each="stu, stuState:${stuList}" th:class="${stuState.odd}?'odd'">
        <td th:text="${stuState.index}">1</td>
        <td th:text="${stu.sid}">101</td>
        <td th:text="${stu.sname}">张三</td>
        <td th:text="${stu.bornDate}">2020-08-02</td>
        <td th:text="${#dates.format(stu.bornDate, 'yyyy-MM-dd')}">2020-08-01</td>
        <td th:text="${stuState.index}%2==0?'偶数':'奇数'">偶数</td>

        <!--if else-->
        <td th:if="${stuState.index} lt 2" th:text="大于">大</td>
        <td th:unless="${stuState.index} lt 2" th:text="小于">小于</td>
    </tr>
</table>

<hr/>

<h1>测试下拉框</h1>

<select id="sec1">
    <option value="0">-请选择-</option>
    <option th:each="c:${citys}" th:value="${c}" th:text="${c}">长沙</option>

</select>

<h1>显示集合中对象属性</h1>
<select id="sec2" >
    <option value="0">-请选择-</option>
    <option th:each="stu:${stuList}" th:value="${stu.sid}" th:text="${stu.sname}">长沙</option>
</select>

<h1>显示集合中对象属性--带回显</h1>
<select id="sec3" th:field="*{obj.sid}">
    <option value="0">-请选择-</option>
    <option th:each="stu:${stuList}" th:value="${stu.sid}" th:text="${stu.sname}">长沙</option>
</select>

<hr/> findByid/lisi?sid=104&name=zhansan
<img src="http://127.0.0.1:8080/thy/images/g1.jpg" th:src="@{${imagePath}}" alt="无法加载"/><br/>
<a th:href="@{'/findByid/'+${obj.sname}(sid=${obj.sid},name=${obj.sname})}">随便玩玩</a>

<hr/>
<h1>数据格式</h1>
<h2 th:text="${#numbers.formatDecimal(num1, 8, 2)}">num1</h2>

<h2 th:text="${'$'+num2}">num2</h2>

<h1>测试url</h1>
<div th:text="${url}">百度1</div>
<div th:utext="${url}">百度2</div>
<div th:include="order.html" style="border: 1px solid red;width: 800px;height: 300px">
</div>
</body>
</html>
```

![image-20210724152620478](C:\Users\20936\AppData\Roaming\Typora\typora-user-images\image-20210724152620478.png)

## 七、SpringBoot项目发布到独立的tomcat中

?    在开发阶段我们推荐使用内嵌的tomcat进行开发，因为这样会方便很多，但是到测试和生产环境，希望在独立的tomcat容器中运行，因为我们需要对tomcat做额外的优化，这时我们需要将工程打成war包发布

=================================================================
1、工程的打包方式为war

```xml
<packaging>war</packaging>
```

2、如果添加了servlet|jsp|jstl依赖,注意<scope>provided</scope>

```xml
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>javax.servlet-api</artifactId>
	<version>3.1.0</version>
	<scope>provided</scope>
</dependency>
<dependency>
      <groupId>org.apache.tomcat.embed</groupId>
      <artifactId>tomcat-embed-jasper</artifactId>
      <scope>provided</scope>
</dependency> 
<dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>jstl</artifactId>     
      <scope>provided</scope>

</dependency>
```

3、将spring-boot-starter-tomcat的范围设置为provided(spring-boot-starter-web自带Tomcat)
设置为provided是在打包时会将该包排除，因为要放到独立的tomcat中运行，是不需要的

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-tomcat</artifactId>
	<scope>provided</scope>

</dependency>

也可以在导入spring-boot-starter-web时配置：
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
	<!-- 移除嵌入式tomcat插件 -->
	<exclusions>
        	<exclusion>
            		<groupId>org.springframework.boot</groupId>
            		<artifactId>spring-boot-starter-tomcat</artifactId>
        	</exclusion>
	</exclusions>
</dependency>
```

4、修改编译设置(idea默认加载插件)

```xml
<plugin>
	<artifactId>maven-war-plugin</artifactId>
	<version>3.2.3</version>
</plugin>

=============================================
<build>
        <plugins>
           	 <plugin>
                	<groupId>org.springframework.boot</groupId>
                	<artifactId>spring-boot-maven-plugin</artifactId>
           	 </plugin>
		</plugins>

        <!-- 应与application.properties(或application.yml)中context-path保持一致 -->
        <finalName>mywar</finalName>

</build>
```

5、修改代码，设置启动配置
需要集成SpringBootServletInitializer，然后重写configure，将SpringBoot的入口类设置进去。

```java
public class ExampleApplication extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(ExampleApplication.class);
	}	
}

注意：SpringBoot1.x和2.x的包路径不同

@SpringBootApplication
public class MywarApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(MywarApplication.class, args);
    }


    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(MywarApplication.class);
    }

}
```

6、打war包
Eclipse:工程右键->Run As->Maven build (Goals输入：clean package)

IDEA:
1、Edit Configurations->“+”->maven->directory(选择路径)|Command line(clean package)
2、在Maven视图plugins右键运行|双击运行
3、也可以直接jsp右键运行会自动打war包


7、将war包复制到webapps下，启动


其他：
1、properties<->yml：
https://www.toyaml.com/index1.html

2、Idea新建项目maven仓库还原默认的解决：
File->Other Settings->Default Settings | Settings for NewProject(2019)
将Maven home directory目录修改成我们自定义安装Maven的目录

3、SpringBoot在IDEA下热部署不起作用（见SpringBoot_IDEA热部署.docx）

4、打jar包使用java -jar运行

```xml
<build>
        <plugins>
            <!-- 解决SpringBoot打包成jar不包含依赖，运行提示没有主清单属性问题 -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>1.4.2.RELEASE</version>
		<!-- 可以省略 
                <configuration>
                    <mainClass>com.example.DemoApplication</mainClass>
                </configuration>		
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
 		-->
            </plugin>	    
        </plugins>
```



```xml
<resources> 
        <resource>
            <!-- JSP包打包到资源里 -->
            <directory>${basedir}/src/main/webapp</directory>
            <!-- 指定resources插件处理哪个目录下的资源文件 -->
            <targetPath>META-INF/resources</targetPath>
            <includes>
                <include>**/**</include>
            </includes>
        </resource>
    </resources>
```

</buil