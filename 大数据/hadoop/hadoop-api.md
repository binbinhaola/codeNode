<<<<<<< HEAD
# hdfs基本操作

## 相关依赖

![image-20230826192117188](F:\markdownImg\image-20230826192117188.png)

**配置log4j**

![image-20230826192231166](F:\markdownImg\image-20230826192231166.png)

## 新建文件夹

```java
        //连接的集群地址
        URI uri = new URI("hdfs://node1:8020");

        //创建一个配置文件
        Configuration conf = new Configuration();

        //登录用户
        String user = "root";

        //1，获取到了客户端对象
        FileSystem fs = FileSystem.get(uri, conf,user);

        //2，创建一个文件夹 
        fs.mkdirs(new Path("/study/test"));

        //3，关闭资源
        fs.close();
```

## 上传文件

![image-20230627171334162](F:\markdownImg\image-20230627171334162.png)

## hdfs配置文件优先级

```java
    /**
     * 参数优先级
     * hdfs-default.xml => hdfs-site.xml => 在项目资源目录下的配置文件 => 代码内部配置
     */
```

## 文件下载

![image-20230627174823488](F:\markdownImg\image-20230627174823488.png)

## 删除

```java
public void testDel() throws IOException {

        //参数解读:
        //参数1：要删除的路径
        //阐述2：是否递归删除
        fs.delete(new Path("/study/test/test.txt"),false);

        // 删除空目录
        fs.delete(new Path("/study/test"),false);

        // 删除非空目录
        fs.delete(new Path("/study/test"),true);
    }
```

## 更名和移动

```java
    public void testMv() throws IOException {
        //参数解读：
        //参数1，源文件路径
        //参数2:目标文件路径

        //文件名修改
        fs.rename(new Path("/study/test/test.txt"),new Path("/study/test/good.txt"));

        //文件名移动和更名
        fs.rename(new Path("/study/test/good.txt"),new Path("/study/test2/bad.txt"));

        //目录更名
        fs.rename(new Path("/study/test"),new Path("/study/exam"));
    }
```

## 文件详情查看

```java
    public void fileDetail() throws IOException {

        //获取文件信息
        RemoteIterator<LocatedFileStatus> listFiles = fs.listFiles(new Path("/"), true);

        while (listFiles.hasNext()){
            LocatedFileStatus fileStatus = listFiles.next();
            System.out.println("========="+fileStatus.getPath()+"=========");
            System.out.println(fileStatus.getPermission());
            System.out.println(fileStatus.getOwner());
            System.out.println(fileStatus.getGroup());
            System.out.println(fileStatus.getLen());
            System.out.println(fileStatus.getModificationTime());
            System.out.println(fileStatus.getReplication());
            System.out.println(fileStatus.getBlockSize());
            System.out.println(fileStatus.getPath().getName());

            //获取块信息
            BlockLocation[] blockLocations = fileStatus.getBlockLocations();
            System.out.println(Arrays.toString(blockLocations));
        }


    }
}
```

## HDFS文件和文件夹的判断

```java
    public void testFile() throws IOException {
        FileStatus[] listStatus = fs.listStatus(new Path("/"));

        for(FileStatus status:listStatus){
            if(status.isFile()){
                System.out.println("文件："+status.getPath().getName());
            }else{
                System.out.println("文件夹："+status.getPath().getName());
            }
        }
    }
```



# MapReduce

![image-20230826194729196](F:\markdownImg\image-20230826194729196.png)

![image-20230826195730588](F:\markdownImg\image-20230826195730588.png)

## wordCount源码&序列化类型

```java
//泛型为两组[k,V]
//第一组[K,V]表示输入map的键值对类型
//第二组[K,V]表示输出map的键值对类型
//Text对应String类型，IntWritable对应int
public static class TokenizerMapper extends Mapper<Object,Text,Text,IntWritable>{
    public void map(){
        //重写父类方法
    }
}

//逻辑与mapper类似
//第一组[K,V]表示输入的map键值类型，要与map的输出类型匹配
public static class IntSumReducer extends Reducer<Text,IntWritable,Text,IntWritable>{
    public void reduce(){
        //重写
    }
}
```

job的配置![image-20230627212753076](F:\markdownImg\image-20230627212753076.png)

hadoop对应的类型

![image-20230627213002047](F:\markdownImg\image-20230627213002047.png)

