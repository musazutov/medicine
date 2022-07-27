import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:testtask/beans/preparation_bean.dart';
import '../beans/preparation_detail_bean.dart';
import '../utils/variables.dart';
import 'api_response.dart';

class API {
  String baseUrl = 'https://api.pills-prod.sdh.com.ua/v1';
  late Dio _dio;
  static final API _instance = API._internal();

  API._internal() {
    _dio = Dio();
  }

  static API get instance => _instance;

  Future<Dio> getDio() async {
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 15000;
    _dio.options.sendTimeout = 15000;
    _dio.options.receiveTimeout = 15000;

    return _dio;
  }

  Future<ApiResponse> getPreparations() async {
    debugPrint('getPreparations called');

    try {
      var response = await (await getDio()).get('/medicine/');
      debugPrint('response ${response.data}');

      ApiResponse apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.apiResult == ApiResult.success) {
        apiResponse.data = response.data['results'] != null
            ? (response.data['results'] as List)
                .map((e) => PreparationBean.fromJson(e))
                .toList()
            : [];
      }
      return apiResponse;
    } on DioError catch (e) {
      return handleDioError(e);
    } catch (e) {
      debugPrint('exception $e');
      return ApiResponse(
          apiResult: ApiResult.error, message: 'Something went wrong');
    }
  }

  Future<ApiResponse> searchPreparations(String filter) async {
    debugPrint('searchPreparations called');

    try {
      var response = await (await getDio()).get('/medicine/', queryParameters: {
        'search': filter,
      });
      debugPrint('response ${response.data}');

      ApiResponse apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.apiResult == ApiResult.success) {
        apiResponse.data = response.data['results'] != null
            ? (response.data['results'] as List)
                .map((e) => PreparationBean.fromJson(e))
                .toList()
            : [];
      }
      return apiResponse;
    } on DioError catch (e) {
      return handleDioError(e);
    } catch (e) {
      debugPrint('exception $e');
      return ApiResponse(
          apiResult: ApiResult.error, message: 'Something went wrong');
    }
  }

  Future<ApiResponse> getPreparationDetail(int preparationId) async {
    debugPrint('getPreparations called');

    try {
      var response = await (await getDio()).get('/medicine/$preparationId');
      debugPrint('response ${response.data}');

      ApiResponse apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.apiResult == ApiResult.success) {
        apiResponse.data = PreparationDetailBean.fromJson(response.data);
      }
      return apiResponse;
    } on DioError catch (e) {
      return handleDioError(e);
    } catch (e) {
      debugPrint('exception $e');
      return ApiResponse(
          apiResult: ApiResult.error, message: 'Something went wrong');
    }
  }

  ApiResponse handleDioError(DioError e) {
    debugPrint(
        'dierror ${e.response?.data} status code ${e.response?.statusCode} and message is ${e.message}  ');

    switch (e.type) {
      case DioErrorType.response:
        return ApiResponse(
            apiResult: ApiResult.error, message: 'Server returned error');

      case DioErrorType.connectTimeout:
        return ApiResponse(
            apiResult: ApiResult.error, message: 'Request timed out');

      default:
        return ApiResponse(
            apiResult: ApiResult.error, message: 'Network exception');
    }
  }
}
