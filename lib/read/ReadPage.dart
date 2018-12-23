import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:nima/nima_actor.dart';

class ReadPage extends StatefulWidget {
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
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
              new Text(" Read", style: new TextStyle(color: Color(0xFF4E5780)))
            ],
          ),
        ),
        body: new NimaActor("assets/robot.nima",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "Flight"));
  }
}
