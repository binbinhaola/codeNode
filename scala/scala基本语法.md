<<<<<<< HEAD
# Scala的基本使用

## 1.基础语法

###   1.1变量

​	var声明变量

​	val声明常量

```scala
var c:Int = 1
var c = 1

//scala会自动判断类型，可以不指定变量类型
```



基础数据类型：

**Byte、Char、Short、Int、Long、Float、Double、Boolean**



增强数据类型：

**StringOps、RichInt、RichDouble、RichChar**



**操作符:**

和java一致，**没有提供++、—–操作符**



## 2.流程控制

**IF表达式**

在Scala中， IF表达式是由返回值的，就是if或者else中最后一行语句返回的值

**语句终结符**

Scala不需要语句终结符，只用多条语句写在一行数需要添加



### **循环**

#### **for循环**

```scala
for(i:Int <-1 to 10)  //条件判断为闭区间
for(i:Int <-1 until 10) //条件判断为开区间
for(c:Char <- "hello scala") println(c) //for循环遍历字符串
```

for循环可以不用花括号，会执行跟在条件判断后的第一个语句



#### **while循环**

```scala
var n:Int = 10
while(n>0){
    n-=1
}
```



#### 高级for循环



**if守卫模式**

在循环的同时进行逻辑判断

```scala
for(i <-i to 10 if i % 2 == 0 )  //循环出1到10之间的偶数
```



#### for推导式

在使用for循环迭代数字时,使用yield指定一个规则，将迭代出来的数字按照规则运算，并创建一个新的集合

```scala
var test = for(i <- 1 to 10 ) yield i*2
var test: IndexedSeq[Int] = Vector(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
```



## 3.Scala的集合

![image-20231011173435185](F:\markdownImg\image-20231011173435185.png)

Scala集合分为**可变**和**不可变**集合

**可变集合**：集合的元素可以动态修改 scala.collection.mutable

**不可变集合**：集合的元素在初始化后就无法修改了  scala.collection.imutable

创建集合时，不指定包名，默认会使用不可变集合



### Set集合

Set代表一个没有重复元素的集合
Set集合分为可变的和不可变的集合，默认情况下使用的是不可变集合

#### 创建set集合

不可变

```scala
val s = Set(1,2,3)
val s: scala.collection.immutable.Set[Int] = Set(1, 2, 3)
```

可变

```scala
val s2 = scala.collection.mutable.Set(1,2,3)
val s2: scala.collection.mutable.Set[Int] = HashSet(1, 2, 3)

s2 +=4
val res8: s2.type = HashSet(1, 2, 3, 4)
```



#### HashSet

集合分为可变和不可变

```scala
val s = new scala.collection.mutable.HashSet[Int]()
s: scala.collection.mutable.HashSet[Int] = HashSet()

scala> s += 1
val res0: s.type = HashSet(1)

scala> s += 2
val res1: s.type = HashSet(1, 2)

scala> s += 3
val res2: s.type = HashSet(1, 2, 3)
```



#### LinkedHashSet

只有可变的，没有不可变的

```scala
var s = new scala.collection.mutable.LinkedHashSet[Int]()
var s: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet()

scala> s += 1
val res0: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1)

scala> s += 5
val res1: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1, 5)

scala> s += 2
val res2: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1, 5, 2)
```



#### SortedSet

分为可变和不可变集合，

集合中的元素时按照元素的字典顺序排序的

```scala
var s = scala.collection.mutable.SortedSet[String]()
var s: scala.collection.mutable.SortedSet[String] = TreeSet()

scala> s += ("c")
val res0: scala.collection.mutable.SortedSet[String] = TreeSet(c)

scala> s +=("a")
val res1: scala.collection.mutable.SortedSet[String] = TreeSet(a, c)

scala> s +=("b")
val res2: scala.collection.mutable.SortedSet[String] = TreeSet(a, b, c)
```



### List集合

List代表一个不可变的列表

```scala
//创建一个List集合
val l = List(1,2,3,4)
val l: List[Int] = List(1, 2, 3, 4)
```

.head: 表示获取List中的第一个元素

.tail：表示获取List中第一个元素之后的所有元素

