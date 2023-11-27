vue2语法

```javascript
vite项目，导出对象

export default{
  data(){
    return{
      num:0,
      uname:"tom"
    }
  }
}
  <div>
    <p>{{ num }}</p>
    <p>{{ uname }}</p>
  </div>
```

## 模板语法

​	通过"Mustache"(双大括号)语法进行文本的插值

​	v-once指令为一次性插值，数据不会改变

​	v-html解析为html渲染

```html
<span>Message:{{msg}}</span>

<span v-once>Message:{{msg}}</span>

<P v-html="msg"></P>
```

属性绑定

​	v-bind指令进行属性值的绑定

```html
<p v-bind:id="id">111</p>
```

  直接绑定js表达式

```html
<button @click="id='d2'">change color </button>
<p>{{num + 1}}</p>//直接在mustache中加入js代码
<p>{{ uname.split('').reverse().join('') }}</p>
```

#### 动态参数 

也可以在指令参数中使用js表达式，用方括号括起来

```vue
v-bind 缩写 :
<a :[attributeName]="url"></a>

v-on 缩写 @
<button @[MouseEvent]="attributeName='class'">改变属性</button>
```

#### 计算属性

方法属性，编写一个函数，并以属性方式调用

```js
  computed:{//有依赖值(message)，如依赖值不变，就不会重新计算
    reverseMsg:function(){
      return this.message.split('').reverse().join('');
    }
  },
```

#### Getter

此为计算属性完整写法，简写方式默认只包含get方法

一般没有set方法，更改计算属性，一般都是只读

```js
  computed:{
    reverseMsg:{
        get:function(){
            return this.message.split('').reverse().join('');
          }
   	 }
  },
```

#### Setter

```js
      set:function(newVal: any){
        console.log(newVal);
      }
```

#### 侦听器

监听数据的变化，数据变化就会调用这个函数.

```js
//函数方式监听  
watch:{
    message:function(newVal,oldVal){
      console.log(newVal);
      console.log(oldVal);
    }
  }

//对象方式监听
  watch:{
    message:{
      immediate: true,//初始化的时候调用函数
      handler:function(newVal){
        console.log(newVal);
          if(newVal.length<5 || newVal.length>10){
            console.log("输入框的内容不能小于5或者大于10");
          }
      }
    },
    deep:true,//表示是否深度监听
  }

//使用字符串的形式，单独监听对象中对应的属性
"user.name":{
    handler:function(){}
}
```

#### Class和style绑定

通过布尔值的true，false来判断是否为标签绑定对应的类名

```html
//可以同时添加多个类名
<div :class="{类名:布尔值}"></div>

//会和静态类名合并
<div :class="{类名:布尔值}" class="类名"></div>

//将多个类名属性放在对象中
classObj:{
  active:true,
  hello:true,
}
<div :class="classObj"></div>

//通过computed属性来绑定属性
computed:{
  case:function(){
  return{
       active:this.actived&& !this.error,
       hello:this.error
     }
  }
}
<p :class="case">{{ message }}</p>
```

**数组语法**

数组里面可以放置对象

![image-20230428093414948](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230428093414948.png)

#### style样式绑定操作

内联样式，基本和类名一致

```html
//使用样式属性
data(){
	return{
		color:'red',
		fontSize:'30px'
	}
}
<div :style="{color:color,fontSize:fontSize}"></div>

//使用样式对象
<div :style="StyleObj"></div>
```

#### 条件渲染

```html
v-if="表达式"
v-else-if="表达式"
v-else="表达式"
```

 在<template>元素上使用v-if条件渲染分组

template是一个不可见的包裹元素，不会被渲染到界面上

![image-20230428095901037](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230428095901037.png)

#### v-for渲染一组元素

```html
data(){
  return{
    person:["tom","jack",'willian']
  }
}
<ul>
    //index获取元素下标,key获取元素键值
   <li v-for="(item,index,key) in person" :key="index">{{ item }}</li>
</ul>
```

### 数组更新检测 

