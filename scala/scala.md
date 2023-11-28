# Scala语言的特点

1.是一门多范式的编程语言，支持面向对象和函数式编程

2.scala源代码会编译成java字节码.class,然后运行于JVM之上，可以调用java库，实现两种语言的无缝对接

3.简洁高效

4.快速掌握Scala的建议:1.学习scala的特有语法 2.搞清楚scala和java区别 3.如何规范使用scala



## Scala快速入门

```scala
object HelloScala{
	def main(args:Array[String]): Unit = {
        println("hello,scala!")
    }
}
```

说明

1.Object表示一个伴生对象，这里可以简单理解为一个对象

2.HelloScala就是对象名字，它底层真正对应的类名是HelloScala$，对象是HelloScala$类型的一个静态对象MODULE$

3.当编写一个Object HelloScala底层会生成两个.class文件，分别是HelloScala和HelloScala$



## ide创建Scala项目

1.安装插件

2.创建scala项目

3.添加maven支持



## 字符串的输出方式

![image-20231016191214276](F:\markdownImg\image-20231016191214276.png)



## 文档注释

多行注释

```scala
  /**
   * @example
   *    输入n1 = 10 n2 = 20 return 30
   * @param n1
   * @param n2
   * @return
   */
  def sum(n1:Int,n2:Int):Int = {
    return n1+n2
  }
```

```cmd
scaladoc -d f:/path  fileName #生成文档 	
```



# 变量

变量声明基本语法

var | val 变量名[:变量类型] = 变量值



### 注意事项

**声明变量时，类型可以省略（编译器自动推导，类型推导）**

类型确定后不能修改，**是强数据类型语言**

var 修饰的变量可变，val修饰的变量不可变 

val没有线程安全问题，因此效率高，推荐使用

var修饰的对象引用可以改变，val修饰的则不能改变，但对象的状态可以改变

声明变量需要初始值，可用"_"代替9



### 数据类型

Scala中数据类型都是对象

分为AnyVal(值类型)和AnyRef(引用类型),都是对象

![image-20231017211803219](F:\markdownImg\image-20231017211803219.png)

​	Any是根类型，他是所有类的父类

​	Null类型是一个特殊类，只有一个值null,是bottom class 是所有AnyRef类的子类

​	Nothing类型也是bottom class，是所有类的子类，在开发中可以将Nothind类型的值返回给任意变量或者函数，常用于抛出异常

### 整数类型

scala中整数型常量的默认类型为Int，赋值大于Int长度的值需要在后面加上"l"

![image-20231018145336338](F:\markdownImg\image-20231018145336338.png)

### 浮点类型

scala的浮点型常量默认为Double，声明Float型常量，需要在后面加"f"或'F'

float小数位在第7位

![image-20231018145648243](F:\markdownImg\image-20231018145648243.png)

### 字符类型(char)

char可以表示单个字符，16位无符号字符(2个字节) U+0000 U+FFFF

![image-20231018153141405](F:\markdownImg\image-20231018153141405.png)



### Unit,Null,Nothing

Null类只有一个实例对象null，可以赋值给任意引用类型，但不能赋值给值类型

Unit 返回值为"()"



### 值类型转换

在scala程序进行赋值或者运算时，精度小的类型自动转换为精度大的数据类型，这个就是自动类型转换（隐式转换)

**自动类型转换细节**

1. 多种类型的数据混合运算时，系统首先自动将所有数据转换成容量最大的那种数据类型，然后再进行计算

2. 当把精度（容量）大的数据类型赋值给精度（容量）小的数据类型时，就会报错，反之就会进行自动类型转换

3. （byte，short）和char之间不会互相自动转换

4. byte,short,char 他们三者可以计算，在计算时首先转换为Int类型

5. 自动提升原则，表达式结果的类型自动提升为操作数中最大的类型

**强制转换**

​	可以将大容量类型转换为小容量类型，需要使用强制转换函数，但可能造成精度降低或者溢出

**强制转换细节**

1.数据从大-->小，就需要强制转换

2.强转符号只针对于最近的操作数有效，往往会使用小括号提升优先级

```scala
val num1:Int = 10 * 3.5.toInt + 6*1.5.toInt //36
val num2:Int = (10 * 3.5 + 6 * 1.5).toInt //44
```

3.char类型可 以保存Int常量，但不能保存In的变量值，需要强转

![image-20231018165728925](F:\markdownImg\image-20231018165728925.png)

4.Byte和Short类型在进行运算时，当作Int类型处理



### 标识符

**标识符的概念**

1.Scala对各种变量，方法，函数等命名时使用的**字符序列**称为标识符

2.凡是自己可以起名字的地方都用标识符

3.**首字符为操作符（比如+ - * /），后续字符也需要跟操作符，至少一个**

4.反引号可以将预留字作为标识符

5"_"不能作为标识符



## 运算符

![image-20231018202212401](F:\markdownImg\image-20231018202212401.png)

### 算数运算符

![image-20231018202304268](F:\markdownImg\image-20231018202304268.png)

1.两个整数相除只保留整数位

2.a % b = a - a*b/b

3.赋值运算符的左边只能是变量，右边可以是变量，表达式，常量/代码块

![image-20231018204354071](F:\markdownImg\image-20231018204354071.png)

![image-20231018210213385](F:\markdownImg\image-20231018210213385.png)

## 键盘输入语句

引用类 StdIn 来获取键盘输入



# 流程控制

光标放在包名称上,按下ctrl + b可在侧边栏查看对应的包目录



## 单分支

基本语法

```scala
if(条件表达式){

​	执行代码块

}
```

条件表达式为true时，执行代码块代码



## 多分支

if else 和 java一样



在scala中没有switch，而是使用**模式匹配**来处理



## for循环

for循环的特性被称为**for推导式**或**for表达式**

```scala
for(i:Int <-1 to 10)  //条件判断为闭区间
for(i:Int <-1 until 10) //条件判断为开区间
for(c:Char <- "hello scala") println(c) //for循环遍历字符串
for(l:List <- List("aaa","bbb")) //循环遍历集合
```



### **循环守卫**

保护式为true则进入循环体内部，为false则跳过，类似continue

```scala
for (i <- 1 to 3 if i != 2){
    print(i +"")
}
```



### **引入变量**

没有关键字，所以范围后一定要加；来隔断逻辑

```scala
for(i<-1 to 3;j= 4 - i){
    print(j+"")
}
```



### **嵌套循环**

```scala
for(i<- 1 to 3; j<-1 to 3){
    println("i=" + i + "j=" + j)
}
```



### 循环返回值

将遍历过程中处理的结果返回到一个新的Vector集合中，使用yield关键字

```scala
//将每次循环的带的i，放入到集合vector中，并返回给res
// yield 后面可以接一个代码块，可以对i进行处理
val res = for(i <-i to 10) yield { i*2 } 
println(res)
```



**使用花括号代替小括号**

```scala
    for(i <- 1 to 3 ; j = i*2){
      println("i=" + i + " j= "+j)
    }

    //等价
    println("------------------")
    for{i <- 1 to 3
        j = i * 2}{
      println("i=" + i + " j= "+j)
    }
```

当for推导式包含单一表达式时使用圆括号，当其包含多个表达式时使用大括号



### **控制循环步进**

```scala
//Range(1,20,3)的对应的构建方法是
//def apply(start:Int,end:Int,step:Int):Range = new Range(start,end,step)
for(i <- Range(1,2,3)) //通过range实例控制步长

for( i <- 1 to 10 if i % 2 ==1){} // 通过for循环守卫进行步长控制
```



## while循环

和java一致

在使用循环时，尽量不要改变外部变量，如果需要改变，则使用递归的方式来改变变量的值



## 多重循环控制

![image-20231019172358122](F:\markdownImg\image-20231019172358122.png)



## 实现Break和Continue

Scala内置控制结构去掉了break和continue



