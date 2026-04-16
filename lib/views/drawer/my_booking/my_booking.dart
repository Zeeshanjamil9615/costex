import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/Export_Madeups_fabric/Export_Madeups_fabric.dart';
import 'package:costex_app/views/drawer/export_grey_febric/export_grey_febric.dart';
import 'package:costex_app/views/drawer/export_multi_width_fabric/export_multi_width_fabric.dart';
import 'package:costex_app/views/drawer/export_processed_fabric/export_processed_fabric.dart';
import 'package:costex_app/views/drawer/grey_febric_costing_sheet/grey_febric_costing_sheet.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation.dart';
import 'package:costex_app/views/drawer/towel_costing_sheet/towel_costing_sheet.dart';
import 'package:costex_app/views/drawer/user_quotation/user_quotation.dart';
import 'package:costex_app/views/home/home.dart' show AppDrawer;
import 'package:costex_app/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController(), permanent: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchCounts();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          homeController.companyName.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await SessionService.instance.clearSession();
              Get.offAll(() => const LoginPage());
            },
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
      body: Obx(() {
        final isBusy =
            homeController.isCountsLoading.value && homeController.counts.isEmpty;
        if (isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => homeController.fetchCounts(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _buildCards(context),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    final cards = <_BookingCard>[
      _BookingCard(
        title: 'GREY FABRIC SHEET',
        subtitle: 'All Time',
        countKey: 'grey_fabric',
        icon: Icons.inventory_2_outlined,
        onTap: () => Get.offAll(
          () => const GreyFabricCostingScreen(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'EXPORT GREY FABRIC SHEET',
        subtitle: 'All Time',
        countKey: 'export_grey_fabric',
        icon: Icons.upload_file,
        onTap: () => Get.offAll(
          () => const ExportGreyPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'EXPORT PROCESSED FABRIC SHEET',
        subtitle: 'All Time',
        countKey: 'export_processed_fabric',
        icon: Icons.checkroom,
        onTap: () => Get.offAll(
          () => const ExportProcessedFabricPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'EXPORT MADEUPS FABRIC SHEET',
        subtitle: 'All Time',
        countKey: 'export_madeups_fabric',
        icon: Icons.attach_money,
        onTap: () => Get.offAll(
          () => const ExportMadeupsPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'EXPORT MULTI WIDTH MADEUPS FABRIC SHEET',
        subtitle: 'All Time',
        countKey: 'multi_madeups_costing',
        icon: Icons.width_full,
        onTap: () => Get.offAll(
          () => const MultiMadeupsPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'TOWEL COSTING SHEET',
        subtitle: 'All Time',
        countKey: 'towel_costing',
        icon: Icons.cleaning_services,
        onTap: () => Get.offAll(
          () => const TowelCostingPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'MY QUOTATIONS',
        subtitle: 'Open',
        countKey: null,
        icon: Icons.request_quote,
        onTap: () => Get.offAll(
          () => const MyQuotationsPage(),
          transition: Transition.rightToLeft,
        ),
      ),
      _BookingCard(
        title: 'USER QUOTATIONS',
        subtitle: 'Open',
        countKey: null,
        icon: Icons.description,
        onTap: () => Get.offAll(
          () => const UserQuotation(),
          transition: Transition.rightToLeft,
        ),
      ),
    ];

    return cards.map(_buildDashboardCard).toList();
  }

  Widget _buildDashboardCard(_BookingCard card) {
    final String? countKey = card.countKey;
    final bool isLoading =
        homeController.isCountsLoading.value && homeController.counts.isEmpty;

    final String displayValue = countKey != null
        ? (homeController.counts[countKey]?.toString() ??
            (isLoading ? '...' : '0'))
        : '0';

    return GestureDetector(
      onTap: card.onTap,
      child: Container(
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
                card.icon,
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
                    card.title,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? countKey;
  final VoidCallback onTap;

  const _BookingCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.countKey,
  });
}

