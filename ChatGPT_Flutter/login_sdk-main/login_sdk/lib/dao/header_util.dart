import 'package:login_sdk/dao/login_dao.dart';

///接口所需请求header信息，auth-token可从问答区获取
hiHeaders() {
  Map<String, String> header = {
    "auth-token": 'ZmEtMjAyMS0wNC0xMaiAyMToyddMjoyddMC1mYQ==fg',
    "course-flag": 'fg',
    'boarding-pass': LoginDao.getBoardingPass() ?? ""
  };
  return header;
}
