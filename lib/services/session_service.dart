import 'package:get_storage/get_storage.dart';

class SessionService {
  SessionService._internal();

  static final SessionService instance = SessionService._internal();

  final GetStorage _box = GetStorage();
  static const String _companyDataKey = 'company_data';

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

  Future<void> clear() async {
    await _box.remove(_companyDataKey);
  }
}

