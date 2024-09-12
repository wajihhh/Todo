import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:todo_getx/signin/sign_in.dart';
import 'package:todo_getx/token_manager.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;

  DioInterceptor(this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

    log('[ URL: ${options.uri} ]');
    log('[ Headers: ${options.headers.toString()} ]');
    log('[ Request: ${options.data.toString()} ]');

  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    super.onResponse(response, handler);
    log('[ Response: ${response.data} ]');
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    log('[ Error ] ${err.toString()}');
    log('[ Error Response] ${err.response.toString()}');
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
          // case 401:
          case 403:
            throw BadRequestException(err.requestOptions, err.response!);
          case 401:
          // case 403:
            throw UnauthorizedException(err.requestOptions);
        // case 401:
        // case 403:
        //   tokenHandling(err, handler);
        // break;
          case 404:
            throw NotFoundException(err.requestOptions, err.response!);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      default:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }

  void tokenHandling(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token might be expired
      TokenManager().clearToken();  // Clear expired token
      Get.offAll(() => const SignInView());  // Redirect to sign-in
    }
  }
}



class BadRequestException extends DioException {
  BadRequestException(RequestOptions request, Response response)
      : super(requestOptions: request, response: response);

  @override
  String toString() {
    return response!.data['message'];
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'unknown_error'.tr;
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'conflict_occured'.tr;
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'access_denied'.tr;
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions request, Response response)
      : super(requestOptions: request, response: response);

  @override
  String toString() {
    return response!.data['message'];
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No Internet Connection.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'connection_timed_out'.tr;
  }
}
