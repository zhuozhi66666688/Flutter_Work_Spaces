import 'package:flutterproj/net/http/core/dio_adapter.dart';
import 'package:flutterproj/net/http/core/hi_net_adapter.dart';

import '../request/base_request.dart';
import 'hi_error.dart';

class HiNet {
  HiNet._();
  static final HiNet _instance = HiNet._();

  static HiNet getInstance() {
    return _instance;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printL("url:${request.url()}");
    // printL("method:${request.httpMethod()}");
    // printL("header:${request.headers}");
    // printL("params:${request.params}");
    //
    // request.addHeader("token", "123");
    // printL('header: ${request.headers}');
    // HiNetAdapter adapter = MockAdapter();
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = HiNetResponse(
        data: null,
        request: request,
        statusCode: -1,
        statusMessage: e.message,
      );
    } catch (e) {
      error = e;
      response = HiNetResponse(
        data: null,
        request: request,
        statusCode: -1,
        statusMessage: e.toString(),
      );
    }

    if (response == null) {
      printL(error);
    }

    var result = response.data;
    printL("result->response=:$response");

    var status = response.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }
}

void printL(message) {
  print("HiNet->${message?.toString()}");
}
