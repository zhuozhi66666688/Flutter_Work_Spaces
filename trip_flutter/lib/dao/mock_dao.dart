import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockDao {
  static Future<T?> getMockData<T>(
      String jsonPath, T Function(Map<String, dynamic>) fromJson) async {
    try {
      // 读取本地JSON文件
      final jsonString = await rootBundle.loadString('assets/json/$jsonPath');
      // 解析JSON
      final jsonResult = json.decode(jsonString);
      // 转换为HomeModel对象
      return fromJson(jsonResult as Map<String, dynamic>);
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
