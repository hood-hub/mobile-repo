// lib/src/services/dio_service.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure_storage;
import '../constants/api_constants.dart';
import '../providers/dio_providers/dio_provider.dart';
import '../utils/custom_exceptions.dart';

class DioService {
  final Dio _dio;
  final secure_storage.FlutterSecureStorage _secureStorage;
  final Ref _ref;

  DioService(this._dio, this._secureStorage, this._ref) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 25); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the auth token from secure storage
        String? token = _ref.read(tokenProvider); // Use `read` to access token from provider
        print('token: $token');
        if (token == null) {
          // If tokenProvider is empty, load from secure storage as fallback
          token = await _secureStorage.read(key: 'auth_token');
          print('token: $token');
        }

        // Attach token to request headers
        if (token != null) {
          options.headers['Authorization'] = '$token';
        }
        // Add any additional headers if necessary
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // You can handle common response scenarios here
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle errors globally
        return handler.next(e);
      },
    ));
  }

  /// Generic GET request
  Future<Response> getRequest(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      // Handle DioError appropriately
      throw _handleDioError(e);
    }
  }

  /// Generic POST request with support for dynamic body and file uploads
  Future<Response> postRequest(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        List<MultipartFile>? files, // For file uploads
      }) async {
    print('post-body $data');
    try {
      FormData? formData;
      if (files != null && files.isNotEmpty) {
        formData = FormData.fromMap(data ?? {});
        for (var file in files) {
          formData.files.add(MapEntry('files', file));
        }
      }

      final response = await _dio.post(
        endpoint,
        data: formData ?? data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      // Handle DioError appropriately
      print(e);
      throw _handleDioError(e);
    }
  }

  /// Generic PUT request
  Future<Response> putRequest(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw  CustomException.fromDioException(e);
    }
  }

  /// Generic DELETE request
  Future<Response> deleteRequest(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw  CustomException.fromDioException(e);
    }
  }

  /// Handle Dio Errors
  Exception _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timeout with server');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Exception('Receive timeout in connection with server');
    } else if (error.type == DioExceptionType.badResponse) {
      // Handle known error responses
      if (error.response?.statusCode == 401) {
        return Exception('Unauthorized: Invalid credentials');
      } else if (error.response?.statusCode == 404) {
        return Exception('Not Found: The requested resource was not found');
      } else if (error.response?.statusCode == 500) {
        return Exception('Internal Server Error');
      }
      return Exception(
          'Received invalid status code: ${error.response?.statusCode}');
    } else if (error.type == DioExceptionType.cancel) {
      return Exception('Request to server was cancelled');
    } else {
      return Exception('Unexpected error occurred: ${error.message}');
    }
  }
}
