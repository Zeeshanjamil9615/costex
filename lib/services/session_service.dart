import 'package:get_storage/get_storage.dart';

class SessionService {
  SessionService._internal();

  static final SessionService instance = SessionService._internal();

  final GetStorage _box = GetStorage();
  static const String _companyDataKey = 'company_data';
  static const String _userEmailKey = 'user_email';

  Future<void> saveCompanyData(Map<String, dynamic>? data) async {
    if (data == null) return;
    await _box.write(_companyDataKey, data.map((key, value) => MapEntry(key.toString(), value)));
  }

  Map<String, dynamic>? get companyData {
    final raw = _box.read(_companyDataKey);
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  String? get companyId {
    final data = companyData;
    if (data == null) return null;
    return data['id']?.toString() ??
        data['company_id']?.toString() ??
        data['0']?.toString();
  }

  String get companyName {
    final data = companyData;
    if (data == null) return 'COMPANY';
    return data['company_name']?.toString() ??
        data['1']?.toString() ??
        'COMPANY';
  }

  Future<void> saveUserEmail(String email) async {
    await _box.write(_userEmailKey, email);
  }

  String? get userEmail {
    final value = _box.read(_userEmailKey);
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return null;
  }

  bool get hasActiveSession => userEmail != null && companyId != null;

  Future<void> clearSession() async {
    await _box.remove(_companyDataKey);
    await _box.remove(_userEmailKey);
  }

  @Deprecated('Use clearSession instead')
  Future<void> clear() async => clearSession();
}

