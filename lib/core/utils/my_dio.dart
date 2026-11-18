import 'dart:developer';

import 'package:cryptovista_app/presentation/widgets/custom_toast.dart';
import 'package:dio/dio.dart';

class MyDio {
  late final Dio dio;

  MyDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://crypto-research-backend-9atv.onrender.com',
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 90),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.jsonContentType,
        },
      ),
    );
  }

  // GET
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        path,
        queryParameters: queryParameters,
      );

      printSuccessDetails(response: response);

      return response.data;
    } on DioException catch (error) {
      printFailedDetails(error: error);
    }
  }

  // POST
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      printSuccessDetails(response: response);

      return response.data;
    } on DioException catch (error) {
      printFailedDetails(error: error);
    }
  }

  // PATCH
  Future<dynamic> patch({required String path, dynamic data}) async {
    try {
      final Response response = await dio.patch(path, data: data);

      printSuccessDetails(response: response);

      return response.data;
    } on DioException catch (error) {
      printFailedDetails(error: error);
    }
  }

  // DELETE
  Future<dynamic> delete({required String path, dynamic data}) async {
    try {
      final Response response = await dio.delete(path, data: data);

      printSuccessDetails(response: response);

      return response.data;
    } on DioException catch (error) {
      printFailedDetails(error: error);
    }
  }

  // SUCCESS LOG
  void printSuccessDetails({required Response response}) {
    log('========== REQUEST SUCCESS ==========');
    log('Status Code: ${response.statusCode}');
    log('Method: ${response.requestOptions.method}');
    log('URL: ${response.realUri}');
    log('Query Parameters: ${response.requestOptions.queryParameters}');
    log('Request Body: ${response.requestOptions.data}');
    log('Response: ${response.data}');
    log('=====================================');
  }

  // ERROR LOG
  void printFailedDetails({required DioException error}) {
    CustomToast.error(error.type.name);
    log('========== REQUEST FAILED ==========');
    log('Status Code: ${error.response?.statusCode}');
    log('Method: ${error.requestOptions.method}');
    log('URL: ${error.requestOptions.uri}');
    log('Query Parameters: ${error.requestOptions.queryParameters}');
    log('Request Body: ${error.requestOptions.data}');
    log('Response: ${error.response?.data}');
    log('Error Type: ${error.type}');
    log('Error Message: ${error.message}');
    log('====================================');
  }
}
