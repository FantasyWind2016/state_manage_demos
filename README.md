# state_manage_demos

包含Flutter中不同方案的状态管理的demo。  

## 简单介绍

### 普通模式

全局使用EventBus同步状态；页面内手动setState。  
未进行页面分层。  

### GetX2.0.7

使用GetX进行状态管理。  

### MobX1.2.0

分为mobx和flutter_mobx两个库，mobx主要是提供响应式编程能力和基本的状态管理。flutter_mobx提供flutter中应用的工具。  
MobX的亮点在于通过生成代码，拦截state的每一个getter和setter，达到了精确刷新的目标。  

### BLoC4.0.0

BLoC是类似redux的框架，从架构图就能明显看出来，不过本身也做了一些精简，增加了一些易用性的调整。  

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
更新粒度|类|属性|类|默认类，Selector筛选，builder支持child|类|属性
学习成本|低|中等：标注，脚手架|低：标准流程|低|中等：模板代码|高：了解响应式编程
使用成本|低|低：少量模板代码|中等：模板代码|低|中等：模板代码|低
功能丰富度|有路由管理|无|提供MultiBlocProvider，插件|无|StoreConnector提供完整的生命周期|无
版本风险|劫持了系统方法|自动生成代码|使用人数据比较多|官方框架|官方社区维护|基于Dart
