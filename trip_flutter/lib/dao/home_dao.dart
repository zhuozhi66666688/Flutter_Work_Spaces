import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

///首页大接口
class HomeDao {
  static Future<HomeModel?> fetch() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    // print(bodyString);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      return HomeModel.fromJson(result['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyString);
    }
  }

  static Future<HomeModel?> fetchMock() async {
    try {
      // 读取本地JSON文件
      final jsonString =
          await rootBundle.loadString('assets/json/home_model.json');
      // 解析JSON
      final jsonResult = json.decode(jsonString);
      // 转换为HomeModel对象
      return HomeModel.fromJson(jsonResult);
    } catch (e) {
      debugPrint('Error reading mock data: $e');
      return null;
    } finally {
      // try {
      //   HomeDao.fetch();
      // } catch (e) {
      //   debugPrint('Error reading mock data: $e');
      // }
    }
  }
}