：：向队列的头部追加数据，创建新的列表

```scala
10 :: l
val res8: List[Int] = List(10, 1, 2, 3, 4)

l2 :: l
val res9: List[Any] = List(List(2, 3, 4, 5), 1, 2, 3, 4)
```



#### ListBuffer

ListBuffer是可变的，可以动态增加或者移除元素

```scala
val lb = scala.collection.mutable.ListBuffer[Int]()
lb: scala.collection.mutable.ListBuffer[Int] = ListBuffer()

scala> lb +=5
res58: lb.type = ListBuffer(1, 2, 5)

scala> lb -=5
res59: lb.type = ListBuffer(1, 2)

//遍历ListBuffer
for(i<-lb) println(i)
```



### Map集合

Map是一种可迭代的键值对（key/value）结构
Map分为可变和不可变，默认情况下使用的是不可变Map

#### 创建Map

```scala
//不可变Map
val ages = Map("jack"->30,"tom"->25,"jessic"->23) //创建格式1
val ages = Map(("jack",30),("tom",25),("jessic",23)) //创建格式2

//可变Map
val ages = scala.collection.mutable.Map("jack"->30,"tom"->25,"jessic"->23)

```



#### 查询

```scala
//通过key直接查询
val age = ages("jack")

//getOrElse函数
val age = ages.getOrElse("jack1", 0) //查询到返回结果，没有则返回后面的值
```



#### 修改

```scala
//更新元素
ages("jack") = 31 //key直接修改

//增加元素
ages[String:Int] += ("nihao"->30,"buhao"->12)

//移除元素
ages[String:Int] -= "nihao"
```



#### 遍历

```scala
//遍历map数据
for ((key,value) <- ages) println(key +" " + value)

//map的key
for(key <- ages.keySet) println(key)

//map的值
for(value <-ages.values) println(value)
```



#### 子类

HashMap、SortedMap和LinkedHashMap

HashMap：是一个按照key的hash值进行排列存储的map
SortedMap：可以自动对Map中的key进行排序【有序的map】
LinkedHashMap：可以记住插入的key-value的顺序



HashMap分为可变和不可变的

SortedMap是不可变的

LinkedHashMap是可变的



### Array集合



#### Array

​	Scala中Array的含义与Java中的数组类似，长度不可变,数组初始化后，长度就固定下来了，而且元素全部根据其类型进行初始化,可以直接使用Array()创建数组，元素类型自动推断



#### ArrayBuffer

Scala中ArrayBuffer与Java中的ArrayList类似，长度可变
ArrayBuffer：支持添加元素、移除元素

```scala
//初始化
val b = new ArrayBuffer[Int]()

//添加元素
b += 1
b.type = ArrayBuffer(1)

b += (2, 3, 4, 5)
b.type = ArrayBuffer(1, 2, 3, 4, 5)

//在指定下标插入数据
b.insert(index,val)

//移除指定下标元素
b.remove(index)

//Array 和 ArrayBuffer 互相转换
b.toArray
a.toBuffer
```



### 数组常见操作

**遍历**

```scala
for(i<-b) println(i)

for(i<-0 util b.length) println(b(i))
```

**求和，求最大值**

```scala
val sum = a.sum

val max = a.max
```

**数组排序**

```scala
scala.util.Sorting.quickshot(Array)
```



### Tuple

​	称之为元组，它与Array类似，都是不可变的，但与数组不同的是元组可以包含不同类型的元素

**Tuple中的元素角标从 1 开始**

```scala
val t = (1, 3.14, "hehe")

//获取元素
t._1 //1
t._2 //3.14
t._3 //"hehe"
```



### 集合总结



**可变集合**

LinkedHashSet、ListBuffer、ArrayBuffer、LinkedHashMap



**不可变集合**

List、SortedMap



**可变+不可变集合**

Set、HashSet、SortedSet、Map、HashMap



**其他**

**Array、Tuple**
**Array**：长度不可变，里面的元素可变
**Tuple**：长度不可变，里面的元素也不可变



## 4.Scala函数的使用

### 函数的定义

