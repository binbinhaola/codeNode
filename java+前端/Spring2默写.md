**1、解释Spring支持的几种bean的作用域**

request：对于每次 HTTP 请求，使用 request 定义的 bean 都将产生一个新实例，即每次 HTTP 请求将会产生不同的 bean 实例。
session：同一个 Session 共享一个 bean 实例。
global-session：同 session 作用域不同的是，所有的Session共享一个Bean实例。

1.singleton（单例模式）
2.prototype（原型模式）
3.request（HTTP请求）
4.session（会话）
5.global-session（全局会话）



**2、Spring框架中的单列bean是线程安全的吗？**

不是，Spring框架中的单例bean不是线程安全的。
spring 中的 bean 默认是单例模式，spring 框架并没有对单例 bean 进行多线程的封装处理。

**3、Spring如何处理线程并发问题？**

在一般情况下，只有无状态的Bean才可以在多线程环境下共享，在Spring中，绝大部分Bean都可以声明为singleton作用域，因为Spring对一些Bean中非线程安全状态采用ThreadLocal进行处理，解决线程安全问题。

**4、使用@Autowired注解自动装配的过程是怎么样的？**
在启动spring IOC时，容器自动装载了一个AutowiredAnnotationBeanPostProcessor后置处理器，当容器扫描到@Autowired、@Resource或@Inject时，就会在IOC容器自动查找需要的bean,并装配对该对象的属性。在使用@Autowired时，首先在容器中查询对应类型的bean:
如果查询结果刚好为一个，就将该bean装配给@Autowired指定的数据；
如果查询的结果不止一个，那么@Autowired会根据名称来查找；
如果上述查找的结果为空，那么会抛出异常。解决方法为，使用required=false


