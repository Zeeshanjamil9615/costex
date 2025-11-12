import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedMenu = 'Dashboard'.obs;
  var isUsersExpanded = false.obs;

  void toggleUsers() {
    isUsersExpanded.value = !isUsersExpanded.value;
  }

  void selectMenu(String menu) {
    selectedMenu.value = menu;
  }
}