### **break实现**

```scala
    var n = 1
    //breakable
    //1.breakable 是一个高阶函数(能够接受函数的函数)
    //2.breakable 对beak（）抛出的异常做了处理
    //3.当给函数传入代码块时，会将()改为{}
    //    def breakable(op: => Unit): Unit =
    //      try op catch {   
    //        case ex: BreakControl if ex eq breakException =>
    //      }
    // op: => Unit 表示一个接受没有输入，也没有返回值的函数
    breakable(
        while (n <= 20) {
        n += 1
        println("n=" + n)
        if (n == 18) {
          //中断while
          //1.在scala中使用函数式的break函数终端循环
          break()
        }
      }
    )
```

### Continue实现

使用 if-else 或者 循环守卫来实现相应的效果

```scala
for(i <-1 to 10 if (i != 2 && i != 3)){
    println("i= " + i)
}
```



# 函数式编程

## 方法和函数的转换

```scala
//方法转换为函数
val f1 = Object.method _

//给变量赋值一个匿名函数
val f2 = (n1:Int) =>{
    n1*2
}
```

## 函数的定义

![image-20231023170315561](F:\markdownImg\image-20231023170315561.png)

## 函数的调用

![image-20231023172956010](F:\markdownImg\image-20231023172956010.png)

## 函数递归

![image-20231023174454469](F:\markdownImg\image-20231023174454469.png)

 

##  过程

![image-20231024194000232](F:\markdownImg\image-20231024194000232.png)



## 惰性函数

当函数返回值被声明为lazy时，函数的执行将被推迟，直到首次对此取值，改函数才会执行。这种函数我们称之为**惰性函数**

```scala
def main(args:Array[String]):Unit={
    lazy val res = sum(10,20)
    println("----------")
    println("res=" + res)
    
    def sum(n1:Int,n2:Int):Int = {
        println("sum() 执行了..")
        return n1 + n2
    }
}
```

![image-20231024200148613](F:\markdownImg\image-20231024200148613.png)

1.lazy不能修饰var类型的变量

2.在声明一个变量时，如果给声明了lazy，那么变量值得分配也会推迟。比如 lazy val i = 10



## 异常

scala没有编译异常，异常都是在运行得时候捕获处理

throw关键字，抛出一个异常对象。所有异常都是Throwable的子类型

```scala
    try {
      val r = 10 / 0
    } catch {
          //1.在scala中只有一个catch
          //2.catch中通过case来匹配异常
          //3.=>关键符号，表示后面对该异常得处理代码快
      case ex: ArithmeticException => println("捕获了异常")
      case ex: Exception => println("捕获了大异常")
    } finally {
      println("scala finally...")
    }
```



用注解声明抛出的异常

```scala
  def main(args: Array[String]): Unit = {
    f11()
  }
  
  @throws(classOf[NumberFormatException])//等同于JavaNumberFormatException.class
  def f11()={
    "abc".toInt
  }
```



## 面向对象

### 入门

```scala
//cat.name不是直接访问属性，而是cat.name_$eq("小白")调用了方法发
cat.name = "小白"

//一个class Cat 对应的字节码文件只有一个cat.class,默认是public 
class Cat{
    //1.当我们声明了var name:String时,在底层对应private name
    //2.同时会生成两个public方法name() <=类似=>getter public name_$eq() => setter
    var name:String = "" //初始值
    var age:Int = _ // _ 表示给age一个默认的值，如为Int类默认是0
    var color:String = _  //_ 给color默认值,如为String,默认是""
}
```

<img src="F:\markdownImg\image-20231025162002998.png" alt="image-20231025162002998" style="zoom:150%;" />

![image-20231025162022907](F:\markdownImg\image-20231025162022907.png)

**创建对象**

val | var 对象名 [:类型] = new 类型()

## 匿名函数编程

"Hello".foreach.res *= _.toLong 中 的"__"是遍历出来的数据，相当于函数接受的形参

![image-20231025171036503](F:\markdownImg\image-20231025171036503.png)



## 类与对象的应用实例

定义类的属性和方法

```scala
  class Dog{
    var name:String = _
    var age:Int = _
    var weight:Double = 0.0

    def say(): String = {
      "小狗信息如下： name=" + this.name + "\t age= " + this.age + " weight=" + this.weight
    }
  }
```



##  构造器

**构造器又叫构造方法**，是类的一种特殊的方法，它的主要作用就是完成新对象的初始化

 ![image-20231030213156041](F:\markdownImg\image-20231030213156041.png)

scala可以有任意多个构造方法(支持重载)

scala类的构造器包括：主构造器和辅助构造器

```scala
class 类名(形参列表){ //主构造器
    //类体
}

def this(形参列表){ //辅助构造器
    
}

def this(形参列表){ //辅助构造器可以有多个
    
}
//this名称的构造器可以有多个，编译器通过不同参数来区分
```

 ![image-20231030214838958](F:\markdownImg\image-20231030214838958.png)

```scala
//主构造器
class Person(inName:String,inAge:Int){
  var name:String = inName
  var age:Int = inAge
    
 def this(name:String) = {
    //辅助构造器，必须在第一行显示调用主构造器(可以是直接，也可以是间接)
    //因为需要调用父类的构造函数
    this("jack",10)
    this.name = name
  }
}
```

主构造器在参数前加上private可以将主构造器私有化

```scala
class Person private(){
    //类体
    //私有构造器直接加上private
    private def this(name:String)={
        
    }
}
```



### 属性高级部分

![image-20231031004730556](F:\markdownImg\image-20231031004730556.png)

![image-20231031004918847](F:\markdownImg\image-20231031004918847.png)

**bean属性**

​	将Scala字段加上@BeanProperty时，会自动生成规范的setXxx/getXxx方法。

```scala
class Car{
    @BeanProperty var name:String = null
}
```

**scala对象创建的流程分析**

1.加载类的信息（属性信息，方法信息）

2.在内存中(堆)开辟空间

3.使用父类的构造器(主和辅助)进行初始化

4.使用主构造器对属性进行初始化

5.使用辅助构造器对属性进行初始化

6.将开辟的对象的地址赋给p这个引用



# 包介绍

## java包回顾

![image-20231031154107823](F:\markdownImg\image-20231031154107823.png)

包的文件路径要和源码文件一致，class文件路径也和源码路径一致



## Scala包

**基本语法**

package 包名

作用和java的一致

scala包名和源码所在的文件目录可以不一致，但编译后的字节码位置与包名一致

```scala
//1.package com.atguigu{} 表示我们创建了包com.atguigu,在{}中
//我们能可以继续写他的子包 scala //com.atguigu.scala, 还可以写类，特质trait，object
//2.scala支持，在一个文件中，同时创建多个包，以及给各个包创建类，trait和object

package com.atguigu{
    package scala{
        class Person{
            val name = "Nick"
            
            def play(message:String): Unit = {
                println(this.name + " " + message)
            }
        }
    }  
}
```

作用域原则：可以直接向上访问，Scala中子包可以直接访问父包中的内容

父类访问子包内容时，需要import对应的类等



### 包对象

包可以包含类，对象和特质trait，但不能包含函数/方法或变量的定义。

包对象是对此机制的补充

```scala
//1.package object scala 表示创建一个包对象scala,他是com.atguigu.scala这个包对应的包对象
//2.每一个包都可以有一个包对象
//3.包对象的名字要和包名称一致
//4.包对象中可定义变量方法
//5.包对象中定义的变量和方法，可以在对应的使用
package object scala{
    
}

package scala{ //包 com.atguigu.scala
    
}
```



### 包可见性

**java包可见性**

![image-20231031182209757](F:\markdownImg\image-20231031182209757.png)

**scala包可见性**

![image-20231031191625889](F:\markdownImg\image-20231031191625889.png)

