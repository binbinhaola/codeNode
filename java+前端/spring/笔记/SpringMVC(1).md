## 概念和基本配置

MVC解释如下：

​	M是指业务模型（Model）:通俗的讲是我们之间用于封装数据传递的实体类

​	V是指用户界面(View)：一般指的是前端页面

​	C则是控制器(Controller)：控制器就就相当于Servlet的基本功能，处理请求，返回响应



流程图：

![image-20230314172200646](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230314172200646.png)

### 配置环境并搭建项目

​	1、引入Spring-webmvc

​	2、配置web.xml，将DispathcerServlet替换掉Tomcat自带的servlet，url-patter写为/

```xml
<servlet>
    <!--Servlet替换-->
    <servlet-name>app</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <!--XMl配置文件-->
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:springmvc.xml</param-value>
    </init-param>
    <!--注解类配置-->
    <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>com.example.config.MvcConfiguration</param-value>
        </init-param>
        <init-param>
            <param-name>contextClass</param-name>
            <param-value>org.springframework.web.context.support.AnnotationConfigWebApplicationContext</param-value>
        </init-param>
    <!--表示容器启动立即创建对应servlet对象 -->
    <load-on-startup>1</load-on-startup>
</servlet>

    <servlet-mapping>
        <servlet-name>app</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
```



完全去除掉配置文件，建立配置类，接受主配置，和Servlet配置

```java
public class MainInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{MainConfiguration.class};   //基本的Spring配置类，一般用于业务层配置
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[0];  //配置DispatcherServlet的配置类、主要用于Controller等配置
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};    //匹配路径，与上面一致
    }
}
```

![image-20230314175052506](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230314175052506.png)



## Controller控制器

![image-20230314190456400](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230314190456400.png)

1、引用依赖

```xml
        <dependency>
            <groupId>org.thymeleaf</groupId>
            <artifactId>thymeleaf-spring5</artifactId>
            <version>3.0.12.RELEASE</version>
        </dependency>
```

2、配置页面配置

web配置类注解

@ComponentScan("com.example.controller")
@Configuration
@EnableWebMvc

```java
@Bean
public ThymeleafViewResolver thymeleafViewResolver(@Autowired SpringTemplateEngine springTemplateEngine){
    ThymeleafViewResolver resolver = new ThymeleafViewResolver();
    resolver.setOrder(1);   //可以存在多个视图解析器，并且可以为他们设定解析顺序
    resolver.setCharacterEncoding("UTF-8");   //编码格式是重中之重
    resolver.setTemplateEngine(springTemplateEngine);   //和之前JavaWeb阶段一样，需要使用模板引擎进行解析，所以这里也需要设定一下模板引擎
    return resolver;
}

//配置模板解析器
@Bean
public SpringResourceTemplateResolver templateResolver(){
    SpringResourceTemplateResolver resolver = new SpringResourceTemplateResolver();
    resolver.setSuffix(".html");   //需要解析的后缀名称
    resolver.setPrefix("/WEB-INF/template");   //需要解析的HTML页面文件存放的位置
    return resolver;
}

//配置模板引擎Bean
@Bean
public SpringTemplateEngine springTemplateEngine(@Autowired ITemplateResolver resolver){
    SpringTemplateEngine engine = new SpringTemplateEngine();
    engine.setTemplateResolver(resolver);   //模板解析器，默认即可
    return engine;
}
```

3、新建Controller 

```java
@Controller //控制器注解

public class MainController {
    //mapper名称("浏览器访问地址")
    @RequestMapping("/test")
    
    public ModelAndView index(){    
        return new ModelAndView("index"//页面地址);
    }

    @RequestMapping("/test2")
    public ModelAndView index2(){
        return new ModelAndView("home");
    }
}
```

而页面中的数据我们可以直接向Model进行提供：

```java
@RequestMapping(value = "/index")
public ModelAndView index(){
    ModelAndView modelAndView = new ModelAndView("index");
    modelAndView.getModel().put("name", "啊这");
    return modelAndView;
}
```

这样Thymeleaf就能收到我们传递的数据进行解析：

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="static/test.js"></script>
</head>
<body>
    HelloWorld！
    <div th:text="${name}"></div>
