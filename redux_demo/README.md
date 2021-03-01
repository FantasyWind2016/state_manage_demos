# redux_demo

Redux的结构和BLoC高度类似。  
状态：不可变 State--State  
事件：枚举或类 Event--Action  
逻辑：State转换 BLoC--Reducer  
注册：依靠context BLoCProvider--StoreProvider  
消费：BlocListener纯监听/BlocBuilder界面/BlocConsumer兼有--StoreConnector/onChange监听  
BLoC有multi系统的工具类，Redux未提供。  
Redux在StoreConnector中提供了完整的状态生命周期回调。  