```scala
class Person{
    //增加一个包访问权限
    //1.仍然是私有的
    //2.在指定包(包括子包)下也可以使用这个私有属性，扩大了访问权限 
    private[packageName] val name = "tat"
}
```

### 包的引入

1.import语句可以出现在任何地方("_"表示引入所有包，"{}"花括号选择器，引入指定包)

2.将引入的包进行重命名

```scala
def test():Unit={
    import java.util.{HashMap=>JavaHashMap,List}
    import scala.collection.mutable._
    var map = new HashMap()
    var map1 = new JavaHashMap()
}
```

3.如果某个冲突的类根本就不会用到，那么这个类可以直接隐藏掉.

```scala
import java.util.{HashMap=>_,_} //映入Java.util包，但忽略HashMap类
```



# 封装

1.scala中为了简化代码开发，当声明属性时，本身就自动提供了对应的setter/getter方法。

2.形式上dog.food的属性访问，实际上通过的方法访问属性



# 继承

## java继承

![image-20231031221941322](F:\markdownImg\image-20231031221941322.png)

![image-20231031223359031](F:\markdownImg\image-20231031223359031.png)

## scala继承

子类继承了父类所有属性

但是私有属性无法访问

### 方法重写

  scala中，重写一个非抽象方法需要override修饰符。

  子类通过super.methods关键字来调用同名父类方法

![image-20231101090338702](F:\markdownImg\image-20231101090338702.png)

### 类型检查和转换

```scala
classOf[String] //获取对象的类名
obj.isInstanceOf[T] //判断对象是否为T类型
//子类引用给父类（向上转型，自动）
//将父类的引用重新转成子类引用，向下转型，需要强转
obj.asInstanceOf[T] //将对象强转为T类型
```



## Scala超类构造

![image-20231102154324889](F:\markdownImg\image-20231102154324889.png)

![image-20231102154233499](F:\markdownImg\image-20231102154233499.png)

![image-20231102154301812](F:\markdownImg\image-20231102154301812.png)

​	调用了Emp类的辅助构造器，而辅助构造器又调用了主构造器，因为继承于Person类，所有调用了Person类的辅助构造器this(),父类的辅助构造器调用了主构造器，所以先执行println("Person"),然后...(默认名字),"Emp .....","Emp 辅助构造器"



在scala中，只有主构造器可以调用父类的构造器



## 覆写字段

​	java中只能重写方法，不能重写属性/字段，当子类定义了一个和父类相同名字的字段是，子类就是定义了一个新的字段，这个字段在父类中是被隐藏的，是不可重写的。

​	对于同一个对象，用父类的引用去取值(字段)，会取到父类的字段值，用子类的引用去取值，则取到子类字段的值



**scala 可以复写属性，通过override关键字，本质上是复写了获取属性的方法**

### **java的动态绑定机制**

1.如果调用的是方法，则jvm机会将该方法和对象的内存地址绑定

2.如果调用的是一个属性，则没有动态绑定机制，在哪里调用，就返回对应值



### 覆写细节

1.def 只能重写另一个def（即：方法只能重写另一个方法）

2.val只能重写另一个val属性 或 重写不带参数的def

3.var只能重写另一个抽象的var属性

```scala
//1.当一个类含有抽象属性时，该类需要抽象化
//2.对于抽象的属性，底层不会生成对应的属性声明，而是生成两个对应的抽象方法(name,name_$eq)

abstract class A03{ //抽象类
    var name :String //抽象字段
}

class Sub_A03 extends A03{
    //1.在子类中重写父类的抽象属性，本质上时实现了抽象方法
    //2.override关键字可不写
    //3.定义了的var属性不能被重写
    var name:String = ""
}
```



## 抽象类

通过关键字abstract标记的不能被实例化的类。方法不用abstract标记。抽象类可以拥有抽象字段，抽象属性没有初始值

默认情况下，一个抽象类不能实例化，但是在实例化时动态实现抽象类的所有方法，就可以将类实例化。

如果一个类继承了抽象类，则此类必须实现所有的抽象方法和抽象属性，除非自己也是抽象类

抽象类不能有private方法和属性



## 匿名子类

通过包含带有定义或重写的代码块的方式创建一个匿名子类

```scala
object NoNameDemo01 {
  def main(args: Array[String]): Unit = {
    val david = new Monster {
       var name: String = "david"

       def cry(): Unit = {
        println("nb")
      }
    }
    david.cry()
  }
}

abstract class Monster{
  var name:String
  def cry()
}
```



# 单例对象(伴生对象)

​	scala中**没有静态的概念**，所以为类产生了一个特殊的“伴生对象”，这个类所有的“静态”内容都可以放置在它的伴生对象中声明

```scala
object OneInstance {
  def main(args: Array[String]): Unit = {
    val p1 = Person("tom",11)
    p1.printInfo()
  }
}


//伴生类和伴生对象标识符要相同
class Person private (val name: String, val age: Int) {
  def printInfo() {
    println(name, age, Person.home)
  }
}
//基本语法
object Person {
  val home = "China"

  //定义一个类的对象实例的创建方法
  def apply(name:String,age:Int): Person = new Person(name,age)

}
```



## 设计模式

```scala
class Person private(val name:String,val age:Int){
    def printInfo(){
        .....
    }
}

//饿汉式
object Person{
    private val p1:Person=new Person("121",121)
    def getInstance():Person = p1
}

//懒汉式
object Person{
    private var p1:Person = _
    def getInstanfe():Person ={
        if(p1==null){
            //如果没有对象实例，就创建一个
            p1 = new Person("tom",12)
        }
        p1
    }
}
```



# 特质（trait)

​	scala中采用trait来代替接口的概念。trait既可以有抽象属性和方法，也可以有具体的属性和方法，一个类可以混入（mixin）多个特质

![image-20231106210709197](F:\markdownImg\image-20231106210709197.png)

```scala
//特质基本语法
trait name{
   //....
}
```

**继承父类和trait时，如果属性名相同，需要重写该属性**

```scala
//Logger就是自身类型特质，当这里做了自身类型后，那么
//trait Logger extends Exception,要求混入该特质的类也是Exception子类
trait Logger{
    //明确告诉编译器，我就是Exception,如果没有这句话，下面的getMessage不能调用
    this:Exception =>
    def log():Unit={
        println(getMessage)
    }
}
```

## 特质混入

```scala
//普通混入
Class student extends Person with Young{
    ...
}
```

```scala
//动态混入
//在创建新实例时混入特征
val studentWithTalent = new Student14 with talent

trait talent{
	def dancing:Unit
    def singing:Unit
}

//当一个抽象类有抽象方法，如何动态混入特质
new MySQL3_ with Operator3{
    override def say():Unit = { //帮方法实现放在最后面
        println("nihao")
    }
}

abstract class MySQL3_{
    def say()
}

trati Operator3{
    ....
}
```

```scala
class a extends trait1 with class1 with trait2{
    //当继承多个类和特征时
    //使用super调用父类的函数为最后一个混入的特征的函数
    def func(){
        super.func()
    }
    
}
```

## 叠加特质

构建对象同时混入多个特质，称为叠加特质

特质声明顺序从左到右，方法执行从右到左

![image-20231107085857654](F:\markdownImg\image-20231107085857654.png)

![image-20231107090449300](F:\markdownImg\image-20231107090449300.png)

![image-20231107090803946](F:\markdownImg\image-20231107090803946.png)

![image-20231107100947786](F:\markdownImg\image-20231107100947786.png)

**富接口**

特质中既有抽象方法，又有非抽象方法

```scala
trat Operator{
    def insert(id:Int)
    def sayHello(){
        println("nihao")
    }
}
```



## 钻石继承 

![image-20231106215601375](F:\markdownImg\image-20231106215601375.png)

![image-20231106215828274](F:\markdownImg\image-20231106215828274.png)

```scala
class a1 extend c1 with c2 = {
    def fun():Unit = {
        
        super[c1].fun()//指定对应父类的方法
    }
}
```

