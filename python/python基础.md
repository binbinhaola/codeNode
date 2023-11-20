## python的基本概念

### 	变量与字符串

#### 	转义字符

![image-20230531221727226](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230531221727226.png)

#### 原始字符串

​	不会使用进行字符转义,在字符串前加上r

```python
print(r"D:\three\test\test\xxx")
```

#### 长字符串

​	可以让字符串包含换行符(三单引号，双引号都可，需要前后对应)

```python
string = '''fdsfsdfs
        fdsfsdf
        sdfsdf
        sdfdsf
        sfsdf '''
```

#### 字符串与运算符号

​	字符串+字符串 字符串拼接

​	字符串*数字 将字符串拼接相应次数

  

### 条件判断

if 语句嵌套

```python
if guess == 8:
    print("牛逼啊")
    print("呵呵，猜中了又怎样")
else:
    if guess < 8:
        print("小了")
    else:
        print("大了")
```



### 循环语句

while 循环

```python
while counts>0;
  do somthing ....
  counts+=1
```



### 随机数模组

random.randint(num,num) 范围生成整数

random.getstate 获取随机数状态

random.setstate 设置随机数状态

### 数字类型

浮点数采用了IEEE754标准存储，会产生一定的误差

通过decimal模块，使用decimal实例来确保生成的小数准确

```python
import decimal
a = decimal.Decimal('0.1')
b = decimal.Decimal('0.2')
c = decimal.Decimal('0.3')

print(a+b == c)
```

复数

```python
x = 1+2j
x.real #获取实部数字
x.imag #获取虚部数字
#以浮点形式获取
```

### 布尔类型

bool()函数 接受一个值，判断值的真假

python 中 true == 1;false == 0



### 判断结构

```python
if age < 18
	print("buxing")
else:
	print("keyi")
    
print("不行") if age <18 else print("可以") #将if结构转换为条件表达式

small = a if a<b else b #通过if判断，true返回a false 返回 b
```



### 循环结构

while for break continue

```python
i = 1
while i < 5:
    print("循环内，i的值是",i)
    i +=1
    if(i==3):
        break
else:
    print("循环外,i的值是",i)
    
#else 和while 可以组合使用，当while条件不为真是执行else中的语句
```



for 循环的迭代

```python
for each in "FishC":
	print(each)
    
range(start,stop,step) #接受1-3个参数，生成一个数字序列
```



### 列表

```python
list = [1,2,3,4,"412414"] #声明一个列表 

list[-1] #选择列表最后一个元素，负数下标为倒数
```

列表切片

```python
list[0:3]|list[:3] #获取前三个值的列表
list[3:] #获取3下标后的值的列表
list[:] #获取所有列表值
list[0:6:2] #第三个参数设置步进值
list[::-1] #列表倒序输出
```

增

```python
list.append("value") #列表末尾添加元素
list.extend(["11","22"]) #列表末尾添加一个可迭代对象   
s[len(s):] = [6] #列表切片，可以使用列表替换掉选取的列表切片
```

删

```python
list.remove("value") #删除列表中指定值,如有重复元素，只会删除第一个匹配元素
list.pop(index) #删除指定下标的数据
list.clear #清空指定列表
```

改

```python
list[3:] = ["1","2","3"] #批量替换列表值
list.sort() #将数字按从小到大排序
list.reverse() #反转列表元素
```

查  

```python
list.count(3) #统计元素出现的次数
list.index("123") #获取元素的下标值
list.index(3,1,7) #获取元素3的小标，在列表坐标1-7之间
list.copy() #拷贝列表对象 
```

list[1,2,3]*3 会将列表内元素重复三遍(重复引用三次)



is运算符

```
x is y #检测两个变量是否指向同一内存地址
```



浅拷贝和深拷贝

```python
import copy
list2 = copy.copy(list) #实现的浅拷贝，在嵌套数组中，子对象只复制了引用
list2 = copy.deepcopy(list) #深拷贝，拷贝对象的同时，也将子对象一起拷贝
```

 

列表推导式

```python
list = [1,2,3,4,5]
list = [i*2 for i in list] #将list中的所有元素值*2 [expression for taget in iterable]
#推导式后可以接判断语句或者嵌套
```



### 元组

元组是不可变的，不能修改元素(当元素指向可修改对象时可以修改),能切片操作

```python
#元组的声明
rhyme = (1,2,3,4,5,'zifuchuan')
rhyme = 1,2,3,4,5,'字符串'

t = (123,"fishc",3.14) #元组的打包
x,y,z = t #元组的解包


```