![image-20230428112138319](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230428112138319.png)

### 事件处理

![image-20230429162023393](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230429162023393.png)

函数需要参数，但调用时没传入参数时，自动获取事件参数

### 事件修饰符

.stop 阻止事件冒泡传递，直接添加在click后面，添加前，会依次调用父元素和子元素的方法，给子元素添加后缀后，只会执行子元素方法.

```html
    <div @click="divClick">
      <button @click.stop="btnClick">按钮</button>
    </div>
```

.prevent阻止默认行为

只会执行submitClick方法，不会触发表单提交

```html
<form action="">
    <input type="submit" value="提交" @click.prevent="submitClick">
</form>
```

.once只触发一次回调函数

### 按键修饰符

![image-20230502105547175](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230502105547175.png)

@keyup.(keyCode | keyAlias)用来监听键盘的键帽

按下松开回车键后触发函数。

```html
<input type="text" @keyup.enter="keyUp">
```



### 表单输入绑定

v-model 双向绑定，当input中，msg值进行了改变，<h2>标签中的msg值也会对应的进行变化

![image-20230502100054081](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230502100054081.png)

![image-20230502101237950](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230502101237950.png)

```html
//v-model的原理
changeVal(e:any){
   console.log(e)
   this.msg.name=e.target.value;
}

<div>
    <input type="text" v-model="msg.name">
    <h2>{{ msg.name }}</h2>
    <input type="text" :value="msg.name" @input="changeVal">
</div>
```



### model表单控件的基本使用

1.复选框

只有单个勾选框时，v-model为布尔值

```html
  <div>
    <input type="checkbox" v-model="checked">
    <h2>{{ checked }}</h2>
  </div>
```

有多个勾选框的话，v-model为数组

勾选后将value添加至数组中

```html
    <input type="checkbox" v-model="fruits" value="apple">apple
    <input type="checkbox" v-model="fruits" value="pear">pear
    <input type="checkbox" v-model="fruits" value="melon">melon
```

2.单选框

绑定后，选中那个就会获取哪个的值

```html
    <input type="radio" v-model="sex" value="man">男
    <input type="radio" v-model="sex" value="women">女
```

3.选项框

单选，多选规则和之前的一致，需要将v-model绑定在select标签上

```html
    <select name="" id="" v-model="citys" multiple>
      <option value="shenzhen">深圳</option>
      <option value="changsha">长沙</option>
      <option value="guangzhou">广州</option>
    </select>
```



### model修饰符

.lazy修饰符，当输入框失去焦点后，再去同步输入框中的数据

```html
    <input type="text" v-model.lazy="msg" >
    <h2>{{ msg }}</h2>
```

.number修饰符，将输入框中的内容，自动转换为数字类型

```html
    <input type="text" v-model.number="counter">
    <h2>{{typeof counter }}</h2>
```

.trim修饰符，自动过滤掉输入框中的首尾空白字符(输入空格时不改变value)



## 组件基础

引入组件

<script lang=ts>标签要指定语言

```js
import Content from './components/Content.vue'
```

组件注册

```js
export default{
    
  components:{
    Content //(Content:Content),表示引入的组件名
  }
}
```

组件使用

```html
<template>
  <div>
    <Content></Content>
  </div>
</template>
```

### 组件数据的存放

通过Prop向子组件传递数据

```html
<Hello :message="msg"></Hello> //动态值
<Hello val="aaa"></Hello> //静态值
//在模板标签中，自定义传递的属性名和值
```

使用props属性引入父组件传入的值

```html
<script lang="ts">
    export default{
        props:["message"]
    }
</script>
//直接引用即可
<template>
    <div>Hello</div>
    <h2>{{ message }}</h2>
</template>
```

### prop的基本用法

![image-20230504114214720](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230504114214720.png)

prop为单项数据流，子组件的数据修改不会影响到父组件



### 子组件传值给父组件

#### 监听子组件事件$emit

​		**流程：子组件触发自定义函数传值->父组件监听对应函数->获取子函数返回值，并触发自己的函数，并将子函数的值传入到函数中**

