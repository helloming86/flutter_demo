import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/flutter_layout_page.dart';
import 'package:flutter_demo/demo/gesture_page.dart';
import 'package:flutter_demo/demo/launch_page.dart';
import 'package:flutter_demo/demo/less_group_page.dart';
import 'package:flutter_demo/demo/plugin_use.dart';
import 'package:flutter_demo/demo/res_page.dart';
import 'package:flutter_demo/demo/stateful_group_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("路由与导航"),
        ),
        body: RouteNavigator(),
      ),
      routes: <String, WidgetBuilder>{
        "less": (BuildContext context) => LessGroupPage(),
        "ful": (BuildContext context) => StatefulGroupPage(),
        "plugin": (BuildContext context) => PluginUsePage(),
        "layout": (BuildContext context) => FlutterLayoutPage(),
        "gesture": (BuildContext context) => GesturePage(),
        "res": (BuildContext context) => ResPage(),
        "launch": (BuildContext context) => LaunchPage(),
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
      child: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text("${byName?'':'不'}通过路由跳转"),
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _item("StatefulWidget与基础组件", StatefulGroupPage(), "ful"),
          _item("StateLessWidget与基础组件", LessGroupPage(), "less"),
          _item("Flutter布局开发", FlutterLayoutPage(), "layout"),
          _item("如何使用Flutter插件和包", PluginUsePage(), "plugin"),
          _item("检测手势及点击处理", GesturePage(), "gesture"),
          _item("Flutter导入使用资源文件", ResPage(), "res"),
          _item("打开第三方应用", LaunchPage(), "launch"),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if(byName){
            Navigator.pushNamed(context, routeName);
          } else {
             Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