## MapReduce编程规范

![image-20230627231942987](F:\markdownImg\image-20230627231942987.png)

![image-20230627232232148](F:\markdownImg\image-20230627232232148.png)

<img src="F:\markdownImg\image-20230627232425650.png" alt="image-20230627232425650" style="zoom:200%;" />

## WordCount实例需求分析

![image-20230627233029609](F:\markdownImg\image-20230627233029609.png)

## Mapper

Context 抽象类，储存了全局信息，位于mapper和reduce之间

setup内部方法，初始化

cleanup内部方法，关闭资源

map内部方法,需要实现的业务功能

```java
/**
 * KEYIN, map阶段输入的key的类型:LongWritable (偏移量)
 * VALUEIN, map阶段输入value类型:Text
 * KEYOUT, map阶段输出的key类型:Text
 * VALUEOUT map阶段输入的value类型：IntWritable
 */
public class WordCountMapper extends Mapper<LongWritable,Text,Text, IntWritable> {

    private Text outK = new Text();
    private IntWritable outV = new IntWritable(1);

    @Override
    protected void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException {

        //1.获取一行
        String line = value.toString();

        //2.切割字符串
        String[] words = line.split(" ");

        //3.循环写出
        for(String word:words){

            //封装outK
            outK.set(word);

            //写出
            context.write(outK,outV);
        }
    }
}
```



## Reducer

Context抽象类，链接mapper和reducer，以及其他的系统代码

```java
**
 * KEYIN, reduce阶段输入的key的类型:Text
 * VALUEIN, reduce阶段输入value类型:IntWritable
 * KEYOUT, reduce阶段输出的key类型:Text
 * VALUEOUT reduce阶段输入的value类型：IntWritable
 */
public class WordCountReducer extends Reducer<Text, IntWritable,Text,IntWritable> {

    IntWritable outV = new IntWritable();

    @Override
    protected void reduce(Text key, Iterable<IntWritable> values,Context context) throws IOException, InterruptedException {

        int sum = 0;

        //累加
        for (IntWritable value : values) {
            sum += value.get();
        }

        outV.set(sum);


        //写出
        context.write(key,outV);
    }
}
```



## Driver

```java
public class WordCountDriver {

    public static void main(String[] args) throws IOException, InterruptedException, ClassNotFoundException {

        // 1.获取job
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf);

        // 2.获取jar包路径
        job.setJarByClass(WordCountDriver.class);

        // 3.关联mapper和reducer
        job.setMapperClass(WordCountMapper.class);
        job.setReducerClass(WordCountReducer.class);

        // 4.设置map输出的kv类型
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);

        // 5.设置最终输出的KV类型
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        // 6.设置输入路径和输出路径
        FileInputFormat.setInputPaths(job,new Path("F:\\bigdata\\input\\inputword"));
        FileOutputFormat.setOutputPath(job,new Path("F:\\bigdata\\output\\output"));

        // 7.提交job
        boolean result = job.waitForCompletion(true);

        System.exit(result?0:1);
    }
}
```

## jar打包运行

```xml
    <build>
        <plugins>
            //jar without dependencies
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.6.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            //jar with dependencies
            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <configuration>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

运行时指定目录，接受main函数的arg参数

指定运行main函数时需要使用全包名



## hadoop序列化

![image-20230628161915160](F:\markdownImg\image-20230628161915160.png)

## 自定义序列化

![image-20230628162603718](F:\markdownImg\image-20230628162603718.png)

![image-20230628162637759](F:\markdownImg\image-20230628162637759.png)



## 序列化案例

1.新增实体类来储存多条数据

2.在mapper中将实体类封装好

3.在reduce中将实体类的数据处理完成 

4.输出数据



## MapReduce框架原理

![image-20230628195853692](F:\markdownImg\image-20230628195853692.png)

### InputFormat数据输入

![image-20230628201029948](F:\markdownImg\image-20230628201029948.png)



### FileInputFormat切片机制



![image-20230628224627672](F:\markdownImg\image-20230628224627672.png)



## TextInputFormat



## CombineTextInputFormat

![image-20230628233553377](F:\markdownImg\image-20230628233553377.png)

切片机制

虚拟存储后，会进行合并。如果虚拟存储没有大于设置的切片最大值，就会一直合并，直到大于设置的值

=======
# hdfs基本操作

## 相关依赖

![image-20230826192117188](F:\markdownImg\image-20230826192117188.png)

**配置log4j**

![image-20230826192231166](F:\markdownImg\image-20230826192231166.png)

## 新建文件夹

```java
        //连接的集群地址
        URI uri = new URI("hdfs://node1:8020");

        //创建一个配置文件
        Configuration conf = new Configuration();

        //登录用户
        String user = "root";

        //1，获取到了客户端对象
        FileSystem fs = FileSystem.get(uri, conf,user);

        //2，创建一个文件夹 
        fs.mkdirs(new Path("/study/test"));

        //3，关闭资源
        fs.close();
