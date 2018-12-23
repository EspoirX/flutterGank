import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gank/bean/TodayGank.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    //_requestTodayGank();

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
              new Text(" News", style: new TextStyle(color: Color(0xFF4E5780)))
            ],
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.more_vert),
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
        body: new GankListView());
  }
}

class GankListView extends StatefulWidget {
  @override
  _GankListViewState createState() => _GankListViewState();
}

class _GankListViewState extends State<GankListView> {
  List<TodayGank> gankList = new List<TodayGank>();
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
    return new Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: new ListView.separated(
          itemCount: gankList.length,
          itemBuilder: (BuildContext context, int index) {
            return loadItemHolder(gankList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return divider1;
          }),
    );
  }

  loadItemHolder(TodayGank info) {
    String createdAt = info.createdAt;
    createdAt = createdAt.substring(0, createdAt.indexOf('T'));

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          info.desc,
          style: new TextStyle(
              color: Color(0xFF404450), fontSize: 16, height: 1.1),
        ),
        nineImageWidget(info),
        new Stack(
          children: <Widget>[
            new Align(
                alignment: Alignment.centerLeft,
                child: new Text(info.who,
                    style:
                        new TextStyle(color: Color(0xFFC3C5D0), fontSize: 13))),
            new Align(
                alignment: Alignment.centerRight,
                child: new Text(createdAt,
                    style:
                        new TextStyle(color: Color(0xFFC3C5D0), fontSize: 13))),
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
              ? new Image.network(imageUrl,
                  fit: BoxFit.cover, width: screenWidth / 3)
              : new Image.network(imageUrl,
                  fit: BoxFit.cover, width: cellWidth, height: cellWidth);
          rowArr.add(new Padding(
            padding: const EdgeInsets.all(2.0),
            child: image,
          ));
        }
      }
      rows.add(rowArr);
    }
    for (var row in rows) {
      _imgList.add(new Row(
        children: row,
      ));
    }
    return new Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 20.0),
      child: new Column(
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
    Dio dio = new Dio();
    Response response = await dio.get(url);
    var result = response.data['results'];

    List androidJson = result['Android'];
    List appJson = result['App'];
    List iOSJson = result['iOS'];
    List videoJson = result['休息视频'];
    List dataJson = result['拓展资源'];
    List recommendJson = result['瞎推荐'];
    List welfareJson = result['福利'];

    List<TodayGank> androidList = new List<TodayGank>();
    List<TodayGank> appList = new List<TodayGank>();
    List<TodayGank> iOSList = new List<TodayGank>();
    List<TodayGank> videoList = new List<TodayGank>();
    List<TodayGank> dataList = new List<TodayGank>();
    List<TodayGank> recommendList = new List<TodayGank>();
    List<TodayGank> welfareList = new List<TodayGank>();

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
}
