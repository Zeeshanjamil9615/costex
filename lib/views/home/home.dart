import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/Export_Madeups_fabric/Export_Madeups_fabric.dart';
import 'package:costex_app/views/drawer/adduser/adduser.dart';
import 'package:costex_app/views/drawer/adduser/alluser/all_user.dart';
import 'package:costex_app/views/drawer/export_grey_febric/export_grey_febric.dart';
import 'package:costex_app/views/drawer/export_multi_width_fabric/export_multi_width_fabric.dart';
import 'package:costex_app/views/drawer/export_processed_fabric/export_processed_fabric.dart';
import 'package:costex_app/views/drawer/grey_febric_costing_sheet/grey_febric_costing_sheet.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation.dart';
import 'package:costex_app/views/drawer/towel_costing_sheet/towel_costing_sheet.dart';
import 'package:costex_app/views/drawer/user_quotation/user_quotation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

// Import your new pages

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Get.find if controller exists, otherwise create it
    final HomeController homeController =  Get.put(HomeController());

    final List<Map<String, dynamic>> dashboardCards = [
      {
        'title': 'TOTAL CLIENTS',
        'value': '4',
        'subtitle': 'All Time',
        'icon': Icons.people_outline,
      },
      {
        'title': 'GREY FABRIC',
        'value': '2',
        'subtitle': 'All Time',
        'icon': Icons.inventory_2_outlined,
      },
      {
        'title': 'EXPORT GREY FABRIC',
        'value': '3',
        'subtitle': 'All Time',
        'icon': Icons.archive_outlined,
      },
      {
        'title': 'PROCESSED FABRICS',
        'value': '3',
        'subtitle': 'All Time',
        'icon': Icons.checkroom_outlined,
      },
      {
        'title': 'MADEUPS COSTING',
        'value': '2',
        'subtitle': 'All Time',
        'icon': Icons.article_outlined,
      },
      {
        'title': 'MULTI MADEUPS COSTING',
        'value': '3',
        'subtitle': 'All Time',
        'icon': Icons.layers_outlined,
      },
      {
        'title': 'TOWEL COSTING',
        'value': '2',
        'subtitle': 'All Time',
        'icon': Icons.dry_cleaning_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'COMPANY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: dashboardCards.map((card) => _buildDashboardCard(card)).toList(),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardIconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              card['icon'],
              color: AppColors.cardIcon,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'],
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,













                    
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  card['subtitle'],
                  style: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            card['value'],
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Drawer(
      backgroundColor: AppColors.sidebarBackground,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            color: AppColors.sidebarBackground,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.person, size: 32, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'COSTEX COMPANY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: const Text(
              'MAIN',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  page: const HomePage(),
                  homeController: homeController,
                ),
                _buildExpandableMenuItem(
                  icon: Icons.people,
                  title: 'Users',
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.inventory,
                  title: 'Grey Fabric',
                  page: const GreyFabricCostingScreen(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.upload_file,
                  title: 'Export Grey Fabric',
                  page: const ExportGreyPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.checkroom,
                  title: 'Export Processed Fabric',
                  page: const ExportProcessedFabricPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.attach_money,
                  title: 'Export Made-Ups Fabric',
                  page: const ExportMadeupsPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.width_full,
                  title: 'Export Multi Width Made-Ups Fabric',
                  page: const MultiMadeupsPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.cleaning_services,
                  title: 'Towel Costing Sheet',
                  page: const TowelCostingPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.request_quote,
                  title: 'My Quotations',
                  page: const MyQuotationsPage(),
                  homeController: homeController,
                ),
                _buildMenuItem(
                  icon: Icons.description,
                  title: 'User Quotations',
                  page: const UserQuotation(),
                  homeController: homeController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Widget page,
    required HomeController homeController,
  }) {
    return Obx(() {
      final isSelected = homeController.selectedMenu.value == title;
      
      return ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.white70,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        onTap: () {
          homeController.selectMenu(title);
          Get.back(); // Close drawer
          
          // Navigate to the page
          Get.offAll(() => page);
        },
      );
    });
  }

  Widget _buildExpandableMenuItem({
    required IconData icon,
    required String title,
    required HomeController homeController,
  }) {
    return Obx(() {
      final isExpanded = homeController.isUsersExpanded.value;
      final isSelected = homeController.selectedMenu.value == title;
      
      return Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.white70,
              size: 20,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: isSelected ? AppColors.primary : Colors.white54,
              size: 20,
            ),
            selected: isSelected,
            selectedTileColor: AppColors.primary.withOpacity(0.1),
            onTap: () {
              homeController.toggleUsers();
            },
          ),
          if (isExpanded) ...[
            _buildSubMenuItem(
              title: 'Add User',
              page: const AddUserPage(),
              homeController: homeController,
            ),
            _buildSubMenuItem(
              title: 'All Users',
              page: const AllUsersPage(),
              homeController: homeController,
            ),
          ],
        ],
      );
    });
  }
  Widget _buildSubMenuItem({
    required String title,
    required Widget page,
    required HomeController homeController,
  }) {
    return Obx(() {
      final isSelected = homeController.selectedMenu.value == title;
      
      return ListTile(
        contentPadding: const EdgeInsets.only(left: 56, right: 16),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        onTap: () {
          homeController.selectMenu(title);
          Get.back(); // Close drawer
          
          // Navigate to the page
          Get.offAll(() => page);
        },
      );
    });
  }
}