子组件自定义函数，通过$emit将自定义事件的名称和数据发送到父组件

```vue
methods:{
      sendParent(){
          this.$emit('send',this.msg)//第一个为函数名，第二个为值
      }
}
//button触发函数，将数据提交
<button @click="sendParent">提交数据给父组件</button>
```

父组件监听自定义事件，获取默认值，在子组件事件触发后，调用自身的自定义函数

```vue
methods:{
    getChidMsg(val:String){
      console.log(val);
    }
}

<chid @send="getChidMsg"></chid>
```

#### 父组件访问子组件$refs

给元素或者子组件去注册一个“引用信息”,通过$refs去获取相应的dom元素

```html
<Hello :message="msg" ref="hello"></Hello>
<p ref="p"></p>

mounted(){
   console.log(this.$refs);//获取子组件
}
```

#### 子组件访问父组件和跟组件$parent,$root

```vue
mounted(){
      console.log(this.$parent); //可直接获取父组件(不建议，复用子组件会有多个父组件)
	  console.log(this.$root);//直接获取根组件
 }
```

### 通过插槽分发内容

#### 插槽的基本使用

子组件添加占位标签

```html
<template>
    <div>
        <h2>我是content组件内容</h2>
        <div>
            <slot></slot>
        </div>
    </div>
</template>
```

父组件为子标签配置对应内容

```html
<template>
  <div>
    <child>
      <button>按钮</button>
    </child>
    <child>
      <input type="text"/>
    </child>
  </div>
</template>
```

#### 具名插槽的使用

可以插入多个标签进行替代,一起作为替换元素进行替换

```html
<dick> <input type="text"/><h2>标题</h2></dick>
```

子组件为slot设置名称

```html
    <template>
        <div>
            <h2>我是content组件内容</h2>
            <div>
                <slot name="button"></slot>
                <slot name="h2"></slot>
                <slot name="input"></slot>
                
            </div>
        </div>
    </template>

```

父组件只能在template标签中设置替换的slot标签，使用v-slot:name来匹配对应的slot插槽

vue2直接在替换标签上使用slot:name来匹配插槽

父级模板里的所有内容都是在父级作用域中编译的；子模板里的所有内容都是在作用域中编译的

```html
    <child>
      <template v-slot:button>
        <button>按钮</button>
      </template>
      <template v-slot:input>
        <input type="text"/>
      </template>
      <template v-slot:h2>
        <h2>插槽</h2>
      </template>
    </child>
```

#### 备用内容

相当于插槽的默认值

子模组中直接添加标签即可

```html
<slot name="button"><button>默认按钮</button></slot>
```

#### 作用域插槽

​	绑定在"<slot>"元素上的attribute被称为插槽prop,在父级作用域中，我们可以使用带值的v-slot来定义我们提供的插槽prop的名字

通过v-bind进行数据绑定

```html
<slot :list="list"></slot>
```

父组件在template中通过v-slot来接受数据

```html
//default为slot名称，没有则为default
<dick>
  <template v-slot:default="slotProps">{{ slotProps }}</template>
</dick>
```

### Provide/Inject

可以实现跨级通信,默认不是响应式

```vue
provider:{
	message:"nihao"
}//祖先组件提供数据

provider(){
	return{
		message:this.message
	}
}//传输对象是将provider转换为函数

inject:['message'] //后代组件获取值
```

provider提供一个响应式对象或通过函数返回响应式数据，来实现数据响应式

```vue
data(){
	return{
		obj:{
			message:"helloWorld"
		}
	}
}

provider(){
	return{
		obj.this.obj //响应式对象
		message:()=>this.message //函数返回相应式数据,后代组件以函数的形式获取相应的值,最好使用computed属性获取值
	}
}
```

### 生命周期钩子

https://cn.vuejs.org/guide/essentials/lifecycle.html



### 组合式API

将同一个逻辑关注点相关代码收集在一起

