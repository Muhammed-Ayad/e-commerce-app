import 'package:dio/dio.dart';

class DioClient {
  final String _url = 'https://e-commerce-app-15805-default-rtdb.firebaseio.com/';
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

// class ApiService {
//   final Dio _client = Dio(
//     BaseOptions(
//       baseUrl: Urls.baseUrl,
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//       contentType: Headers.formUrlEncodedContentType,
//     ),
//   );

//   Future<Restaurants> getRestaurantList() async {
//     final response = await _client.get(Urls.restaurantList);

//     if (response.statusCode == 200) {
//       return Restaurants.fromMap(response.data);
//     } else {
//       throw Exception('Failed to load restaurant list!');
//     }
//   }

//   Future<Restaurants> searchRestaurant(String query) async {
//     final response = await _client.get(
//       Urls.searchRestaurant,
//       queryParameters: {'q': query},
//     );

//     if (response.statusCode == 200) {
//       return Restaurants.fromSearchMap(response.data);
//     } else {
//       throw Exception('Failed to load search result!');
//     }
//   }

//   Future<Restaurant> getRestaurantDetailById(String id) async {
//     final response = await _client.get(Urls.restaurantDetail(id));

//     if (response.statusCode == 200) {
//       return Restaurant.fromMap(response.data);
//     } else {
//       throw Exception('Failed to load restaurant detail!');
//     }
//   }

//   Future<bool> postReviewById({
//     required String id,
//     required String name,
//     required String review,
//   }) async {
//     _client.interceptors.add(LogInterceptor(requestBody: true));
//     final request = await _client.post(
//       Urls.restraurantReview,
//       data: {'id': id, 'name': name, 'review': review},
//     );

//     if (request.statusCode == 201) {
//       return true;
//     } else {
//       throw Exception('Failed to post review!');
//     }
//   }
// }
