import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 简化重构
// 功能逻辑职责分离
// 1.显示logo 2.定义Animation对象 3.渲染过渡效果
// AnimatedBuilder是渲染树中的一个独立的类。
// 与AnimatedWidget类似，AnimatedBuilder自动监听来自Animation对象的通知，
// 并根据需要将该控件树标记为脏(dirty)，因此不需要手动调用addListener()。


class AnimatedBuilderPage extends StatefulWidget {
  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

// 个人理解，initState()，相当于装子弹开枪。
// initState()方法创建一个AnimationController和一个Tween，然后通过animate()绑定它们。
// build()方法返回一个带有LogoWidget作为子对象的GrowTransition对象，以及一个用于驱动过渡的动画对象。
class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
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
    return GrowTransition(animation: animation, child: LogoWidget(),);
  }
}


// 1. 需要设置动画效果的UI模块，本例是Flutter的Logo
class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // EdgeInsets.symmetric() 指定垂直和水平方向的边距
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

// GrowTransition 本身是无状态的，同时拥有定义过渡动画所需的最终变量集合。
// 可以理解为静态的动画结构，或者动画逻辑文案/需求文档
// 2. 本例，Flutter的Logo要有动画效果，那么应该是怎样的动画效果呢？
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    );
  }
  
}

