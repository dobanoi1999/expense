import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final DioException? dioException;

  NetworkException({
    required this.message,
    this.code,
    this.statusCode,
    this.dioException,
  });

  @override
  String toString() => 'NetworkException: message';
  factory NetworkException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          message: 'Connection timeout',
          code: 'CONNECTION_TIMEOUT',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.sendTimeout:
        return NetworkException(
          message: 'Send timeout',
          code: 'SEND_TIMEOUT',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Receive timeout',
          code: 'RECEIVE_TIMEOUT',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode ?? 0;
        final message = _getErrorMessage(statusCode, dioException.response);
        return NetworkException(
          message: message,
          code: 'BAD_RESPONSE',
          statusCode: statusCode,
          dioException: dioException,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request cancelled',
          code: 'REQUEST_CANCELLED',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.unknown:
        return NetworkException(
          message: dioException.message ?? 'Unknown error occurred',
          code: 'UNKNOWN_ERROR',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Bad certificate',
          code: 'BAD_CERTIFICATE',
          statusCode: null,
          dioException: dioException,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'Connection error',
          code: 'CONNECTION_ERROR',
          statusCode: null,
          dioException: dioException,
        );
    }
  }

  static String _getErrorMessage(int statusCode, Response? response) {
    final data = response?.data;
    if (data is Map && data.containsKey('message')) {
      return data['message'];
    }
    if (data is Map && data.containsKey('error')) {
      return data['error'].toString();
    }

    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Error: $statusCode';
    }
  }
}

class ApiResponse<T> {
  final T? data;
  final bool isSuccess;
  final String? message;
  final NetworkException? error;

  ApiResponse({required this.isSuccess, this.data, this.message, this.error});

  factory ApiResponse.success(T data) {
    return ApiResponse(isSuccess: true, data: data, message: 'Success');
  }

  factory ApiResponse.failure(NetworkException error) {
    return ApiResponse(isSuccess: false, error: error, message: error.message);
  }
}
