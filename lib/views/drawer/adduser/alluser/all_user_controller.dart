// all_users_controller.dart
import 'dart:developer';

import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:get/get.dart';

class User {
  final int id;
  final String companyId;
  final String addedBy;
  final String userName;
  final String email;
  final String cellNo;
  final String department;
  final String designation;
  final String address;
  final String status;
  final String timestamp;

  const User({
    required this.id,
    required this.companyId,
    required this.addedBy,
    required this.userName,
    required this.email,
    required this.cellNo,
    required this.department,
    required this.designation,
    required this.address,
    required this.status,
    required this.timestamp,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    String readValue(String primary, [String? fallback]) {
      if (map[primary] != null && map[primary].toString().isNotEmpty) {
        return map[primary].toString();
      }
      if (fallback != null && map[fallback] != null) {
        return map[fallback].toString();
      }
      return '';
    }

    return User(
      id: int.tryParse(readValue('id', '0')) ?? 0,
      companyId: readValue('company_id', '1'),
      addedBy: readValue('added_by', '2'),
      userName: readValue('full_name', '3'),
      email: readValue('email_address', '4'),
      address: readValue('address', '5'),
      cellNo: readValue('cell_number', '6'),
      department: readValue('department_name', '7'),
      designation: readValue('designation_no', '8'),
      status: readValue('status', '10'),
      timestamp: readValue('timestamp', '11'),
    );
  }
}

class AllUsersController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;

  final RxList<User> allUsers = <User>[].obs;
  final RxList<User> filteredUsers = <User>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(searchQuery, (_) => filterUsers());
  }

  Future<void> fetchUsers() async {
    final companyId = _session.companyId;
    if (companyId == null) {
      log('No company id found for fetching users');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiService.getCompanyUsers(companyId: companyId);
      final users = response.map(User.fromMap).toList();
      allUsers.assignAll(users);
      filterUsers();
    } catch (error, stack) {
      log('Failed to fetch users', error: error, stackTrace: stack);
      Get.snackbar(
        'Error',
        'Unable to fetch users. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterUsers() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredUsers.assignAll(allUsers);
      return;
    }

    filteredUsers.assignAll(allUsers.where((user) {
      return user.userName.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.cellNo.toLowerCase().contains(query) ||
          user.department.toLowerCase().contains(query) ||
          user.designation.toLowerCase().contains(query) ||
          user.address.toLowerCase().contains(query);
    }).toList());
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}