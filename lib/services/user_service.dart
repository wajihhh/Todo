import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../config.dart';
import '../exception_handler.dart';
import 'api.dart';

class UserService {
  final Api _api = Api();

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      Dio dio = await _api.createDio();
      var response = await dio.post(ApiConstants.login, data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        return {'status': true, 'token': response.data['token']};
      } else {
        return {
          'status': false,
          'message': 'Invalid credentials or missing token'
        };
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          return {'status': false, 'message': 'Invalid password'};
        }
      }
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      Dio dio = await _api.createDio();
      var response = await dio.post(
        ApiConstants.registration,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      return response.statusCode == 200;
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
