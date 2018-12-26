import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_gank/bean/CategoryWow.dart';
import 'package:flutter_gank/bean/XianDuInfo.dart';
import 'package:flutter_gank/network/DioManager.dart';

class ReadPage extends StatefulWidget {
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<CategoryWow> categoryList = new List<CategoryWow>();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _requestCategory();
    _tabController =
        new TabController(length: categoryList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              Text("G", style: new TextStyle(color: Color(0xFF4286F4))),
              Text("e", style: new TextStyle(color: Color(0xFFE84436))),
              Text("e", style: new TextStyle(color: Color(0xFFFABC05))),
              Text("k", style: new TextStyle(color: Color(0xFF34A853))),
              Text(" Read", style: new TextStyle(color: Color(0xFF4E5780)))
            ],
          ),
          bottom: TabBar(
            labelColor: Color(0xFF2FA0F0),
            controller: _tabController,
            indicatorColor: Color(0xFF2FA0F0),
            unselectedLabelColor: Color(0xFFA5A7B6),
            indicatorPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            isScrollable: true,
            tabs: categoryList.map((CategoryWow category) {
              return Tab(text: category.title);
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categoryList.map((CategoryWow category) {
            return ReadListView(category: category);
          }).toList(),
        ));
  }

  ///获取类型
  Future _requestCategory() async {
    String categoryUrl = "https://gank.io/api/xiandu/category/wow";
    var categoryData = await DioManager.instance.get(categoryUrl);
    List results = categoryData["results"];
    for (int i = 0; i < results.length; i++) {
      CategoryWow category = CategoryWow.fromJson(results[i]);
      categoryList.add(category);
    }
    setState(() {
      _tabController =
          new TabController(length: categoryList.length, vsync: this);
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class ReadListView extends StatefulWidget {
  final CategoryWow category;

  const ReadListView({Key key, this.category}) : super(key: key);

  @override
  _ReadListViewState createState() => _ReadListViewState(category);
}

class _ReadListViewState extends State<ReadListView>
    with AutomaticKeepAliveClientMixin {
  //继承 AutomaticKeepAliveClientMixin 保存状态
  final CategoryWow category;
  List<XianDuInfo> xianDuList = new List();
  double screenWidth;
  int page = 1;
  bool isLoading = false;
  ScrollController _scrollController;

  _ReadListViewState(this.category);

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //滑动到底部
        _getMoreData(category.id);
      }
    });
    _requestGankList(category.id, false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: loadItemHolder(xianDuList[index], index),
              );
            } else if (index == xianDuList.length) {
              return _buildLoadView();
            } else {
              return loadItemHolder(xianDuList[index], index);
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return divider1;
          },
          itemCount: xianDuList.length == 0 ? 0 : xianDuList.length + 1,
          controller: _scrollController,
        ),
      ),
      onRefresh: () {
        return _handlerRefresh(category.id);
      },
    );
  }

  loadItemHolder(XianDuInfo info, int index) {
    String createdAt = info.createdAt;
    createdAt = createdAt.substring(0, createdAt.indexOf('T'));
    bool isHasImage =
        info.cover != null && info.cover != "" && info.cover != "none";
    if (isHasImage) {
      return getImageViewHolder(info, createdAt, isHasImage);
    } else {
      return getTextViewHolder(info, createdAt, isHasImage);
    }
  }

  ///没图片的item类型
  Widget getTextViewHolder(XianDuInfo info, String createdAt, bool isHasImage) {
    return getCommItemUI(info, createdAt, isHasImage);
  }

  ///有图片的item类型
  Widget getImageViewHolder(
      XianDuInfo info, String createdAt, bool isHasImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(info.cover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        getCommItemUI(info, createdAt, isHasImage)
      ],
    );
  }

  ///公共UI
  Widget getCommItemUI(XianDuInfo info, String createdAt, bool isHasImage) {
    return Container(
      height: 80, //指定高低，不然就包裹
      width: isHasImage ? screenWidth - 140 : screenWidth - 32,
      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              info.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFF41444E)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                //圆形图片
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(info.site.icon),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    info.site.name + "." + createdAt,
                    style: TextStyle(color: Color(0xFFC1C3CE), fontSize: 10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///加载更多UI
  Widget _buildLoadView() {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      child: Center(
        child: FlareActor(
          "assets/loading.flr",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          animation: "Loading",
        ),
      ),
      color: Colors.white,
    );
  }

  ///请求网络
  Future _requestGankList(String id, bool isLoadMore) async {
    String url = "https://gank.io/api/xiandu/data/id/" +
        id +
        "/count/10/page/" +
        page.toString();
    var response = await DioManager.instance.get(url);
    List results = response['results'];
    List<XianDuInfo> list = new List();
    for (int i = 0; i < results.length; i++) {
      XianDuInfo info = XianDuInfo.fromJson(results[i]);
      list.add(info);
    }
    setState(() {
      if (isLoadMore) {
        this.xianDuList.addAll(list);
      } else {
        this.xianDuList = list;
      }
      isLoading = false;
    });
  }

  ///下拉刷新
  Future _handlerRefresh(String id) async {
    await Future.delayed(Duration(seconds: 2), () {
      page = 1;
      _requestGankList(id, false);
    });
  }

  ///加载更多
  Future _getMoreData(String id) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2), () {
        page++;
        _requestGankList(id, true);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
