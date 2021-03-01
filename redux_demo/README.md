# redux_demo

Redux的结构和BLoC高度类似。  
状态：不可变 State--State  
事件：枚举或类 Event--Action  
逻辑：完成State转换 BLoC--Reducer  
注册：依靠context BLoCProvider--StoreProvider  
消费：BlocListener纯监听/BlocBuilder界面/BlocConsumer兼有--StoreConnector/onChange监听  
BLoC有multi系统的工具类，Redux未提供。  
BLoC提供了脚手架插件，可以快速创建模板代码。  
Redux在StoreConnector中提供了完整的状态生命周期回调。  
Redux异步Action需要借助redux_thunk。而BLoC的mapEventToState方法直接就是异步的。  

所以BLoC和Redux比较起来，两者在功能上并没有太大的差别，不过BLoC发布较早，所以使用者较多；而redux是flutter官方发布的，更新上相对有保障。  
从代码上来看，redux更偏向于库，只是提供一个能力，并未限制太多代码结构，而且页面层的处理还都是另外通过flutter_redux提供的；而BLoC偏向于框架，将状态管理和代码结构放到了一起。  