![image-20231106220209931](F:\markdownImg\image-20231106220209931.png)

## 扩展类

特质可以继承类，以用来拓展该类的一些功能

所有混入该特质的类，会自动称为那个特质所继承的超类的子类

如果混入该特质的类，已经继承了另一个类（A类），则要求A类是特质超类的子类，否则就会出现了多继承现象，发生错误



## 自身类型

主要是为了解决特质的循环依赖问题，同时可以确保特质在不扩展某个类的情况下，依然可以做到**限制混入该特质的类的类型**

```scala
class User(val name:String,val password:String)

trait UserDao{
    _: User=> //为类起别名,可以当作在特质内操作User类,不用继承就可以操作User类
    
    def insert():Unit ={
        println(s"inser into db: $this.name")
    }
}
```



## 补充

```scala
trait MyTrait{}
class A extends MyTrait{}
object B{
    def test(m:MyTrait):Unit = {
        println("ok")
    }
}
//当一个类继承了一个trait
//那么改类的实例，就可以传递给这个trait的引用
val a01 = new A
B.test(a01)
```



# 枚举类和应用类

枚举类：需要继承Enumeration

```scala
println(WorkDay.MONDAY) // 测试枚举类

//定义枚举类
object WorkDay extends Enumeration{
    val MONDAY = Value(1,"Monday")
    val TUESDAY = Value(2,"TuesDay")
}

//定义应用类对象
object TestApp extends App{
    
}

```

应用类：需要继承App	



# 嵌套类

类似于java的内部类 

java类的五大成员：1.属性 2.方法 3.内部类 4.构造器 5.内部类



**scala内部类创建语法**

![image-20231104212359732](F:\markdownImg\image-20231104212359732.png)

**内部类调用外部类属性**

![image-20231105174736148](F:\markdownImg\image-20231105174736148.png)

```scala
class ScalaOuterClass{
    myouter => //外部类的别名，看作是外部类的实例
    class ScalaInnerClass{
        def info() = {
            println("sss"+ myouter.name + myouter.sal)
        }
    }
    
    //属性定义在别名后
    var name = "scoot"
    private var sal = 30000.9
}
```



## 类型投影

![image-20231105192843561](F:\markdownImg\image-20231105192843561.png)

![image-20231105192819566](F:\markdownImg\image-20231105192819566.png)



# 隐形转换



## 隐式函数

隐式转换函数是以implicit关键字声明的带有单个参数的函数，这种函数将会自动应用，将值从一种类型转换为另一种类型。

1.隐式函数的函数名可以是任意的，只与函数签名(函数参数类型和返回值类型)有关

2.隐式函数可以有多个，但需要确保一种转换规则只有一个函数可以识别

```scala
//隐式函数要在作用域中才能生效
implicit def f1(d:Double):Int = {
    d.toInt
}

//转换会报错
implicit def f2(d:Double):Int = {
    d.toInt
}

val num:Int = 3.5
```



## 丰富类库功能

​	如果需要为一个类增加一个方法，可以通过隐式转换来实现。（动态增加功能）比如为MySQL类增加一个delete方法

```scala
object ImpliciteDemo02 {
  def main(args: Array[String]): Unit = {

    implicit def addDelete (mysql:MySQL):DB = {
      new DB
    }

    val mysql = new MySQL()

    mysql.delete()
  }
}

class MySQL {
  def insert(): Unit = {
    println("insert")
  }
}

class DB {
  def delete(): Unit = {
    println("delete")
  }
}
```



## 隐式值

​	隐式值叫做**隐式变量**，将某个形参变量标记为implicit,所以编译器会在方法省略隐式参数的情况下去搜索作用域内的隐式值作为缺省值

```scala
object ImpliciteDemo03 {
  def main(args: Array[String]): Unit = {

    implicit val str1:String = "jack"//隐式值

    //name就是隐式参数
    def hello(implicit name:String)={
      println("你是:"+name)
    }

    hello //使用隐式值不带()
  }
}     
// 隐式参数底层格式为
//hello$1(str1)
//所以隐式参数优先级比默认参数高
```



## 隐式类

可以用implicit声明类，可以扩展类功能。

**特点：**

1.所带的构造参数有且只能有一个

2.隐式类必须被定义在“类”或“伴生对象”或“包对象”里，**即隐式类不能是顶级的（top-level objects)**

3.隐式类不能是case class

4.作用域内不能有与之相同名称的标识符

```scala
object implicitClassDemo01 {
  def main(args: Array[String]): Unit = {
    val l = new MySQL1

    l.addsuffix() // 如何关联到DB1$1(mySQL).addsuffix()
    l.sayOk()
  }
  
  implicit class DB1(val m:MySQL1){ //ImplicitClassDemo$DB1$2
    def addsuffix():String={
      m + "scala"
    }
  }

  class MySQL1{
    def sayOk():Unit={
      println("sayOk")
    }
  }
}
```



## 转换时机

1.当方法中的参数的类型与目标类型不一致时

2.当对象调用所在类中不存在的方法或成员时，编译器会自动将对象进行隐式转换（根据类型）



# 集合

scala同时支持不可变集合和可变集合

![image-20231107115117930](F:\markdownImg\image-20231107115117930.png)

  ![image-20231107121625897](F:\markdownImg\image-20231107121625897.png)  



## 定长数组

```scala
//[Int]表示泛型，即该数组中只能存放Int
//[Any]表示该数组可以存放任意类型
val arr01 = new Array[Int](4)

//使用的是obejct Array的apply方法
//直接初始化数组，泛型类型和数据有关
var arr02 = Array(1,3,"xxx")
```



## 变长数组

```scala
//声明
val arr2 = ArrayBuffer[Int]()
//追加值
arr2.append(2) //可以理解成java数组的扩容，hashcode不一致，返回了新对象
//重新赋值
arr2(0) = 7
//删除
arr2.remove(0) //通过下标删除
```



## 定长数组与变长数组的转换

```scala
//数组本身没变，返回的数组有变化
arr1.toBuffer //转变长
arr2.toArray  //转定长
```



## 多维数组

```scala
//定义
val arr = Array.ofDim[Double](3,4) //说明：二位数组中有三个一维数组，每个一位数组中有四个元素

//赋值
arr(1)(1) = 11.11
```



## Scala数组与java的List转换

```scala
val arr = ArrayBuffer("1","2","3")

 //引入隐式类
import scala.jdk.CollectionConverters.{BufferHasAsJava, CollectionHasAsScala}

 //通过增强方法直接转换
 val javaArr = arr.asJava
 println(javaArr.getClass)


 val scalArr = javaArr.asScala
 println(scalArr)

```



## 元组

可以存放各种或不同类型的数据,灵活松散，对数据没有过多的约束,

注意：元组最大只有22个元素

```scala
    //1.tuple1 就是一个Tuple 类型是Tuple4
    //编辑器会根据元素的个数不同，对应不同的元组类型
    //从Tuple1-->Tuple22
    val tuple1 = (1,2,3,"hello",4)
    println(tuple1.getClass)
    println(tuple1)
```

### 访问方式

```scala
    println(tuple1._1) //直接访问


    /*
      override def productElement(n: Int): Any = n match { 
        case 0 => _1
        case 1 => _2
        case 2 => _3
        case 3 => _4
        case 4 => _5
        case _ => throw new IndexOutOfBoundsException(s"$n is out of bounds (min 0, max 4)")
     }
     */
    println(tuple1.productElement(1)) //通过数组方式访问
```

### 遍历

```scala
    //元组使用迭代器进行遍历
	for(iten <- tuple1.productIterator){
      println(iten)
    }
```



## List

scala的List可以直接存放数据，就是一个object

![image-20231108154029734](F:\markdownImg\image-20231108154029734.png)

