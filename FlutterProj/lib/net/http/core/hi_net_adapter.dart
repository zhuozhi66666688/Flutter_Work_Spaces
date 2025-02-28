import 'dart:convert';

import 'package:flutterproj/net/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  T data;
  BaseRequest request;
  int statusCode;
  String statusMessage;
  dynamic extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }

  HiNetResponse({
    required this.data,
    required this.request,
    required this.statusCode,
    required this.statusMessage,
    this.extra,
  });
}
