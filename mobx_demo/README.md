# mobx_demo

1. MobX是单纯的状态管理组件，不具备路由管理功能；因此想要直接干掉StatefulWidget，就需要自备无context路由跳转组件；
2. 状态绑定是双向的，但响应式编程比较麻烦，只看到了通过autorun、ObservableStream的形式监听事件；
3. 因为mobx本身是前端状态管理组件，所以使用方式与习惯和前端相似；