</body>
</html>
```

当然，如果仅仅是传递一个页面不需要任何的附加属性，我们可以直接返回View名称，SpringMVC会将其自动包装为ModelAndView对象：

```java
@RequestMapping(value = "/index")
public String index(){
    return "index";
}
```

还可以单独添加一个Model作为形参进行设置，SpringMVC会自动帮助我们传递实例对象：

```java
@RequestMapping(value = "/index")
public String index(Model model){  //这里不仅仅可以是Model，还可以是Map、ModelMap
    model.addAttribute("name", "yyds");
    return "index";
}
```

### 添加静态内容

我们的页面中可能还会包含一些静态资源，比如js、css，因此这里我们还需要配置一下，让静态资源通过Tomcat提供的默认Servlet进行解析，我们需要让配置类实现一下`WebMvcConfigurer`接口，这样在Web应用程序启动时，会根据我们重写方法里面的内容进行进一步的配置：

```java
@Override
public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
    configurer.enable();   //开启默认的Servlet
}

@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/static/**").addResourceLocations("/WEB-INF/static/");   
  	//配置静态资源的访问路径
}
```

我们编写一下前端内容：

```xml
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
      <!-- 引用静态资源，这里使用Thymeleaf的网址链接表达式，Thymeleaf会自动添加web应用程序的名称到链接前面 -->
    <script th:src="@{/static/test.js}"></script>
</head>
<body>
    HelloWorld！
</body>
</html>
```

创建`test.js`并编写如下内容：

```js
window.alert("欢迎来到GayHub全球最大同性交友网站")
```



## @RequestMapping详解

![image-20230314224942755](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230314224942755.png)

path,value表示访问路径，可同时设置多个

将注解添加在Controller类上面，相当于给类里面所有的方法添加上了地址前缀.

ideal的"Endpoint"可以查看Controller映射，并且进行方法调试



路径还支持使用通配符进行匹配：

* ?：表示任意一个字符，比如`@RequestMapping("/index/x?")`可以匹配/index/xa、/index/xb等等。

* *：表示任意0-n个字符，比如`@RequestMapping("/index/*")`可以匹配/index/lbwnb、/index/yyds等。

* **：表示当前目录或基于当前目录的多级目录，比如`@RequestMapping("/index/**")`可以匹配/index、/index/xxx等。

  

- Method属性，限定Controller的请求方式，是一个数组可以限制多个请求方式
- 衍生注解 `@PostMapping @GetMapping` 顾名思义
- params 指定请求必须携带参数,可设置多个,在参数名前添加"!"表示不能附带此参数，可做判断
- header 限定请求头内容规则和"params"一致

* consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;

* produces:  指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；

  

## @RequestParam和@RequestHeader详解

为方法添加一个形式参数，并在形式参数前面添加`@RequestParam`注解即可获取到请求数据,方法形参如何请求参数同名，可不加此注解。

required=false/true、defaultValue设定默认值

直接添加`HttpServletRequest`为形式参数即可，SpringMVC会自动传递该请求原本的`HttpServletRequest`对象，同理，我们也可以添加`HttpServletResponse`作为形式参数，甚至可以直接将HttpSession也作为参数传递

我们还可以直接将请求参数传递给一个实体类：

```java
@Data
public class User {
    String username;
    String password;
}
```

注意必须携带set方法或是构造方法中包含所有参数，请求参数会自动根据类中的字段名称进行匹配

`@RequestHeader`与`@RequestParam`用法一致，不过它是用于获取请求头参数的，这里就不再演示了



## @CookieValue和@SessionAttrbutie

通过使用`@CookieValue`注解，我们也可以快速获取请求携带的Cookie信息

```java
@RequestMapping(value = "/index")
public ModelAndView index(HttpServletResponse response,
                          @CookieValue(value = "test", required = false) String test){
    System.out.println("获取到cookie值为："+test);
    response.addCookie(new Cookie("test", "lbwnb"));
    return new ModelAndView("index");
}
```

同样的，Session也能使用注解快速获取：

```java
@RequestMapping(value = "/index")
public ModelAndView index(@SessionAttribute(value = "test", required = false) String test,
                          HttpSession session){
    session.setAttribute("test", "xxxx");
    System.out.println(test);
    return new ModelAndView("index");
}
```



## 重定向和请求转发

在视图名称前添加"redirect:"字段即可实现重定向

在视图名称前添加"forward:"字段即可实现转发

### Bean的Web作用域

- request:@RequestScope,对于每次http请求，使用request作用域是都会生成一个新Bean，请求结束后bean会消失
- session:@SessionScope,对于每个会话，使用session作用域的Bean都会产生一个新实例，会因对话过期后消失



## RestFul风格

我们就可以直接从请求路径中读取参数，比如：`http://localhost:8080/mvc/index/123456`

`@PathVariable` 方法形参添加注解就可获取路径数据

```java
@RequestMapping("/index/{str}")
public String index(@PathVariable String str) {
    System.out.println(str);
    return "index";
}
```

我们可以按照不同功能进行划分：

* POST http://localhost:8080/mvc/index  -  添加用户信息，携带表单数据
* GET http://localhost:8080/mvc/index/{id}  -  获取用户信息，id直接放在请求路径中
* PUT http://localhost:8080/mvc/index  -  修改用户信息，携带表单数据
* DELETE http://localhost:8080/mvc/index/{id}  -  删除用户信息，id直接放在请求路径中



***

## Interceptor拦截器

![image-20230315144941928](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230315144941928.png)

实现HandlerIntercepter接口，

重写方法`preHandle(),postHandle(),afterCompletion()`

**拦截器注册**:

在web配置类中重写方法，构建接口实现类

```java
@Override
public void addInterceptors(InterceptorRegistry registry) {
    registry
        .addInterceptor(new XXX);
    	.addPathPatterns("/**") //添加拦截器的匹配路径，只要匹配就拦截
         .excludePathPatterns("/home"); //不拦截路径
}
```

拦截器流程：

true： prehandler->Controller->postHandler->afterCompletion

false： preHandler

发生异常：preHandler->Controller->afterCompletion

**多拦截器**：

当注册多个拦截器时，拦截器会以栈的方式运行，

1prehandler->2prehandler->controller->2afterhandler->1afterhandler->2aftercompletion->1aftercompletion

## 自定义异常处理

当我们的请求映射方法中出现异常时，会直接展示在前端页面，这是因为SpringMVC为我们提供了默认的异常处理页面，当出现异常时，我们的请求会被直接转交给专门用于异常处理的控制器进行处理。

我们可以自定义一个异常处理控制器，一旦出现指定异常，就会转接到此控制器执行：

```java
@ControllerAdvice
public class ErrorController {

    @ExceptionHandler(Exception.class)
    public String error(Exception e, Model model){  //可以直接添加形参来获取异常
        e.printStackTrace();
        model.addAttribute("e", e);
        return "500";
    }
}
```

接着我们编写一个专门显示异常的页面：

```java
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
  500 - 服务器出现了一个内部错误QAQ
  <div th:text="${e}"></div>
</body>
</html>
```

接着修改：

```java
@RequestMapping("/index")
public String index(){
    System.out.println("我是处理！");
    if(true) throw new RuntimeException("您的氪金力度不足，无法访问！");
    return "index";
}
```

访问后，我们发现控制台会输出异常信息，同时页面也是我们自定义的一个页面。s

## JSON

我们也可以将JS对象转换为JSON字符串：

```js
JSON.stringify(obj)
```

JSONObject就是对JSON数据的一种对象表示。同样的还有JSONArray，它表示一个数组，用法和List一样，数组中可以嵌套其他的JSONObject或是JSONArray

当出现循环引用时，会按照以下语法来解析：![img](https://img2018.cnblogs.com/blog/1758707/201908/1758707-20190814212141691-1998020800.png)

`JSON.toJSONString(Object)` 可将实体类直接转换为json格式数据

```java
@RequestMapping(value = "/index", produces = "application/json")
```

里我们修改了`produces`的值，将返回的内容类型设定为`application/json`，表示服务器端返回了一个JSON格式的数据

//也可以直接将对象返回至前端



也可以在类上添加`@RestController`表示此Controller默认返回的是字符串数据

**json传数据时加上@ResponseBody**

pringMVC非常智能，我们可以直接返回一个对象类型，它会被自动转换为JSON字符串格式

```java
@RequestMapping(value = "/data", produces = "application/json")
@ResponseBody//主要用来接收前端传递给后端的json字符串中的数据
public Student data(){
    Student student = new Student();
    student.setName("杰哥");
    student.setAge(18);
    return student;
}
```

注意需要在配置类中添加一下FastJSON转换器（默认只支持JackSon）：

```java
@Override
public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
    converters.add(new FastJsonHttpMessageConverter());
}
```



## AJAX请求

引入jq：

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

编写js：

```js
function updateData() {
    //美元符.的方式来使用Ajax请求，这里使用的是get方式，第一个参数为请求的地址（注意需要带上Web应用程序名称），第二个参数为成功获取到数据的方法，data就是返回的数据内容
  	$.get("/mvc/data", function (data) {   //获取成功执行的方法
        window.alert('接受到异步请求数据：'+JSON.stringify(data))  //弹窗展示数据
        $("#username").text(data.name)   //这里使用了JQuery提供的选择器，直接选择id为username的元素，更新数据
        $("#age").text(data.age)
    })
}
```

使用JQuery非常方便，我们直接通过JQuery的选择器就可以快速获取页面中的元素，注意这里获取的元素是被JQuery封装过的元素，需要使用JQuery提供的方法来进行操作。

这样，我们就实现了从服务端获取数据并更新到页面中（实际上之前，我们在JavaWeb阶段使用XHR请求也演示过，不过当时是纯粹的数据）

那么我们接着来看，如何向服务端发送一个JS对象数据并进行解析：

```js
function submitData() {
    $.post("/mvc/submit", {   //这里使用POST方法发送请求
        name: "测试",     //第二个参数是要传递的对象，会以表单数据的方式发送
      	age: 18   
    }, function (data) {
        window.alert(JSON.stringify(data))   //发送成功执行的方法
    })
}
```

服务器端只需要在请求参数位置添加一个对象接收即可（和前面是一样的，因为这里也是提交的表单数据）：

```java
@RequestMapping("/submit")
@ResponseBody
public String submit(Student student){
    System.out.println("接收到前端数据："+student);
    return "{\"success\": true}";
}
```

我们也可以将js对象转换为JSON字符串的形式进行传输，这里需要使用ajax方法来处理：

```js
function submitData() {
    $.ajax({   //最基本的请求方式，需要自己设定一些参数
        type: 'POST',   //设定请求方法
        url: "/mvc/submit",   //请求地址
        data: JSON.stringify({name: "测试", age: 18}),  //转换为JSON字符串进行发送
        success: function (data) {
            window.alert(JSON.stringify(data))
        },
        contentType: "application/json"  //请求头Content-Type一定要设定为JSON格式
    })
}
```

如果我们需要读取前端发送给我们的JSON格式数据，那么这个时候就需要添加`@RequestBody`注解：

```java
@RequestMapping("/submit")
@ResponseBody
public String submit(@RequestBody JSONObject object){
    System.out.println("接收到前端数据："+object);
    return "{\"success\": true}";
}
```

这样，我们就实现了前后端使用JSON字符串进行通信。

## 实现文件上传和下载

1、在web配置类下注册一个bean

```java
@Bean("multipartResolver")   //注意这里Bean的名称是固定的，必须是multipartResolver
public CommonsMultipartResolver commonsMultipartResolver(){
    CommonsMultipartResolver resolver = new CommonsMultipartResolver();
    resolver.setMaxUploadSize(1024 * 1024 * 10);   //最大10MB大小
    resolver.setDefaultEncoding("UTF-8");   //默认编码格式
    return resolver;
}
```

2、编写一个Controller，使用`CommonMultipartFile`对象接受上传的文件

```java
//这里处理方法的形参名必须与前端 input 标签的 name 的值保持一致，不然会报 500 错误
@RequestMapping(value = "/upload", method = RequestMethod.POST)
@ResponseBody
public String upload(@RequestParam CommonsMultipartFile file) throws IOException {
    File fileObj = new File("test.html");
    file.transferTo(fileObj);
    System.out.println("用户上传的文件已保存到："+fileObj.getAbsolutePath());
    return "文件上传成功！";
}
```

3、导入依赖

```xml
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.4</version>
</dependency>
```

4、html添加文件上传点

```html
<div>
    <form action="upload" method="post" enctype="multipart/form-data">
        <input type="file" name="file">
        <input type="submit">
    </form>
</div>
```

5、下载功能，添加下载Controller

直接使用HttpServletResponse，并向输出流中传输数据即可

```java
@RequestMapping(value = "/download", method = RequestMethod.GET)
@ResponseBody
public void download(HttpServletResponse response){
    response.setContentType("multipart/form-data");
    try(OutputStream stream = response.getOutputStream();
        InputStream inputStream = new FileInputStream("test.html")){
        IOUtils.copy(inputStream, stream);
    }catch (IOException e){
        e.printStackTrace();
    }
}
```



## DispathcerServlet源码解析
