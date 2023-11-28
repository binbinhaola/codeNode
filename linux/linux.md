# linux基础



## 桌面和终端基本操作

ctrl+alt+f[3-6]可以开启多个shell



## Linux文件与目录结构

Linnux**系统中一切皆文件**

### 目录结构

![image-20230802211913005](F:\markdownImg\image-20230802211913005.png)

bin （二进制）存放可执行文件

sbin 存放管理员可执行文件

lib，lib64 存放库文件

usr 用户的所有应用程序和信息

dev 设备目录

etc 系统配置文件

opr 可选目录，一般装第三方软件在此目录

proc 系统进程目录



## VIM编辑器

![image-20230802225023377](F:\markdownImg\image-20230802225023377.png)

### 一般模式

| **y[num \|移动光标的执行如"w","G"]y**   | 复制当行,num指定复制的行数                        |
| --------------------------------------- | ------------------------------------------------- |
| **y$**                                  | 复制从当前光标位置开始到当前行结束                |
| **y^**                                  | 复制从当前光标位置开始到当前行开始                |
| **w**                                   | 将光标移动到下一个单词                            |
| b                                       | 移动到上一个词的词头                              |
| **[num] p**                             | 粘贴数据,num为粘贴的次数                          |
| **d[num \| 移动光标的执行如"w","G" ]d** | 删除当前行，num为删除总行数                       |
| **x\|X**                                | x截切当前光标位置字符,X截取当前光标位置之前的字符 |
| **r**                                   | 替换当前字符                                      |
| **R**                                   | 切换为替换模式                                    |
| shift+^                                 | 移动到当前行头                                    |
| shift+$                                 | 移动到当前行尾                                    |
| e                                       | 移动到当前词尾                                    |
| 1+G                                     | 移动到页头                                        |
| G                                       | 移动到页尾                                        |
| 数字N+G                                 | 移动到目标行                                      |
| h                                       | 左移光标                                          |
| j                                       | 下移光标                                          |
| k                                       | 上移光标                                          |
| l                                       | 右移光标                                          |

![image-20230803111944783](F:\markdownImg\image-20230803111944783.png)

### 命令模式

![image-20230803114236942](F:\markdownImg\image-20230803114236942.png)

set nu 显示行号

u可以回退上次输入

<img src="F:\markdownImg\image-20230803115749414.png" alt="image-20230803115749414" style="zoom:200%;" />



## 网络配置和系统管理操作



![image-20230803164653091](F:\markdownImg\image-20230803164653091.png)



### 修改静态IP

​     centos: vim /etc/sysconfig/network-scripts/netName

![image-20230803172219139](F:\markdownImg\image-20230803172219139.png)

### 配置主机名

hostname 显示主机名

hostnamectl set-hostname xxx 直接修改主机名

sudo vim /etc/hostname 主机名配置文件



### 远程登陆

基于ssh协议



## linux系统管理

![image-20230803193625093](F:\markdownImg\image-20230803193625093.png)

以d结尾的称为守护进程，概念上和服务差不多



### **服务操作语法**

![image-20230803194341940](F:\markdownImg\image-20230803194341940.png)

.target  服务的集合

.service 服务文件



### 系统运行级别

​	init 的进程是linux初始化后主动启动的第一个linux进程，随后根据用户自己定义的系统运行级别，来启动不同的服务进程(**会调用init.d目录下的所有的脚本，启动守护进程**)

![image-20230803201459720](F:\markdownImg\image-20230803201459720.png)

init3,5 可以切换界面



### 配置服务开机启动和关闭防火墙

systemctl disable/enable service 控制服务自启动

centos:firewalld

ubantu:ufw



### 关机重启命令

linux 采用预读延迟写入的操作，所以关机前需要去将内存写入到磁盘

shutdown 关机指令

**参数：**

| -c     | 取消操作     |
| ------ | ------------ |
| now    | 立刻关机     |
| [num]  | 指定分钟关机 |
| 15:28  | 指定时间关机 |
| -r     | 重启         |
| -H     | 相当于halt   |
| -h now | 立马关机     |

sync 将数据由内存同步到硬盘中

halt 停机，关闭系统，但不断电

poweroff 关机断电



## shell指令整体介绍以及帮助命令

man[命令或配置文件] 获取帮助信息

![image-20230807202413468](F:\markdownImg\image-20230807202413468.png)

| 命令        | 作用                            |
| ----------- | ------------------------------- |
| type name   | 判断一个shell指令是否为内置命令 |
| man -f      | 查看shell内置指令               |
| help name   | 只能获取shell内置指令的帮助信息 |
| name --help | 显示指令的帮助信息              |



## 文件目录类指令