```js
//组合式API
setup(){//组件被创建之前执行，setup中避免使用this
	let msg="nihao";//变量
    function changMsg(){
      msg="buhao";
    }//方法
    return {
      msg,
      changMsg
    };//暴露变量和方法
}
```

setup中的数据默认不是响应式的，和data()不一样

![image-20230505101447761](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230505101447761.png)

```vue
import{ref} from 'vue'
```

ref会返回一个带有value属性的对象，需要手动获取值

```vue
let counter = ref(0)
    function addCounter(){
      counter.value++
    }
//模板自动解析value值
<h2>
    {{counter}}
</h2>
```

![image-20230505102219580](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230505102219580.png)

#### setup中使用watch

引入方法

```html
import{ref,reactive,watch,watchEffect} from 'vue';
```

```js
    //watch侦听的响应式引用，回调函数
    watch(counter,(newVal,oldVal)=>{
      console.log("new"+newVal);
      console.log("old"+oldVal);
    
    });
    //watchEffect(回调函数)不需要指定监听的属性，组件初始化时会自动执行一次回调函数，自动收集依赖
    watchEffect(()=>{
      console.log(user.name);
    });
```

watch和watchEffect的区别：

1，watchEffect不需要指定监听属性，自动收集依赖，只要在回调中引用了响应式的属性，只要属性发生改变，回调就会执行

2，watch只能监听指定的属性

#### 使用computed

1，引入computed

 以函数的形式调用

```js
    const reverseMsg=computed(()=>{//返回一个带有value属性的对象
      return msg.value.split('').reverse().join('');
    });

	//对象中使用computed函数
    const user = reactive({
        name:"张三",
        age:18,
        reverseMsg:computed(()=>{//返回一个带有value属性的对象
      return msg.value.split('').reverse().join('');})
    });
```

#### 使用props参数

```html
//静态形式传值默认为字符串格式
<hello :message='message'></hello>
```

子组件接受参数，定义props，再在setup中获取props对象的值

```css
props:{
      message:{
       type:String,
       efault:'你好'
	}
},
setup(props){
    console.log(props.message);
},
```

因为props式相应式的，如果使用es6解构，就会消除prop的相应性

```vue
setup(props){
    console.log(props.message);
},
```

引入onUpdated监控状态变化，toRefs进行转换

通过refs转换后的对象就是响应式的了

```js
import {onUpdated,toRefs} from 'vue'
props:{
      message:{
       type:String,
       efault:'你好'
	}
},
    
setup(props){
    //大括号内为需要结构的属性，props中
	const {message} = toRefs(props);//返回一个响应式对象
	console.log(message.value);
	onUpdated(()=>{
		console.log(message.value);
	});
},
```

#### context参数

​	setup函数的第二个参数是context，context是一个普通的js对象，暴露了其他可能再setup中有用的值：

context不是响应式结构，可以通过es6结构

```js
export default{
	emits:['injectCounter']//是因为在子组件向父组件发送自定义事件的时候，使用“emits”选项声明它。
	setup(props,context){
        //Attribute(非响应式对象，等同于$attrs)
		console.log(context.attrs)

		//插槽(非响应式对象，等同于$slots)
		console.log(context.slots)

		//触发事件(方法，等同于$emit)
		console.log(context.emit)

		//暴露公共property(函数)
		console.log(context.expose)
		//当子组件返回一个渲染函数，但又想将属性暴露时，使用expose函数
		context.expose(){
			methods,attr
		}
		return ()=>h('div',counter.value)
    }
}
```

#### 使用provide-inject

![image-20230505225832609](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230505225832609.png)

从setup返回的refs再模板中访问时时被自动浅解包的，因此不应该在模板中使用.value

父组件

引入provide函数

```js
import{provide} from 'vue';

provide('name',name);//设置值和名称
```

子组件

映入provide函数

```js
import{inject} from 'vue';

const name = inject('name');//设置值和名称
```

也可设置用ref函数设置响应式数据

#### 单文件组件

”<script setup>“是在单文件组件(SFC)中使用组合式API的编译时语法糖，添加后里面的代码会被编译成组件"setup"函数中的内容

