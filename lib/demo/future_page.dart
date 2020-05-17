import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FuturePage extends StatefulWidget {
  _FuturePageState createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String showResult = '';
  Future<CommonModel> fetchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8decoder = Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter异步操作Future"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<CommonModel>(
        future: fetchPost(),
        builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Input a Url to start');
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return Text('ConnectionState is active');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Text('icon: ${snapshot.data.icon}'),
                    Text('statusBarColor: ${snapshot.data.statusBarColor}'),
                    Text('title: ${snapshot.data.title}'),
                    Text('url: ${snapshot.data.url}'),
                  ],
                );
              }
          }
          return null;
        },
      ),
    );
  }
}

class CommonModel {
  final bool hideAppBar;
  final String icon, title, url, statusBarColor;

  CommonModel(
      {this.hideAppBar, this.icon, this.title, this.url, this.statusBarColor});

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