| 命令                            | 作用                                                        |
| ------------------------------- | ----------------------------------------------------------- |
| pwd:print working directory     | 显示当前工作目录的绝对路径                                  |
| cd -                            | 跳转至上次访问路径                                          |
| ls -a                           | 显示全部的文件，连同隐藏文档                                |
| ls -l == ll                     | 长数据串列出，包含文件的属性与权限等等数据                  |
| mkdir a b c                     | 可同时创建多个文件夹                                        |
| mkdir -p a/b/c                  | 创建一个目录以及它的父目录                                  |
| rmdir                           | 移除一个目录                                                |
| rmdir -p g/h/c/                 | 删除一个目录以及其父目录                                    |
| touch filename                  | 创建一个文件                                                |
| scp[-r] source remotedest       | 将本地文件复制到远程目录(远程目录地址：root@dest:/filepath) |
| cp[-r] source dest              | 将文件\文件夹复制到指定路径 (-r 递归复制)                   |
| rm[-r] deleteFile               | 删除指定文件夹                                              |
| rm [-f]                         | 强制删除文件，不进行确认                                    |
| rm [-v]                         | 显示指令的详细执行操作                                      |
| mv oldNameFile newNameFile      | 文件重命名                                                  |
| mv /temp/movefile /targetFolder | 移动文件                                                    |
| cat[-n] fileName                | 显示所有行的行号，包括空行                                  |
| less                            | 可以查看文件，操作很多                                      |
| echo [选项] [输出内容]          | 输出内容在控制台                                            |
| echo -e                         | 支持反斜杠控制的字符转换                                    |
| ls -l > 文件                    | 列表的内内容写入文件中(覆盖写)                              |
| ls -al >> 文件                  | 列表的内容追加到文件的末尾                                  |
| cat 文件1 > 文件2               | 将文件1的内容覆盖到文件2                                    |
| echo "内容" >> 文件             |                                                             |
| head 文件                       | 查看文件头10行内容                                          |
| head -n 5 文件                  | 查看文件头5行内容                                           |
| tail 文件                       | 查看文件尾部10行内容                                        |
| tail -n 5 文件                  | 查看文件尾部5行内容                                         |
| tail -f 文件                    | 实时追踪该文档的所有更新                                    |
| ln -s[原文件或目录] [软链接名]  | 给源文件创建一个软链接                                      |
| rm [软链接名]                   | 删除软链接                                                  |
| rm [软连接名]/                  | 删除原始的真实目录                                          |
| ln [文件名] [链接名]            | 创建一个硬链接                                              |
| history                         | 查看已执行过的命令                                          |
| history -c                      | 清空历史命令                                                |

\cp 使用的原生命令，cp 实际命令为'cp -i' 带有交互提示

./ 表示当前目录

硬链接相当于直接指向原始文件（相当于别名,只能创建文件的硬链接)

软链将相当于创建一个文件(存放的原始文件地址)，再让文件指向原始文件



## 时间日期类

![image-20230808194744965](F:\markdownImg\image-20230808194744965.png)

![image-20230808195104829](F:\markdownImg\image-20230808195104829.png)

 

## 用户管理命令

### 用户和组类

| 命令                       | 功能                       |
| -------------------------- | -------------------------- |
| adduser 用户名             | 添加新用户                 |
| adduser -group 组名 用户名 | 添加用户到某个组中         |
| id 用户名                  | 查询用户                   |
| su 用户名                  | 切换用户                   |
| who am i                   | 查看当前用户               |
| userdel 用户名             | 删除用户                   |
| userdel -r 用户名          | 删除用户同时删除用户文件夹 |
| groupadd 组名              | 添加小组                   |
| usermod -g 组名 用户名     | 设置用户的组               |
| groupmod -n 新名称 旧名称  | 修改组名称                 |
| groupdel 组名              | 删除用户组                 |
|                            |                            |
|                            |                            |
|                            |                            |
|                            |                            |
|                            |                            |
|                            |                            |
|                            |                            |
|                            |                            |

  **sudo指令能为普通用户赋予root权限，但是用户不能在任何地方使用此命令，需要在/etc/sudors 文件中进行配置**

在此组中的用户可以在任何地方执行sudo指令

![image-20230821162715547](F:\markdownImg\image-20230821162715547.png)



### 文件权限类

![image-20230821163043365](F:\markdownImg\image-20230821163043365.png)

-普通文件 d-目录文件 c-字符输入文件 b-块文件(一般为储存设备)

![image-20230821163549356](F:\markdownImg\image-20230821163549356.png)

#### chmod改变权限

