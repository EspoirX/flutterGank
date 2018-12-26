import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gank/bean/TodayGank.dart';
import 'package:flutter_gank/network/DioManager.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //状态栏字体颜色
        brightness: Brightness.light,
        //阴影
        elevation: 0,
        //背景
        backgroundColor: Colors.white,
        //标题
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("G", style: TextStyle(color: Color(0xFF4286F4))),
            Text("e", style: TextStyle(color: Color(0xFFE84436))),
            Text("e", style: TextStyle(color: Color(0xFFFABC05))),
            Text("k", style: TextStyle(color: Color(0xFF34A853))),
            Text(" News", style: TextStyle(color: Color(0xFF4E5780)))
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            //标题颜色
            disabledColor: Color(0xFF707070),
            color: Color(0xFF707070),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: Color(0xFF707070),
          ),
          onPressed: null,
          //标题颜色
          disabledColor: Color(0xFF707070),
          color: Color(0xFF707070),
        ),
      ),
      body: GankListView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GankListView extends StatefulWidget {
  @override
  _GankListViewState createState() => _GankListViewState();
}

class _GankListViewState extends State<GankListView> {
  List<TodayGank> gankList = List<TodayGank>();
  double screenWidth;

  @override
  void initState() {
    if (gankList.length == 0) {
      _requestTodayGank();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    Widget divider1 = Divider(
      color: Color(0xFFF4F4F4),
      height: 32,
    );
    return RefreshIndicator(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ListView.separated(
            itemCount: gankList.length,
            itemBuilder: (BuildContext context, int index) {
              return loadItemHolder(gankList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return divider1;
            }),
      ),
      onRefresh: _handlerRefresh,
    );
  }

  loadItemHolder(TodayGank info) {
    String createdAt = info.createdAt;
    createdAt = createdAt.substring(0, createdAt.indexOf('T'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          info.desc,
          style: TextStyle(color: Color(0xFF404450), fontSize: 16, height: 1.1),
        ),
        nineImageWidget(info),
        Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text(info.who,
                    style: TextStyle(color: Color(0xFFC3C5D0), fontSize: 13))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(createdAt,
                    style: TextStyle(color: Color(0xFFC3C5D0), fontSize: 13))),
          ],
        )
      ],
    );
  }

  Widget nineImageWidget(TodayGank gank) {
    List<Widget> _imgList = []; //九宫格
    List<String> _images = gank.images;
    num len = _images == null ? 0 : _images.length;
    List<List<Widget>> rows = [];
    // 通过双重for循环，生成每一张图片组件
    for (var row = 0; row < getRow(len); row++) {
      // row表示九宫格的行数，可能有1行2行或3行
      List<Widget> rowArr = [];
      for (var col = 0; col < 3; col++) {
        // col为列数，固定有3列
        num index = row * 3 + col;
        double cellWidth = (screenWidth - 100) / 3;

        if (index < len) {
          String imageUrl = gank.type == "福利" ? gank.url : _images[index];
          Image image = _images.length == 1
              ? Image.network(imageUrl,
                  fit: BoxFit.cover, width: screenWidth / 3)
              : Image.network(imageUrl,
                  fit: BoxFit.cover, width: cellWidth, height: cellWidth);
          rowArr.add(Padding(
            padding: const EdgeInsets.all(2.0),
            child: image,
          ));
        }
      }
      rows.add(rowArr);
    }
    for (var row in rows) {
      _imgList.add(Row(
        children: row,
      ));
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 20.0),
      child: Column(
        children: _imgList,
      ),
    );
  }

  // 获取行数，n表示图片的张数
  int getRow(int n) {
    int a = n % 3;
    int b = n ~/ 3;
    if (a != 0) {
      return b + 1;
    }
    return b;
  }

  ///获取最新一天的干货
  Future _requestTodayGank() async {
    String url = "https://gank.io/api/today";
    var response = await DioManager.instance.get(url);
    var result = response['results'];
    List androidJson = result['Android'];
    List appJson = result['App'];
    List iOSJson = result['iOS'];
    List videoJson = result['休息视频'];
    List dataJson = result['拓展资源'];
    List recommendJson = result['瞎推荐'];
    List welfareJson = result['福利'];

    List<TodayGank> androidList = List<TodayGank>();
    List<TodayGank> appList = List<TodayGank>();
    List<TodayGank> iOSList = List<TodayGank>();
    List<TodayGank> videoList = List<TodayGank>();
    List<TodayGank> dataList = List<TodayGank>();
    List<TodayGank> recommendList = List<TodayGank>();
    List<TodayGank> welfareList = List<TodayGank>();

    for (int i = 0; i < androidJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(androidJson[i]);
      androidList.add(todayGank);
    }
    for (int i = 0; i < appJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(appJson[i]);
      appList.add(todayGank);
    }
    for (int i = 0; i < iOSJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(iOSJson[i]);
      iOSList.add(todayGank);
    }
    for (int i = 0; i < videoJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(videoJson[i]);
      videoList.add(todayGank);
    }
    for (int i = 0; i < dataJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(dataJson[i]);
      dataList.add(todayGank);
    }
    for (int i = 0; i < recommendJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(recommendJson[i]);
      recommendList.add(todayGank);
    }
    for (int i = 0; i < welfareJson.length; i++) {
      TodayGank todayGank = TodayGank.fromJson(welfareJson[i]);
      welfareList.add(todayGank);
    }
    setState(() {
      gankList.clear();
      gankList.addAll(androidList);
      gankList.addAll(appList);
      gankList.addAll(iOSList);
      gankList.addAll(videoList);
      gankList.addAll(dataList);
      gankList.addAll(recommendList);
      gankList.addAll(welfareList);
    });
  }

  ///刷新列表
  Future _handlerRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      _requestTodayGank();
    });
  }
}
