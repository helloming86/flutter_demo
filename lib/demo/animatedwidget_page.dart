import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 简化与重构
// 使用AnimatedWidget创建一个可重用动画的widget
// 相当于使用 AnimatedWidget类 代替 addListener()和setState() 来实现给Widget添加动画
// AnimatedWidget 类允许从setState()调用中的动画代码中分离出widget代码。
// AnimatedWidget 不需要维护一个State对象来保存动画。
// AnimatedWidget(基类)中会自动调用addListener()和setState()。

class AnimatedWidgetPage extends StatefulWidget {
  @override
  _AnimatedWidgetPageState createState() => _AnimatedWidgetPageState();
}

class _AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    animation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedLogo(animation: animation,);
  }
}

class AnimatedLogo extends AnimatedWidget{

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
  
}


