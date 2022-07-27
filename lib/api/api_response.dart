import 'package:dio/dio.dart';

import '../utils/variables.dart';

class ApiResponse {
  ApiResponse({required this.apiResult, this.message = ''});
  late ApiResult apiResult;
  late String message;
  dynamic data;

  ApiResponse.fromJson(Response response) {
    apiResult =
        response.statusCode == 200 ? ApiResult.success : ApiResult.error;
  }
}
