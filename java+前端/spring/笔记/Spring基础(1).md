## 了解Ioc容器

​	JavaBean ：拥有一定规范的Java实体类，内部提供一些公共方法能够对对象内部属性进行操作

​	IOC(inversion of control)控制反转

<img src="C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309100629276.png" alt="image-20230309100629276" style="zoom:200%;" />



## 容器的创建与Bean注册

1、mavne引入spring依赖

2、配置spring配置文件

3、配置文件添加<bean/>标签

4、声明 `ClassPathXmlApplicationContext（）`对象，接受配置文件路径



类信息通过bean标签全部交付给ioc容器管理

<bean scope="propotype/singleton"> 设定bean的单例和多例模式

![image-20230309105941663](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309105941663.png)

设置对象的初始化方法，和销毁方法

```xml
<bean init-method="" destroy-method=""/>
```

设置bean生成顺序

```xml
<bean depends-on="name"/>
```



## 依赖注入

IoC在创建对象时，将预先给定的属性注入到对象中，这就称为依赖注入

```xml
<bean class="com.test.bean.Student">
    <property name="name" value="小明"/>
    <property name="age" value="20"/>
    <property name="card" ref="card"/> //引用其他bean
</bean>

<bean name="card" class="com.test.bean.Card"/>
```

集合的注入

```xml
<bean class="com.test.bean.Student">
    <property name="name" value="小明"/>
    <property name="age" value="20"/>
    <property name="list">
        <list>
            <value type="java.lang.String">nihao</value>
            <value type="java.lang.String">12313</value>
            <value type="java.lang.String">123</value>
        </list>
        
       	<map>
                <entry key="英語" value="10"/>
                <entry key="数学" value="20"/>
         </map>
    </property>
</bean>
```



自动注入

```xml
<bean class="com.test.bean.Student" autowire="byType">
    <!--byname 根据类方法名称来自动获取值-->
```



## AOP机制

​	面向切面 AOP 在程序运行是，动态的将代码切入到类指定的方法或位置上。在方法执行前后做一些额外的操作(代理)。在不改变原有业务的情况下，添加额外的动作.

![image-20230309142207566](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309142207566.png)



aop相关标签：

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">
```



添加新的AOP配置：

```xml
<aop:config>
    //切入点，也就是被代理类的方法
    <aop:pointcut id="test" expression="execution(* com.test.bean.Student.test.say(String))"/> //execution填写格式：修饰符 包名.类名.方法名称(方法参数)
</aop:config>
```

* 类名：使用*也可以代表包下的所有类
* 方法名称：可以使用*代表全部方法
* 方法参数：填写对应的参数即可，比如(String, String)，也可以使用*来代表任意一个参数，使用..代表所有参数。



添加方法增强

```xml
<aop:config>
    //aspect ref为引用的增强类
    <aop:aspect ref="test">
        <aop:pointcut id="stu" expression="execution(* com.test.bean.Student.say(String))"/>
        //method为方法名，pointcut-ref为被代理类引用
        <aop:after-returning method="after" pointcut-ref="stu"/>
    </aop:aspect>
</aop:config>
```



为切入方法添加 `JoinPoint` 参数，可以通过参数获取切入点信息

```java
public void before(JoinPoint point){
    System.out.println("我是执行之前");
    System.out.println(point.getTarget());  //获取执行方法的对象
    System.out.println(Arrays.toString(point.getArgs()));  //获取传入方法的实参
}
```



## 接口实现AOP

```xml
<aop:around method="around" pointcut-ref="stu"/>
```

环绕方法完全代理了此方法，它完全将被代理方法包含在中间，需要手动调用

代理方法传入`ProceedingJoinPoint`参数，通过 `proceed()`方法调用

被增强方法返回值通过proceed()方法返回



接口实现AOP

```xml
<aop:config>
    <aop:pointcut id="stu" expression="execution(* com.test.bean.Student.say(String))"/>
    //advice-ref 代理接口 
    <aop:advisor advice-ref="before" pointcut-ref="stu"/>
</aop:config>
```

其实，我们之前学习的操作正好对应了AOP 领域中的特性术语：

- 通知（Advice）: AOP 框架中的增强处理，通知描述了切面何时执行以及如何执行增强处理，也就是我们上面编写的方法实现。
- 连接点（join point）: 连接点表示应用执行过程中能够插入切面的一个点，这个点可以是方法的调用、异常的抛出，实际上就是我们在方法执行前或是执行后需要做的内容。
- 切点（PointCut）: 可以插入增强处理的连接点，可以是方法执行之前也可以方法执行之后，还可以是抛出异常之类的。
- 切面（Aspect）: 切面是通知和切点的结合，我们之前在xml中定义的就是切面，包括很多信息。
- 引入（Introduction）：引入允许我们向现有的类添加新的方法或者属性。
- 织入（Weaving）: 将增强处理添加到目标对象中，并创建一个被增强的对象，我们之前都是在将我们的增强处理添加到目标对象，也就是织入（这名字挺有文艺范的）

 

## 注解进行配置

`@Configuration` 指定类为配置文件 等同于配置xml文件

`@Bean` 指定配置文件内类构造函数为Bean 等同于配置文件<bean/>

`@Scope` 指定类的单多例模式 等同于<scope>标签

`@Component` 直接在类上添加注解，来进行bean注册，需要添加自动扫描

`@ComponentScan()` 组件扫描，添加在配置类上.接受包路径

Bean,Component 后可以为bean命名



## 注解进行自动注入

`@Autowire` 加载字段上，无需set方法自动注入值

```java
//配置文件中Bean通过Autowired注入
@Bean
public Student student(@Autowired Card card){
    Student student = new Student();
    student.setCard(card);
    return student;
}
```

`@Resource 通过set方法注入值` (推荐字段)

![image-20230309173802205](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309173802205.png)

`@Qualifier()` 接受一个名称，注入指定名称的Bean

`@PostConstrut` 注解来添加构造后执行的方法，等价于init-method

`@Predestroy` 销毁方法

![image-20230309195420030](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309195420030.png)

![image-20230309195915689](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309195915689.png)



## 注解实现AOP操作

`@EnableAspectJAutoProxy` 给配置类加上注解

`@Aspect` 给代理类加上注解

`@before()` 加在增强方法上，接受execution字符串,方法应用与被增强方法前

`@AfterReturning(returning )` 同上 returning 返回被增强方法的返回值

![image-20230309204818197](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230309204818197.png)

`@Around()` 环绕方法，增强方法需传入ProceedingJoinPoint



其他注解配置

`@import(path)` 配置文件，通过import传入路径，导入其他配置文件，也能直接将其他类作为bean



## JUnit集成:快速使用上下文

引入依赖

```xml
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.8.1</version>
            <scope>test</scope>
        </dependency>
		<dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>5.3.13</version>
        </dependency>
```

`@ExtendWith(SpringExtension.class)`

`@ContextConfiguration(classes=xxxx.class or 配置文件.xml)`test注解，引入上下文

之后直接在测试方法中注入bean即可