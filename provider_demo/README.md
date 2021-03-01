# provider_demo

遇到的问题：

- 在widget的回调方法中使用`Provider.of`获取model时，必须加上`listen:false`，否则会报错。也就是说该方法默认是监听的。  
- 未找到合适的方法可以单独的监听model的属性，比如监听网络请求返回成功后关闭当前界面；可以使用Consumer，在builder中处理，但builder方法还有child参数，有点冗余。另外这个builder方法不是专门给监听用的，不是异步执行，所以不能直接pop出页面，需要转为异步执行。  
- 刷新颗粒度有点大，这个问题和BLoC、GetX一样，只有MobX做到了精细化刷新。Consumer的监听是整个model，在监听成功后关闭页面的同时，其他监听也会rebuild页面。最后是需要使用Selector的selector+shouldRebuild来控制其他监听者不刷新。  
- 因为更新数据和页面必须调用notifyListeners方法，所以model中的代码难免有些累赘，尤其是有些setter方法。  

优点：  

- 使用Selector可以最大程度的控制刷新范围，但如果处处这样使用，难免太多复杂。所以肯定是要有取舍，只有比较复杂的页面，或者重要的页面特别优化一下。  
