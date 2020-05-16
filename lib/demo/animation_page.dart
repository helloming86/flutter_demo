import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Animation对象是Flutter动画库中的一个核心类，它生成指导动画的值。
// Animation对象有状态。可以通过访问其value属性获取动画的当前值。
// Animation对象本身和UI渲染没有任何关系。
// Animation对象知道动画的当前状态（例如，它是开始、停止还是向前或向后移动），但它不知道屏幕上显示的内容。
// AnimationController管理Animation。
// CurvedAnimation 将过程抽象为一个非线性曲线.
// Tween在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween可能会生成从红到蓝之间的色值，或者从0到255。
// 使用Listeners和StatusListeners监听动画状态改变。
// 本例，通过addListener()、addStatusListener()和setState()给widget添加基础的动画。
// 每次动画生成一个新数字时，监听函数都会调用setState()。
// 使用addStatusListener来处理动画状态更改的通知，例如启动、停止或反转方向。
// 当动画完成或返回其开始状态时，通过反转方向来无限循环运行动画。


class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  // 创建Flutter动画Animation抽象类，拥有其当前值和状态(完成或停止)
  Animation<double> animation;
  // 创建Flutter动画控制类AnimationController，拥有控制动画的方法
  // forward() 启动动画 reverse({double from}) 倒放动画 reset() 重置动画 stop({bool canceled = true}) 停止动画
  // vsync 参数 存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
  AnimationController controller;
  // 创建Flutter动画状态类AnimationStatus
  AnimationStatus animationStatus;
  double animationValue;
  @override
  void initState() {
    super.initState();
    // Flutter 控制类 初始化设置
    controller = AnimationController(
      // vsync对象会绑定动画的定时器到一个可视的widget，所以当widget不显示时，动画定时器将会暂停，
      // 当widget再次显示时，动画定时器重新恢复执行，这样就可以避免动画相关UI不在当前屏幕时消耗资源。
      // 如果要使用自定义的State对象作为vsync时，请包含TickerProviderStateMixin。
      vsync: this,
      duration: Duration(seconds: 10),
    );
    // Flutter 基础类 初始化设置
    // Tween.animate()需要传入控制器对象
    // 初始化时添加监听器
    // addListener 动画的值发生变化时被调用
    // addStatusListener 动画状态发生变化时被调用
    // 使用Tween对象，需调用其animate()方法，传入一个控制器对象。
    animation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((status) {
        setState(() {
          animationStatus = status;
        });
      });
  }

  @override
  void dispose() {
    // 动画完成时释放控制器以防止内存泄漏。
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animation"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                controller.reset();
                controller.forward();
              },
              child: Text(
                'Start',
                textDirection: TextDirection.ltr,
              ),
            ),
            Text(
              'Status:' + animationStatus.toString(),
              textDirection: TextDirection.ltr,
            ),
            Text(
              'Value:' + animationValue.toString(),
              textDirection: TextDirection.ltr,
            ),
            Container(
              height: animation.value,
              width: animation.value,
              child: FlutterLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