```html
//引入setup属性后，无需导出数据，子组件无需注册，导入后直接使用
<script setup lang="ts">
    import Hello from './components/Hello.vue';
    import{ref} from 'vue';	
    //定义变量，在模板使用时不需要暴露出去,模板直接使用
    const num = 20;
    //使用响应式变量时，还是需要从vue中引入
    const b = ref(10)
</script>
<template>
  <Hello/>
  <h2>{{ num }}</h2>
</template>
```



## VueRouter

**路由核心**:改变url，但是页面不进行整体刷新

路由表，是一个映射表，一个路由就是一组映射关系，key:value,key:表示路由，value:可以为funstion或者component

**安装路由**:npm install vue-router@4



### VueRouter的使用

配置路由配置

```js
import { createRouter, createWebHashHistory } from 'vue-router'
// 1. 定义路由组件.
// 也可以从其他文件导入
import Home from '../views/Home.vue'
import About from  '../views/About.vue'

// 2. 定义一些路由
// 每个路由都需要映射到一个组件。
// 我们后面再讨论嵌套路由。
const routes = [
  { path: '/', component: Home },
  { path: '/about', component: About },
]

// 3. 创建路由实例并传递 `routes` 配置
// 你可以在这里输入更多的配置，但我们在这里
// 暂时保持简单
const router = createRouter({
  // 4. 内部提供了 history 模式的实现。为了简单起见，我们在这里使用 hash 模式。
  history: createWebHashHistory(),
  routes, // `routes: routes` 的缩写
})
//导出路由
export default router;
```

main.ts装载router

```js
import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'//引入路由

const app = createApp(App)

app.use(router)//装载路由
app.mount('#app')
```

组件中使用路由

```vue
<script setup lang="ts">

</script>

<template>
  <div>
    <h1>Hello App!</h1>
    <p>
      <!--使用 router-link 组件进行导航 -->
      <!--通过传递 `to` 来指定链接 -->
      <!--`<router-link>` 将呈现一个带有正确 `href` 属性的 `<a>` 标签-->
      <!-- 使用一个自定义组件 router-link 来创建链接。这使得 Vue Router 可以在不重新加载页面的情况下更改 URL，处理 URL 的生成以及编码。 -->
      <router-link to="/">Go to Home</router-link>
      <router-link to="/about">Go to About</router-link>
    </p>
    <!-- 路由出口 -->
    <!-- 路由匹配到的组件将渲染在这里 -->
    <router-view></router-view>
  </div>
</template>


```

#### 带参数的动态路由

```vue
//带参数的路由 
{ path: '/user/:id', component:User}
```

传数据的routerLink

```vue
<router-link to="/user/123">Go to User</router-link>
```

页面加载完成后获取路由

```vue
<script>
    export default{
        mounted(){
            console.log(this.$route)
        }
    }
</script>
```

组合式api中获取当前路由，并获取值

```vue
<script setup lang="ts">
    import { useRoute } from "vue-router";
    console.log(useRoute().params.id);//useRoute返回一个对象，从对象中获取值
    
</script>
```

#### 路由404页面配置

```vue
  //正则表达式进行匹配所有路径，:path为动态值
  { path:'/:path(.*)', component:NotFound}
```

#### 路由正则表达式

```vue
  {
    // path:'/news/:id(\\d+)',
    // component:News

    //多参数
    // path:'/news/:id+',

    //参数可传可不传
    // path:'/news/:id*',

    //参数可传可不传,不能重复叠加参数
    // path:'/news/:id?',
    component:News
  }
```

#### 嵌套路由

在路由中的children属性里加入子路由

```vue
  {
    path:"/parent",
    component:Parent,
    children:[
      {
        path:"styleOne",
        component:StyleOne
      },
      {
        path:"styleTwo",
        component:StyleTwo
      }
    ]
  },
```

父组件通过子路由调用子组件

