# 基础



## 第一个ts程序

![image-20230509193650942](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230509193650942.png)

## 原始数据类型



### 类型声明

```ts
let num:number = 10;
function abc(a:number){
    let b:number = 10;
    console.log(b+a);
}
abc(11);

//类型声明，指定ts变量(参数，形参)的类型 ts编译器，自动检查
//类型申明给变量设置了类型，使用变量只能存储定义的类型
```

### 基础数据类型

https://typescript.bootcss.com/basic-types.html

## 数组和对象

```js
//声明空数组
let ar1[]=[]
//声明类型数组
let ar1:number[]=[1,2,3]
//泛型数值
let arry3:Array<number>=[10,20,30]
//声明一个对象，处number,string,boolean之外的类型
let obj:object={}an
```

## Any和Void

any表示任意类型数据，void为空

```ts
//void函数
function fun1():void{
	console.log(123);
}
```

## 类型推断

1，定义变量的时候，直接给变量赋值，则定义类型为对应的类型

2，定义变量的时候，没有赋值，则定义类型为any类型

## 联合类型

可以为变量定义多种类型

会根据变量的赋值，来走类型判断，给变量定义一个类型

应不确定联合类型的具体类型，只能访问所有类型的共有属性和方法

```ts
let f:boolean | number = true; //使用|符号定义
```

## 接口

### 接口的类型-对象

```ts
//定义接口
//接口开头加大写I
//实现对象的属性要与接口的完全一致
interface IPerson{
    readonly id:number, //只读属性
    name:string,
    age:number,
    sex?:string, //？属性表示为可选属性
    [propName:string]:any//任意属性和任意属性值
    [propName:string]:string//一旦定义了任意属性的类型，那么确定类型的属性和任意属性要为此类型或类型子集
    [propName:string]:string|number| //定义联合属性
}

let p:IPerson={
    name: "tom",
    age: 0,
    aww:12,
    sdfe:12,
}

```

### 接口的类型-数组

```ts
interface INewArray{
    [index:number]:number//任意属性，index表示数组中的下标
}
let arr:INewArray=[1,2,3,4]
```

### 接口的类型-函数

```ts
interface IsearchFunc{
    //(参数:类型,....):返回的类型
    (a:string,b:string):boolean
}

//参数返回值
const fun1:IsearchFunc = function(a:string,b:string):boolean{
    return a.search(b) !==-1
}

```

## 函数

### 函数-定义函数

```ts
//命名函数
function add(a:string,b:string):string{
    return a+b;
}
//匿名函数,函数表达式
let add2=function(a:number,b:number):number{
    return a+b;
}
//函数完整的写法
let add3:(a:number,b:number)=>number=function(a:number,b:number):number{
    return a+b
}
```

### 函数-可选参数和默认参数

```ts
ts//可选参数？，必选参数不能位于可选参数后面
let getName=function(x:string='li',y?:string):string{//设置默认值
    return x+y;
}

```

### 函数-剩余参数和函数重载

```ts
//函数重载:函数名相同，形参不同的多个函数
//函数重载声明
function newAdd(x:string,y:string):string;
function newAdd(x:number,y:number):number;
//函数实现
function newAdd(x:string|number,y:string|number):string|number|undefined{
    if(typeof x=='string'&& typeof y=='string'){
        return x+y;
    }else if(typeof x=='number' && typeof y=='number'){
        return x+y;
    }
    return undefined;
}
console.log(newAdd(1,2));
console.log(newAdd("12","dd"));
```

## 类型断言-1

```ts
//类型断言:手动指定一个类型
//2种方法
//1.变量as 类型
//2.<类型>变量
function getLength(x:string|number):number{
    if((x as string).length){
        return (<string>x).length
    }else{
        return <number>x;
    }
}
```

## 类型断言-2

```ts
//将任何一个类型断言为any,any类型时可以访问任何属性和方法的
//极可能掩盖真正的类型错误，所以不确定时不要用'as any'
(window as any).a =10;
//将any 断言为一个具体的类型
function abc(x:any,y:any):any{
    return x+y;
}

let a = abc(1,2) as number;
let b = abc('1','2') as string;

```

## 类型别名和字符串字面量类型

用Type去定义

```ts
type str=string //type给类型别名
type triple = string | number | boolean;//常用于联合类型别名

let a:triple = false;
let b:triple = "true";
let c:triple = 111;
let s:str = "123";

//用来约束取值只能时某几个字符串中的一个
type stringType = "tom" | "jack" | "dick"
let names:stringType = "jack";
```

## 元组Tuple

初始化时需要有对应类型数量的值

```ts
let arr:number[]=[1,2,3,4]
//数值和字符串
//元组(Tuple)合并了不同类型的对象
let Tarr:[number,string]=[123,"123"]
//添加内容的时候，需要时number或者string类型
Tarr.push(1)
Tarr.push("123")
Tarr.push(2)
```

## 枚举

### 常数项

```ts
//使用枚举类给一组数组赋予名称
//可以通过名称去拿取值，通过值去拿去拿去名称
enum numberType{
    one=2,//手动赋值，没有赋值，第一个参数默认为0，后面递增
    two=1,
    three,//重复值会进行覆盖
    four
}
//尽量不要重复值
```

### 计算所得项