```scala
    val list01 = List(1,2,3)
    println(list01)
    
    val list02 = Nil //空集合
    println(list02)

    val value = list01(0) // 访问元素
```



### 元素的追加

向列表增加元素，会返回一个新的列表/集合对象。不会影响原列表

```scala
    //通过 :+ 和 +: 给list追加元素
	//:所在方向表示list
    val newList = list01 :+ 4	//列表末尾加元素
    val newList2 = 10 +: list01	//列表开头加元素
 
    //::符号的使用 从右向左运算
	//表示向集合中，新建集合添加元素(最右边的元素为集合)
    val list4 = List(1,2,3,"abc")
    //1.List()
    //2.List(list(1,2,3,"abc"))
    //3.List(6,list(1,2,3,"abc"))
    //...
    val list5 = 4 :: 5 :: 6 :: list4 :: Nil
    println(list5)

	//:::符号的使用 与::运算顺序一致 符号左边为集合
	//表示将集合中的每一个元素，加入到右边的集合中（最右元素为集合）
	val list6 = 4 :: 5 :: list5 ::: Nil
```



## ListBuffer

ListBuffer是可变数组，可以添加，删除元素，属于序列

```scala
    val list1 = new ListBuffer[Int]
    list1 += 4 //添加元素
    list1.append(5)


    val list0 = new ListBuffer[Int]
    list0 +=20
    list0 ++= list1 //将list1元素加入到list0中

    val list3 = list0 :+ 5 //list0 没有变化

    list1.remove(1) // 将下标为1的元素删除

```



## Queue队列

队列是个有序列表，底层通过数组或者链表来实现

遵循先入先出原则

scala中分为可变和不可变，一般使用可变队列

```scala
    //创建Queue
    val q1 = new mutable.Queue[Any]
    //增加单个元素
    q1 += 20
    
    //将集合元素加入队列
    q1 ++= List(2,4,6)
    
    //将集合作为元素加入队列
    q1 += List(1,2,3)
```



### 删除队列元素

```scala
    //dequeque 从队列的头部取出元素 q1本身会变
    val value = q1.dequeue()

    //enqueque 入队列，默认是从队列的尾部加入
    q1.enqueue(20)
```



## 返回队列元素

```scala
    //返回队列第一个元素
    println(q1.head) //对q1没有影响
    //返回最后一个的元素
    println(q1.last) //对q1没有影响
    //取出队尾的数据(除了第一个数据以外的所有数据)
    println(q1.tail) //返回一个队列

```



## MAP

​	scala的Map 和Java类似，也是一个散列表。通过键值对映射储存数据，分为**可变（无序）map**和**不可变（有序）map**

```scala
    //1.默认map是 immutable.Map
    //2.key-value 类型支持Any
    //3.在底层kv的类型是tuple2
    val map1 = Map("Alice" -> 10,"Bob"->20,"Kotlin"->"peking")

	//需要指定可变Map包
    //可变map映射
    val map2 = mutable.Map("Alice" -> 10,"Bob"->20,"kotlin" -> "Peking")

    //创建空的映射
    val map3 = new mutable.HashMap[String,Int]()
    
    //对偶元组
    val map4 = mutable.Map(("Alice",10),("Bob"->20))
```



### Map取值

```scala
    //方法1-使用map(key)
    println(map4("Alice"))

    //查询不到则直接抛出异常
    println(map4("Alice~"))

    //方法2：使用contains方法检查是否存在key
    if(map4.contains("Alice_")){
      println("key存在，值="+map4("Alice_"))
    }else{
      println("key不存在XP")
    }

    //方法3：使用map.get(key).get取值
    //通过映射.get(key)这样的调用返沪一个Option对象，要么是some，要么是None
    println(map4.get("Alice")) //存在some
    println(map4.get("Blice")) //不存在none
    println(map4.get("Aliace").get) //none取值会抛出异常

    //方法4：map4.getOrElse()
    println(map4.getOrElse("Aewlice",111))
```



### map的删除，修改，添加操作(仅限可变Map)

```scala
val map4 = mutable.Map(("A",1),("B","北京"),("C",3))
map4("AA") = 20 //如果存在key则修改key值，如不存在key则添加kv

//增加单个元素
 map4 +=("D"->4) //key存在就修改，不存在就添加
 map4 +=("B"->50)

//增加多个元素
 val map5 = map4 + ("E"->1,"F"->3) 
 map4 +=("EE"->1, "FF"->3 )

//删除元素
 map4 -=("A","B") //有key就删除，key不存在也不会报错
```



### map遍历

```scala
val map1 = mutable.map(("A",1),("B",2),("C",3))
for((k,v)<-map1) println(k+"is mapped to" +v)
for(v <- map1.keys) println(v)
for(v <- map1.values) println(v)
for(v <- map1) println(v) //v是元组
```



## SET

集是不重复元素的结合，set集无序，默认以哈希集实现

```scala
  val set1 = Set(1,2,3)

  import scala.collection.mutable
  val set2 = mutable.Set(1,2,3)
```



## 可变集合的元素添加和删除

```scala
    //删除
    //删除元素不存在也不会报错和生效
    set2 -= 2
    set2.remove("121") //直接按值删除

    //添加
    //添加对象如已经存在不会重复添加，也不会报错
    set2.add(222)
    set2 += (111)
    set2.+=(5)
```

# 集合操作



## 集合元素映射-map映射

​	将集合中的每一个元素，通过指定功能（函数）映射（转换）成新的结果集合。就是将函数作为参数传递给另外一个函数

![image-20231109092707095](F:\markdownImg\image-20231109092707095.png)

```scala
  def main(args: Array[String]): Unit = {
    println(test(sum, 20.0))
    println(test((x:Double) => x * 2, 20.0))
  }

  //1.test是一个高阶函数
  //2.f:Double => Double 表示一个函数，该函数接受一个Double类型的值，返回Double
  //3.n1:Double 普通参数
  def test (f:Double => Double,n1:Double)={
    f(n1)
  }
  //test2是一个高阶函数，可以接受一个没有输入，返回为Unit的函数
  def test2(f:() => Unit)={
      f()
  }

  //普通函数
  def sum (d:Double):Double = {
    d + d
  }
  
  //在scala中，可以把一个函数直接赋给一个变量，但是不执行函数
  val f1 = sum(1.0) _
```



## 扁平化操作

flatmap,效果就是讲过集合中的每个元素的子元素，映射到某个函数并返回新的集合

![image-20231109101613833](F:\markdownImg\image-20231109101613833.png)

## filter过滤

filter：将符合要求的数据（筛选）放置到新的集合中



## reduce化简  

将二元函数引入于集合中的函数

![image-20231109110104712](F:\markdownImg\image-20231109110104712.png)

```scala
    val nums = List(1,2,3,4,5,6,7,8,9,10)
    val list3 = nums.reduce((x, y) => x + y) //同nums.reduce((_+_)
)
```



## fold折叠

fold函数将上一步返回的值作为函数的第一个参数继续传递参与运算，直到list中的所有元素被遍历

```scala
    val list = List(1,2,3,4)

    //函数柯里化，将参数分开传递
    println(list.foldLeft(5)(_ - _)) //将5从左到右和list的元素相减
    println(list.foldLeft(5)(_ + _)) //将5从右到左和list的元素相加
```

![image-20231109181812875](F:\markdownImg\image-20231109181812875.png)



## scan扫描

scan对集合的所有元素做fold操作，但是会把产生的所有中间结果放置于一个集合中保存

![image-20231109184830847](F:\markdownImg\image-20231109184830847.png)



## 拉链（合并）

当需要将两个集合进行对偶元组合并时，可以使用拉链

对偶元组：只有两个元素的元组

```scala
    val list1 = List(1,2,3)
    val list2 = List(4,5,6)

    val list3 = list1.zip(list2)// list((1,4),(2,5),(3,6))
```

