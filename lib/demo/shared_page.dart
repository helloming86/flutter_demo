import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPage extends StatefulWidget {
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  String countString = '';
  String localCount = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared_Preferences实现本地存储"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Count'),
          ),
          RaisedButton(
            onPressed: _getCounter,
            child: Text('Get Count'),
          ),
          Text(
            countString,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            localCount,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + " 1";
    });
    int counter = (preferences.getInt('counter') ?? 0) + 1;
    await preferences.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      localCount = preferences.getInt('counter').toString();
    });
  }
}