| 指令                               |                                                              |
| ---------------------------------- | ------------------------------------------------------------ |
| chmod[{ugoa}{+-=}{rwx}] 文件或目录 | 修改文件或目录权限，第一个参数为选择的用户类型，第二个表示添加删除或授予权限，第三个为权限参数 |
| chmod[model=421] 文件或目录        | 用数字作为参数                                               |
| chmod -R 777                       | 将文件的所有子文件和目录指定相应的权限                       |
| chown -R 用户名 文件目录名         | 更改属主，递归修改                                           |
| chgrp -R 组名 文件目录名           | 更改属组，递归修改                                           |
|                                    |                                                              |
|                                    |                                                              |

![image-20230821165740960](F:\markdownImg\image-20230821165740960.png)

#### chown改变所有者

基本语法：

  chown[-R] [最终用户] [文件或目录]  改变文件或者目录的所有者



## 搜索查找类

**find指令将从指定目录向下递归地遍历其各个子目录，将满足条件的文件显示在终端**

find[搜索范围] [选项]

![image-20230824224950251](F:\markdownImg\image-20230824224950251.png)

size通过+-号来表示大小范围。 



**locate指令，利用事先建立的系统中所有文件名及路径的locate数据库实现快速定位给定的文件**,**无需遍历系统**.

使用先需要使用updatedb进行数据库更新

**which 指令可以查询指令位置**



### grep过滤查找及"|"管道符

管道符，"|",表示将前一个命令的处理结果输出传递给后面的命令处理

基本语法

  grep 选项 查找内容 源文件

 选项 -n 显示匹配行以及行号

 选项 -i 忽略大小写

  选项 -m[n] 限制匹配的行数



## 压缩解压类

![image-20230831171320328](F:\markdownImg\image-20230831171320328.png)

![image-20230831171555392](F:\markdownImg\image-20230831171555392.png)

![image-20230831172043352](F:\markdownImg\image-20230831172043352.png)

-z 调用 gzip/gunzip来处理打包文件



## 磁盘管理类

apt-get install tree  #ubantu 获取tree

tree ./ 显示当前目录下目录和其子目录

![image-20230831184440988](F:\markdownImg\image-20230831184440988.png)

![image-20230831185412864](F:\markdownImg\image-20230831185412864.png)

![image-20230831195712063](F:\markdownImg\image-20230831195712063.png)



## 进程管理类

**Linux中的进程和服务**

  计算机中，一个正在执行的程序或命令，被叫做“进程”(process).

  启动之后一直存在，常驻内存的进程，一般被称为“服务”(service)

![image-20230831201230412](F:\markdownImg\image-20230831201230412.png)

![image-20230831201632532](F:\markdownImg\image-20230831201632532.png)

![image-20230905222329374](F:\markdownImg\image-20230905222329374.png)

### 终止进程

![image-20230905225643091](F:\markdownImg\image-20230905225643091.png)

### 查看进程树

![image-20230906224842622](F:\markdownImg\image-20230906224842622.png)

### 实时监控系统进程状态

**基本命令**：top[选项]

| 命令    | 参数                               |
| ------- | ---------------------------------- |
| -d 秒数 | 指定top命令每隔几秒更新。默认是3秒 |
| -i      | 使top不显示任何闲置或者僵死进程    |
| -p      | 通过指定进程id来监控单个进程窗状态 |



**操作说明**

shift + P	以cpu使用率排序

shift+M	以内存使用率排序

shift+N	以PID排序

q	退出top



### netstat显示网络状态和端口监控

![image-20230906230900664](F:\markdownImg\image-20230906230900664.png)



## crontab 系统定时任务

基本命令：crontab[选项]

![image-20230906232636105](F:\markdownImg\image-20230906232636105.png)

**进入crontab编辑界面，会打开vim编辑器**

'* * * * *'执行的任务

![image-20230906233816329](F:\markdownImg\image-20230906233816329.png)

![image-20230906233831787](F:\markdownImg\image-20230906233831787.png)

![image-20230906233851160](F:\markdownImg\image-20230906233851160.png)

## 软件包管理

### RPM

(RedHat Package Manager) RedHat软件包管理工具

![image-20230907223011671](F:\markdownImg\image-20230907223011671.png)

rpm -qi 软件名 查询安装的软件信息

![image-20230907223341600](F:\markdownImg\image-20230907223341600.png)

![image-20230907223503219](F:\markdownImg\image-20230907223503219.png)

### YUM

YUM(Yellow dog Updater Modifed) 基于RPM包管理，能够从指定的服务器自动下载RPM包并自动处理依赖关系



![image-20230907224300197](F:\markdownImg\image-20230907224300197.png)

![image-20230907224314184](F:\markdownImg\image-20230907224314184.png)

![image-20230907224631091](F:\markdownImg\image-20230907224631091.png)



## shell编程

shell脚本一般为sh后缀，后缀没有限制。

指定解析器

![image-20230910101406111](F:\markdownImg\image-20230910101406111.png)



![image-20230910102015405](F:\markdownImg\image-20230910102015405.png)

