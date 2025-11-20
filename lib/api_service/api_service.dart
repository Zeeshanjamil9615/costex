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

  Future<Map<String, dynamic>> addUser({
    required String companyId,
    required String companyName,
    required String fullName,
    required String email,
    required String address,
    required String departmentName,
    required String designation,
    required String cellNumber,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'addUser',
        data: FormData.fromMap({
          'company_id': companyId,
          'company_name': companyName,
          'full_name': fullName,
          'email_address': email,
          'address': address,
          'dept_name': departmentName,
          'designation': designation,
          'password': password,
          'cell_number': cellNumber,
        }),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to add user')
            : error.message ?? 'Unable to add user',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCompanyUsers({
    required String companyId,
  }) async {
    try {
      final response = await _dio.post(
        'getCompanyUsers',
        data: FormData.fromMap({'company_id': companyId}),
      );
      final parsed = _parseResponse(response);
      final data = parsed['data'];
      if (data is List) {
        return data
            .whereType<Map>()
            .map((e) => e.map((key, value) => MapEntry(key.toString(), value)))
            .toList();
      }
      return <Map<String, dynamic>>[];
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to fetch users')
            : error.message ?? 'Unable to fetch users',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String userId,
    required String fullName,
    required String cellNumber,
    required String address,
    required String email,
    required String departmentName,
    required String designation,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'updateUser',
        data: FormData.fromMap({
          'user_id': userId,
          'full_name': fullName,
          'cell_number': cellNumber,
          'address': address,
          'email_address': email,
          'department_name': departmentName,
          'designation_no': designation,
          'password': password,
        }),
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to update user')
            : error.message ?? 'Unable to update user',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getUsers({
    required String companyId,
  }) async {
    try {
      final response = await _dio.post(
        'getUsers',
        data: FormData.fromMap({'company_id': companyId}),
      );
      final parsed = _parseResponse(response);
      final users = parsed['users'];
      if (users is List) {
        return users
            .whereType<Map>()
            .map((user) => user.map((key, value) => MapEntry(key.toString(), value)))
            .toList();
      }
      return <Map<String, dynamic>>[];
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to fetch users')
            : error.message ?? 'Unable to fetch users',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> getUserFabricRecords({
    required String companyId,
    required String fabricType,
    required String username,
  }) async {
    try {
      final response = await _dio.post(
        'getUserFabricRecords',
        data: FormData.fromMap({
          'company_id': companyId,
          'fabric_type': fabricType,
          'username': username,
        }),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to fetch user quotations')
            : error.message ?? 'Unable to fetch user quotations',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> getCounts({
    required String companyId,
  }) async {
    try {
      final response = await _dio.post(
        'getCounts',
        data: FormData.fromMap({'company_id': companyId}),
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to fetch counts')
            : error.message ?? 'Unable to fetch counts',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveGreyFabricQuote({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveGreyFabricQuote',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save grey fabric quotation')
            : error.message ?? 'Unable to save grey fabric quotation',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveExportGreyFabricQuote({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveExportGreyFabricQuote',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save export grey fabric quotation')
            : error.message ?? 'Unable to save export grey fabric quotation',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveExportProcessedFabricQuote({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveExportProcessedFabricQuote',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save export processed fabric quotation')
            : error.message ?? 'Unable to save export processed fabric quotation',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveExportMadeupsFabricQuote({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveExportMadeupsFabricQuote',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save export madeups fabric quotation')
            : error.message ?? 'Unable to save export madeups fabric quotation',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveMultiMadeupsFabricQuote({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveMultiMadeupsFabricQuote',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save export multi madeups fabric quotation')
            : error.message ?? 'Unable to save export multi madeups fabric quotation',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> saveTowelCostingSheet({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dio.post(
        'saveTowelCostingSheet',
        data: FormData.fromMap(payload),
      );
      return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to save towel costing sheet')
            : error.message ?? 'Unable to save towel costing sheet',
        statusCode: error.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> fetchMyQuotations({
    required String companyId,
    required String fabricType,
  }) async {













    
    try {
      final response = await _dio.post(
        'myQuotations',
        data: FormData.fromMap({
          'fabric_records': '1',
          'fabric_type': fabricType,
          'company_id': companyId,
        }),
      );
       return _parseResponse(response);
    } on DioException catch (error) {
      throw ApiException(
        error.response?.data is Map<String, dynamic>
            ? (error.response!.data['message']?.toString() ??
                'Unable to fetch quotations')
            : error.message ?? 'Unable to fetch quotations',
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

    if (_isSuccessStatus(status) || _looksLikeDataPayload(payload)) {
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

  bool _looksLikeDataPayload(Map<String, dynamic> payload) {
    if (payload.containsKey('records')) {
      return true;
    }
    if (payload.containsKey('data') && payload['data'] is List) {
      return true;
    }
    if (payload.containsKey('users') && payload['users'] is List) {
      return true;
    }
    return false;
  }
}

