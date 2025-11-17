import 'dart:convert';

import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}

class ApiService {
  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: _baseUrl,
                connectTimeout: const Duration(seconds: 25),
                receiveTimeout: const Duration(seconds: 25),
                headers: const {'Accept': 'application/json'},
              ),
            );

  static const String _baseUrl = 'https://yarnonline.pk/costex/company/api/';

  final Dio _dio;

  Future<Map<String, dynamic>> registerCompany({
    required String companyName,
    required String address,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        'registerRequest',
        data: FormData.fromMap({
          'company_name': companyName,
          'address': address,
          'phone_no': phoneNumber,
          'email_address': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to process request')
            : error.message ?? 'Unable to process request',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        'registerVerify',
        data: FormData.fromMap({
          'email_address': email,
          'otp': otp,
        }),
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to verify OTP')
            : error.message ?? 'Unable to verify OTP',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'loginRequest',
        data: FormData.fromMap({
          'txtusername': username,
          'txtpassword': password,
        }),
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ?? 'Unable to login')
            : error.message ?? 'Unable to login',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Map<String, dynamic> _parseResponse(Response<dynamic> response) {
    if (response.statusCode != 200) {
      throw ApiException(
        'Unexpected response from server',
        statusCode: response.statusCode,
      );
    }

    final payload = _normalizePayload(response.data);
    final dynamic status = payload['status'];

    if (_isSuccessStatus(status)) {
      return payload;
    }

    throw ApiException(
      payload['message']?.toString() ?? 'Unexpected server response',
      statusCode: status is int ? status : int.tryParse(status?.toString() ?? ''),
    );
  }

  Map<String, dynamic> _normalizePayload(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    if (data is String && data.isNotEmpty) {
      final trimmed = data.trim();

      Map<String, dynamic>? decodedMap;
      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map) {
          decodedMap = Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        final jsonStart = trimmed.indexOf('{');
        final jsonEnd = trimmed.lastIndexOf('}');

        if (jsonStart != -1 && jsonEnd != -1 && jsonEnd > jsonStart) {
          final jsonSegment = trimmed.substring(jsonStart, jsonEnd + 1);
          try {
            final decoded = jsonDecode(jsonSegment);
            if (decoded is Map) {
              decodedMap = Map<String, dynamic>.from(decoded);
            }
          } catch (_) {
            // fall through
          }
        }
      }

      if (decodedMap != null) {
        return decodedMap;
      }

      final cleaned = trimmed
          .replaceAll(RegExp(r'<[^>]*>', multiLine: true), ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      return {
        'status': null,
        'message': cleaned.isNotEmpty ? cleaned : 'Unexpected response from server',
      };
    }

    return {'status': null, 'message': 'Unexpected response from server'};
  }

  bool _isSuccessStatus(dynamic status) {
    if (status == null) return false;
    if (status is int) return status == 200;

    final normalized = status.toString().toLowerCase();
    return normalized == '200' ||
        normalized == 'success' ||
        normalized == 'ok' ||
        normalized == 'true';
  }
}

