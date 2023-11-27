

# Java集合框架

![img](https://www.runoob.com/wp-content/uploads/2014/01/2243690-9cd9c896e0d512ed.gif)

Java 集合框架主要包括两种类型的容器，一种是集合（Collection），存储一个元素集合，另一种是图（Map），存储键/值对映射。Collection 接口又有 3 种子类型，List、Set 和 Queue，再下面是一些抽象类，最后是具体实现类，常用的有 [ArrayList](https://www.runoob.com/java/java-arraylist.html)、[LinkedList](https://www.runoob.com/java/java-linkedlist.html)、[HashSet](https://www.runoob.com/java/java-hashset.html)、LinkedHashSet、[HashMap](https://www.runoob.com/java/java-hashmap.html)、LinkedHashMap 等等。

集合框架是一个用来代表和操纵集合的统一架构。所有的集合框架都包含如下内容：

- 

  **接口：**是代表集合的抽象数据类型。例如 Collection、List、Set、Map 等。之所以定义多个接口，是为了以不同的方式操作集合对象

- **实现（类）：**是集合接口的具体实现。从本质上讲，它们是可重复使用的数据结构，例如：ArrayList、LinkedList、HashSet、HashMap。

- **算法：**是实现集合接口的对象里的方法执行的一些有用的计算，例如：搜索和排序。这些算法被称为多态，那是因为相同的方法可以在相似的接口上有着不同的实现。

除了集合，该框架也定义了几个 Map 接口和类。Map 里存储的是键/值对。尽管 Map 不是集合，但是它们完全整合在集合中。

![img](https://www.runoob.com/wp-content/uploads/2014/01/java-coll-2020-11-16.png)



Java 集合框架提供了一套性能优良，使用方便的接口和类，java集合框架位于java.util包中， 所以当使用集合框架的时候需要进行导包。

## 集合接口

集合框架定义了一些接口。本节提供了每个接口的概述：

| 序号 | 接口描述                                                     |
| :--- | :----------------------------------------------------------- |
| 1    | Collection 接口 Collection 是最基本的集合接口，一个 Collection 代表一组 Object，即 Collection 的元素, Java不提供直接继承自Collection的类，只提供继承于的子接口(如List和set)。Collection 接口存储一组不唯一，无序的对象。 |
| 2    | List 接口 List接口是一个有序的 Collection，使用此接口能够精确的控制每个元素插入的位置，能够通过索引(元素在List中位置，类似于数组的下标)来访问List中的元素，第一个元素的索引为 0，而且允许有相同的元素。List 接口存储一组不唯一，有序（插入顺序）的对象。 |
| 3    | Set Set 具有与 Collection 完全一样的接口，只是行为上不同，Set 不保存重复的元素。Set 接口存储一组唯一，无序的对象。 |
| 4    | SortedSet 继承于Set保存有序的集合。                          |
| 5    | Map Map 接口存储一组键值对象，提供key（键）到value（值）的映射。 |
| 6    | Map.Entry 描述在一个Map中的一个元素（键/值对）。是一个 Map 的内部接口。 |
| 7    | SortedMap 继承于 Map，使 Key 保持在升序排列。                |
| 8    | Enumeration 这是一个传统的接口和定义的方法，通过它可以枚举（一次获得一个）对象集合中的元素。这个传统接口已被迭代器取代。 |

### Set和List的区别

- \1. Set 接口实例存储的是无序的，不重复的数据。List 接口实例存储的是有序的，可以重复的元素。
- \2. Set检索效率低下，删除和插入效率高，插入和删除不会引起元素位置改变 **<实现类有HashSet,TreeSet>**。
- \3. List和数组类似，可以动态增长，根据实际存储的数据的长度自动增长List的长度。查找元素效率高，插入删除效率低，因为会引起其他元素位置改变 **<实现类有ArrayList,LinkedList,Vector>** 。

------

## 集合实现类（集合类）

Java提供了一套实现了Collection接口的标准集合类。其中一些是具体类，这些类可以直接拿来使用，而另外一些是抽象类，提供了接口的部分实现。

标准集合类汇总于下表：

| 序号 | 类描述                                                       |
| :--- | :----------------------------------------------------------- |
| 1    | **AbstractCollection**  实现了大部分的集合接口。             |
| 2    | **AbstractList**  继承于AbstractCollection 并且实现了大部分List接口。 |
| 3    | **AbstractSequentialList**  继承于 AbstractList ，提供了对数据元素的链式访问而不是随机访问。 |
| 4    | [LinkedList](https://www.runoob.com/java/java-linkedlist.html) 该类实现了List接口，允许有null（空）元素。主要用于创建链表数据结构，该类没有同步方法，如果多个线程同时访问一个List，则必须自己实现访问同步，解决方法就是在创建List时候构造一个同步的List。例如：`List list=Collections.synchronizedList(newLinkedList(...));`LinkedList 查找效率低。 |
| 5    | [ArrayList](https://www.runoob.com/java/java-arraylist.html) 该类也是实现了List的接口，实现了可变大小的数组，随机访问和遍历元素时，提供更好的性能。该类也是非同步的,在多线程的情况下不要使用。ArrayList 增长当前长度的50%，插入删除效率低。 |
| 6    | **AbstractSet**  继承于AbstractCollection 并且实现了大部分Set接口。 |
| 7    | [HashSet](https://www.runoob.com/java/java-hashset.html) 该类实现了Set接口，不允许出现重复元素，不保证集合中元素的顺序，允许包含值为null的元素，但最多只能一个。 |
| 8    | LinkedHashSet 具有可预知迭代顺序的 `Set` 接口的哈希表和链接列表实现。 |
| 9    | TreeSet 该类实现了Set接口，可以实现排序等功能。              |
| 10   | **AbstractMap**  实现了大部分的Map接口。                     |
| 11   | [HashMap](https://www.runoob.com/java/java-hashmap.html) HashMap 是一个散列表，它存储的内容是键值对(key-value)映射。 该类实现了Map接口，根据键的HashCode值存储数据，具有很快的访问速度，最多允许一条记录的键为null，不支持线程同步。 |
| 12   | TreeMap 继承了AbstractMap，并且使用一颗树。                  |
| 13   | WeakHashMap 继承AbstractMap类，使用弱密钥的哈希表。          |
| 14   | LinkedHashMap 继承于HashMap，使用元素的自然顺序对元素进行排序. |
| 15   | IdentityHashMap 继承AbstractMap类，比较文档时使用引用相等。  |

在前面的教程中已经讨论通过java.util包中定义的类，如下所示：

| 序号 | 类描述                                                       |
| :--- | :----------------------------------------------------------- |
| 1    | Vector 该类和ArrayList非常相似，但是该类是同步的，可以用在多线程的情况，该类允许设置默认的增长长度，默认扩容方式为原来的2倍。 |
| 2    | Stack 栈是Vector的一个子类，它实现了一个标准的后进先出的栈。 |
| 3    | Dictionary Dictionary 类是一个抽象类，用来存储键/值对，作用和Map类相似。 |
| 4    | Hashtable Hashtable 是 Dictionary(字典) 类的子类，位于 java.util 包中。 |
| 5    | Properties Properties 继承于 Hashtable，表示一个持久的属性集，属性列表中每个键及其对应值都是一个字符串。 |
| 6    | BitSet 一个Bitset类创建一种特殊类型的数组来保存位值。BitSet中数组大小会随需要增加。 |

------

## 集合算法

集合框架定义了几种算法，可用于集合和映射。这些算法被定义为集合类的静态方法。

在尝试比较不兼容的类型时，一些方法能够抛出 ClassCastException异常。当试图修改一个不可修改的集合时，抛出UnsupportedOperationException异常。

集合定义三个静态的变量：EMPTY_SET，EMPTY_LIST，EMPTY_MAP的。这些变量都不可改变。



| 序号 | 算法描述                                               |
| :--- | :----------------------------------------------------- |
| 1    | Collection Algorithms 这里是一个列表中的所有算法实现。 |

## 如何使用迭代器

通常情况下，你会希望遍历一个集合中的元素。例如，显示集合中的每个元素。

一般遍历数组都是采用for循环或者增强for，这两个方法也可以用在集合框架，但是还有一种方法是采用迭代器遍历集合框架，它是一个对象，实现了[Iterator](https://www.runoob.com/java/java-iterator.html) 接口或 ListIterator接口。

迭代器，使你能够通过循环来得到或删除集合的元素。ListIterator 继承了 Iterator，以允许双向遍历列表和修改元素。

| 序号 | 迭代器方法描述                                               |
| :--- | :----------------------------------------------------------- |
| 1    | [使用 Java Iterator](https://www.runoob.com/java/java-iterator.html) 这里通过实例列出 Iterator 和 ListIterator 接口提供的所有方法。 |

### 遍历 ArrayList

## 实例

import java.util.*;  public class Test{ public static void main(String[] args) {     List<String> list=new ArrayList<String>();     list.add("Hello");     list.add("World");     list.add("HAHAHAHA");     //第一种遍历方法使用 For-Each 遍历 List     for (String str : list) {            //也可以改写 for(int i=0;i<list.size();i++) 这种形式        System.out.println(str);     }      //第二种遍历，把链表变为数组相关的内容进行遍历     String[] strArray=new String[list.size()];     list.toArray(strArray);     for(int i=0;i<strArray.length;i++) //这里也可以改写为  for(String str:strArray) 这种形式     {        System.out.println(strArray[i]);     }         //第三种遍历 使用迭代器进行相关遍历          Iterator<String> ite=list.iterator();     while(ite.hasNext())//判断下一个元素之后有值     {         System.out.println(ite.next());     } } }



**解析：**

三种方法都是用来遍历ArrayList集合，第三种方法是采用迭代器的方法，该方法可以不用担心在遍历的过程中会超出集合的长度。

### 遍历 Map

## 实例

```java
import java.util.*;  public class Test{    
    public static void main(String[] args) {      
        Map<String, String> map = new HashMap<String, String>();     
        map.put("1", "value1");      
        map.put("2", "value2");  
        map.put("3", "value3");           
        //第一种：普遍使用，二次取值     
        System.out.println("通过Map.keySet遍历key和value：");     
        for (String key : map.keySet()) {     
            System.out.println("key= "+ key + " and value= " + map.get(key));      }            //第二种      System.out.println("通过Map.entrySet使用iterator遍历key和value：");      Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();      while (it.hasNext()) {       Map.Entry<String, String> entry = it.next();       System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());      }            //第三种：推荐，尤其是容量大时      System.out.println("通过Map.entrySet遍历key和value");      for (Map.Entry<String, String> entry : map.entrySet()) {       System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());      }          //第四种      System.out.println("通过Map.values()遍历所有的value，但不能遍历key");      for (String v : map.values()) {       System.out.println("value= " + v);      }     } }
```



------

## 如何使用比较器

TreeSet和TreeMap的按照排序顺序来存储元素. 然而，这是通过比较器来精确定义按照什么样的排序顺序。

这个接口可以让我们以不同的方式来排序一个集合。

| 序号 | 比较器方法描述                                               |
| :--- | :----------------------------------------------------------- |
| 1    | 使用 Java Comparator 这里通过实例列出Comparator接口提供的所有方法 |

------

## 总结

Java集合框架为程序员提供了预先包装的数据结构和算法来操纵他们。

集合是一个对象，可容纳其他对象的引用。集合接口声明对每一种类型的集合可以执行的操作。

集合框架的类和接口均在java.util包中。

任何对象加入集合类后，自动转变为Object类型，所以在取出的时候，需要进行强制类型转换。



# Java ArrayList

ArrayList 类是一个可以动态修改的数组，与普通数组的区别就是它是没有固定大小的限制，我们可以添加或删除元素。

ArrayList 继承了 AbstractList ，并实现了 List 接口。

![img](https://www.runoob.com/wp-content/uploads/2020/06/ArrayList-1-768x406-1.png)

ArrayList 类位于 java.util 包中，使用前需要引入它，语法格式如下：

```
import java.util.ArrayList; // 引入 ArrayList 类

ArrayList<E> objectName =new ArrayList<>();　 // 初始化
```

- **E**: 泛型数据类型，用于设置 objectName 的数据类型，**只能为引用数据类型**。
- **objectName**: 对象名。

ArrayList 是一个数组队列，提供了相关的添加、删除、修改、遍历等功能。

### 添加元素

ArrayList 类提供了很多有用的方法，添加元素到 ArrayList 可以使用 add() 方法:

## 实例



```java
import java.util.ArrayList;

public  class RunoobTest {
 public  static  void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob"); 
    sites.add("Taobao");
    sites.add("Weibo");
    System.out.println(sites);
  }
}

以上实例，执行输出结果为：
```



```
[Google, Runoob, Taobao, Weibo]
```

### 访问元素

访问 ArrayList 中的元素可以使用 get() 方法：

## 实例

**

```java
import  java.util.ArrayList;

public class  RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    System.out.println(sites.get(1)); *// 访问第二个元素*
  }
}
```

**注意**：数组的索引值从 0 开始。

以上实例，执行输出结果为：

```
Runoob
```

### 修改元素

如果要修改 ArrayList 中的元素可以使用 set() 方法：

## 实例

**

```java
import  java.util.ArrayList;
public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    sites.set(2, "Wiki"); *// 第一个参数为索引位置，第二个为要修改的值*
    System.out.println(sites);
  }
}
```

以上实例，执行输出结果为：

```
[Google, Runoob, Wiki, Weibo]
```

### 删除元素

如果要删除 ArrayList 中的元素可以使用 remove() 方法：

## 实例

**

```java
import java.util.ArrayList;

public  class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    sites.remove(3); *// 删除第四个元素*
    System.out.println(sites);
  }
}
```

以上实例，执行输出结果为：

```
[Google, Runoob, Taobao]
```

### 计算大小

如果要计算 ArrayList 中的元素数量可以使用 size() 方法：

## 实例

**

```java
import java.util.ArrayList;

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    System.out.println(sites.size());
  }
}
```

以上实例，执行输出结果为：

```
4
```

### 迭代数组列表

我们可以使用 for 来迭代数组列表中的元素：

## 实例

**

```java
import java.util.ArrayList;

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    for (int i = 0; i < sites.size(); i++) {
      System.out.println(sites.get(i));
    }
  }
}
```

以上实例，执行输出结果为：

```
Google
Runoob
Taobao
Weibo
```

也可以使用 for-each 来迭代元素：

## 实例

**

```java
import java.util.ArrayList;

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Google");
    sites.add("Runoob");
    sites.add("Taobao");
    sites.add("Weibo");
    for (String i : sites) {
      System.out.println(i);
    }
  }
}
```

以上实例，执行输出结果为：

```
Google
Runoob
Taobao
Weibo
```

### 其他的引用类型

ArrayList 中的元素实际上是对象，在以上实例中，数组列表元素都是字符串 String 类型。

如果我们要存储其他类型，而 <E> 只能为引用数据类型，这时我们就需要使用到基本类型的包装类。

基本类型对应的包装类表如下：

| 基本类型 | 引用类型  |
| :------- | :-------- |
| boolean  | Boolean   |
| byte     | Byte      |
| short    | Short     |
| int      | Integer   |
| long     | Long      |
| float    | Float     |
| double   | Double    |
| char     | Character |

此外，BigInteger、BigDecimal 用于高精度的运算，BigInteger 支持任意精度的整数，也是引用类型，但它们没有相对应的基本类型。

```
ArrayList<Integer> li=new Arraylist<>();     // 存放整数元素
ArrayList<Character> li=new Arraylist<>();   // 存放字符元素
```

以下实例使用 ArrayList 存储数字(使用 Integer 类型):

## 实例

**

```java
import java.util.ArrayList;

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<Integer> myNumbers = **new** ArrayList<Integer>();
    myNumbers.add(10);
    myNumbers.add(15);
    myNumbers.add(20);
    myNumbers.add(25);
    for (int i : myNumbers) {
      System.out.println(i);
    }
  }
}
```

以上实例，执行输出结果为：

```
10
15
20
25
```

### ArrayList 排序

Collections 类也是一个非常有用的类，位于 java.util 包中，提供的 sort() 方法可以对字符或数字列表进行排序。

以下实例对字母进行排序：

## 实例

**

```java
import java.util.ArrayList;
import java.util.Collections; // 引入 Collections 类

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<String> sites = new ArrayList<String>();
    sites.add("Taobao");
    sites.add("Wiki");
    sites.add("Runoob");
    sites.add("Weibo");
    sites.add("Google");
    Collections.sort(sites); // 字母排序
    for (String i : sites) {
      System.out.println(i);
    }
  }
}
```

以上实例，执行输出结果为：

```
Google
Runoob
Taobao
Weibo
Wiki
```

以下实例对数字进行排序：

## 实例

**

```java
import java.util.ArrayList;
import java.util.Collections; // 引入 Collections 类*

public class RunoobTest {
  public static void main(String[] args) {
    ArrayList<Integer> myNumbers = **new** ArrayList<Integer>();
    myNumbers.add(33);
    myNumbers.add(15);
    myNumbers.add(20);
    myNumbers.add(34);
    myNumbers.add(8);
    myNumbers.add(12);

    Collections.sort(myNumbers); // 数字排序*

    for (int i : myNumbers) {
      System.out.println(i);
    }
  }
}
```

以上实例，执行输出结果为：

```
8
12
15
20
33
34
```

------

## Java ArrayList 方法

Java ArrayList 常用方法列表如下：

| 方法                                                         | 描述                                          |
| :----------------------------------------------------------- | :-------------------------------------------- |
| [add()](https://www.runoob.com/java/java-arraylist-add.html) | 将元素插入到指定位置的 arraylist 中           |
| [addAll()](https://www.runoob.com/java/java-arraylist-addall.html) | 添加集合中的所有元素到 arraylist 中           |
| [clear()](https://www.runoob.com/java/java-arraylist-clear.html) | 删除 arraylist 中的所有元素                   |
| [clone()](https://www.runoob.com/java/java-arraylist-clone.html) | 复制一份 arraylist                            |
| [contains()](https://www.runoob.com/java/java-arraylist-contains.html) | 判断元素是否在 arraylist                      |
| [get()](https://www.runoob.com/java/java-arraylist-get.html) | 通过索引值获取 arraylist 中的元素             |
| [indexOf()](https://www.runoob.com/java/java-arraylist-indexof.html) | 返回 arraylist 中元素的索引值                 |
| [removeAll()](https://www.runoob.com/java/java-arraylist-removeall.html) | 删除存在于指定集合中的 arraylist 里的所有元素 |
| [remove()](https://www.runoob.com/java/java-arraylist-remove.html) | 删除 arraylist 里的单个元素                   |
| [size()](https://www.runoob.com/java/java-arraylist-size.html) | 返回 arraylist 里元素数量                     |
| [isEmpty()](https://www.runoob.com/java/java-arraylist-isempty.html) | 判断 arraylist 是否为空                       |
| [subList()](https://www.runoob.com/java/java-arraylist-sublist.html) | 截取部分 arraylist 的元素                     |
| [set()](https://www.runoob.com/java/java-arraylist-set.html) | 替换 arraylist 中指定索引的元素               |
| [sort()](https://www.runoob.com/java/java-arraylist-sort.html) | 对 arraylist 元素进行排序                     |
| [toArray()](https://www.runoob.com/java/java-arraylist-toarray.html) | 将 arraylist 转换为数组                       |
| [toString()](https://www.runoob.com/java/java-arraylist-tostring.html) | 将 arraylist 转换为字符串                     |
| [ensureCapacity](https://www.runoob.com/java/java-arraylist-surecapacity.html)() | 设置指定容量大小的 arraylist                  |
| [lastIndexOf()](https://www.runoob.com/java/java-arraylist-lastindexof.html) | 返回指定元素在 arraylist 中最后一次出现的位置 |
| [retainAll()](https://www.runoob.com/java/java-arraylist-retainall.html) | 保留 arraylist 中在指定集合中也存在的那些元素 |
| [containsAll()](https://www.runoob.com/java/java-arraylist-containsall.html) | 查看 arraylist 是否包含指定集合中的所有元素   |
| [trimToSize()](https://www.runoob.com/java/java-arraylist-trimtosize.html) | 将 arraylist 中的容量调整为数组中的元素个数   |
| [removeRange()](https://www.runoob.com/java/java-arraylist-removerange.html) | 删除 arraylist 中指定索引之间存在的元素       |
| [replaceAll()](https://www.runoob.com/java/java-arraylist-replaceall.html) | 将给定的操作内容替换掉数组中每一个元素        |
| [removeIf()](https://www.runoob.com/java/java-arraylist-removeif.html) | 删除所有满足特定条件的 arraylist 元素         |
| [forEach()](https://www.runoob.com/java/java-arraylist-foreach.html) | 遍历 arraylist 中每一个元素并执行特定操作     |

# Java LinkedList

链表（Linked list）是一种常见的基础数据结构，是一种线性表，但是并不会按线性的顺序存储数据，而是在每一个节点里存到下一个节点的地址。

链表可分为单向链表和双向链表。

一个单向链表包含两个值: 当前节点的值和一个指向下一个节点的链接。

![img](https://www.runoob.com/wp-content/uploads/2020/06/408px-Singly-linked-list.svg_.png)

一个双向链表有三个整数值: 数值、向后的节点链接、向前的节点链接。

![img](https://www.runoob.com/wp-content/uploads/2020/06/610px-Doubly-linked-list.svg_.png)

Java LinkedList（链表） 类似于 ArrayList，是一种常用的数据容器。

与 ArrayList 相比，LinkedList 的增加和删除的操作效率更高，而查找和修改的操作效率较低。

**以下情况使用 ArrayList :**

- 频繁访问列表中的某一个元素。
- 只需要在列表末尾进行添加和删除元素操作。

**以下情况使用 LinkedList :**

- 你需要通过循环迭代来访问列表中的某些元素。
- 需要频繁的在列表开头、中间、末尾等位置进行添加和删除元素操作。

LinkedList 继承了 AbstractSequentialList 类。

LinkedList 实现了 Queue 接口，可作为队列使用。

LinkedList 实现了 List 接口，可进行列表的相关操作。

LinkedList 实现了 Deque 接口，可作为队列使用。

LinkedList 实现了 Cloneable 接口，可实现克隆。

LinkedList 实现了 java.io.Serializable 接口，即可支持序列化，能通过序列化去传输。

![img](https://www.runoob.com/wp-content/uploads/2020/06/linkedlist-2020-11-16.png)

LinkedList 类位于 java.util 包中，使用前需要引入它，语法格式如下：

```java
// 引入 LinkedList 类
import java.util.LinkedList; 

LinkedList<E> list = new LinkedList<E>();   // 普通创建方法
或者
LinkedList<E> list = new LinkedList(Collection<? extends E> c); // 使用集合创建链表
```

```java
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        System.out.println(sites);
    }
}
```

```
[Google, Runoob, Taobao, Weibo]
```

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        // 使用 addFirst() 在头部添加元素
        sites.addFirst("Wiki");
        System.out.println(sites);
    }
}
```

```
[Wiki, Google, Runoob, Taobao]
```

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        // 使用 addLast() 在尾部添加元素
        sites.addLast("Wiki");
        System.out.println(sites);
    }
}
```

```
[Google, Runoob, Taobao, Wiki]
```

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        // 使用 removeFirst() 移除头部元素
        sites.removeFirst();
        System.out.println(sites);
    }
}
```

以上实例，执行输出结果为：

[Runoob, Taobao, Weibo]

在列表结尾移除元素：

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        // 使用 removeLast() 移除尾部元素
        sites.removeLast();
        System.out.println(sites);
    }
}
```

以上实例，执行输出结果为：

[Google, Runoob, Taobao]

获取列表开头的元素：

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        // 使用 getFirst() 获取头部元素
        System.out.println(sites.getFirst());
    }
}
```

```
Google
```

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        // 使用 getLast() 获取尾部元素
        System.out.println(sites.getLast());
    }
}
```

```
Weibo
```

### 迭代元素

我们可以使用 for 配合 size() 方法来迭代列表中的元素：

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        for (int size = sites.size(), i = 0; i < size; i++) {
            System.out.println(sites.get(i));
        }
    }
}
```

size() 方法用于计算链表的大小。

以上实例，执行输出结果为：

```
Google
Runoob
Taobao
Weibo
```

```java
// 引入 LinkedList 类
import java.util.LinkedList;

public class RunoobTest {
    public static void main(String[] args) {
        LinkedList<String> sites = new LinkedList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Weibo");
        for (String i : sites) {
            System.out.println(i);
        }
    }
}
```

以上实例，执行输出结果为：

```
Google
Runoob
Taobao
Weibo
```

### 常用方法

| 方法                                           | 描述                                                         |
| :--------------------------------------------- | :----------------------------------------------------------- |
| public boolean add(E e)                        | 链表末尾添加元素，返回是否成功，成功为 true，失败为 false。  |
| public void add(int index, E element)          | 向指定位置插入元素。                                         |
| public boolean addAll(Collection c)            | 将一个集合的所有元素添加到链表后面，返回是否成功，成功为 true，失败为 false。 |
| public boolean addAll(int index, Collection c) | 将一个集合的所有元素添加到链表的指定位置后面，返回是否成功，成功为 true，失败为 false。 |
| public void addFirst(E e)                      | 元素添加到头部。                                             |
| public void addLast(E e)                       | 元素添加到尾部。                                             |
| public boolean offer(E e)                      | 向链表末尾添加元素，返回是否成功，成功为 true，失败为 false。 |
| public boolean offerFirst(E e)                 | 头部插入元素，返回是否成功，成功为 true，失败为 false。      |
| public boolean offerLast(E e)                  | 尾部插入元素，返回是否成功，成功为 true，失败为 false。      |
| public void clear()                            | 清空链表。                                                   |
| public E removeFirst()                         | 删除并返回第一个元素。                                       |
| public E removeLast()                          | 删除并返回最后一个元素。                                     |
| public boolean remove(Object o)                | 删除某一元素，返回是否成功，成功为 true，失败为 false。      |
| public E remove(int index)                     | 删除指定位置的元素。                                         |
| public E poll()                                | 删除并返回第一个元素。                                       |
| public E remove()                              | 删除并返回第一个元素。                                       |
| public boolean contains(Object o)              | 判断是否含有某一元素。                                       |
| public E get(int index)                        | 返回指定位置的元素。                                         |
| public E getFirst()                            | 返回第一个元素。                                             |
| public E getLast()                             | 返回最后一个元素。                                           |
| public int indexOf(Object o)                   | 查找指定元素从前往后第一次出现的索引。                       |
| public int lastIndexOf(Object o)               | 查找指定元素最后一次出现的索引。                             |
| public E peek()                                | 返回第一个元素。                                             |
| public E element()                             | 返回第一个元素。                                             |
| public E peekFirst()                           | 返回头部元素。                                               |
| public E peekLast()                            | 返回尾部元素。                                               |
| public E set(int index, E element)             | 设置指定位置的元素。                                         |
| public Object clone()                          | 克隆该列表。                                                 |
| public Iterator descendingIterator()           | 返回倒序迭代器。                                             |
| public int size()                              | 返回链表元素个数。                                           |
| public ListIterator listIterator(int index)    | 返回从指定位置开始到末尾的迭代器。                           |
| public Object[] toArray()                      | 返回一个由链表元素组成的数组。                               |
| public T[] toArray(T[] a)                      | 返回一个由链表元素转换类型而成的数组。                       |

# Java HashSet

HashSet 基于 HashMap 来实现的，是一个不允许有重复元素的集合。

HashSet 允许有 null 值。

HashSet 是无序的，即不会记录插入的顺序。

HashSet 不是线程安全的， 如果多个线程尝试同时修改 HashSet，则最终结果是不确定的。 您必须在多线程访问时显式同步对 HashSet 的并发访问。

HashSet 实现了 Set 接口。

![img](https://www.runoob.com/wp-content/uploads/2020/07/java-hashset-hierarchy.png)

HashSet 中的元素实际上是对象，一些常见的基本类型可以使用它的包装类。

基本类型对应的包装类表如下：

| 基本类型 | 引用类型  |
| :------- | :-------- |
| boolean  | Boolean   |
| byte     | Byte      |
| short    | Short     |
| int      | Integer   |
| long     | Long      |
| float    | Float     |
| double   | Double    |
| char     | Character |

HashSet 类位于 java.util 包中，使用前需要引入它，语法格式如下：

```
import java.util.HashSet; // 引入 HashSet 类
```

以下实例我们创建一个 HashSet 对象 sites，用于保存字符串元素：

```
HashSet<String> sites = new HashSet<String>();
```

### 添加元素

HashSet 类提供类很多有用的方法，添加元素可以使用 add() 方法:

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");  // 重复的元素不会被添加
        System.out.println(sites);
    }
}
```

执行以上代码，输出结果如下：

```
[Google, Runoob, Zhihu, Taobao]
```



在上面的实例中，Runoob 被添加了两次，它在集合中也只会出现一次，因为集合中的每个元素都必须是唯一的。



### 判断元素是否存在

我们可以使用 contains() 方法来判断元素是否存在于集合当中:

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");  // 重复的元素不会被添加
        System.out.println(sites.contains("Taobao"));
    }
}
```

执行以上代码，输出结果如下：

```
true
```

### 删除元素

我们可以使用 remove() 方法来删除集合中的元素:

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");     // 重复的元素不会被添加
        sites.remove("Taobao");  // 删除元素，删除成功返回 true，否则为 false
        System.out.println(sites);
    }
}
```

执行以上代码，输出结果如下：

```
[Google, Runoob, Zhihu]
```

删除集合中所有元素可以使用 clear 方法：

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");     // 重复的元素不会被添加
        sites.clear();  
        System.out.println(sites);
    }
}
```

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");     // 重复的元素不会被添加
        System.out.println(sites.size());  
    }
}
```

执行以上代码，输出结果如下：

```
4
```

### 迭代 HashSet

可以使用 for-each 来迭代 HashSet 中的元素。

```java
// 引入 HashSet 类      
import java.util.HashSet;

public class RunoobTest {
    public static void main(String[] args) {
    HashSet<String> sites = new HashSet<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");
        sites.add("Runoob");     // 重复的元素不会被添加
        for (String i : sites) {
            System.out.println(i);
        }
    }
}
执行以上代码，输出结果如下：

Google
Runoob
Zhihu
Taobao
```

# Java HashMap

HashMap 是一个散列表，它存储的内容是键值对(key-value)映射。

HashMap 实现了 Map 接口，根据键的 HashCode 值存储数据，具有很快的访问速度，最多允许一条记录的键为 null，不支持线程同步。

HashMap 是无序的，即不会记录插入的顺序。

HashMap 继承于AbstractMap，实现了 Map、Cloneable、java.io.Serializable 接口。

![img](https://www.runoob.com/wp-content/uploads/2020/07/WV9wXLl.png)

HashMap 的 key 与 value 类型可以相同也可以不同，可以是字符串（String）类型的 key 和 value，也可以是整型（Integer）的 key 和字符串（String）类型的 value。

![img](https://static.runoob.com/images/mix/java-map.svg)

HashMap 中的元素实际上是对象，一些常见的基本类型可以使用它的包装类。

基本类型对应的包装类表如下：

| 基本类型 | 引用类型  |
| :------- | :-------- |
| boolean  | Boolean   |
| byte     | Byte      |
| short    | Short     |
| int      | Integer   |
| long     | Long      |
| float    | Float     |
| double   | Double    |
| char     | Character |

HashMap 类位于 java.util 包中，使用前需要引入它，语法格式如下：

```
import java.util.HashMap; // 引入 HashMap 类
```

以下实例我们创建一个 HashMap 对象 Sites， 整型（Integer）的 key 和字符串（String）类型的 value：

```
HashMap<Integer, String> Sites = new HashMap<Integer, String>();
```

### 添加元素

HashMap 类提供了很多有用的方法，添加键值对(key-value)可以使用 put() 方法:

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        System.out.println(Sites);
    }
}
```

执行以上代码，输出结果如下：

```
{1=Google, 2=Runoob, 3=Taobao, 4=Zhihu}
```

以下实例创建一个字符串（String）类型的 key 和字符串（String）类型的 value：

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<String, String> Sites = new HashMap<String, String>();
        // 添加键值对
        Sites.put("one", "Google");
        Sites.put("two", "Runoob");
        Sites.put("three", "Taobao");
        Sites.put("four", "Zhihu");
        System.out.println(Sites);
    }
}
```

执行以上代码，输出结果如下：

```
{four=Zhihu, one=Google, two=Runoob, three=Taobao}
```

### 访问元素

我们可以使用 get(key) 方法来获取 key 对应的 value:

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        System.out.println(Sites.get(3));
    }
}
```

执行以上代码，输出结果如下：

```
Taobao
```

### 删除元素

我们可以使用 remove(key) 方法来删除 key 对应的键值对(key-value):

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        Sites.remove(4);
        System.out.println(Sites);
    }
}
```

执行以上代码，输出结果如下：

```
{1=Google, 2=Runoob, 3=Taobao}
```

删除所有键值对(key-value)可以使用 clear 方法：

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        Sites.clear();
        System.out.println(Sites);
    }
}
```

执行以上代码，输出结果如下：

```
{}
```

### 计算大小

如果要计算 HashMap 中的元素数量可以使用 size() 方法：

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        System.out.println(Sites.size());
    }
}
```

执行以上代码，输出结果如下：

```
4
```

### 迭代 HashMap

可以使用 for-each 来迭代 HashMap 中的元素。

如果你只想获取 key，可以使用 keySet() 方法，然后可以通过 get(key) 获取对应的 value，如果你只想获取 value，可以使用 values() 方法。

```java
// 引入 HashMap 类      
import java.util.HashMap;

public class RunoobTest {
    public static void main(String[] args) {
        // 创建 HashMap 对象 Sites
        HashMap<Integer, String> Sites = new HashMap<Integer, String>();
        // 添加键值对
        Sites.put(1, "Google");
        Sites.put(2, "Runoob");
        Sites.put(3, "Taobao");
        Sites.put(4, "Zhihu");
        // 输出 key 和 value
        for (Integer i : Sites.keySet()) {
            System.out.println("key: " + i + " value: " + Sites.get(i));
        }
        // 返回所有 value 值
        for(String value: Sites.values()) {
          // 输出每一个value
          System.out.print(value + ", ");
        }
    }
}
```

执行以上代码，输出结果如下：

```
key: 1 value: Google
key: 2 value: Runoob
key: 3 value: Taobao
key: 4 value: Zhihu
Google, Runoob, Taobao, Zhihu,
```

------

## Java HashMap 方法

hashmap

Java HashMap 常用方法列表如下：

| 方法                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [clear()](https://www.runoob.com/java/java-hashmap-clear.html) | 删除 hashMap 中的所有键/值对                                 |
| [clone()](https://www.runoob.com/java/java-hashmap-clone.html) | 复制一份 hashMap                                             |
| [isEmpty()](https://www.runoob.com/java/java-hashmap-isempty.html) | 判断 hashMap 是否为空                                        |
| [size()](https://www.runoob.com/java/java-hashmap-size.html) | 计算 hashMap 中键/值对的数量                                 |
| [put()](https://www.runoob.com/java/java-hashmap-put.html)   | 将键/值对添加到 hashMap 中                                   |
| [putAll()](https://www.runoob.com/java/java-hashmap-putall.html) | 将所有键/值对添加到 hashMap 中                               |
| [putIfAbsent()](https://www.runoob.com/java/java-hashmap-putifabsent.html) | 如果 hashMap 中不存在指定的键，则将指定的键/值对插入到 hashMap 中。 |
| [remove()](https://www.runoob.com/java/java-hashmap-remove.html) | 删除 hashMap 中指定键 key 的映射关系                         |
| [containsKey()](https://www.runoob.com/java/java-hashmap-containskey.html) | 检查 hashMap 中是否存在指定的 key 对应的映射关系。           |
| [containsValue()](https://www.runoob.com/java/java-hashmap-containsvalue.html) | 检查 hashMap 中是否存在指定的 value 对应的映射关系。         |
| [replace()](https://www.runoob.com/java/java-hashmap-replace.html) | 替换 hashMap 中是指定的 key 对应的 value。                   |
| [replaceAll()](https://www.runoob.com/java/java-hashmap-replaceall.html) | 将 hashMap 中的所有映射关系替换成给定的函数所执行的结果。    |
| [get()](https://www.runoob.com/java/java-hashmap-get.html)   | 获取指定 key 对应对 value                                    |
| [getOrDefault()](https://www.runoob.com/java/java-hashmap-getordefault.html) | 获取指定 key 对应对 value，如果找不到 key ，则返回设置的默认值 |
| [forEach()](https://www.runoob.com/java/java-hashmap-foreach.html) | 对 hashMap 中的每个映射执行指定的操作。                      |
| [entrySet()](https://www.runoob.com/java/java-hashmap-entryset.html) | 返回 hashMap 中所有映射项的集合集合视图。                    |
| [keySet](https://www.runoob.com/java/java-hashmap-keyset.html)() | 返回 hashMap 中所有 key 组成的集合视图。                     |
| [values()](https://www.runoob.com/java/java-hashmap-values.html) | 返回 hashMap 中存在的所有 value 值。                         |
| [merge()](https://www.runoob.com/java/java-hashmap-merge.html) | 添加键值对到 hashMap 中                                      |
| [compute()](https://www.runoob.com/java/java-hashmap-compute.html) | 对 hashMap 中指定 key 的值进行重新计算                       |
| [computeIfAbsent()](https://www.runoob.com/java/java-hashmap-computeifabsent.html) | 对 hashMap 中指定 key 的值进行重新计算，如果不存在这个 key，则添加到 hasMap 中 |
| [computeIfPresent()](https://www.runoob.com/java/java-hashmap-computeifpresent.html) | 对 hashMap 中指定 key 的值进行重新计算，前提是该 key 存在于 hashMap 中。 |

# Java Iterator（迭代器）

Java Iterator（迭代器）不是一个集合，它是一种用于访问集合的方法，可用于迭代 [ArrayList](https://www.runoob.com/java/java-arraylist.html) 和 [HashSet](https://www.runoob.com/java/java-hashset.html) 等集合。

Iterator 是 Java 迭代器最简单的实现，ListIterator 是 Collection API 中的接口， 它扩展了 Iterator 接口。

![img](https://www.runoob.com/wp-content/uploads/2020/07/ListIterator-Class-Diagram.jpg)

迭代器 it 的两个基本操作是 next 、hasNext 和 remove。

调用 it.next() 会返回迭代器的下一个元素，并且更新迭代器的状态。

调用 it.hasNext() 用于检测集合中是否还有元素。

调用 it.remove() 将迭代器返回的元素删除。

Iterator 类位于 java.util 包中，使用前需要引入它，语法格式如下：

```
import java.util.Iterator; // 引入 Iterator 类
```

### 获取一个迭代器

集合想获取一个迭代器可以使用 iterator() 方法:

```java
// 引入 ArrayList 和 Iterator 类
import java.util.ArrayList;
import java.util.Iterator;

public class RunoobTest {
    public static void main(String[] args) {

        // 创建集合
        ArrayList<String> sites = new ArrayList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");

        // 获取迭代器
        Iterator<String> it = sites.iterator();

        // 输出集合中的第一个元素
        System.out.println(it.next());
    }
}
```

执行以上代码，输出结果如下：

```
Google
```

### 循环集合元素

让迭代器 it 逐个返回集合中所有元素最简单的方法是使用 while 循环：

```java
while(it.hasNext()) {
    System.out.println(it.next());
}
```

以下输出集合 sites 中的所有元素：

```java
// 引入 ArrayList 和 Iterator 类
import java.util.ArrayList;
import java.util.Iterator;

public class RunoobTest {
    public static void main(String[] args) {

        // 创建集合
        ArrayList<String> sites = new ArrayList<String>();
        sites.add("Google");
        sites.add("Runoob");
        sites.add("Taobao");
        sites.add("Zhihu");

        // 获取迭代器
        Iterator<String> it = sites.iterator();

        // 输出集合中的所有元素
        while(it.hasNext()) {
            System.out.println(it.next());
        }
    }
}
```

执行以上代码，输出结果如下：

```
Google
Runoob
Taobao
Zhihu
```

删除元素

要删除集合中的元素可以使用 remove() 方法。

以下实例我们删除集合中小于 10 的元素：