```scala
//如果两个数组数据不对应，会出现数据丢失
val list1 = List(1,2)
val list2 = List(4,5,6)

val list3 = list1.zip(list2) //List((1,4), (2,5))
```



## 迭代器

iterator 的构建实际是AbstractIterator 的一个匿名自己

该子类提供了 hasNext,next等方法



## LazyList

​	LazyList是一个集合，可以用于存放无穷多个元素，但不会一次性生产出来，会动态生产，元素遵循lazy规则。

```scala
    def numsForm(n:BigInt) : LazyList[BigInt] = n #:: numsForm(n+1)
    val lazyList = numsForm(1)

```



## View(视图)

LazyList的懒加载特性，也可以对其他合计应用View方法来获得类似的效果，

特点1：view方法产出一个总是被懒执行的集合

特点2：view不会缓存数据，每次都要重新计算

```scala
    val viewSquares1 = (1 to 100)
      .view
      .filter((num)=> num.toString.equals(num.toString.reverse))
	println(viewSquares1) //直接打印不显示数据,且不会执行filter操作

	//遍历会加载数据
    for(item <- viewSquares1){
      println(item)
    }
```



# 多线程

2.13 版本scala的多线程集合需要引入依赖

```xml
        <dependency>
            <groupId>org.scala-lang.modules</groupId>
            <artifactId>scala-parallel-collections_2.13</artifactId>
            <version>1.0.4</version>
        </dependency>
```



## 线程安全

所有线程安全的集合，都是以Synchronized开头的集合



## 并行集合

![	](F:\markdownImg\image-20231109231306467.png)

```scala
    (1 to 5).foreach(println(_))
    println()
    (1 to 5).par.foreach(println(_)) //平行集合
```



# 操作符重载

![image-20231108165727894](F:\markdownImg\image-20231108165727894.png)

![image-20231110155208335](F:\markdownImg\image-20231110155208335.png)

中置操作符：A 操作符 B 等同于 A.操作符(B)



# 模式匹配(Match)

scala的模式匹配，类似于java中的switch

![image-20231110161745586](F:\markdownImg\image-20231110161745586.png)

案例展示

```scala
    val oper = '#'
    val n1 =20
    val n2 =10
    var res = 0

    //1.match (类似Java switch) 和 case 是关键字
    //2.如匹配成功，执行=>后面的代码块
    //3.匹配顺序从上倒下，匹配到后会执行代码
    //4.不需要break，代码块执行完成后自动退出
    //5.所有条件匹配不上时，匹配 case _
    oper match{
      case '+' => res = n1 + n2
      case '_' => res = n1 - n2
      case '*' => res = n1 * n2
      case '/' => res = n1 / n2
      case _ => println("oper error") //没有case _ 在所有条件匹配不上时，会抛出异常
    }
    println("res=" + res)
```



## 守卫

![image-20231110163826945](F:\markdownImg\image-20231110163826945.png)

![image-20231110170556620](F:\markdownImg\image-20231110170556620.png)



![image-20231110170541621](F:\markdownImg\image-20231110170541621.png)



## 中置表达式

```scala
  def main(args: Array[String]): Unit = {
    List(1,3,5,9) match{
      //1.两个元素之间::叫中置表达式
      //2.first匹配第一个,second匹配第二个,qita1匹配剩余部分,名字随意
      case first :: second :: qita =>println(first+""+second+""+ qita.length)
      case _ => println("nihao")
    }
  }
```



## 类型匹配

<img src="F:\markdownImg\image-20231111122436338.png" alt="image-20231111122436338" style="zoom:67%;" />

![image-20231111122620580](F:\markdownImg\image-20231111122620580.png)

如果case _ 出现在match中间，则表示隐藏变量名，即不使用，而不是表示默认匹配

```scala
val result = obj match{
case _: BigInt => Int.MaxValue //不接受obj，只对类型进行判断
}
```



## 匹配数组

![image-20231111131311653](F:\markdownImg\image-20231111131311653.png)

![image-20231111132204851](F:\markdownImg\image-20231111132204851.png)

## 匹配列表

![image-20231111132532616](F:\markdownImg\image-20231111132532616.png)



## 匹配元组

![image-20231111133752861](F:\markdownImg\image-20231111133752861.png)



## 对象匹配

case中对象的unapply方法(提取器)返回some合集则为匹配成功

返回none集合则为匹配失败

用来提取出类的实例对象转入的参数

```scala
object ObjMatchDemo01 {
  def main(args: Array[String]): Unit = {

    //模式匹配使用：
    val number:Double = 36.0

    number match{
      //说明case Square(n)的运行机制
      //1.当匹配到 case Square(n)
      //2.调用Square的unapply(z:Double),z 的值就是number
      //3.如果对象提取器unapply(z:Double) 返回的是Some(6),则表示匹配成功，
      //  同时将6赋值给Square(n)的 n
      case Square(n) => println(n)
      case _ => println("nothing matched")
    }

  }
}

object Square{
  //1.unapply方法时对象提取器
  //2.接受z:Double类型
  //3. 返回类型是Option[Double]
  //4.返回值是Some(math.sqrt(z)) 返回z的开平方的值，并放入到Some(x)
  def unapply(z:Double): Option[Double] = Some(math.sqrt(z))
  def apply(z:Double): Double = z * z
}
```

![image-20231111144702257](F:\markdownImg\image-20231111144702257.png)

![image-20231111144711892](F:\markdownImg\image-20231111144711892.png)

![image-20231111145014761](F:\markdownImg\image-20231111145014761.png)



## 变量声明的模式匹配

![image-20231111152250778](F:\markdownImg\image-20231111152250778.png)



## For表达式的模式匹配

```scala
    val map = Map("A"->1,"B"->0,"C"->3)

    for((k,v)<- map){
      println((k,v))
    }

    //筛选值为0的键值对
    for((k,0)<-map){
      println((k,0))
    }

    //守卫，筛选键值为A的键值对
    for((k,v)<-map if k=="A"){
      println((k,v))
    }
```



# 样例类

![image-20231111165905700](F:\markdownImg\image-20231111165905700.png)

```scala
object CaseClassDemo01 {
  def main(args: Array[String]): Unit = {
    println("hello~")
  }
}

abstract class Amount
case class Dollar(value:Double) extends Amount
case class Currency(value: Double,unit:String) extends Amount
case object NoAmount extends Amount
```



## 样例列应用

```scala
object CaseClassDemo01 {
  def main(args: Array[String]): Unit = 
    //体验使用样例类方式进行对象匹配的整洁性
    val dol1 = Dollar(2000.0)
    for(amt <- Array(dol1,Currency(1000.0,"RMB"),NoAmount)){
      val result = amt match {
        case Dollar(v) => "$" + v
        case Currency(v,u) => v +" "+ u
        case NoAmount => ""
      }
      println(amt + ":" + result)
    }

  }
}

abstract class Amount
case class Dollar(value:Double) extends Amount
case class Currency(value: Double,unit:String) extends Amount
case object NoAmount extends Amount
```

![image-20231111174115211](F:\markdownImg\image-20231111174115211.png)

# 匹配嵌套结构

通过类型匹配获取数据

```scala
    val sale = Bundle("书籍",10,Book("漫画",40),Bundle("文学作品",20,Book("《阳关》",80),Book("《围城》",30)))

    //知识点1 -使用case语句，得到“漫画”
    val res = sale match{
      case Bundle(_,_,Book(desc,_),_*) => desc
    }
    println(res)

    //知识点2-通过@表示法将嵌套的值绑定到变量。_*绑定剩余Item到rest
    val res2 = sale match{
      //如果我们进行对象匹配时，不想接受某些值，则使用_ 忽略即可，_*表示所有
      case Bundle(_,_,art @ Book(_,_),rest @ _*) => (art,rest)
    }
    println(res2)

    //知识点3-不使用_*绑定剩余Item到rest
    val res3 = sale match {
      case Bundle(_, _, art@Book(_, _), rest) => (art, rest)
    }
    println(res3)

    //解决方案
    def price(it:Item):Double = {
      it match {
        case Book(_,p) =>p
        case Bundle(_,disc,ites @ _*) => ites.map(price).sum-disc
      }
    }
```



