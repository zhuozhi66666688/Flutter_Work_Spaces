import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/util/navigator_util.dart';

import 'header_util.dart';

///登录接口
class LoginDao {
  static const boardingPass = "boarding_pass";

  static login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {};
    paramsMap['userName'] = userName;
    paramsMap['password'] = password;
    var uri = Uri.https('api.geekailab.com', '/uapi/user/login', paramsMap);
    final response = await http.post(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    print(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      if (result['code'] == 0 && result['data'] != null) {
        //保存登录令牌
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(bodyString);
      }
    } else {
      throw Exception(bodyString);
    }
  }

  static void _saveBoardingPass(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }

  ///登出
  static void logOut() {
    //移除登录保存的信息
    HiCache.getInstance().remove(boardingPass);
    NavigatorUtil.goToLogin();
  }
}
