import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String barTitle;

  const HomePage({Key key, this.barTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //状态栏字体颜色
        brightness: Brightness.light,
        //阴影
        elevation: 0,
        //背景
        backgroundColor: Colors.white,
        //标题
        title: new Text(
          widget.barTitle,
          textAlign: TextAlign.center,
          style: new TextStyle(color: Colors.blue),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.group_work),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          //标题颜色
          disabledColor: Colors.blue,
        ),
      ),
      body: new Text("aaaa"),
    );
  }
}