## Sealed类

![image-20231112133531880](F:\markdownImg\image-20231112133531880.png)



# 偏函数(partial function)

1.在对符合 某个条件，而不是所有情况进行逻辑操作时，使用偏函数是一个不错的选择。

2.将包在大括号内的一组case语句封装为函数，我们称之为偏函数，它只对会作用于指定类型的参数或指定范围值的参数实施计算，超出范围的值会忽略 

3.偏函数在scala中是一个特质PartialFunction

```scala
    //使用偏函数解决
    val list = List(1,2,3,4,"hello")
    //定义一个偏函数
    //1.[Any,Int]表示偏函数接受Any类型，返回的类型是Int类型
    //2.isDefinedAt(x: Any) 如果返回true，就会去调用apply构建对象实例，如果是false过滤
    //3.apply 构造器，对传入的值 +1，并返回(新的集合)
    val partialFunc = new PartialFunction[Any,Int] {

      override def isDefinedAt(x: Any): Boolean = if(x.isInstanceOf[Int]) true else false

      override def apply(v1: Any): Int = v1.asInstanceOf[Int]+1

    }

    //使用偏函数
    //不能通过map使用偏函数,应该使用collect
    val list2 = list.collect(partialFunc)
    println(list2)
```

![image-20231112140210853](F:\markdownImg\image-20231112140210853.png)



## 简化形式

```scala
//简化1
def f2:PartialFunction[Any,Int]={
    case i:Int=> i+1 //case语句可以自动转换为偏函数
}
val list2 = List(1,2,3,4,"Abc").collect(f2)

//简化2
val list3 = List(1,2,3,4,5,"ABC").collect{case i:Int => i+1}
```



# 作为参数的函数

函数作为一个变量传入到另一个函数中，那么该作为参数的函数的类型是：funcion1,即(参数类型) =>返回类型

函数类型根据接受参数不同,一个参数就是function1



## 匿名函数

没有名字的函数，通过函数表达式来设置匿名函数



## 高阶函数

能够接受函数作为参数的函数，叫做高阶函数



**高阶函数可以返回函数类型**

```scala
    //说明
    //1.minusxy是个高阶函数，因为它返回匿名函数
    //2.返回的匿名函数(y:Int) => x - y
    //3.返回的匿名函数可以使用变量接受
    def minusxy(x:Int)={
      (y:Int) => x - y
    }
    val result3 = minusxy(3)(5)
```



## 参数类型判断

![image-20231112163435854](F:\markdownImg\image-20231112163435854.png)



## 闭包(closure)

闭包就是一个函数和与其相关的引用环境组合的一个整体（实体）

```scala
def minusxy(x:Int) = (y:Int)=> x-y
//f函数就是闭包
val f = minusxy(20)
```

![image-20231112164320442](F:\markdownImg\image-20231112164320442.png)



# 函数柯里化（curry)

![image-20231112170838429](F:\markdownImg\image-20231112170838429.png)

![image-20231112172805718](F:\markdownImg\image-20231112172805718.png)

# 控制抽象

![image-20231112173312984](F:\markdownImg\image-20231112173312984.png)

抽象控制是这样的函数：

1.参数是函数

2.函数参数没有输入值,可以有返回值

```scala
def MyRunInThread2(fi:()=>Unit)={
    new Thread{
        ovrride def run():Unit={
            f1()
        }
    }.start()
}

MyRunInThread2{
    ()=>println("nihao")
    Thread.sleep(5000)
    println("干完了 ")
}

def MyRunInThread2(fi:=>Unit)={
    new Thread{
        ovrride def run():Unit={
            f1
        }
    }.start()
}
//对于没有输入，也没有返回值的函数，可以简写成如下形式
MyRunInThread2{
    println("nihao")
    Thread.sleep(5000)
    println("干完了 ")
}
```

**控制抽象实例**

```scala
  def main(args: Array[String]): Unit = {

    var x = 10
      
    // x>0 是一个匿名函数,返回Boolean值
    util(x>0){ 
      x-=1
      println("x="+x)
    }
  }
  //参数名不加()，相当于只需要函数体，不需要参数定义(自己理解)
  def util(condition: => Boolean)(block: =>Unit):Unit ={
    if(condition){
      block
      util(condition)(block)
    }
  }
}
```



# 使用递归思想去思考编程

scala中循环不建议用while和do..while，而建议递归

在使用递归时，应避免重复递归调用

![image-20231112213118695](F:\markdownImg\image-20231112213118695.png)



# 并发编程模型Akka

Akka是编写并发程序的框架,同时提供了Scala和JAVA的开发接口

![image-20231113150522431](F:\markdownImg\image-20231113150522431.png)

![image-20231113151439763](F:\markdownImg\image-20231113151439763.png)

Ajax异步处理模型

![image-20231113151400364](F:\markdownImg\image-20231113151400364.png)

![image-20231113151829787](F:\markdownImg\image-20231113151829787.png)

![image-20231114121237618](F:\markdownImg\image-20231114121237618.png)

![image-20231113151926539](F:\markdownImg\image-20231113151926539.png)

![image-20231113152109366](F:\markdownImg\image-20231113152109366.png)

## 快速入门

### Actor自我通讯

```scala
import akka.actor.{Actor, ActorRef, ActorSystem, Props}

//说明
//1.当我们继承Actor后，就是一个Actor,核心方法receive方法重写
class SayHelloActor extends Actor{
  //说明
  //1.receive方法，会被该Actor的MailBox(实现Runnable接口）调用
  //2.当该Actor的MailBox接受到消息，就会调用receive
  //3.type Receive = partialFunction[Any,Unit]
  override def receive: Receive = {
    case "hello" => println("收到hello,回应hello too:")
    case "ok" => println("ok,回应ok too:")
    case "exit" =>{
      println("接受到exit执行,退出系统")
      context.stop(self)  //停止当前actorRef
      context.system.terminate() //退出actorSystem
    }
    case _ => println("匹配不到")
  }
}

object SayHelloActor{
  //1.先创建一个ActorSystem,专门用于创建Actor
  private val actorFactory: ActorSystem = ActorSystem("actoryFactory")

  //2.创建一个Actor的同时，返回Actor的ActorRef
  //说明
  //Props[SayHelloActor]创建了一个sayHelloActor实例，使用反射
  //"sayHelloActor"给actor取名
  //syaHelloActorRef: ActorRef 就是 Props[SayHelloActor] 的ActorRef
  //创建的SayHelloActor 实例被ActorSystem接管
  private val sayHelloActorRef: ActorRef = actorFactory.actorOf(Props[SayHelloActor], "syaHelloActor")

  def main(args: Array[String]): Unit = {
    //SayHelloActor发消息(邮箱)
    sayHelloActorRef ! "hello"
    sayHelloActorRef ! "ok"

    //研究异步如何退出Actor模型
    sayHelloActorRef ! "exit"
  }
}
```

代码运行流程

![image-20231114091425042](F:\markdownImg\image-20231114091425042.png)



### Acotr间互相通讯

![image-20231114101213538](F:\markdownImg\image-20231114101213538.png)

![image-20231114101504051](F:\markdownImg\image-20231114101504051.png)

**AAcotr**

