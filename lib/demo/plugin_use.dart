import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class PluginUsePage extends StatefulWidget {
  @override
  _PluginUseState createState() => _PluginUseState();
}

class _PluginUseState extends State<PluginUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("使用Flutter包和插件"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: ColorUtil.color('#889900')
              ),
            ),
          ],
        ),
      ),
    );
  }
}