# bloc_demo

本文涉及的bloc版本为4.0.0，flutter_bloc版本4.0.1。  

## 和mobx对比

### 消费状态

bloc需要把bloc对象注册到context中，使用的地方再通过Class从context取。  
mobx需要自己手动创建store对象并持有，使用Observer的地方不需要依赖Class和context。  
对于普通的页面而言，逻辑层对象只是自己在用，确实没必要注册到context中，反而增加了使用复杂度。  

那么我们现在要问一下，为什么有的框架需要把state对象注册到context中？  
那是因为像bloc这样的框架，在绑定消费者widget的观察关系时，需要从context里取，这样才能通知消费者更新。如果你手动创建并持有state，那么消费者widget根本不知道你使用的state发生了变化。  
getx框架也是类似的，只不过GetBuilder相当于把BlocProvider和BlocBuilder合并到一起了，可以注册state并在builder里获取到。而bloc注册和获取是分开的。  
但是，抛弃掉BLoC官方的代码风格，我们也是可以在Widget中持有注册的bloc，这样至少在触发event的时候需要从context里取了，代码会少一点。  

bloc每次Map都会返回新的state，因此无论state中哪个数据变动，state都会变化，从而导致widget的build。虽然可以通过condition来判断是否要刷新，但相当于把筛选的工作交给了消费者来做。  
mobx通过store中数据的setter方法，可以控制只有使用了本次更新数据的Observer才会刷新。对于消费者很省心。  

### 触发事件

bloc需要先获取bloc对象，然后传入event对象。  
mobx是直接调用store的方法，不过该方法需要标注为@action。  

### 生产者角度
