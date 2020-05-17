import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// 使用 show 只引入 timeDilation
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

// Hero指的是可以在路由(页面)之间“飞行”的widget。
// 使用Flutter的Hero widget创建hero动画。
// 将 hero从一个路由飞到另一个路由。
// 将 hero 的形状从圆形转换为矩形，同时将其从一个路由飞到另一个路由的过程中进行动画处理。
// Flutter中的Hero widget实现了通常称为 共享元素转换 或 共享元素动画的动画风格。

class RadialHeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadialExpansionDemo(),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(
    Rect begin,
    Rect end,
  ) {
    return MaterialRectCenterArcTween(
      begin: begin,
      end: end,
    );
  }

  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8, // 阴影大小
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                  tag: imageName,
                  createRectTween: _createRectTween,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return Container(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
        tag: imageName,
        createRectTween: _createRectTween,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder:
                  (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: opacityCurve.transform(animation.value),
                      child: _buildPage(context, imageName, description),
                    );
                  },
                );
              }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0是标准/正常的动画速度
    return Scaffold(
      appBar: AppBar(
        title: Text('Radial Hero Animation'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/radial_hero_animation/images/chair-alpha.png',
                'Chair'),
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/radial_hero_animation/images/binoculars-alpha.png',
                'Binoculars'),
            _buildHero(
                context,
                'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/radial_hero_animation/images/beachball-alpha.png',
                'Beach ball'),
          ],
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  RadialExpansion({Key key, this.maxRadius, this.child})
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  // 裁切布局
  // ClipRect 将 child 剪裁为给定的矩形大小
  // ClipRRect 将 child 剪裁为圆角矩形
  // ClipOval 如果 child 为正方形时剪裁之后是圆形，如果 child 为矩形时，剪裁之后为椭圆形
  // ClipPath 将 child 按照给定的路径进行裁剪
  // CustomClipper 并不是一个widget，但是使用CustomClipper可以绘制出任何我们想要的形状
  // SizedBox 能强制子控件具有特定宽度、高度或两者都有,使子控件设置的宽高失效
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  Photo({Key key, this.photo, this.onTap, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        // LayoutBuilder 返回一个根据父view 的size 创建的view
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.network(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
