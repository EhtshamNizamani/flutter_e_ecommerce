import 'user_model.dart';

class ApiResponse {
  final int statusCode;
  final UserModel data;
  final String message;
  final bool success;

  ApiResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  // Factory method to create an ApiResponse from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      data: UserModel.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