​	在Scala中定义函数需要使用 def 关键字，函数包括函数名、参数、函数体

### 函数的返回值

​	Scala要求必须给出函数所有参数的类型，但是函数返回值的类型不是必须的，因为Scala可以自己根据函数体中的表达式推断出返回值类型。



``` scala
//单行函数
def sayHello(name:String) = print("Hello,"+name)

//多行函数
def sayHello(name: String, age: Int) = {
	println("My name is "+name+",age is "+age)
	age
}
```

### 函数的参数

​	在Scala中，有时候我们调用某些函数时，不希望给出参数的具体值，而是希望使用参数自身默认的值，此时就需要在定义函数时使用默认参数。
如果给出的参数不够，则会从左往右依次应用参数。

```scala
def sayHello(fName: String, mName: String = "mid", lName: String = "last") = fName + " " + mName + " " + lName

sayHello("zhang","san")
res122: String = zhang san last
```



#### 带名参数

​	在调用函数时，也可以不按照函数定义的参数顺序来传递参数，而是使用带名参数的方式来传递。

```scala
def sayHello(fName: String, mName: String = "mid", lName: String = "last") = fName + " " + mName + " " + lName

sayHello(fName = "Mick", lName = "Tom", mName = "Jack")
```



#### 可变参数

​	在Scala中，有时我们需要将函数定义为参数个数可变的形式，则此时可以使用变长参数来定义函数。

```scala
def sum(nums: Int*) = {
  var res = 0
  for (num <- nums) res += num
  res
}

sum(1,2,3,4,5) //可以传入多个参数
```



### 过程函数-特殊的函数

​	定义函数时，如果函数体直接在花括号里面而没有使用=连接，则函数的返回值类型就是Unit，这样的函数称之为过程

​	过程通常用于不需要返回值的函数

```scala
def sayHello(name: String) {  "Hello, " + name } //已过时
def sayHello(name: String): Unit = "Hello, " + name //显性定义返回值
```



## lazy

将一个变量声明为lazy，则只有在第一次使用该变量时，变量对应的表达式才会发生计算
=======
# Scala的基本使用

## 1.基础语法

###   1.1变量

​	var声明变量

​	val声明常量

```scala
var c:Int = 1
var c = 1

//scala会自动判断类型，可以不指定变量类型
```



基础数据类型：

**Byte、Char、Short、Int、Long、Float、Double、Boolean**



增强数据类型：

**StringOps、RichInt、RichDouble、RichChar**



**操作符:**

和java一致，**没有提供++、—–操作符**



## 2.流程控制

**IF表达式**

在Scala中， IF表达式是由返回值的，就是if或者else中最后一行语句返回的值

**语句终结符**

Scala不需要语句终结符，只用多条语句写在一行数需要添加



### **循环**

#### **for循环**

```scala
for(i:Int <-1 to 10)  //条件判断为闭区间
for(i:Int <-1 until 10) //条件判断为开区间
for(c:Char <- "hello scala") println(c) //for循环遍历字符串
```

for循环可以不用花括号，会执行跟在条件判断后的第一个语句



#### **while循环**

```scala
var n:Int = 10
while(n>0){
    n-=1
}
```



#### 高级for循环



**if守卫模式**

在循环的同时进行逻辑判断

```scala
for(i <-i to 10 if i % 2 == 0 )  //循环出1到10之间的偶数
```



#### for推导式

在使用for循环迭代数字时,使用yield指定一个规则，将迭代出来的数字按照规则运算，并创建一个新的集合

```scala
var test = for(i <- 1 to 10 ) yield i*2
var test: IndexedSeq[Int] = Vector(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
```



## 3.Scala的集合

![image-20231011173435185](F:\markdownImg\image-20231011173435185.png)

Scala集合分为**可变**和**不可变**集合

**可变集合**：集合的元素可以动态修改 scala.collection.mutable

**不可变集合**：集合的元素在初始化后就无法修改了  scala.collection.imutable

创建集合时，不指定包名，默认会使用不可变集合



### Set集合

Set代表一个没有重复元素的集合
Set集合分为可变的和不可变的集合，默认情况下使用的是不可变集合

#### 创建set集合

