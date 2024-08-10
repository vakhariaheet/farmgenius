import 'package:demo/services/keys.dart';
import 'package:dio/dio.dart';

class ApiService<T> {
  final Dio _dio = Dio();

  Future<Response<T>> post(
      String route, dynamic data, bool? isAuth, Options options) async {
    try {
      print('${envKeys.BACKEND_URL}$route');
      final response = await _dio.post<T>('${envKeys.BACKEND_URL}$route',
          data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> get(String route, bool? isAuth) async {
    try {
      final response = await _dio.get<T>('${envKeys.BACKEND_URL}$route');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> put(
      String route, Map<String, dynamic> data, bool? isAuth) async {
    try {
      final response =
          await _dio.put<T>('${envKeys.BACKEND_URL}$route', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> delete(String route, bool? isAuth) async {
    try {
      final response = await _dio.delete<T>('${envKeys.BACKEND_URL}$route');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