### 字符串(2)

#### 大小写字母换来换去

```python
capitaliza() #字符串首字母大写，其余小写
casefold() #返回所有字母为小写的字符串
title() #每个单词的首字母变成大写
swapcase() #大小写反转
upper() #所有字母大写
lower() #所有字母小写
```

左中右对齐

```python
#接受一个参数，表示字符串长度,第二个参数为填充字符串
center() #字符串中间对其

ljust() #左对齐
rjust() #右对齐
zfill() #使用0填充字符串
```

#### 查找

```python
count(sub[,start[,end]]) #查询子字符串，在字符串中出现的次数
find(sub,[,start,[,end]]) #查找子字符串下标值，从左往右
rfind(sub,[,start,[,end]]) #同上，从右往左
index(sub,[,start,[,end]]) #查找子字符串下标值，从左往右 抛出异常
rindex(sub,[,start,[,end]]) #同上，从右往左 抛出异常
```

#### 替换

```python
expandtabs([tabsize=8]) #空格替换制表符，返回新的字符串
replace(old,new,count=-1) #将指定的子字符串，替换为新的字符串,count指定替换次数
translate(table) #使用表格规则，对字符串进行替换,返回一个新的字符串
str.maktrans("abdjskdf","123213","str") #生成表格规则,第三个参数为忽略的字符串
```

#### 判断

```python
#可以传入元组，匹配多个字符串 
startswith(prefix,[,start[,end]]) #字符串是否以字符串开头
endswith(suffix[,start[,end]])  #字符串是否以字符串结尾

istitle()
isupper()
islower()
isalpha() #判断是否为纯字母字符串
isspace() #判断是否为空白字符串
isprintable() #判断是否都为可打印字符
isdecimal() #判断是否为十进制数字
isdigit() #判断是否为阿拉伯数字
isnumeric()#判断是否为数字
isidentifier() #判断是否是一个合法python变量名
keyword.iskeyword("str") #判断字符是不是python保留标识符
```

#### 截取

```python
#下面三个方法可以传入字符串，去除匹配的字符,匹配方式为一直匹配，直到又不匹配的字符出钱
lstrip() #截取字符串左侧空白
rstrip() #截取右侧空白
strip() #左右都不留白

#传入字符串，需要匹配整个字符串
removeprefix() #删除前缀
removesuffix() #删除后缀
```



#### 拆分和拼接

```python
partition() #传入一个分割符，返回一个三元组
rpartition() #从右到左寻找分隔符
split() #第一个参数指定分隔符，第二个参数指定分割次数
rsplit() #方向相反
splitlines() #字符串按行分割，将结果以列表的形式返回,True分割后保存换行符
join(iterable) #将字符串以分割符的形式，将接受的字符串拼接起来,效率比加号直接拼接性能高很多
```



#### 格式化字符串

```python
"string{}str".format("replace") #接受参数会替换字符串中的花括号，花括号使用数字指定使用的参数位置,传入参数被当作元组元素对待

"我叫{name},我爱{fav}".format(name="小甲鱼",fav="python")#使用关键字进行替换
```

![image-20230606121217884](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230606121217884.png)

#### f-字符串

![image-20230606121440996](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230606121440996.png)

![image-20230606121536860](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230606121536860.png)



### 序列

```python
id(obj) #返回一个对象的唯一整数值,可理解为id 可变序列对象不变，不可变序列对象改变
x is y ,x is not y #判断两个对象是否为同一个对象
x in y,x not in y
del #删除对象或可变序列里的可变对象
```

#### 序列相关函数

```python
#转换可迭代对象
list() #转化为队列
tuple() #转化为元组
str() #转化为字符串
min(s,defult) max(s,defult)#字面意思,没有值则是default值
len() #长度
sum(s,start) #计算和,start计算起始位置
sorted(s) #返回一个新列表 s.sort()会改变元数组
reversed(s) #返回一个参数反向迭代器
all() #判断可迭代对象中，是否所有值为真
any() #判断可迭代对象中，是否某个值为真
enumerate(s,num) #返回一个枚举对象,返回一个带编号的二元数组,num为开始序号
zip(z,y) #用于创建一个聚合多个可迭代对象的迭代器,将传入参数的每个可迭代对象的每个元素，依次组合成元组，即第i个元组包含来自每个参数的第i个元素,长度以最短的为准

import itertools
itertools.zip_longest(x,y,x) #会按照最长的数组来聚合，空值自动填充为none
map(func,iter) #根据提供的函数，对指定的可迭代对象的每个元素进行运算，并返回运算结果的迭代器,可迭代对象数量与函数参数数量对应n 
filter(func,iter) #返回计算结果为真的元素的迭代器
iter(s) #将可迭代对象转换为迭代器
next(s,default) #逐个将迭代器中的元素提取出来
```

