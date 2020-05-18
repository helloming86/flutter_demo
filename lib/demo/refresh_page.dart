import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


List<String> cityNames = [
  '北京',
  '上海',
  '广州',
  '深圳',
  '香港',
  '苏州',
  '杭州',
  '重庆',
  '郑州',
  '天津',
  '武汉',
];

class RefreshPage extends StatefulWidget {
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新及上拉加载更多"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          // scrollDirection: Axis.horizontal, 水平方向滚动
          children: _buildList(),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  void _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}
