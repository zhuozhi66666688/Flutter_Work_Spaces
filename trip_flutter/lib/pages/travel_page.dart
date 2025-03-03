import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../model/travel_category_model.dart';

///旅拍页面
class TravelPge extends StatefulWidget {
  const TravelPge({Key? key}) : super(key: key);

  @override
  State<TravelPge> createState() => _TravelPgeState();
}

class _TravelPgeState extends State<TravelPge> with TickerProviderStateMixin {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelTabModel;
  late TabController _controller;

  get _tabBar => TabBar(
      controller: _controller,
      isScrollable: true,
      //设置Tab左侧对齐，去除左侧偏移
      tabAlignment: TabAlignment.start,
      //指定指示器的宽度为Tab的宽度
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      indicator: const UnderlineIndicator(
        strokeCap: StrokeCap.round,
        borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
        // insets: EdgeInsets.only(bottom: 0)
      ),
      tabs: tabs.map<Tab>((TravelTab tab) {
        return Tab(text: tab.labelName);
      }).toList());

  get _tabBarView => TabBarView(
      controller: _controller,
      children: tabs.map((TravelTab tab) {
        return TravelTabPage(groupChannelCode: tab.groupChannelCode);
      }).toList());

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    TravelDao.fetchTravelCategoryModelMock().then((TravelCategoryModel? model) {
      //TabBar空白的问题
      _controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
      setState(() {
        tabs = model?.tabs ?? [];
        travelTabModel = model;
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //获取刘海屏Top安全边距
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Flexible(child: _tabBarView)
        ],
      ),
    );
  }
}
