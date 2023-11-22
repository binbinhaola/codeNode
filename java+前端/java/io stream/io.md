## JAVA IO 流

### 流

​	完整路径：`/root/temp`  '/'可代替 以/开头

​	相对路径:	`test/test` 不是以/开头的



#### 字节流

##### FileInputStream

获取文件输入流：`new FIleInputStream("path")` 

`new FIleInputStream("path"(File文件))` 

######  `read()`

​		一个一个字符读取，没有值时返回-1

​		参数：byte[] 接受字符数组，按数组长度来读取字节(仅限纯文本文件)

###### `available()`

​		判断字符长度

###### `skip()`

​		接受int，跳过对应字节



##### FileOutputStream

​	获取文件输出流：`new FIleInputStream("path")` 

###### 	`write()`

​		参数：

​		bytes[]   接受一个byte数组写入

​		off 偏移位数

​		len 每次的写入长度

​		append 设定是否在文件后追加数据默认false

###### 	`flush()`

​		执行刷新操作，保证数据写入到硬盘内

------



#### 字符流

通过字符进行读取,只适合纯文本文件

##### FileReader

获取文件输入流：`new FileReader("path")` 

###### `read()` 

​	以字符为单位读取



##### FileWriter

获取字符输出流：`new FileWriter("path")` 

###### `write()`

​	接受char[] 数组

 	String 字符串

​	len 限制长度，读取数据长度大于实际长度是不会清空数据，会有多于的字符产生

###### `append()`

​	返回FileWrite本身，可以链式调用。

------



#### 文件对象

获取File对象 ： `new File("path")` 不会自动检查文件

##### File

文件获取长度为long



`exists()` 判断文件是否存在

`createNewFIle()` 创建一个文件 返回布尔值

`mkdir()` 创建一个文件夹 返回布尔值

`mkdirs()` 创建目录文件和文件夹

------



#### 缓冲流

##### BufferedInputStream

获取对象：`new BufferedInputStream(new FileInputStreamer(),size)`

###### `mark(limit),reset()`

​	 mark()相当于打了一个断点，调用reset()方法会将字节读取位置返回到mark()的调用位置

​	limit必须大于size,超过limit标记失效

##### BuffredOutputStream 

同输入流

##### BufferedReader

###### 	`lines()`  

​		可以一行一行读取数据

##### BufferedWriter

​	`newLine()` 换行

------



#### 转换流

##### OutputStreamWriter

​	获取对象：`new OutputStreamWirter(new FileOutputStream())`

##### InputStreamReader

​	获取对象：`new InputStreamReader(new FileInputStream())`

------



#### 打印流

##### Printstream

​	获取对象： `new PrintStream(new FileInputStream())`

 赋予一个输出流

工作原理：

 ![image-20230306163437394](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230306163437394.png)

##### printf()

​	https://kimzing.blog.csdn.net/article/details/69951340?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-69951340-blog-127258567.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-69951340-blog-127258567.pc_relevant_default&utm_relevant_index=5

##### Scanner()

  接受一个输入流

------

#### 数据流和对象流

##### DataInputStream 

​	接受一个输入流，用于基本数据类型的读取

##### DateOutputStream

​	接受一个输出流，用于基本数据的写入(二进制数据，并非字符串)

##### ObjectOutputStream

​	接受一个输出流，可以写入序列化对象数据与基本数据

​	`writeObject()`

##### ObjectInputStream

​	接受一个输入流，可以接受序列化对象数据与基本数据

​	`readObject()`



​	transient 关键字，属性不参与序列化

------



#### 要注意的方法

```JAVA
try(String){
    
}catch(ioException e ){

}
```

无需finally 自动调用close方法

流使用后使用close()方法,否则流会占用文件,放于finally代码块



**`new String(bytes)`** 

string构造函数接受一个字节数组，可直接转化为字符串



**`String.getBytes()`**

直接将string转化为byte数组

