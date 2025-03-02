import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

///我的页面
class MyPge extends StatefulWidget {
  const MyPge({Key? key}) : super(key: key);

  @override
  State<MyPge> createState() => _MyPgeState();
}

class _MyPgeState extends State<MyPge> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: HiWebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '0176ac',
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
