class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNetError(this.code, this.message, {this.data});

  @override
  String toString() {
    return 'HiNetError{code: $code, message: $message, data: $data}';
  }
}

class NeedAuth extends HiNetError {
  NeedAuth(String massage, {int code = 403, dynamic data})
    : super(code, massage, data: data);
}

class NeedLogin extends HiNetError {
  NeedLogin({String massage = "请先登陆", int code = 401}) : super(code, massage);
}
