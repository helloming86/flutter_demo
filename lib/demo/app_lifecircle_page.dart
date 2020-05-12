import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLifeCirclePage extends StatefulWidget {
  @override
  _AppLifeCircleState createState() => _AppLifeCircleState();
}

class _AppLifeCircleState extends State<AppLifeCirclePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("----build----");
    return Scaffold(
      // 顶部标题栏
      appBar: AppBar(
        title: Text("应用生命周期"),
        leading: BackButton(),
      ),
      // 主体
      body: Container(
        child: Text("应用生命周期"),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("state = $state");
    if(state==AppLifecycleState.paused) {
      print("App 进入后台");
    } else if (state == AppLifecycleState.resumed) {
      print("App 进入前台");
    } else if (state == AppLifecycleState.inactive) {
      print("App 进入非活动状态，比如正在接电话");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