### 字典

```python
x = {"a":"ab","b":"bb"} #键值对应
b = dict(a="aaa",b="bbb",c="ccc") #创建
c = dict([("a","aaa"),("b","bbb"),("c","ccc")]) #创建
d = dict({"a":"ab","b":"bb"}) #创建
e = dict({"a":"ab","b":"bb"},刘备="lbb") #创建
f = dict(zip(["a","b","c"],["aaa","bbb","ccc"]))#创建

d = dict.fromkeys("Fish",value) #将第一个参数作为键(可迭代参数)，第二个参数作为值
pop("key","default") #删除键值,默认返回值
popitem() #删除最后一个键值对，3.7之前随机删除，因为不是顺序排列
del dict["key"] #del删除字典值，或整个字典
clear() #清空字典

x["c"] = "ccc" #指定不存在的key创建一个新的键值对
```

```python
update() #传入键值对或者字典
get(default) #输入要查找的键值，查找不到显示default
setdefault("c","code") #查找key值项，如没有则将default设置为此键的值

items(),values(),keys() #获取对应的视图对象
```



### 集合

集合中的每个元素都是独一无二的，无序的

```python
set("string") #创建集合
isdisjoint(set("string")) #判断set是否与字符串有交集
issubset("string") #判断set是否为字符串的子集
issuperset("string") #判断set是否为字符串的超集
union({1,2,3}) #生成set与元素的并集
intersection("string") #找到set与字符串的交集
difference("string") #找到属于set但不属于字符串的差集
symmetric_difference("String")#排除掉set和字符串中共同元素后的，对称差集

s <= set("FishC") #检测子集
s < set("FishC") #检测真自己
s >= set("fishc") #检测超集
s > set("fishc") #检测真超集
s | {1,2,3} | set("python") #获取并集
s & {1,2,3} & set("and") #获取交集
s - set("php") -set("python") #获取差集
s ^ set("python") #获取对称差集
```

不可变集合 frozenset()

```python
t = frozenset("fishc")
update("string") #修改set为传入参数的并集
add("string") #插入到集合中
remove("string") #删除指定元素
discard("string") #静默删除 
pop() #随机删除一个元素
clear()
hash(value) #获取hash值 
```

<img src="C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230608172645536.png" alt="image-20230608172645536" style="zoom:50%;" />



### 函数

```python
def function(arg): #函数的定义
	statement....
```

#### 关键字参数

```python
def myfunc(s,vt,0):
    return "".join((o,vt,s))
myfunc(o="我",vt="打了",s="小甲鱼") #默认为位置参数，位置参数在关键字参数之前

#默认参数
def myfunc(s,vt,o="小甲鱼"): #默认参数
    return """"""
def func (arg,/) #斜杠左侧只能使用位置参数
def func (a,*,b,c) #*号右侧只能为关键字参数
def func (*args,a,b) #收集参数打包为元组，获取多个参数,后面参数需要关键字参数获取
def func (**kwargs) #打包为字典

def func1 (a,b,c,d):
    pass

func1(*args) #传入元组，进行解包
```



#### 作用域

在函数内修改全局变量时，python会自动创建一个局部变量进行替换

 global语句

```python
x = 100;

def myfunc():
    global x #指定全局变量
    x = 520
```

函数嵌套

```python
#外部无法直接访问funB
def funA():
    x= 520
    def funB():
        x = 880
        print("In funB, x=",X) #内部函数可以访问外部变量，但无法修改
    funB()
    print("In funA, x=",X)
```

nonlocal

```python
#外部无法直接访问funB
def funA():
    x= 520
    def funB():
        nonlocal x #声明
        x = 880
        print("In funB, x=",X) #内部函数可以修改外部值
    funB()
    print("In funA, x=",X)
```

L local 局部作用域

E enclosed 嵌套函数外层作用域

G global 全局作用域
B build-In 内置作用域 内置函数名

#### 闭包

```python
def power(exp):
    def exp_of(base):
        return base ** exp #exp外部作用域变量会保存下来
    return exp_of 
```



