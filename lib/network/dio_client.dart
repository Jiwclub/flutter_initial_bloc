import 'dart:async';

import 'package:dio/dio.dart';

/*

  * https://github.com/flutterchina/dio/blob/master/README-ZH.md
  *
*/
class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    // BaseOptions、Options、RequestOptions
    BaseOptions options = BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); //continue
      },
      onResponse: (Response response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }

  getAuthorizationHeader() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getInt('token');
  }

  /// get
  Future get(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();

      Map<String, dynamic> authorization = {"token": getAuthorizationHeader()};
      requestOptions = requestOptions.copyWith(headers: authorization);
      var response = await dio.get(
        path,
        queryParameters: params,
        options: requestOptions,
      );
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  ///  post
  Future post(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  put 操作
  Future put(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.put(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  patch 操作
  Future patch(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.patch(path, data: params, options: requestOptions);
    return response.data;
  }

  /// delete 操作
  Future delete(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response =
        await dio.delete(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  post form
  Future postForm(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }
}

/*
   * error
   */
//
ErrorEntity createErrorEntity(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      {
        return ErrorEntity(code: -1, message: "请求取消");
      }
    case DioErrorType.connectionTimeout:
      {
        return ErrorEntity(code: -1, message: "连接超时");
      }

    case DioErrorType.sendTimeout:
      {
        return ErrorEntity(code: -1, message: "请求超时");
      }

    case DioErrorType.receiveTimeout:
      {
        return ErrorEntity(code: -1, message: "响应超时");
      }
    case DioErrorType.badResponse:
      {
        try {
          int? errCode = error.response?.statusCode;
          if (errCode == null) {
            return ErrorEntity(code: -2, message: error.message);
          }
          switch (errCode) {
            case 400:
              {
                return ErrorEntity(code: errCode, message: "请求语法错误");
              }
            case 401:
              {
                return ErrorEntity(code: errCode, message: "没有权限");
              }

            case 403:
              {
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              }

            case 404:
              {
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              }

            case 405:
              {
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              }

            case 500:
              {
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              }

            case 502:
              {
                return ErrorEntity(code: errCode, message: "无效的请求");
              }

            case 503:
              {
                return ErrorEntity(code: errCode, message: "服务器挂了");
              }

            case 505:
              {
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              }

            default:
              {
                // return ErrorEntity(code: errCode, message: "未知错误");
                return ErrorEntity(
                    code: errCode,
                    message: error.response?.statusMessage ?? '');
              }
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }

    default:
      {
        return ErrorEntity(code: -1, message: error.message);
      }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code;
  String? message;
  ErrorEntity({required this.code, this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
