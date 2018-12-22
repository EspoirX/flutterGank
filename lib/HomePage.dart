import 'package:flutter/material.dart';
import 'package:flutter_gank/index/IndexPage.dart';
import 'package:flutter_gank/material/MaterialPage.dart';
import 'package:flutter_gank/me/MyPage.dart';
import 'package:flutter_gank/read/ReadPage.dart';

class HomePage extends StatefulWidget {
  final String barTitle;

  const HomePage({Key key, this.barTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bottomBarTitles = ['首页', '阅读', '资料库', '我的'];
  int _tabIndex = 0; //当前下标
  var tabImages; //存储图标数组
  var pageBodys; //存储page数组

  void initData() {
    //二维数组存储图标
    tabImages = [
      [
        getTabImage('images/ic_home.png', 0),
        getTabImage('images/ic_home_selected.png', 1)
      ],
      [
        getTabImage('images/ic_book.png', 0),
        getTabImage('images/ic_book_selected.png', 1)
      ],
      [
        getTabImage('images/ic_data.png', 0),
        getTabImage('images/ic_data_selected.png', 1)
      ],
      [
        getTabImage('images/ic_man.png', 0),
        getTabImage('images/ic_man_selected.png', 1)
      ]
    ];
    //存储page
    pageBodys = [
      new IndexPage(),
      new ReadPage(),
      new MaterialPage(),
      new MyPage()
    ];
  }

  ///创建标题
  Text getTabTitle(int curIndex) {
    return new Text(bottomBarTitles[curIndex],
        style: new TextStyle(
            color: curIndex == _tabIndex
                ? const Color(0xFF2FA0F0)
                : const Color(0xFFA5A7B6)));
  }

  ///创建ImageIcon
  ImageIcon getTabImage(String path, int index) {
    return new ImageIcon(
      AssetImage(path),
      size: 20,
      color: index == 0 ? const Color(0xFFA5A7B6) : const Color(0xFF2FA0F0),
    );
  }

  ///获取ImageIcon
  ImageIcon getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new Scaffold(
      body: pageBodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        fixedColor: Colors.white,
        onTap: (index) {
          setState(() {
            _tabIndex = index; //更新下标
          });
        },
        items: [
          new BottomNavigationBarItem(
              title: getTabTitle(0), icon: getTabIcon(0)),
          new BottomNavigationBarItem(
              title: getTabTitle(1), icon: getTabIcon(1)),
          new BottomNavigationBarItem(
              title: getTabTitle(2), icon: getTabIcon(2)),
          new BottomNavigationBarItem(
              title: getTabTitle(3), icon: getTabIcon(3))
        ],
      ),
    );
  }
}