```scala
package com.atguigu.akka.actors

import akka.actor.{Actor, ActorRef}

class AActor(actorRef:ActorRef) extends Actor{

  val bActorRef:ActorRef = actorRef
  var count:Int = _

  override def receive: Receive = {
    case "start" => {
      println("AActor 出招了 , start ok")
      self ! "我打" //发给自己
    }
    case "我打" =>{
      count match {
        case 10 =>{
          println("打累了，撤了")
          bActorRef ! "exit"
          context.stop(self)
          context.system.terminate()
        }
        case _ =>{
          //给BActor 发出消息
          //这里需要持有BActor的引用(BActorRef)
          println("AActor(黄飞鸿) wcsndm")
          count += 1
          Thread.sleep(1000)
          bActorRef ! "我打"
        }
      }
    }
  }

}

```

**BActor**

```scala
package com.atguigu.akka.actors

import akka.actor.Actor

class BActor extends Actor{
  override def receive: Receive = {
    case "我打" =>{
      println("BActor(乔峰) aminos all")
      //通过sender()可以获取到发送消息的actor的引用
      Thread.sleep(1000)
      sender() ! "我打"
    }

    case "exit"=>{
      println("行，我也累了")
      context.stop(self)
      context.system.terminate()
    }
  }
}

```

**启动对象**

```scala
package com.atguigu.akka.actors

import akka.actor.{ActorRef, ActorSystem, Props}

object ActorGame extends App {
   val actorfactory: ActorSystem = ActorSystem("actorfactory")
    //先创建BActor 引用/代理
   val bActorRef: ActorRef = actorfactory.actorOf(Props[BActor], "bActor")
    //创建AActor的引用
   val aActorRef: ActorRef = actorfactory.actorOf(Props(new AActor(bActorRef)), "AActor")

   //aActor出招
  aActorRef ! "start"

}

```



### Akka网络编程

同一端口可以连接多个程序，但不能被多个程序监听



## 小黄鸡客服项目

![image-20231114190445430](F:\markdownImg\image-20231114190445430.png)

项目结构

![image-20231114190650587](F:\markdownImg\image-20231114190650587.png)

分为服务端，业务端，和通讯协议（样式类)。*在akka中不推荐使用java序列化，且默认禁止java序**列化**

**服务端配置**

```scala
  val host = "127.0.0.1" //服务器地址
  val port = 9999
  val conf = ConfigFactory.parseString(
    s"""
       |akka.actor.provider="akka.remote.RemoteActorRefProvider"
       |akka.actor.allow-java-serialization = "on" //akka默认关闭java序列化，需要手动开启
       |akka.remote.artery.enable = "on"
       |akka.remote.artery.canonical.hostname = $host
       |akka.remote.artery.canonical.port = $port
       """.stripMargin //默认以"|"进行分割，去掉空格
  ) //这个相当于配置文件

  //创建网络ActorSystem
  val serverActorSystem: ActorSystem = ActorSystem("Server",conf)

  //创建YellowChikenServer 的actor和返回actorRef
  val yellowChikenServerRef: ActorRef = serverActorSystem.
    actorOf(Props[YellowChickenServer], "YellowChickenServer")
```

客户端配置

```scala
  //在Actor中有一个方法preStart方法,他会在actor运行前执行
  //在akka的开发中，通常将初始化的工作，放在prestart方法
override def preStart(): Unit = {
    serverActorRef = context.      actorSelection(s"akka://Server@${serverHost}:${serverPort}/user/YellowChickenServer")
  } //server字段为服务端AcotrSystem名,'YellowChickenServer'为服务端ActorRef名称
  

val(host,port,serverHost,serverPort) = ("127.0.0.1",9990,"127.0.0.1",9999) //服务器和客户端配置

  val conf = ConfigFactory.parseString(
    s"""
       |akka.actor.provider="akka.remote.RemoteActorRefProvider"
       |akka.actor.allow-java-serialization = "on"
       |akka.remote.artery.enable = "on"
       |akka.remote.artery.canonical.hostname = $host
       |akka.remote.artery.canonical.port = $port
   """.stripMargin)

  //创建ActorSystem
  val client: ActorSystem = ActorSystem("client", conf)
  //创建CustomerActor实例和引用
  val customerActorRef: ActorRef = client.actorOf(Props(new CustomerActor(serverHost, serverPort)), "CutomerActor")

```



## Spark Master Worker 进程通讯项目

![image-20231114193024125](F:\markdownImg\image-20231114193024125.png)

![image-20231114193726925](F:\markdownImg\image-20231114193726925.png)

**注册以及心跳更新**

![image-20231114224501946](F:\markdownImg\image-20231114224501946.png)



```scala
context.system.scheduler.scheduleAtFixedRate(0  millis,10000 millis,self,RemoveTimeOutWorker) //设置定时任务,用于心跳检测和更新信息
```



# 设计模式

![image-20231115104813019](F:\markdownImg\image-20231115104813019.png)

![image-20231115110503617](F:\markdownImg\image-20231115110503617.png)



## 简单工厂模式

简单工厂模式是由一个工厂对象决定创建出哪一种产品类的实例。

定义了一个创建对象的类，由u这个类来封装实例化对象的行为

```scala
//在此静态类中创建对象
object SimpleFactory {
  def createPizza(t: String): Pizza = {
    var pizza: Pizza = null

    if (t.equals("greek")) {
      pizza = new GreekPizza
    } else if (t.equals("pepper")) {
      pizza = new PepperPizza
    }
    pizza

  }
}
```

```scala
pizza = SimpleFactory.createPizza(orderType) //在其他类中调用对象方法，获取pizza对象
```



## 工厂模式

**设计方案：**将披萨项目的实例化功能抽象成抽象方法

**方法模式：**定义了一个创建对象的抽象方法，由子类决定要实例化的类。工厂方法模式将对象的**实例化推迟到子类**

父类breakable代码块为通用代码，子类继承来获取参数信息;

抽象了一个createPizza方法，交给继承的子类来实现

```scala
abstract class OrderPizza {

  breakable{
    var orderType: String = null
    var pizza: Pizza = null

    do{
      println("请输入pizza的类型，使用工厂方法模式")
      orderType = StdIn.readLine()
      pizza = createPizza(orderType)

      if(pizza==null) break()

      pizza.prepare()
      pizza.bake()
      pizza.cut()
      pizza.box()

    } while (true)
  }

  //抽象的方法,createPizza(orderType)
  def createPizza(t:String):Pizza
}
```

**子类实现方法createPizza**

```scala
class BJOrderPizza extends OrderPizza {
  override def createPizza(t: String): Pizza = {
    println("使用的是工厂方法模式")
    var pizza:Pizza = null
    if(t.equals("cheese")){
      pizza = new BJCheesePizza
    }else if(t.equals("pepper")){
      pizza = new BJPepperPizza
    }
    pizza
  }
}

```



## 抽象工厂模式

1.定义了一个trait用于创建相关或有依赖关系的对象簇，不需指明具体的类

2.抽象工厂模式可以将简单工厂和工厂方法模式进行整合

3.从设计层面来看，抽象工厂模式是对简单工厂模式的改进

4.分为AbsFactory(抽象工厂)和具体实现的工厂子类。

![image-20231115195249013](F:\markdownImg\image-20231115195249013.png)



## 装饰者模式

![image-20231115214809097](F:\markdownImg\image-20231115214809097.png)

定义：

1.动态的将新功能附加到对象上。

![image-20231115215909325](F:\markdownImg\image-20231115215909325.png)

![image-20231115215924392](F:\markdownImg\image-20231115215924392.png)



# 泛型

## 逆变和顺变

<img src="F:\markdownImg\image-20231120231948340.png" alt="image-20231120231948340" style="zoom:50%;" />



![image-20231120232430648](F:\markdownImg\image-20231120232430648.png)

 

```scala
class Parent{}
class Child extends Parent{}
class SubChild extends Child{}

//定义带泛型的集合类型
//E，-E，+E定义见上
class MyCollection[E]{}
```



## 上下限

<img src="F:\markdownImg\image-20231120233157024.png" alt="image-20231120233157024" style="zoom:50%;" />

![image-20231120233303915](F:\markdownImg\image-20231120233303915.png)
