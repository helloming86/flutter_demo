import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LifeCirclePage extends StatefulWidget {
  @override
  _LifeCircleState createState() => _LifeCircleState();
}

class _LifeCircleState extends State<LifeCirclePage> {
  int _count = 0;
  @override
  void initState() {
    print("----initState----");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("----didChangeDependencies----");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("----build----");
    return Scaffold(
      appBar: AppBar(
        title: Text("页面生命周期"),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
              child: Text(
                "点我",
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(
              _count.toString(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(LifeCirclePage oldWidget) {
    print("----didUpdateWidget----");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("----deactivate----");
    super.deactivate();
  }

  @override
  void dispose() {
    print("----dispose----");
    super.dispose();
  }
}
