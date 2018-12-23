import 'package:flutter/material.dart';

class MaterialPage extends StatefulWidget {
  @override
  _MaterialPageState createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPage> {
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
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text("G", style: new TextStyle(color: Color(0xFF4286F4))),
              new Text("e", style: new TextStyle(color: Color(0xFFE84436))),
              new Text("e", style: new TextStyle(color: Color(0xFFFABC05))),
              new Text("k", style: new TextStyle(color: Color(0xFF34A853))),
              new Text(" Repo", style: new TextStyle(color: Color(0xFF4E5780)))
            ],
          ),
        ),
        body: new Text("3"));
  }
}
