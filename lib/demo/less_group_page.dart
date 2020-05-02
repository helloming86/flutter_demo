import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
        title: "StateLessWidget与基础组件",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("StateLess Widget 与 基础组件"),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  "I am Text ",
                  style: textStyle,
                ),
                Icon(
                  Icons.android,
                  size: 50,
                  color: Colors.red,
                ),
                CloseButton(),
                BackButton(),
                Chip(
                  avatar: Icon(Icons.photo),
                  label: Text("StateLess Widget 与 基础组件"),
                ),
                Divider(
                  height: 10, // 分割线容器高度，而不是线高度
                  indent: 10, // 左侧间距
                  color: Colors.yellow,
                ),
                Card(
                  // 带有圆角阴影边框等效果的卡片
                  color: Colors.blue, // 颜色
                  elevation: 5, // 阴影
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("I am Card ", style: textStyle ,),
                  ),
                ),
                AlertDialog(
                  title: Text("盘他"),
                  content: Text("你这糙老头子坏得很"),
                ),
              ],
            ),
          ),
        ));
  }
}