```

## 上传文件

![image-20230627171334162](F:\markdownImg\image-20230627171334162.png)

## hdfs配置文件优先级

```java
    /**
     * 参数优先级
     * hdfs-default.xml => hdfs-site.xml => 在项目资源目录下的配置文件 => 代码内部配置
     */
```

## 文件下载

![image-20230627174823488](F:\markdownImg\image-20230627174823488.png)

## 删除

```java
public void testDel() throws IOException {

        //参数解读:
        //参数1：要删除的路径
        //阐述2：是否递归删除
        fs.delete(new Path("/study/test/test.txt"),false);

        // 删除空目录
        fs.delete(new Path("/study/test"),false);

        // 删除非空目录
        fs.delete(new Path("/study/test"),true);
    }
```

## 更名和移动

```java
    public void testMv() throws IOException {
        //参数解读：
        //参数1，源文件路径
        //参数2:目标文件路径

        //文件名修改
        fs.rename(new Path("/study/test/test.txt"),new Path("/study/test/good.txt"));

        //文件名移动和更名
        fs.rename(new Path("/study/test/good.txt"),new Path("/study/test2/bad.txt"));

        //目录更名
        fs.rename(new Path("/study/test"),new Path("/study/exam"));
    }
```

## 文件详情查看

```java
    public void fileDetail() throws IOException {

        //获取文件信息
        RemoteIterator<LocatedFileStatus> listFiles = fs.listFiles(new Path("/"), true);

        while (listFiles.hasNext()){
            LocatedFileStatus fileStatus = listFiles.next();
            System.out.println("========="+fileStatus.getPath()+"=========");
            System.out.println(fileStatus.getPermission());
            System.out.println(fileStatus.getOwner());
            System.out.println(fileStatus.getGroup());
            System.out.println(fileStatus.getLen());
            System.out.println(fileStatus.getModificationTime());
            System.out.println(fileStatus.getReplication());
            System.out.println(fileStatus.getBlockSize());
            System.out.println(fileStatus.getPath().getName());

            //获取块信息
            BlockLocation[] blockLocations = fileStatus.getBlockLocations();
            System.out.println(Arrays.toString(blockLocations));
        }


    }
}
```

## HDFS文件和文件夹的判断

```java
    public void testFile() throws IOException {
        FileStatus[] listStatus = fs.listStatus(new Path("/"));

        for(FileStatus status:listStatus){
            if(status.isFile()){
                System.out.println("文件："+status.getPath().getName());
            }else{
                System.out.println("文件夹："+status.getPath().getName());
            }
        }
    }
```



# MapReduce

![image-20230826194729196](F:\markdownImg\image-20230826194729196.png)

![image-20230826195730588](F:\markdownImg\image-20230826195730588.png)

## wordCount源码&序列化类型

```java
//泛型为两组[k,V]
//第一组[K,V]表示输入map的键值对类型
//第二组[K,V]表示输出map的键值对类型
//Text对应String类型，IntWritable对应int
public static class TokenizerMapper extends Mapper<Object,Text,Text,IntWritable>{
    public void map(){
        //重写父类方法
    }
}