```vue
<template>
    <div>
        <h2>父组件</h2>
        <router-link to="/parent/styleOne">样式1</router-link>
        <router-link to="/parent/styleTwo">样式2</router-link>

        <router-view></router-view>
    </div>
</template>
```

#### 编程式导航

在vue实例中，可以通过$router(全局路由器)访问路由实例，(this.$router.push)

$route可以获取当前活跃的路由对象

通过js和$router实例来对跳转进行控制

```js
        methods:{
            goPage(){
                if(false){
                    //路径
                    this.$router.push('/');
                };
                //传入对象和值
                 this.$router.push({path:"/user/123"});
                //给路由设置姓名后，通过姓名跳转
                this.$router.push({name:"news",params:{id:123}})
                //带问号传参
                this.$router.push({path:"/path",query:{name:"zhangsan"}})
            }
        }
```

将当前页面替换为所跳转的页面，所以无法通过回退键回到替换前的页面

```js
this.$router.push({path:"/path",query:{name:"zhangsan"},replace:true})
//替换方法
this.$router.replace
```

![image-20230507125202312](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230507125202312.png)

#### 命名路由和命名视图

```html
 //通过name属性来访问路由
<router-link :to="{name:'laoge',params:{id:223}}">Go to page</router-link>

//路由
  {
    path:"/page/:id",
    name:"laoge",
    component:Page,
  },
```

路由同时展示多个视图

```vue
//通过name来确定展示视图    
<router-view name="shopTop"></router-view>
<router-view></router-view>
<router-view name="shopFooter"></router-view>  

{
    path:"/shop",
    components:{
      default:shopMain,
      shopTop:shopTop,
      shopFooter//key和val同名时可以这么写
    }
  },
```

#### 重定向和别名

```vue
{
    path:"/",
	alias:{'/111','/222'}, //起别名
    redirect:"/home",//路径重定向
	redirect:{name:"home"}//命名路由重定向
	redirect:(to: any)=>{ 
      console.log(to);
      return {path:"/home"};
    }
}
```

#### 路由组件传参

```
//路由prop传参
{
	path:"/shop/:id",
	component:shop,
	props:true //布尔值控制prop
}
//命名路由传参，通过对象控制
{
	path:"/shop/:id",
	components:{
		shop,
		shop2,
	},
	props:{shop:true,shop2:false}
}

//选项式api
props:['id'] //数组获取

//组合式api
const props = defineProps({ //函数获取
	id:String
})
```

#### 导航守卫

全局守卫

各路守卫

 每个路由设置的导航守卫

组件守卫

![image-20230508163241707](C:\Users\gyj\AppData\Roaming\Typora\typora-user-images\image-20230508163241707.png)

#### 路由懒加载

https://router.vuejs.org/zh/guide/advanced/lazy-loading.html



## 状态管理

index.ts

```js
//状态集中管理
//数据实现响应式
//如何在App组件中通过provider来提供数据
import{reactive} from 'vue';
const  store={
    state:reactive({
        msg:"helloWorld"
    }),
    updateMsg:function(){
        this.state.msg='你好'
    }
}

//导出仓库
export default store;
```

app.vue

```vue
<script>
import Home from './views/Home.vue';
import store from "./store";

export default{
  provide:{
    store,
  },
  components:{
    Home
  }
}
</script>

<template>
  <Home></Home>
</template>


<style scoped>
</style>

```

Home.vue

```vue
<template>
    <div>{{ store.state.msg }}</div>
    <button @click="updateMsg">改变messgae</button>
</template>
<script>
    export default{
        inject:['store'],
        methods: {
            updateMsg(){
                this.store.updateMsg();
            }
        },
    }
</script>
```

#### 使用fetch获取数据

https://www.ruanyifeng.com/blog/2020/12/fetch-tutorial.html

#### axios获取数据

https://www.axios-http.cn/docs/intro

## Proxy解决跨域问题

在外部服务器上获取数据

```js
created(){
    axios.get("/path/api/mmdb/movie/v3/list/hot.json?ct=%E9%95%BF%E6%B2%99&ci=70&channelId=4").then((res)=>{
        console.log(res);
    });
},
```

