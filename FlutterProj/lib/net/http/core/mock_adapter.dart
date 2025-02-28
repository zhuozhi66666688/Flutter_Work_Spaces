import 'package:flutterproj/net/http/core/hi_net_adapter.dart';
import 'package:flutterproj/net/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return HiNetResponse(
        data: {"code": 0, "message": "success"} as T,
        request: request,
        statusCode: 200,
        statusMessage: '',
      );
    });
  }
}
