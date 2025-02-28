import 'package:dio/dio.dart';
import 'package:flutterproj/net/http/core/hi_net.dart';
import 'package:flutterproj/net/http/core/hi_net_adapter.dart';

import '../request/base_request.dart';
import 'hi_error.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.headers);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(
          request.url(),
          data: request.params,
          options: options,
        );
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(
          request.url(),
          data: request.params,
          options: options,
        );
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      printL("dio_adapter" + error);

      ///抛出HiNetError
      throw HiNetError(
        response?.statusCode ?? -1,
        error.toString(),
        data: await buildRes(response, request),
      );
    }
    return await buildRes(response, request);
  }

  Future<HiNetResponse<T>> buildRes<T>(
    Response? response,
    BaseRequest request,
  ) {
    return Future.value(
      HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode ?? -1,
        statusMessage: response?.statusMessage ?? '',
        extra: response,
      ),
    );
  }
}
