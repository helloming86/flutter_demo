import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterLayoutPage extends StatefulWidget {
  @override
  _FlutterLayoutPageState createState() => _FlutterLayoutPageState();
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // 任务管理器标题
        title: "Flutter布局开发",
        // 主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // MaterialApp 的主题 UI Widget 属性
        home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter布局开发"),
            // leading 组件的显示及处理逻辑
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          // 底部导航栏
          bottomNavigationBar: BottomNavigationBar(
            // 当前导航index
            currentIndex: _currentIndex,
            // 点击事件
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            // 导航列表
            items: [
              BottomNavigationBarItem(
                // 图标
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                // 激活选中图标
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                // 标题
                title: Text("首页"),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.list,
                  color: Colors.blue,
                ),
                title: Text("列表"),
              )
            ],
          ),
          // 浮动按钮
          floatingActionButton: FloatingActionButton(
            // 点击事件
            onPressed: null,
            child: Text("点我"),
          ),
          // RefreshIndicator 下拉刷新组件
          body: _currentIndex == 0
              ? RefreshIndicator(
                  // 下拉刷新组件的子组件
                  child: ListView(
                    children: <Widget>[
                      Container(
                        // Column 线性布局
                        child: Column(
                          children: <Widget>[
                            // Row 线性布局
                            Row(
                              children: <Widget>[
                                // ClipOval 圆形裁切 Widget
                                ClipOval(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      "http://www.devio.org/img/avatar.png",
                                    ),
                                  ),
                                ),
                                // Padding 容器 指定内边距
                                Padding(
                                  padding: EdgeInsets.all(10), // EdgeInsets 边缘设置
                                  // ClipRRect 圆角矩形裁剪
                                  child: ClipRRect(
                                    // Opacity 控制子组件透明度
                                    child: Opacity(
                                      opacity: 0.6, // 60%透明度
                                      child: Image.network(
                                        "http://www.devio.org/img/avatar.png",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Opacity(
                                      opacity: 0.6, // 60%透明度
                                      child: Image.network(
                                        "http://www.devio.org/img/avatar.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 100,
                              margin: EdgeInsets.all(10),
                              child: PhysicalModel(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                clipBehavior: Clip.antiAlias, // 抗锯齿
                                child: PageView(
                                  children: <Widget>[
                                    _item("Page1", Colors.deepPurple),
                                    _item("Page2", Colors.green),
                                    _item("Page3", Colors.red),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent),
                                    child: Text("宽度撑满"),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Stack 层叠布局
                      Stack(
                        children: <Widget>[
                          Image.network(
                            "http://www.devio.org/img/avatar.png",
                            width: 100,
                            height: 100,
                          ),
                          // Positioned 通常配合Stack使用
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Image.network(
                              "http://www.devio.org/img/avatar.png",
                              width: 36,
                              height: 36,
                            ),
                          )
                        ],
                      ),
                      // Wrap 流式布局 页面元素的宽度可以按照屏幕分辨率进行适配调整，但整体布局不变
                      // Wrap 会把超出屏幕显示范围的 Widget 自动换行，所以称为流式布局
                      Wrap(
                        spacing: 8, // 水平间距
                        runSpacing: 6, // 垂直间距
                        children: <Widget>[
                          _chip("Flutter"),
                          _chip("进阶"),
                          _chip("实战"),
                          _chip("携程"),
                          _chip("APP"),
                        ],
                      ),
                    ],
                  ),
                  // 舒心事件
                  onRefresh: _handleRefresh,
                )
              : Column(
                  children: <Widget>[
                    Text("列表"),
                    // Expanded 弹性布局 处理剩余空间
                    // Expanded.flex 弹性系数 为0或null，则 child 是没有弹性的
                    // Expanded.flex 大于0，有弹性
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.red),
                        child: Text("填充拉满高度"),
                      ),
                    )
                  ],
                ),
        ));
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    return null;
  }

  _item(String title, Color color) {
    // Container 容器类Widget
    return Container(
      alignment: Alignment.center, // 对齐方式
      decoration: BoxDecoration(color: color), // 容器的背景装饰
      child: Text(
        title,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  _chip(String label) {
    // Chip 标签/标识符 Widget
    return Chip(
      // 标签
      label: Text(label),
      // 图标
      avatar: CircleAvatar(
        // CircleAvatar 圆形图片组件
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
