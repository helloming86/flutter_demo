import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/animatedbuilder_page.dart';
import 'package:flutter_demo/demo/animatedwidget_page.dart';
import 'package:flutter_demo/demo/animation_page.dart';
import 'package:flutter_demo/demo/app_lifecircle_page.dart';
import 'package:flutter_demo/demo/flutter_layout_page.dart';
import 'package:flutter_demo/demo/gesture_page.dart';
import 'package:flutter_demo/demo/hero_page.dart';
import 'package:flutter_demo/demo/image_use.dart';
import 'package:flutter_demo/demo/launch_page.dart';
import 'package:flutter_demo/demo/less_group_page.dart';
import 'package:flutter_demo/demo/life_circle_page.dart';
import 'package:flutter_demo/demo/photo_app_page.dart';
import 'package:flutter_demo/demo/plugin_use.dart';
import 'package:flutter_demo/demo/radial_hero_page.dart';
import 'package:flutter_demo/demo/res_page.dart';
import 'package:flutter_demo/demo/stateful_group_page.dart';

void main() => runApp(DynamicTheme());

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness _brightness = Brightness.light;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: "Montserrat", // 全局更换字体
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("路由与导航"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  if (_brightness == Brightness.dark) {
                    _brightness = Brightness.light;
                  } else {
                    _brightness = Brightness.dark;
                  }
                });
              },
              child: Text(
                "切换主题ABC",
                style: TextStyle(fontFamily: "Montserrat"),
              ), // 局部更换字体
            ),
            RouteNavigator(),
          ],
        ),
      ),
      routes: <String, WidgetBuilder>{
        "less": (BuildContext context) => LessGroupPage(),
        "ful": (BuildContext context) => StatefulGroupPage(),
        "plugin": (BuildContext context) => PluginUsePage(),
        "layout": (BuildContext context) => FlutterLayoutPage(),
        "gesture": (BuildContext context) => GesturePage(),
        "res": (BuildContext context) => ResPage(),
        "launch": (BuildContext context) => LaunchPage(),
        "circle": (BuildContext context) => LifeCirclePage(),
        "appCircle": (BuildContext context) => AppLifeCirclePage(),
        "image": (BuildContext context) => ImageUse(),
        "animation": (BuildContext context) => AnimationPage(),
        "animated": (BuildContext context) => AnimatedWidgetPage(),
        "animatedBuilder": (BuildContext context) => AnimatedBuilderPage(),
        "hero": (BuildContext context) => HeroPage(),
        "radialHero": (BuildContext context) => RadialHeroPage(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          children: <Widget>[
            SwitchListTile(
                title: Text("${byName ? '' : '不'}通过路由跳转"),
                value: byName,
                onChanged: (value) {
                  setState(() {
                    byName = value;
                  });
                }),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _item("StatefulWidget与基础组件", StatefulGroupPage(), "ful"),
                  _item("StateLessWidget与基础组件", LessGroupPage(), "less"),
                  _item("Flutter布局开发", FlutterLayoutPage(), "layout"),
                  _item("如何使用Flutter插件和包", PluginUsePage(), "plugin"),
                  _item("检测手势及点击处理", GesturePage(), "gesture"),
                  _item("Flutter导入使用资源文件", ResPage(), "res"),
                  _item("打开第三方应用", LaunchPage(), "launch"),
                  _item("页面声明周期", LifeCirclePage(), "circle"),
                  _item("APP声明周期", AppLifeCirclePage(), "appCircle"),
                  _item("拍照APP", PhotoAppPage(), "photoApp"),
                  _item("图片的使用", ImageUse(), "image"),
                  _item("Flutter动画-使用监听器和setstate渲染重绘", AnimationPage(), "animation"),
                  _item("Flutter动画-使用AnimatedWidget渲染重绘", AnimatedWidgetPage(), "animated"),
                  _item("Flutter动画-使用AnimatedBuilder渲染重绘(推荐)", AnimatedBuilderPage(), "animatedBuilder"),
                  _item("Hero动画-标准动画", HeroPage(), "hero"),
                  _item("Hero动画-径向动画", RadialHeroPage(), "radialHero"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
