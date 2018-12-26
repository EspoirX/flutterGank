import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_gank/SplashPage.dart';

void main() {
  runApp(new MyApp());
  if (Platform.isAndroid) {
    //透明状态栏
    SystemUiOverlayStyle style =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gank',
        theme:
            ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.black),
        home: SplashPage() // HomePage(barTitle: 'Geek News'),
        );
  }
}