在vite.config.ts文件中配置代理服务器

在检测到/path路径后，会在前面加上target的地址

axios的实际访问url为"https://i.maoyan.com/path/api....",所以要将path替换

```ts
  //中转服务器
  server:{
    proxy:{
      '/path':{
        target:'https://i.maoyan.com',//替换的服务端地址
        changeOrigin:true,//开启代理，允许跨域
        rewrite:path=>path.replace(/^\/path/,'')//设置重写路径
      }
    }
  }
```

## vuex

核心就是store(仓库)

Vuex的状态储存式响应式的

不能直接改变store中的状态

$store来获取仓库数据,通过仓库中"mutations"属性的方法来改变数据，方便追踪

使用**store.commit("function")**方法来触发方法，改变state的状态

##  pinia

pinia的引入

```html
npm install pinia //安装pinia
```

在main.ts中引入pinia，引入到app中,

```js
import {createPinia} from 'pinia'
//创建一个仓库
const pinia = createPina()

app.use(pinia)
```

### Option Store

```js
import { defineStore } from "pinia";

//options store
const useAgeStore = defineStore('main',{
    state:()=>{ //相当于sotre的data数据,为了完整类型推理，推荐使用箭头函数
        return {age:30}
    },
    getters:{//相当于computed计算属性
        gettersAge(state){
            return state.age + 5;
        }
    },
    actions:{//相当于methods
        addAge(){
            //this指向对应的仓库
            this.age++;
        }
    }
})
```



### Setup Store

```js
//setup store
//setup(){}
export const userCounter=defineStore('counter',()=>{
    const counter = ref(30);//state
    const gettersCounter=computed(()=>{//getters
        return counter.value+5;
    });
    function addCounter(){//actions
        counter.value++;
    }
    return {counter,gettersCounter,addCounter}
});
```

vue中引用store

```vue
<script setup>
import {useAgeStore,userCounter} from '@/stores/index.js';
import {storeToRefs} from 'pinia';

const ageStore = useAgeStore();
const CounterSotre = userCounter();
console.log(ageStore);
console.log(CounterSotre);
//属性使用storeToRefs解构
const{counter,gettersCounter} = storeToRefs(CounterSotre);
//action直接解构
const{addCounter} = CounterSotre;
</script>
<template>
    <main>
        <h2>{{ ageStore.age }}</h2>
        <h2>{{ ageStore.gettersAge }}</h2>
        <button @click="ageStore.addAge">修改age值</button>

        <h2>{{counter }}</h2>
        <h2>{{gettersCounter }}</h2>
        <button @click="addCounter">修改age值</button>
    </main>
</template>
```

### State

state 被定义为一个返回初始状态的函数。这使得 Pinia 可以同时支持服务端和客户端。

修改方式：

https://pinia.vuejs.org/zh/core-concepts/state.html

1，直接修改

2，使用$path方法，传入对象修改

3，使用$path方法，传入函数修改

4，调用aciton中的函数修改

```vue
[...ageStore.arr,5] //...ageStore.arr表示store中的数组
```

### Getter

```js
getters:{//相当于computed计算属性
        gettersAge(){
            //this-->指向store实例,不能对返回值进行推导
            return this.age + 5;
        },
        gettersName(state){
            return this.gettersAge + state.name;
        },
        gettersAge2(state){//向getter获取参数,返回函数接收参数，没有缓存功能，和普通函数一样
            return (num)=> state.age+num;
        },
        //访问其他store中的getters
        getterCounter(){
            const userStore = userCounterStore();
            return userStore.gettersCounter
        }
    },
```

```html
<h2>{{ ageStore.gettersAge2(10) }}</h2>
<h2>{{ ageStore.gettersAge }}</h2>//获取的是getter的返回值
```

### Action

Action相当于组件中的method,可以通过defineStore()中的actions属性来定义，并且他们也是定义业务逻辑的完美选择

https://pinia.vuejs.org/zh/core-concepts/actions.htm88