#### 装饰器

```python
import time
def time_master(func):
    def call_func():
        print("开始运行程序")
        start = time.time()
        func()
        stop=time.time()
        print("结束程序运行...")
        print(f"一共耗费了{(stop-start):.2f}秒。")
    return call_func

@time_master #相当于 myfunc() = time_master(myfunc)
def myfunc():
    time.sleep(2)
    print("Hello FishC.")

myfunc()
```

![image-20230608233857764](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230608233857764.png)

同时调用多个装饰器

#### 装饰器参数的传递

```python
def logger(msg):
    def time_master(func):
        def call_func():
            start = time.time()
            func()
            stop = time.time()
            print(f"[{meg}]一共耗费了{(stop-start):.2f}")
        return call_func
    return time_master

@logger(msg="A") #funA = logger(msg="A")(funA)
def funA():
    time.sleep(1)
    print("正在调用funA...")
    
@logger(msg="B") #funB = logger(msg="B")(funB)    
def funB():
    time.sleep(1)
    print("正在调用funB...")
    
```

#### lambda表达式

```python
lambda y : y*y #返回y的平方
y = [lambda x:x*x,2,3] #可以放在列表内
y[0](y[1]) #能用不要用
```



#### 生成器

```python
def counter():
    i = 0
    while i <=5:
        yield i #获取生成器对象
        i += 1
#生成器每调用一次提供一次数据，并且会保存当前的状态

t = (i ** 2 for i in rang(1,10)) #生成器表达式
```



####  函数文档，类型注释，内省

```python
def function():
    """
    文档内容
    功能：...
    参数：...
    返回值：...
    """
    return ...

help(function) #获取函数文档

#类型注释
def times(s:str="fishc ",n:int) -> str: #期望参数字符串和整数，返回一个字符串
    return s*n

#内省
func.__name__ #获取函数名
func.__annotation__ #获取类型注释
exchange.__doc__ #获取函数文档
```

#### 高阶函数

接受函数参数的参数，被称为高阶函数

```python
import functools
def add(x,y):
    return x + y

functiools.reduce(add,[1,2,3,4,5]) #将可迭代对象，传入到函数中
```

偏函数

对指定函数进行二次包装，将现有的函数的部分参数预先绑定，从而得到一个新的函数，这个就被称为偏函数

```python
square = functools.partial(pow,exp=2)
square(2) == 4
```

@wraps装饰器

不加这个，通过装饰器获取的函数名称不一致

```python
import time
import functools

def time_master(func):
    @functools.wraps(func)
    def call_func():
        print("开始运行程序")
        start = time.time()
        func()
        stop=time.time()
        print("结束程序运行...")
        print(f"一共耗费了{(stop-start):.2f}秒。")
    return call_func

@time_master #相当于 myfunc() = time_master(myfunc)
def myfunc():
    time.sleep(2)
    print("Hello FishC.")

myfunc()
```

### 永久储存

```python
f=open(file,mod) #第一个为文件名或者路径，不存在则创建文件在python主文件夹,
f.write("I love python.") #写入字符，返回写入字符个数
f.writelines(["string1\n","string2\n"]) #传入多个字符串没有返回值

f.close() #关闭文件，写入的数据会储存在文件中
f.flush() #将文件操作保存

readable(),writable() #文件是否可读，可写
f.read() #通过文件指针获取数据,读取到文件的末尾
f.readline() #读取一行数据
f.tell() #获取指针当前位置
f.seek(offset,whence=0) #调整文件指针位置

f.truncate(pos) #截取文件到指定位置，默认为指针当前位置

#单独使用写入模式时，关闭文件会使用截断模式
```

#### 路径处理

pathlib

```python
from pathlib import Path

Path.cwd() #获取当前目录
Path("path") #生成路径对象
q = p / "ssss.txt" #当p为文件夹路径时,q为文件全名
is_dir()
is_file()
exists() #判断路径是否存在
name #文件夹为最后一段路径，文件为文件全名
stem #获取文件名
suffix #文件后缀
parent #获取父级目录
parents #获取逻辑祖先路径构成的序列
parts #路径各个组件拆分为元组
stat() #获取文件信息
Path("./doc").resolve() #将相对路径转换为绝对路径
iterdir() #获取当前路径下所有子文件和子文件夹
mkdir(parents=True,exist_ok=True) #创建文件夹,忽略报错信息,parents为True时自动创建不存在的父文件夹
Path.open() #不用传入路径
rename() #重命名
m.replace(n) #m文件对象替换n文件对象
rmdir() #删除文件夹
unlink() #删除文件
glob("*.txt") #查询路径中.txt后缀的文件
```



