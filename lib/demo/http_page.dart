import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPage extends StatefulWidget {
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  String showResult = '';
  Future<CommonModel> fetchPost() async {
    final response = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Http实现网络操作"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              fetchPost().then((value) {
                setState(() {
                  showResult = '请求结果： \n hideAppBar: ${value.hideAppBar} \n ${value.icon}';
                });
              });
            },
            child: Text(
              '点我',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Text(showResult),
        ],
      ),
    );
  }
}

class CommonModel {
  final bool hideAppBar;
  final String icon, title, url, statusBarColor;

  CommonModel(
      {this.hideAppBar, this.icon, this.title, this.url, this.statusBarColor}
      );

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      hideAppBar: json['hideAppBar'],
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
    );
  }

}