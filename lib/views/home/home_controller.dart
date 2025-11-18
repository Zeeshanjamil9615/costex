import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;

  final selectedMenu = 'Dashboard'.obs;
  final isUsersExpanded = false.obs;
  final counts = <String, int>{}.obs;
  final isCountsLoading = false.obs;

  String get companyName => _session.companyName;

  @override
  void onInit() {
    super.onInit();
    fetchCounts();
  }

  Future<void> fetchCounts() async {
    final companyId = _session.companyId;
    if (companyId == null) {
      debugPrint('No company id found in storage');
      return;
    }
    try {
      isCountsLoading.value = true;
      final response = await _apiService.getCounts(companyId: companyId);
      final data = response['data'] as Map<String, dynamic>? ?? {};
      final parsed = data.map(
        (key, value) => MapEntry(key.toString(), int.tryParse(value.toString()) ?? 0),
      );
      counts.assignAll(parsed);
    } catch (error) {
      debugPrint('Failed to fetch counts: $error');
    } finally {
      isCountsLoading.value = false;
    }
  }

  void toggleUsers() {
    isUsersExpanded.value = !isUsersExpanded.value;
  }

  void selectMenu(String menu) {
    selectedMenu.value = menu;
  }
}