#### with语句和上下文管理器

```python
#能够保证文件的关闭，在程序出错时也可以正常关闭文件
with open("FishC.txt","w") as f:
    f.write("ni hao")

```

pickle python对象序列化

```python
import pickle

x,y,z = 1,2,3
s = "FishC"
l = ["小甲鱼",520,3.14]
d = {"one":1,"two":2}

#序列化对象
with open("data.pkl","wb") as f:
    pickle.dump((x,y,z,s,l,d),f)

#转化序列化对象
with open("data.pkl","rb") as f:
    x,y,z,l,s,d = pickle.load(f)
```



### 异常

```python
try:
    code...
except [expression[as identifier]]:
    code
    
#try-except-else 没有异常时，执行else中的代码
#finally 和java一样
```

raise 语句

```python
raise ValueError("值不正确.") #手动抛出异常
raise ValueError("这样不行~") from ZeroDivisionError #异常链
```

assert语句

只能引发AssertionError异常

```python
s = "FishC"
assert s == "FishC"
assert S != "FishC" #如果条件不成立则抛出异常
```



### 类和对象

类的创建

![image-20230609165306448](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230609165306448.png)

类方法中函数的self参数，是实例化对象本身，用于区分哪个对象调用的这个方法



#### 继承，多重继承，组合

```python
Class B(A) #类B继承类A
isinstance(b,A) #判断实例b是否属于类B
issubclass(B,A) #检测B是否为A的子类

#多重继承
Class C(A,B) #同时继承多个类,子类查询父类属性或者方法按照从左到右的顺序

#组合
class D:
    a = A()
    b = B()
    c = C()
    def day(self):
        self.a.say()
        self.b.say()
        self.c.say()
```

self 用于绑定方法和实例

```python
class C:
    pass
c = C()
c.x = 1
c.y = 2
#通过空类实例来实现字典
```



#### 构造函数，重写，钻石继承

```python
#构造函数
class C:
    def __init__(self,x,y):
        self.x = x
        self.y = y
```

![image-20230612215524581](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230612215524581.png)

钻石继承，会导致a的构造函数被调用两遍

```python
class B1(A):
    def __init__(self):
        super().__init() #使用super函数，会自动调用所属父类的方法，解决此问题
        print("你好")
```

####  Mxinin

```python
class Dispaly:
    def dispaly(self,message):
        print(message)
        
class LoggerMixin:#mixin类都会有mixin后缀
    def log(self,message,filename="logfile.txt"):
        with open(filename,"a") as f:
            f.write(message)
     def display(self,message):
        super().display(message)
        self.log(message)
        
class MySubClass(LoggerMixin,Dispaly):
    def log(self,message):
        super().log(message,filename="subclasslog.txt")

subclass = MySubClass()
subclass.display("This is a test")
```



#### 多态和鸭子类型

```python
#鸭子类型
函数接受一个实例，并不关心实例类型，只要实例拥有对应属性和方法就不会报错
```



#### "私有变量“和__slots__

```python
class C:
    def __init__(self,x):
        self.__x = x
    def set_x(self,x):
        self.__x = x
    def get_x(self):
        print(self.__x)
        
#无法直接使用__x来获取这个值但可以通过 _C__x来获取这个属性值方法也是同理
#_单个下横线开头的变量为私有变量
#_单个下横线结尾的变量一般为保留字符同名变量

```

```python
class C:
    __slots__ = ["x","y"] #对类属性进行限制，类只能拥有指定的属性名
    def __init__(self,x):
        self.x = x
c = C(250)
c.z = 100 #此条语句会报错
#继承自父类中的__slots__属性是不会在子类中生效的
```



#### 魔法方法

```python
__new__(cls,[...]) #实例化前的方法
__del__() #销毁对象前的方法
```



#### 运算魔法方法

```python
class S(str):
    def __add__(self,other): #会拦截替换默认的加法方法
        return len(self) + len(other) #两个s实例相加时，相加字符串长度之和
    
s1 + s2 #相当与 s1.__add__(s2),所以s1在运算符号左边时，拦截生效

def __int__(self): #内置函数也可以进行拦截
    ....
```

![image-20230613230214054](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230613230214054.png)

