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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  var bottomBarTitles = ['首页', '阅读', '资料库', '我的'];
  int _tabIndex = 0; //当前下标
  var tabImages; //存储图标数组

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
  }

  ///创建标题
  Text getTabTitle(int curIndex) {
    return Text(bottomBarTitles[curIndex],
        style: TextStyle(
            color: curIndex == _tabIndex
                ? const Color(0xFF2FA0F0)
                : const Color(0xFFA5A7B6)));
  }

  ///创建ImageIcon
  ImageIcon getTabImage(String path, int index) {
    return ImageIcon(
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
  void initState() {
    super.initState();
    initData();
    _pageController = PageController(initialPage: this._tabIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      this._tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[IndexPage(), ReadPage(), MaterialPage(), MyPage()],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),//禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        fixedColor: Colors.white,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(title: getTabTitle(0), icon: getTabIcon(0)),
          BottomNavigationBarItem(title: getTabTitle(1), icon: getTabIcon(1)),
          BottomNavigationBarItem(title: getTabTitle(2), icon: getTabIcon(2)),
          BottomNavigationBarItem(title: getTabTitle(3), icon: getTabIcon(3))
        ],
      ),
    );
  }
}