不可变

```scala
val s = Set(1,2,3)
val s: scala.collection.immutable.Set[Int] = Set(1, 2, 3)
```

可变

```scala
val s2 = scala.collection.mutable.Set(1,2,3)
val s2: scala.collection.mutable.Set[Int] = HashSet(1, 2, 3)

s2 +=4
val res8: s2.type = HashSet(1, 2, 3, 4)
```



#### HashSet

集合分为可变和不可变

```scala
val s = new scala.collection.mutable.HashSet[Int]()
s: scala.collection.mutable.HashSet[Int] = HashSet()

scala> s += 1
val res0: s.type = HashSet(1)

scala> s += 2
val res1: s.type = HashSet(1, 2)

scala> s += 3
val res2: s.type = HashSet(1, 2, 3)
```



#### LinkedHashSet

只有可变的，没有不可变的

```scala
var s = new scala.collection.mutable.LinkedHashSet[Int]()
var s: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet()

scala> s += 1
val res0: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1)

scala> s += 5
val res1: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1, 5)

scala> s += 2
val res2: scala.collection.mutable.LinkedHashSet[Int] = LinkedHashSet(1, 5, 2)
```



#### SortedSet

分为可变和不可变集合，

集合中的元素时按照元素的字典顺序排序的

```scala
var s = scala.collection.mutable.SortedSet[String]()
var s: scala.collection.mutable.SortedSet[String] = TreeSet()

scala> s += ("c")
val res0: scala.collection.mutable.SortedSet[String] = TreeSet(c)

scala> s +=("a")
val res1: scala.collection.mutable.SortedSet[String] = TreeSet(a, c)

scala> s +=("b")
val res2: scala.collection.mutable.SortedSet[String] = TreeSet(a, b, c)
```



### List集合

List代表一个不可变的列表

```scala
//创建一个List集合
val l = List(1,2,3,4)
val l: List[Int] = List(1, 2, 3, 4)
```

.head: 表示获取List中的第一个元素

.tail：表示获取List中第一个元素之后的所有元素

：：向队列的头部追加数据，创建新的列表

```scala
10 :: l
val res8: List[Int] = List(10, 1, 2, 3, 4)

l2 :: l
val res9: List[Any] = List(List(2, 3, 4, 5), 1, 2, 3, 4)
```



#### ListBuffer

ListBuffer是可变的，可以动态增加或者移除元素

```scala
val lb = scala.collection.mutable.ListBuffer[Int]()
lb: scala.collection.mutable.ListBuffer[Int] = ListBuffer()

scala> lb +=5
res58: lb.type = ListBuffer(1, 2, 5)

scala> lb -=5
res59: lb.type = ListBuffer(1, 2)

//遍历ListBuffer
for(i<-lb) println(i)
```



### Map集合

Map是一种可迭代的键值对（key/value）结构
Map分为可变和不可变，默认情况下使用的是不可变Map

#### 创建Map

```scala
//不可变Map
val ages = Map("jack"->30,"tom"->25,"jessic"->23) //创建格式1
val ages = Map(("jack",30),("tom",25),("jessic",23)) //创建格式2

//可变Map
val ages = scala.collection.mutable.Map("jack"->30,"tom"->25,"jessic"->23)

```



#### 查询

```scala
//通过key直接查询
val age = ages("jack")

//getOrElse函数
val age = ages.getOrElse("jack1", 0) //查询到返回结果，没有则返回后面的值
```



#### 修改

```scala
//更新元素
ages("jack") = 31 //key直接修改

//增加元素
ages[String:Int] += ("nihao"->30,"buhao"->12)

//移除元素
ages[String:Int] -= "nihao"
```



#### 遍历

```scala
//遍历map数据
for ((key,value) <- ages) println(key +" " + value)

//map的key
for(key <- ages.keySet) println(key)

//map的值
for(value <-ages.values) println(value)
```



#### 子类

HashMap、SortedMap和LinkedHashMap

HashMap：是一个按照key的hash值进行排列存储的map
SortedMap：可以自动对Map中的key进行排序【有序的map】
LinkedHashMap：可以记住插入的key-value的顺序



