import 'package:dio/dio.dart';

class DioClient {
  final String _url = 'https://add-orders-84495-default-rtdb.firebaseio.com/';
  late Dio _dio;
  DioClient() {
    _dio = Dio();
    _dio.options.baseUrl = _url;
    _dio.options.validateStatus = (_) => true;
  }

  Future<Response> send({
    required String reqMethod,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    late Response res;

    try {
      switch (reqMethod.toUpperCase()) {
        case 'GET':
          res = await _dio.get(
            path,
          );
          break;
        case 'POST':
          res = await _dio.post(
            path,
            data: body,
          );
          break;
        default:
          throw UnimplementedError();
      }
      throwIfNoSuccess(res);
      return res;
    } on DioError catch (err) {
      if (err.type == DioErrorType.other ||
          err.type == DioErrorType.connectTimeout ||
          err.type == DioErrorType.receiveTimeout) {
        throw ("you don't have intent connection or server down");
      } else {
        throw (res.data.toString());
      }
    } catch (err) {
      rethrow;
    } finally {
      _dio.close();
    }
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode! > 300) {
      final errorMsg = response.data.toString();
      throw (errorMsg);
    }
  }
}
