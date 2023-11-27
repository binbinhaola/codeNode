## 使用JDBC连接数据库

```java
class.forName("com.mysql.jdbc.Driver")//注册驱动 老版本需要
    
//1. 通过DriverManager来获得数据库连接
try (Connection connection = DriverManager.getConnection("连接URL","用户名","密码");
     //2. 创建一个用于执行SQL的Statement对象
     Statement statement = connection.createStatement()){   //注意前两步都放在try()中，因为在最后需要释放资源！
    //3. 执行SQL语句，并得到结果集
    ResultSet set = statement.executeQuery("select * from 表名");
    //4. 查看结果
    while (set.next()){
        ...
    }
}catch (SQLException e){
    e.printStackTrace();
}
//5. 释放资源，try-with-resource语法会自动帮助我们close
```

1、DriverManager.getConnection("url","username","password")，获取数据库链接

2、connection.createStatement(),通过连接获取执行sql的statement对象

3、ResultSet 获取结果集

4、循环结果集获取查询数据

5、查询完成后关闭数据库连接



### 执行DQL操作

执行DQL操作会返回一个ResultSet对象，我们来看看如何从ResultSet中去获取数据：

```java
//首先要明确，select返回的数据类似于一个excel表格
while (set.next()){
    //每调用一次next()就会向下移动一行，首次调用会移动到第一行
}
```

我们在移动行数后，就可以通过set中提供的方法，来获取每一列的数据。

![img](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg-blog.csdnimg.cn%2F202005062358238.png%3Fx-oss-process%3Dimage%2Fwatermark%2Ctype_ZmFuZ3poZW5naGVpdGk%2Cshadow_10%2Ctext_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1JlZ2lubw%3D%3D%2Csize_16%2Ccolor_FFFFFF%2Ct_70&refer=http%3A%2F%2Fimg-blog.csdnimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1638091193&t=bf37a5cb988d0a641d00c7e325d06ce7)

### 执行批处理操作

当我们要执行很多条语句时，可以不用一次一次地提交，而是一口气全部交给数据库处理，这样会节省很多的时间。

```java
public static void main(String[] args) throws ClassNotFoundException {
    try (Connection connection = DriverManager.getConnection();
         Statement statement = connection.createStatement()){

        statement.addBatch("insert into user values ('f', 1234)");
        statement.addBatch("insert into user values ('e', 1234)");   //添加每一条批处理语句
        statement.executeBatch();   //一起执行

    }catch (SQLException e){
        e.printStackTrace();
    }
}
```



### 将查询结果映射为对象

通过反射映射对象

```java
public static <T> T convert(ResultSet set,Class<T> clazz){
    try{
        //默认获取类的首个构造函数
        Constructor<T> constructor = clazz.getConstructor(clazz.getConstructors()[0].getParameterTypes());
        //获取参数列表
        Class<?>[] params = constructor.getParameterTypes();
        //参数列表
        Object[] objects = new Object[params.length];

        for(int i=0;i<objects.length;i++){
            //获取查询到的数据库参数
            objects[i] = set.getObject(i+1);
            //对比数据类型与类接受类型是否一致
            if(objects[i].getClass()!=params[i]){
                throw  new SQLException("错误的类型转换"+objects[i].getClass()+"->"+params[i]);
            }
        }
        return constructor.newInstance(objects);//导入参数调用构造函数生成实例
    } catch (NoSuchMethodException | SQLException | InvocationTargetException | InstantiationException |
             IllegalAccessException e) {
        e.printStackTrace();
        return null;
    }
}
```



## 管理事务

```java
con.setAutoCommit();   //关闭自动提交后相当于开启事务。
// SQL语句
// SQL语句
Savapoint savepoint = con.setSavepoint();//创建回滚点
// SQL语句
con.commit(savapoint);或 con.rollback();
```



## 使用Lombok

我们通过实战来演示一下Lombok的实用注解：

* 我们通过添加`@Getter`和`@Setter`来为当前类的所有字段生成get/set方法，他们可以添加到类或是字段上，注意静态字段不会生成，final字段无法生成set方法。
  * 我们还可以使用@Accessors来控制生成Getter和Setter的样式。 
* 我们通过添加`@ToString`来为当前类生成预设的toString方法。
* 我们可以通过添加`@EqualsAndHashCode`来快速生成比较和哈希值方法。
* 我们可以通过添加`@AllArgsConstructor`和`@NoArgsConstructor`来快速生成全参构造和无参构造。
* 我们可以添加`@RequiredArgsConstructor`来快速生成参数只包含`final`或被标记为`@NonNull`的成员字段。
* 使用`@Data`能代表`@Setter`、`@Getter`、`@RequiredArgsConstructor`、`@ToString`、`@EqualsAndHashCode`全部注解。
  * 一旦使用`@Data`就不建议此类有继承关系，因为`equal`方法可能不符合预期结果（尤其是仅比较子类属性）。
* 使用`@Value`与`@Data`类似，但是并不会生成setter并且成员属性都是final的。
* 使用`@SneakyThrows`来自动生成try-catch代码块。
* 使用`@Cleanup`作用与局部变量，在最后自动调用其`close()`方法（可以自由更换）
* 使用`@Builder`来快速生成建造者模式。
  * 通过使用`@Builder.Default`来指定默认值。
  * 通过使用`@Builder.ObtainVia`来指定默认值的获取方式。

```java
label1:
    for(int i=0;i<10;i++){
        System.out.println("i"+i);
        for(int j=0; j<i;j++){
            System.out.println("j"+j);
            if(j==1) break label1;
        }
}
```

label标签，类似于goto语句，可以让内部语句直接跳转到label所作用的代码块

`@EqualsAndHashCode`默认只比较类本身的属性，不会比较父类的。需要加上参数(callSuper = true//默认为false)，才会比较父类。