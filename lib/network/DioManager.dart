import 'package:dio/dio.dart';

///Dio简单封装
class DioManager {
  Dio dio;
  Options defaultOptions;

  factory DioManager() => _getInstance();
  static DioManager _instance;

  static DioManager get instance => _getInstance();

  static DioManager _getInstance() {
    if (_instance == null) {
      _instance = new DioManager._internal();
    }
    return _instance;
  }

  DioManager._internal() {
    //初始化
    defaultOptions = new Options(connectTimeout: 5000, receiveTimeout: 5000);
    dio = new Dio(defaultOptions);
  }

  Future get(String url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(url,
          data: data, options: options, cancelToken: cancelToken);
    } on DioError catch (ex) {
      if (CancelToken.isCancel(ex)) {
        print("请求取消=" + ex.message);
      } else {
        print("请求错误=" + ex.message);
      }
    }
    if (response != null) {
      return response.data;
    }
  }

  Future post(String url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(url,
          data: data, options: options, cancelToken: cancelToken);
    } on DioError catch (ex) {
      if (CancelToken.isCancel(ex)) {
        print("请求取消=" + ex.message);
      } else {
        print("请求错误=" + ex.message);
      }
    }
    if (response != null) {
      return response.data;
    }
  }
}
