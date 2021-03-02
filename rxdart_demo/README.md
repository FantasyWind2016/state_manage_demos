# rxdart_demo

RxDart名义上是一个响应式无状态框架，但实际可以用来做状态管理。  
RxDart最终的效果更加接近于普通模式，编码习惯也接近。  
在页面状态上，主要是通过Subject更新页面数据，然后通过StreamBuilder刷新。  
在全局状态上，主要是使用Subject替换EventBus，再结合StreamBuilder刷新页面。  
RxDart和其他各类状态管理框架最大的区别在于，它的状态并没有注册到Provider上，页面状态就由页面自己创建并管理；全局状态一般是单例，在应用启动时自己初始化。  

当然如果喜欢其他框架那种管理方式，也可以实现类似Provider的方法注册到context中。但这也的方式比较适合全局状态，免除了单例的使用，对于页面状态而言反而繁琐。  
这一点和GetX是类似的。  

另外，因为所有的数据更新都是通过Subject，理论上只要StreamBuilder使用得到，就可以做到最细粒度的更新，和MobX一致。  

RxDart是基于Dart封装的代码库，而Dart版本更新其实远低于Flutter，所以它的版本更新风险并不大。  

RxDart比较大的一个问题在于有一定的学习成本，如果之前有用过其他语言ReactiveX系列的框架，那么就会比较容易上手。否则使用过程中可能会遇到一些莫名其妙的问题。  

Subject是对Stream的高效封装，其实在其他框架中，如果遇到需要Stream的场景，也可以混合RxDart来解决。  
