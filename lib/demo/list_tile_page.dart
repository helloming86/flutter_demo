import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const CITY_NAMES = {
  '城市1':['东城区','南城区','西城区','北城区','中城区','东城区','南城区','西城区','北城区',],
  '城市2':['东城区','南城区','西城区','北城区','中城区','东城区','南城区','西城区','北城区',],
  '城市3':['东城区','南城区','西城区','北城区','中城区','东城区','南城区','西城区','北城区',],
  '城市4':['东城区','南城区','西城区','北城区','中城区','东城区','南城区','西城区','北城区',],
  '城市5':['东城区','南城区','西城区','北城区','中城区','东城区','南城区','西城区','北城区',],
};


class ListTilePage extends StatefulWidget {
  _ListTilePageState createState() => _ListTilePageState();
}

class _ListTilePageState extends State<ListTilePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpansionTile折叠滚动列表"),
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
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_item(key, CITY_NAMES[key]));
    });
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
        title: Text(
          city,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
      children: subCities.map((subCity) => _buildSub(subCity)).toList(),
    );
  }

  Widget _buildSub(String subCity) {
    // 用法与SizedBox类似，
    // 只不过FractionallySizedBox的宽高是百分比大小，widthFactor，heightFactor参数就是相对于父控件的比例。
    // 注意设置FractionallySizedBox宽高后，其子组件设置的宽高将不起作用
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subCity),
      ),
    );
  }
  
}