HashMap分为可变和不可变的

SortedMap是不可变的

LinkedHashMap是可变的



### Array集合



#### Array

​	Scala中Array的含义与Java中的数组类似，长度不可变,数组初始化后，长度就固定下来了，而且元素全部根据其类型进行初始化,可以直接使用Array()创建数组，元素类型自动推断



#### ArrayBuffer

Scala中ArrayBuffer与Java中的ArrayList类似，长度可变
ArrayBuffer：支持添加元素、移除元素

```scala
//初始化
val b = new ArrayBuffer[Int]()

//添加元素
b += 1
b.type = ArrayBuffer(1)

b += (2, 3, 4, 5)
b.type = ArrayBuffer(1, 2, 3, 4, 5)

//在指定下标插入数据
b.insert(index,val)

//移除指定下标元素
b.remove(index)

//Array 和 ArrayBuffer 互相转换
b.toArray
a.toBuffer
```



### 数组常见操作

**遍历**

```scala
for(i<-b) println(i)

for(i<-0 util b.length) println(b(i))
```

**求和，求最大值**

```scala
val sum = a.sum

val max = a.max
```

**数组排序**

```scala
scala.util.Sorting.quickshot(Array)
```



### Tuple

​	称之为元组，它与Array类似，都是不可变的，但与数组不同的是元组可以包含不同类型的元素

**Tuple中的元素角标从 1 开始**

```scala
val t = (1, 3.14, "hehe")

//获取元素
t._1 //1
t._2 //3.14
t._3 //"hehe"
```



### 集合总结



**可变集合**

LinkedHashSet、ListBuffer、ArrayBuffer、LinkedHashMap



**不可变集合**

List、SortedMap



**可变+不可变集合**

Set、HashSet、SortedSet、Map、HashMap



**其他**

**Array、Tuple**
**Array**：长度不可变，里面的元素可变
**Tuple**：长度不可变，里面的元素也不可变



## 4.Scala函数的使用

### 函数的定义

​	在Scala中定义函数需要使用 def 关键字，函数包括函数名、参数、函数体

### 函数的返回值

​	Scala要求必须给出函数所有参数的类型，但是函数返回值的类型不是必须的，因为Scala可以自己根据函数体中的表达式推断出返回值类型。



``` scala
//单行函数
def sayHello(name:String) = print("Hello,"+name)

//多行函数
def sayHello(name: String, age: Int) = {
	println("My name is "+name+",age is "+age)
	age
}
```

### 函数的参数

​	在Scala中，有时候我们调用某些函数时，不希望给出参数的具体值，而是希望使用参数自身默认的值，此时就需要在定义函数时使用默认参数。
如果给出的参数不够，则会从左往右依次应用参数。

```scala
def sayHello(fName: String, mName: String = "mid", lName: String = "last") = fName + " " + mName + " " + lName

sayHello("zhang","san")
res122: String = zhang san last
```



#### 带名参数

​	在调用函数时，也可以不按照函数定义的参数顺序来传递参数，而是使用带名参数的方式来传递。

```scala
def sayHello(fName: String, mName: String = "mid", lName: String = "last") = fName + " " + mName + " " + lName

sayHello(fName = "Mick", lName = "Tom", mName = "Jack")
```



#### 可变参数

​	在Scala中，有时我们需要将函数定义为参数个数可变的形式，则此时可以使用变长参数来定义函数。

```scala
def sum(nums: Int*) = {
  var res = 0
  for (num <- nums) res += num
  res
}

sum(1,2,3,4,5) //可以传入多个参数
```



### 过程函数-特殊的函数

​	定义函数时，如果函数体直接在花括号里面而没有使用=连接，则函数的返回值类型就是Unit，这样的函数称之为过程

​	过程通常用于不需要返回值的函数

```scala
def sayHello(name: String) {  "Hello, " + name } //已过时
def sayHello(name: String): Unit = "Hello, " + name //显性定义返回值
```



## lazy

将一个变量声明为lazy，则只有在第一次使用该变量时，变量对应的表达式才会发生计算
>>>>>>> e6f9c7032619ea760d965be70abd78cafff1d124
