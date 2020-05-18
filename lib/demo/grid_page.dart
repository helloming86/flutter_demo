import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const CITY_NAMES = ['北京','北京','上海','北京','上海','北京','苏州','北京','苏州','北京','广州','深圳','香港',];

class GridPage extends StatefulWidget {
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView网格滚动列表"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
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
      margin: EdgeInsets.only(bottom: 5, right: 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20,),
      ),
    );
  }
}
