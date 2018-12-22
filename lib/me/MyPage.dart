import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
          centerTitle: true,
          title: new Text("Me", style: new TextStyle(color: Color(0xFF4E5780))),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {},
              //标题颜色
              disabledColor: Color(0xFF707070),
              color: Color(0xFF707070),
            )
          ],
          leading: new IconButton(
            icon: new Icon(
              Icons.search,
              color: Color(0xFF707070),
            ),
            onPressed: null,
            //标题颜色
            disabledColor: Color(0xFF707070),
            color: Color(0xFF707070),
          ),
        ),
        body: new Text("4"));
  }
}
