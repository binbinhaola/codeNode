之前的看作者文档

## 使用Thymeleaf模板引擎

### Thymeleaf语法基础

1、初始化函数中，初始化模板引擎，模板解析器。引擎设置解析器

2、获取context，为context设置变量，

3、通过engine.process(path,context,Writer),写入文件，使用上下文，使用的writer

```java
@WebServlet("/index")
public class HelloServlet extends HttpServlet {

    TemplateEngine engine;
    @Override
    public void init() throws ServletException {
        engine = new TemplateEngine();
          	//设定模板解析器决定了从哪里获取模板文件，这里直接使用ClassLoaderTemplateResolver表示加载内部资源文件
        ClassLoaderTemplateResolver r = new ClassLoaderTemplateResolver();
        engine.setTemplateResolver(r);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //创建上下文，上下文中包含了所有需要替换到模板中的内容
        Context context = new Context();
        context.setVariable("title", "我是标题");
        //通过此方法就可以直接解析模板并返回响应
        engine.process("test.html", context, resp.getWriter());
    }

}
```

接着我们来了解Thymeleaf如何为普通的标签添加内容，比如我们示例中编写的：

```html
<div th:text="${title}"></div>
```

我们使用了`th:text`来为当前标签指定内部文本，注意任何内容都会变成普通文本，即使传入了一个HTML代码，如果我希望向内部添加一个HTML文本呢？我们可以使用`th:utext`属性：

```html
<div th:utext="${title}"></div>
```

并且，传入的title属性，不仅仅只是一个字符串的值，而是一个字符串的引用，我们可以直接通过此引用调用相关的方法：

```html
<div th:text="${title.toLowerCase()}"></div>
```

这样看来，Thymeleaf既能保持JSP为我们带来的便捷，也能兼顾前后端代码的界限划分。

除了替换文本，它还支持替换一个元素的任意属性，我们发现，`th:`能够拼接几乎所有的属性，一旦使用`th:属性名称`，那么属性的值就可以通过后端提供了，比如我们现在想替换一个图片的链接：

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    Context context = new Context();
    context.setVariable("url", "http://n.sinaimg.cn/sinakd20121/600/w1920h1080/20210727/a700-adf8480ff24057e04527bdfea789e788.jpg");
  	context.setVariable("alt", "图片就是加载不出来啊");
    engine.process("test.html", context, resp.getWriter());
}
```

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <img width="700" th:src="${url}" th:alt="${alt}">
</body>
</html>
```

现在访问我们的页面，就可以看到替换后的结果了。

Thymeleaf还可以进行一些算术运算，几乎Java中的运算它都可以支持：

```html
<div th:text="${value % 2}"></div>
```

同样的，它还支持三元运算：

```html
<div th:text="${value % 2 == 0 ? 'yyds' : 'lbwnb'}"></div>
```

多个属性也可以通过`+`进行拼接，就像Java中的字符串拼接一样，这里要注意一下，字符串不能直接写，要添加单引号：

```html
<div th:text="${name}+' 我是文本 '+${value}"></div>
```

### Thymeleaf流程控制语法

```html
<div th:if="${eval}">我是判断条件标签</div>
```

`th:if`会根据其中传入的值或是条件表达式的结果进行判断，只有满足的情况下，才会显示此标签，具体的判断规则如下：

- 如果值不是空的：
  - 如果值是布尔值并且为`true`。
  - 如果值是一个数字，并且是非零
  - 如果值是一个字符，并且是非零
  - 如果值是一个字符串，而不是“错误”、“关闭”或“否”
  - 如果值不是布尔值、数字、字符或字符串。
- 如果值为空，th:if将计算为false

`th:if`还有一个相反的属性`th:unless`，效果完全相反，这里就不演示了。

我们接着来看多分支条件判断，我们可以使用`th:switch`属性来实现：

```html
<div th:switch="${eval}">
    <div th:case="1">我是1</div>
    <div th:case="2">我是2</div>
    <div th:case="3">我是3</div>
</div>
```

只不过没有default属性，但是我们可以使用`th:case="*"`来代替：

```html
<div th:case="*">我是Default</div>
```

```html
<ul>
    <li th:each="title : ${list}" th:text="'《'+${title}+'》'"></li>
</ul>
<!--title接受list的遍历值-->
```

我们还可以获取当前循环的迭代状态，只需要在最后添加`iterStat`即可，从中可以获取很多信息

```html
<ul>
    <li th:each="title, iterStat : ${list}" th:text="${iterStat.index}+'.《'+${title}+'》'"></li>
</ul>
```

状态变量在`th:each`属性中定义，并包含以下数据：

- 当前*迭代索引*，以0开头。这是`index`属性。
- 当前*迭代索引*，以1开头。这是`count`属性。
- 迭代变量中的元素总量。这是`size`属性。
- 每个迭代的*迭代变量*。这是`current`属性。
- 当前迭代是偶数还是奇数。这些是`even/odd`布尔属性。
- 当前迭代是否是第一个迭代。这是`first`布尔属性。
- 当前迭代是否是最后一个迭代。这是`last`布尔属性。

### Thymeleaf模板布局

1、建立一个模板

```html
<div class="head" th:fragment="head-title(sub)">//模板接收参数
  <div>
    <h1>我是标题内容，每个页面都有</h1>
    <h2 th:text="${sub}"></h2>
  </div>
  <hr>
</div>
```

我们可以使用`th:insert`和`th:replace`和`th:include`这三种方法来进行页面内容替换，那么`th:insert`和`th:replace`（和`th:include`，自3.0年以来不推荐）有什么区别？

- `th:insert`最简单：它只会插入指定的片段作为标签的主体。
- `th:replace`实际上将标签直接*替换*为指定的片段。
- `th:include`和`th:insert`相似，但它没有插入片段，而是只插入此片段*的内容*。

2、引用模板

```html
<div th:include="head.html::head-title('这个是第1个页面的二级标题')"></div>
//插入模板，并传入参数

<div class="body">
    <ul>
        <li th:each="title, iterStat : ${list}" th:text="${iterStat.index}+'.《'+${title}+'》'"></li>
    </ul>
</div>
```

