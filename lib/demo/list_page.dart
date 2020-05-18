import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const CITY_NAMES = ['北京','北京','上海','北京','上海','北京','苏州','北京','苏州','北京','广州','深圳','香港',];

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView滚动列表"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        // scrollDirection: Axis.horizontal, 水平方向滚动
        children: _buildList(),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

   Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20,),
      ),
    );
  }
}
