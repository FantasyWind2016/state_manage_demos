# 状态管理演示Demo

本项目使用了不同的框架完成同一功能Demo的状态管理，用来比较不同框架在状态管理中功能的异同点。  
功能包含了全局账户信息，登录页表单，修改用户信息页数据反显。  

## 框架介绍

因为目前项目使用的Flutter版本是1.12.13，所以选择了合适的框架版本，而不是最新版本。  

### 普通模式

全局状态使用EventBus同步状态；页面内手动setState。  
未进行页面分层。  

### GetX2.0.7

GetX的低版本不太稳定，存在一些比较明显的问题。  
本身不支持响应式编程。  
本身包含了路由管理，和基本的弹框，所以可以完全抛弃StatefulWidget。  
该版本的GetX是自己管理所有的state对象，没有借助InheritedWidget，所以逻辑比较清晰，出现问题也好排查。  

### MobX1.2.0

分为mobx和flutter_mobx两个库，mobx主要是提供响应式编程能力和基本的状态管理。flutter_mobx提供flutter中应用的工具。  
通过生成代码，拦截state的每一个getter和setter，达到了精确刷新的目标。  
使用上的优点在于不用在更细数据时写notify代码。  
因为mobx中，state和widget的绑定关系是通过拦截getter和setter方法做到的，所以在页面使用时，Observer不需要声明state的类型。  
虽然自带了响应式编程的能力，但使用起来总感觉怪怪的，没有RxDart方便。  
需要脚手架来自动生成和更新模板代码。不过因为MobX的逻辑并未依赖系统框架，所以Flutter升级版本导致不兼容的问题应该不多。  

### BLoC4.0.0

BLoC是类似redux的框架，从架构图就能明显看出来，不过本身也做了一些精简，增加了一些易用性的调整。  
所有的状态对象都是通过InheritedWidget的方式共享的，所以对context是强依赖。这一点如果是之前用了GetX或者MobX的人会很难受。  
类似Redux的状态流转过程，总是让人觉得要写好多模板代码。  

### Provider4.0.0

功能上相较其他框架比较简单，除了刷新颗粒度因为运行机制问题无法完全解决；还是在最大范围内提供了优化的方案。  
其他的缺点可以结合别的框架一起使用，或者自己手动造一些轮子。  

### Flutter_Redux0.7.0

Redux基本就是Redux官方版的BLoC，除了命名上的差别，其他的也就是工具类的丰富程度了。  
另外一个主要的点是Redux的异步操作需要借助redux_thunk，而BLoC自己解决了。  

### RxDart0.25.0

实际上就是个响应式编程框架，拿来做状态管理需要配合StreamBuilder，抛弃EventBus。  

## 功能比较

框架名称|GetX|MobX|BLoC|Provider|Redux|RxDart
---|:--|:--|:--|:--|:--|:--
Github Star|2.5k|1.8k|6.5k|3.4k|1.4k|2.8k
Pub Likes|3359|flutter_mobx:285,mobx:539|flutter_bloc:1807,bloc:812|3512|flutter_redux:219,redux:176|945
全局状态对象管理|Get.put()|单例|BlocProvider|ChangeNotifierProvider|StoreProvider|单例
是否依赖context|不依赖|不依赖|依赖|依赖|依赖|不依赖
页面状态对象管理|手动创建|手动创建|BlocProvider|ChangeNotifierProvider|StoreProvider|手动创建
页面使用方式|GetBuilder\<T>|Observer|BlocBuilder\<B, S>|Consumer\<T>|StoreConnector\<T>|StreamBuilder(stream:)
代码侵入|继承GetController|继承Store，生成代码|继承Bloc，有模板代码|继承ChangeNotifier|模板代码|无|
触发刷新方式|update(this)|自动|mapEventToState|notifyListeners|reducer()|自动
是否可以独立监听|不|Observable、响应式编程|不可，BlocListener\<B, S>|不可|store.onChange|Subject.listen
是否可以抛弃Stateful|可以|路由类似操作依赖context|路由类似操作依赖context|手动保存context|手动保存context|手动保存context|
更新粒度|类|属性|默认类，condition筛选|默认类，Selector筛选，builder支持child|类|属性
学习成本|低|中等：标注，脚手架|低：标准流程|低|中等：模板代码|高：了解响应式编程
使用成本|低|低：少量模板代码|中等：模板代码|低|中等：模板代码|低
功能丰富度|有路由管理|无|提供MultiBlocProvider，插件|无|StoreConnector提供完整的生命周期|无
版本风险|劫持了系统方法|自动生成代码|使用人数据比较多|官方框架|官方社区维护|基于Dart


## 总结

在使用体验上面，BLoC/Provider/Redux这三个比较类似，BLoC发展相对成熟，而Provider现在是官方框架，Redux相对处于弱势。但Provider只是提供了状态管理，对代码没有限制；而BLoC、Redux的代码模板或许更适合多人协作式的开发模式。  
MobX的思路独树一帜，效果也是最好的；但是感觉比较小众，如果是个人项目，没有什么维护压力，使用起来会比较舒服。但是这个发展现状比较尴尬，因为重要的项目会担心维护问题不敢用，小的项目又不会对页面性能有这么高的要求。  
GetX的目标不仅仅是为了解决状态管理问题，它想要的是在整体上给Flutter开发提效，所以提供了很多工具方法。个人使用会很高效。团队协作的话，可能会和团队自己的轮子功能重复，这就要具体问题具体分析了。  
RxDart说到底只是响应式编程工具框架，想要拿来做状态管理或者代码框架，就需要手撸一些辅助工具。  