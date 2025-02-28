import 'package:flutterproj/net/http/core/hi_net.dart';

enum HttpMethod { GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS }

// 基础请求

abstract class BaseRequest {
  var pathParms;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParms != null) {
      if (pathStr.endsWith("/")) {
        pathStr = "${pathStr}$pathParms";
      } else {
        pathStr = "$pathStr/$pathParms";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    printL(uri.toString());
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, String> headers = Map();

  BaseRequest addHeader(String k, Object v) {
    headers[k] = v.toString();
    return this;
  }
}
