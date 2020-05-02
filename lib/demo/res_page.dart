import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResPage extends StatefulWidget {
  @override
  _PluginUseState createState() => _PluginUseState();
}

class _PluginUseState extends State<ResPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter导入使用资源文件"),
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
            Image(
              width: 100,
              height: 100,
              image:  AssetImage("images/type_channelgs.png"),
            )
          ],
        ),
      ),
    );
  }
}