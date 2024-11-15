import 'package:dio/dio.dart';

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  factory CustomException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return CustomException("Connection Timeout. Please try again later.");
      case DioExceptionType.sendTimeout:
        return CustomException("Send Timeout. Please try again later.");
      case DioExceptionType.receiveTimeout:
        return CustomException("Receive Timeout. Please try again later.");
      case DioExceptionType.badResponse:
        return CustomException(_handleError(dioException.response?.statusCode, dioException.response?.data));
      case DioExceptionType.cancel:
        return CustomException("Request was cancelled");
      case DioExceptionType.unknown:
        return CustomException("Unexpected error occurred. Please check your connection.");
      default:
        return CustomException("Something went wrong");
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please check the data you have entered.";
      case 401:
        return "Unauthorized. Please check your credentials.";
      case 404:
        return "Not Found. The requested resource was not found.";
      case 500:
        return "Internal Server Error. Please try again later.";
      default:
        return "Oops! Something went wrong.";
    }
  }

  @override
  String toString() => message;
}
