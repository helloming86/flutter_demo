import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// 使用 show 只引入 timeDilation
import 'package:flutter/scheduler.dart' show timeDilation;

// Hero指的是可以在路由(页面)之间“飞行”的widget。
// 使用Flutter的Hero widget创建hero动画。
// 将 hero从一个路由飞到另一个路由。
// 将 hero 的形状从圆形转换为矩形，同时将其从一个路由飞到另一个路由的过程中进行动画处理。
// Flutter中的Hero widget实现了通常称为 共享元素转换 或 共享元素动画的动画风格。

// 在不同路由中使用两个 hero widget，但使用匹配的标签来实现动画。
// 导航器管理包含应用程序路由的栈。
// 从导航器栈中推入或弹出路由会触发动画。
// Flutter框架会计算一个补间矩形 ，用于定义在从源路由“飞行”到目标路由时 hero 的边界。在“飞行”过程中， hero 会移动到应用程序上的一个叠加层，以便它出现在两个页面之上。

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HeroAnimation(),
    );
  }
}

class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizedBox 能强制子控件具有特定宽度、高度或两者都有,使子控件设置的宽高失效
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo, // 很重要的参数，tag 是 关联两个Hero动画的 标签FLag
        child: Material(
          color: Colors.transparent,
          // InkWell有的叫溅墨效果，有的叫水波纹效果。
          // 使用场景是给一些无点击事件的部件添加点击事件时使用（也支持长按、双击等事件），
          // 同时你也可以去修改它的颜色和形状。
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0是标准/正常的动画速度
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'http://www.devio.org/img/avatar.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Flippers Page'),
                  ),
                  body: Container(
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: PhotoHero(
                      photo: 'http://www.devio.org/img/avatar.png',
                      width: 100.0,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