//逻辑与mapper类似
//第一组[K,V]表示输入的map键值类型，要与map的输出类型匹配
public static class IntSumReducer extends Reducer<Text,IntWritable,Text,IntWritable>{
    public void reduce(){
        //重写
    }
}
```

job的配置![image-20230627212753076](F:\markdownImg\image-20230627212753076.png)

hadoop对应的类型

![image-20230627213002047](F:\markdownImg\image-20230627213002047.png)

## MapReduce编程规范

![image-20230627231942987](F:\markdownImg\image-20230627231942987.png)

![image-20230627232232148](F:\markdownImg\image-20230627232232148.png)

<img src="F:\markdownImg\image-20230627232425650.png" alt="image-20230627232425650" style="zoom:200%;" />

## WordCount实例需求分析

![image-20230627233029609](F:\markdownImg\image-20230627233029609.png)

## Mapper

Context 抽象类，储存了全局信息，位于mapper和reduce之间

setup内部方法，初始化

cleanup内部方法，关闭资源

map内部方法,需要实现的业务功能

```java
/**
 * KEYIN, map阶段输入的key的类型:LongWritable (偏移量)
 * VALUEIN, map阶段输入value类型:Text
 * KEYOUT, map阶段输出的key类型:Text
 * VALUEOUT map阶段输入的value类型：IntWritable
 */
public class WordCountMapper extends Mapper<LongWritable,Text,Text, IntWritable> {

    private Text outK = new Text();
    private IntWritable outV = new IntWritable(1);

    @Override
    protected void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException {

        //1.获取一行
        String line = value.toString();

        //2.切割字符串
        String[] words = line.split(" ");

        //3.循环写出
        for(String word:words){

            //封装outK
            outK.set(word);

            //写出
            context.write(outK,outV);
        }
    }
}
```



## Reducer

Context抽象类，链接mapper和reducer，以及其他的系统代码

```java
**
 * KEYIN, reduce阶段输入的key的类型:Text
 * VALUEIN, reduce阶段输入value类型:IntWritable
 * KEYOUT, reduce阶段输出的key类型:Text
 * VALUEOUT reduce阶段输入的value类型：IntWritable
 */
public class WordCountReducer extends Reducer<Text, IntWritable,Text,IntWritable> {

    IntWritable outV = new IntWritable();

    @Override
    protected void reduce(Text key, Iterable<IntWritable> values,Context context) throws IOException, InterruptedException {

        int sum = 0;

        //累加
        for (IntWritable value : values) {
            sum += value.get();
        }

        outV.set(sum);


        //写出
        context.write(key,outV);
    }
}
```



## Driver

```java
public class WordCountDriver {

    public static void main(String[] args) throws IOException, InterruptedException, ClassNotFoundException {

        // 1.获取job
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf);

        // 2.获取jar包路径
        job.setJarByClass(WordCountDriver.class);

        // 3.关联mapper和reducer
        job.setMapperClass(WordCountMapper.class);
        job.setReducerClass(WordCountReducer.class);

        // 4.设置map输出的kv类型
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);

        // 5.设置最终输出的KV类型
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        // 6.设置输入路径和输出路径
        FileInputFormat.setInputPaths(job,new Path("F:\\bigdata\\input\\inputword"));
        FileOutputFormat.setOutputPath(job,new Path("F:\\bigdata\\output\\output"));

        // 7.提交job
        boolean result = job.waitForCompletion(true);

        System.exit(result?0:1);
    }
}
```

## jar打包运行

```xml
    <build>
        <plugins>
            //jar without dependencies
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.6.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            //jar with dependencies
            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <configuration>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

运行时指定目录，接受main函数的arg参数

指定运行main函数时需要使用全包名



## hadoop序列化

![image-20230628161915160](F:\markdownImg\image-20230628161915160.png)

## 自定义序列化

![image-20230628162603718](F:\markdownImg\image-20230628162603718.png)

![image-20230628162637759](F:\markdownImg\image-20230628162637759.png)



## 序列化案例

1.新增实体类来储存多条数据

2.在mapper中将实体类封装好

3.在reduce中将实体类的数据处理完成 

4.输出数据



## MapReduce框架原理

![image-20230628195853692](F:\markdownImg\image-20230628195853692.png)

### InputFormat数据输入

![image-20230628201029948](F:\markdownImg\image-20230628201029948.png)



### FileInputFormat切片机制



![image-20230628224627672](F:\markdownImg\image-20230628224627672.png)



## TextInputFormat



## CombineTextInputFormat

![image-20230628233553377](F:\markdownImg\image-20230628233553377.png)

切片机制

虚拟存储后，会进行合并。如果虚拟存储没有大于设置的切片最大值，就会一直合并，直到大于设置的值

>>>>>>> e6f9c7032619ea760d965be70abd78cafff1d124
![image-20230628234007754](F:\markdownImg\image-20230628234007754.png)