如果传入“中文数字”，则执行except代码块，将汉字进行转换返回

 

#### 属性访问魔法方法

直接看视频吧



#### 索引，切片，迭代协议

```python
#如果一个对象定义了__iter__(self)魔法方法，那么它就是一个可迭代对象
#如果一个可迭代对象定义了一个__next__(self)魔法方法，那么它就是一个迭代器
```



#### 代偿

```python
def __contains__(self,item) #实现成员关系的检测
#没实现contains方法是，python会寻找__iter__和__next__方法，进行代偿
#如果都没有，就会获取__getitem__方法
#__contains__ = None 直接赋值none可以不让魔法方法生效
```

![image-20230614093343800](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614093343800.png)

```python
#使用__call__魔法方法，可以像调用函数一样调用对象
```

![image-20230614095644540](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614095644540.png)



#### Property

```python
#propety 可以对x属性进行操作
class C:
    def __init__(self):
        self._x = 250
    def getx(self):
        return self._x
    def setx(self,value):
        self._x = value
    def delx(self):
        del self._x
    x = property(getx,setx,delx) #接受三个函数参数，读写删
    
    #使用装饰器
    @property
    def x(self):
        return self._x
    
    @x.setter
    def x(self,value):
        self._x = value
        
    @x.deleter
    def x(self):
        del self._x

    
#魔法方法
class D:
    def __init__(self):
        self._x=250
    def __getattr__(self,name):
        if name=='x':
            return self._x
        else:
            super().__getattr__(name)
    def __setattr__(self,name,value):
        if name == 'x':
            super().__setattr__('_x',value)
        else:
            super().__setattr__(name,value)
    def __delattr__(self,name):
        if  name == 'x':
            super().__delattr__('_x')
        else:
            super().__delattr__(name)
```



#### 类方法和静态方法

```python
class C:
    def funA(self):
        print(self)
    @classmethod #类方法 涉及类属性用类方法较好
    def funB(cls):
        print(cls)
        
class C:
    @staticmethod #静态方法
    def func():
        print("I love FishC.")
        
```



#### 描述符(比较重要，建议再多看)

```python
   
```

![image-20230614112346149](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614112346149.png)

通过类D来管理类C中的私有属性_x



#### 数据描述符，非数据描述符，优雅编程![image-20230614113623371](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614113623371.png)

描述符只能使用与类属性，对象属性不生效

生效优先级：数据描述符->实例对象属性->非数据描述符->类属性

```python
#数据描述符
__set__,__delete__
#非数据描述符
__get__
#描述符
__set_name__(self,name,owner)
```



#### type()函数和\__init_subclass__

```python
#type可以创建类
#__init_subclass__ 父类用于控制子类属性值
```



#### 元类

给所有的类添加一个属性

![image-20230614154731380](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614154731380.png) 

对类名的定义规范做限制

![image-20230614160201704](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614160201704.png)

修改对象的属性值

![image-20230614160428201](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614160428201.png)

限制类实例化时的传参方式

![image-20230614160924400](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614160924400.png)

禁止一个类被实例化

![  ](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614161304077.png)

只允许实例化一个对象

![image-20230614161612707](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230614161612707.png)



#### 抽象基类

1.抽象基类不能被直接实例化

2.子类必须实现抽象基类中定义的抽象方法

```python
from abc import ABCMeta,abstractmethod
#创建抽象基类
class Fruit(metaclass=ABCMeta):
    def __init__(self,name):
        self.name = name
    @abstractmethod
    def good_for_heal(self):
        pass
    
#继承重写
class Banana(Fruit):
    def good_for_heal(self):
        print("nihao")
```



## 一些运算符

1.x,y = y,x (交换x,y的值)

2.比较运算符

![image-20230601125756784](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230601125756784.png)

3.数字运算符

![image-20230601225023277](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230601225023277.png)

x // y 确保两个数的商为整数，如果不是就向下取整

```python
3 / 2
1

-3 // 2
-2

divmod(3,2) #直接给出两数的地板除的值和余数
(1,1)

pow(2,3,5) #等于2 ** 3 % 5
3
```

4.逻辑运算符

**pyth  中任何对象都能直接进行真值测试(测试该对象的布尔类型为true或者false),用与if或者while语句的条件判断，也可以做为布尔逻辑运算符的操作数**

![image-20230602205903581](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230602205903581.png)

5.运算符优先级

![image-20230602213745734](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230602213745734.png)

6.orc(c) 将值转换为对应的ascii编码