![image-20230910102031059](F:\markdownImg\image-20230910102031059.png)

/xxx/xxx/xxx.sh

./xxx.sh

**第三种：**(不会开启新的子shell)

. xxx.sh

source xxx.sh

**![image-20230910102825661](F:\markdownImg\image-20230910102825661.png)**



### 系统预定义变量

#### 常用系统变量

​	**$HOME $PWD $SHELL $USER**

#### 自定义变量

![image-20230910104040805](F:\markdownImg\image-20230910104040805.png)

![image-20230911103108812](F:\markdownImg\image-20230911103108812.png)

export 可以将变量变为全局变量，

子shell中局部变量的修改，export后修改也不会在父shell中生效。

readonly 关键字，定义只读变量(常量)

unset 关键字，撤销变量定义,常量不能unset



#### 特殊变量

![image-20230911105009456](F:\markdownImg\image-20230911105009456.png)

用来接受调用脚本时传入的参数



![image-20230911105045991](F:\markdownImg\image-20230911105045991.png)



![image-20230911105155042](F:\markdownImg\image-20230911105155042.png)

![image-20230911105403844](F:\markdownImg\image-20230911105403844.png)



### 运算符

![image-20230911110450635](F:\markdownImg\image-20230911110450635.png)



### 条件判断

![image-20230911111659902](F:\markdownImg\image-20230911111659902.png)

使用$?来获取test的结果，0为真，1为假	

![image-20230911115208296](F:\markdownImg\image-20230911115208296.png)

-a 表示与 and

-o 表示或 or

(())中可以直接使用数学运算符号

**let 关键字可以使用高级语言的语法，不加let只能用经典语法**

![image-20230911171318518](F:\markdownImg\image-20230911171318518.png)

![image-20230911115634110](F:\markdownImg\image-20230911115634110.png)

###  流程控制

#### if单分支

![image-20230911161010447](F:\markdownImg\image-20230911161010447.png)

![image-20230911155722130](F:\markdownImg\image-20230911155722130.png)

条件判断时，给判断条件赋予默认值，防止程序报错



#### if多分支

![image-20230911160958902](F:\markdownImg\image-20230911160958902.png)

#### case 语句

  ![image-20230911162402216](F:\markdownImg\image-20230911162402216.png)

![image-20230911162727710](F:\markdownImg\image-20230911162727710.png)



#### for循环

![image-20230911162833007](F:\markdownImg\image-20230911162833007.png)

![el](F:\markdownImg\image-20230911163725610.png)

{1..100} 花括号表示一个序列，表示1到100



#### while循环

![image-20230911170127305](F:\markdownImg\image-20230911170127305.png)



### read读取控制台输入

![image-20230912083013860](F:\markdownImg\image-20230912083013860.png)

read -10 -t "hint for user" input

echo $input



### 函数

#### 系统函数

![image-20230912084444373](F:\markdownImg\image-20230912084444373.png)

basename /opt/function/function.txt

function.txt.

![image-20230912085807126](F:\markdownImg\image-20230912085807126.png)

**$()使用命令替换在脚本中调用系统命令.**

| 函数名                          | 功能         |
| ------------------------------- | ------------ |
| date [+%s]（将日期转换为时间戳) | 显示系统日期 |
| date[+%y%m%d]                   | 显示年月日   |



#### 自定义函数

函数形参不用定义，使用位置参数获取传入参数

![image-20230912090756130](F:\markdownImg\image-20230912090756130.png)

![image-20230912093850898](F:\markdownImg\image-20230912093850898.png)

函数进行return，声明新的变量来接收函数的值



### 正则表达式

配合grep来进行筛选

![image-20230912111116954](F:\markdownImg\image-20230912111116954.png)

![image-20230912111550953](F:\markdownImg\image-20230912111550953.png)

![image-20230912111907038](F:\markdownImg\image-20230912111907038.png)

' \ $ ' **单引号加上反斜杠来对特殊字符进行转义**

![image-20230912112924520](F:\markdownImg\image-20230912112924520.png)

-e 支持扩展 {9}表示重复9次



### **文本处理工具**

![image-20230912113305640](F:\markdownImg\image-20230912113305640.png)

grep 取行

cut 取列



![image-20230912114340659](F:\markdownImg\image-20230912114340659.png)

![image-20230912115610319](F:\markdownImg\image-20230912115610319.png)

![image-20230912120303545](F:\markdownImg\image-20230912120303545.png)



![image-20230912120830032](F:\markdownImg\image-20230912120830032.png)

### 其他杂项

meg 查询用户消息功能是否开启

who -T 查询所有用户的消息功能是否打开

**命令需要文件名时，可以通过管道命令将数据传入到命令中**

![image-20230912174651282](F:\markdownImg\image-20230912174651282.png)
