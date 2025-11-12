// all_users_controller.dart
import 'package:costex_app/views/drawer/adduser/alluser/update_user.dart';
import 'package:get/get.dart';

class User {
  final int id;
  final String userName;
  final String email;
  final String cellNo;
  final String department;
  final String designation;
  final String address;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.cellNo,
    required this.department,
    required this.designation,
    required this.address,
    required this.password,
  });
}

class AllUsersController extends GetxController {
  // Observable list of all users
  final RxList<User> allUsers = <User>[].obs;
  
  // Observable list of filtered users
  final RxList<User> filteredUsers = <User>[].obs;
  
  // Search query
  final RxString searchQuery = ''.obs;
  
  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyUsers();
    
    // Listen to search query changes
    ever(searchQuery, (_) => filterUsers());
  }

  void loadDummyUsers() {
    isLoading.value = true;
    
    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      allUsers.value = [
        User(
          id: 1,
          userName: 'HANAN waqar',
          email: 'hananwaqar7@gmail.com',
          cellNo: '03036646640',
          department: 'NO',
          designation: 'NO',
          address: 'Faisalabad',
          password: 'password123',
        ),
        User(
          id: 2,
          userName: 'Alison Parker',
          email: 'arslan12@gmail.com',
          cellNo: '571',
          department: 'Peter Nieves',
          designation: 'Senior Developer',
          address: 'New York',
          password: 'password123',
        ),
        User(
          id: 3,
          userName: 'ARFAT MAJEED',
          email: 'arafat.m@traveLocity.com.pk',
          cellNo: '03218667901',
          department: 'ADMIN',
          designation: 'CEO',
          address: 'Lahore',
          password: 'password123',
        ),
        User(
          id: 4,
          userName: 'M. Arslan Aslam',
          email: 'arslan@gmail.com',
          cellNo: '0321-3123124',
          department: 'Finance',
          designation: 'Developer',
          address: 'Islamabad',
          password: 'password123',
        ),
        User(
          id: 5,
          userName: 'Sarah Johnson',
          email: 'sarah.j@example.com',
          cellNo: '03001234567',
          department: 'Marketing',
          designation: 'Marketing Manager',
          address: 'Karachi',
          password: 'password123',
        ),
        User(
          id: 6,
          userName: 'Ahmed Khan',
          email: 'ahmed.khan@example.com',
          cellNo: '03119876543',
          department: 'Sales',
          designation: 'Sales Executive',
          address: 'Rawalpindi',
          password: 'password123',
        ),
      ];
      
      filteredUsers.value = allUsers;
      isLoading.value = false;
    });
  }

  void filterUsers() {
    if (searchQuery.value.isEmpty) {
      filteredUsers.value = allUsers;
    } else {
      filteredUsers.value = allUsers.where((user) {
        final query = searchQuery.value.toLowerCase();
        return user.userName.toLowerCase().contains(query) ||
               user.email.toLowerCase().contains(query) ||
               user.cellNo.contains(query) ||
               user.department.toLowerCase().contains(query) ||
               user.designation.toLowerCase().contains(query);
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void refreshUsers() {
    loadDummyUsers();
  }
}