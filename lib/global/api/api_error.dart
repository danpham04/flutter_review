import 'package:flutter_review/global/api/api_response.dart';

class ApiError {
  final String? errorCode;
  final String? message;
  final dynamic extraData;

  ApiError({this.errorCode, this.message, this.extraData});

  ApiError.fromResponse(ApiResponse response)
      : errorCode = response.errorCode,
        message = response.message,
        extraData = response.data;
}