```ts
//计算所得项，需要放置在已经确定赋值的枚举项之前，后面不能存放未手动赋值的枚举项
enum COlor{
    black,
    red="red",
    blue="blue".length,
    green="11"
}
```

### 常数枚举

```ts
//常数枚举是使用const enum定义的枚举类型
//常数枚举与普通枚举的区别是，他会在编译阶段被删除，并且不能包含计算成员
//没有手动赋值，会自动计算值
const enum Obj{
    o,
    b,
    j=10+10
}
```

### 外部枚举

```ts
//外部枚举，使用declare enum定义的枚举类型
//定义的类型只会用于编译时的检查，编译结果中会删除
//声明文件
declare enum ABC{
    a,b,c
}

```

### 外部常数枚举

```ts
//两者结合
declare const enum Add{
    a,b,c
}
```



## 类

### 类的定义

```ts
class Person{
    name:string;
    age:number;
    constructor(name:string,age:number){
        this.name=name;
        this.age=age
    }
    sayHi(str:string){
        console.log('hi'+str);
    }
    
}
```

### 继承

```ts
class Animal{
    name:string;
    age:number;
    constructor(name:string,age:number) {
        this.name=name;
        this.age=age;
    }
    sayHi(str:string){
        console.log('h1,'+str)
    }
}

class Dog extends Animal{
    constructor(name:string,age:number) {
        super(name,age);
    }
    //重写父类方法
    sayHi(str: string): void {
        console.log(str+"cnmb")
    }
}
```

### 存取器

```ts
class Animal{
    name:string;
    age:number;
    constructor(name:string,age:number) {
        this.name=name;
        this.age=age;
    }
    get fullName():string{//get属性
        return this.name+this.age
    }
    set changeName(value:string){//set属性
        this.name = value;
    }
    sayHi(str:string){
        console.log('h1,'+str)
    }
}

let n = new Animal("nima",10);
n.changeName="tom"
console.log(n.fullName)

```

### 静态类

```ts
class A{
    static name1:string; //静态属性
    static sayHi(){ //静态方法
        console.log("hi");
    }
}
//实例无法获取静态属性和方法,只能通过类直接获取
```

### 修饰符

```ts
//private 修饰的属性或方法式私有的，不能再声明它的类的外部访问,可被子类继承，但不能访问
//protected 修饰的属性或者方法式受保护的，和private类似，但是在子类中式允许访问的

class x{
   //readonly age:number //只读属性，但是在构造函数时可以修改的
   //readonly定义在参数上，那就是创建并且初始化的age参数
   //将修饰符添加在参数上时，可以直接创建并初始化age参数
   //constructor(public age:number){}
   //constructor(private age:number){}
   constructor(readonly age:number){}
}
```

### 抽象类

```ts
abstract class Y{//定义一个抽象类
    abstract name:string
    abstract sayHi():void
}

class Z extends Y{//继承抽象类，重写方法
    name: string;
    constructor(name:string){
        super();
        this.name = name;
    }
    sayHi():void{
        console.log("hi");
    }
}
```

### 接口继承类

```ts
class NewPerson{
    name:string
    constructor(name:string){
        this.name = name
    }
    sayHi(){

    }
}
interface IPerson extends NewPerson{//接口继承类中的实例属性和实例方法
    age:number
}

let person:IPerson={
    name:'',
    age:18,
    sayHi(){

    }
}
```

## 声明合并

```ts
//函数合并==>函数重载
//接口合并
//合并的属性的类型必须是唯一的
interface Cat{
    name:'小菊'
    gender:"female"
}
interface Cat{
    name:'小菊',
    age:number,

}

const cat:Cat={
    name: "小菊",
    age: 3,
    gender: "female"
}
```

类的合并和接口合并一致

## 泛型

```ts
function getArr<T>(value:T,count:number):T[]{
    const arr:T[] = [];
    for(let i=0;i<count;i++){
        arr.push(value);
    }
    return arr;
}

```

### 多个泛型参数

```ts
function updateArr<T,U>(t:[T,U]):[U,T]{ //接受元组
     return [t[1],t[0]] 
}
console.log(updateArr([true,"123"]));
```

### 泛型约束

```ts
//泛型约束，约束这个任意输入的类型，必须要有length属性
//表示形参必须拥有T所继承类的方法或者属性
interface ILength{
    length:number
}

function getLength<T extends ILength>(x:T):number{
    return x.length
}

```

### 泛型接口

```ts
//定义一个泛型接口

//约束方法
interface IArr{
    <T>(vlue:T,count:number):Array<T>
}
interface IArr<T>{
    (vlue:T,count:number):Array<T>
}

let getArr1:IArr = function<T>(value:T,count:number):T[]{
    const arr:T[] = [];
    for(let i=0;i<count;i++){
        arr.push(value);
    }
    return arr;
}

//约束属性
interface YPerson<T>{
    name:T;
}
let p:YPerson<String>={
    name:"123"
}
let p1:YPerson<number>={
    name:123
}
```

### 泛型类

```ts
class Human<T>{
    name:string |undefined
    age:T | undefined
    constructor(name:string,age:T) {
        this.name=name
        this.age = age
    }
}

const oldMan = new Human<String>("123","18")
const young = new Human<number>("123",123);
```

