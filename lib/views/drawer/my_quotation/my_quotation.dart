// my_quotations_page.dart
import 'package:costex_app/views/drawer/my_quotation/my_quotation_controller.dart';
import 'package:costex_app/views/drawer/grey_febric_costing_sheet/grey_febric_costing_sheet.dart';
import 'package:costex_app/views/drawer/export_grey_febric/export_grey_febric.dart';
import 'package:costex_app/views/drawer/export_processed_fabric/export_processed_fabric.dart';
import 'package:costex_app/views/drawer/Export_Madeups_fabric/Export_Madeups_fabric.dart';
import 'package:costex_app/views/drawer/export_multi_width_fabric/export_multi_width_fabric.dart';
import 'package:costex_app/views/drawer/towel_costing_sheet/towel_costing_sheet.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class MyQuotationsPage extends StatelessWidget {
  final String? initialFabricType;
  
  const MyQuotationsPage({Key? key, this.initialFabricType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuotationsController controller = Get.put(QuotationsController());
    
    // Set initial fabric type if provided
    if (initialFabricType != null && initialFabricType!.isNotEmpty) {
      // Use a post-frame callback to set the fabric type after the widget is built
      // The ever() listener in the controller will automatically filter quotations
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.updateFabricType(initialFabricType);
      });
    }

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
          'MY QUOTATIONS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Handle logout
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
      drawer: const AppDrawer(), // Your existing drawer
      body: Column(
        children: [
          // Fabric Type Selection Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Fabric Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Fabric Type Dropdown
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color:AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Fabric Type:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Obx(() => DropdownButtonFormField<String>(
                            value: controller.selectedFabricType.value,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: controller.fabricTypes
                                .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(
                                        type,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ))
                                .toList(),
                            onChanged: controller.updateFabricType,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Fabric Records Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.fetchQuotations,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC3545),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Find Records',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Quotations List Section
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Header with search and entries selector
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quotations List',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Obx(() => controller.isFilterActive
                                ? TextButton.icon(
                                    onPressed: controller.resetFilter,
                                    icon: const Icon(Icons.clear, size: 16),
                                    label: const Text('Clear Filter'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFFFF5722),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Search Bar
                        TextField(
                          onChanged: controller.updateSearchQuery,
                          decoration: InputDecoration(
                            hintText: 'Search by quotation no, customer name, username, type, quality...',
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.5),
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                            suffixIcon: Obx(() =>
                                controller.searchQuery.value.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 20),
                                        onPressed: () =>
                                            controller.updateSearchQuery(''),
                                      )
                                    : const SizedBox.shrink()),
                            filled: true,
                            fillColor: Colors.grey[50],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(height: 1),
                  
                  // List of Quotations
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }

                      if (controller.filteredQuotations.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.description_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller.selectedFabricType.value.isNotEmpty
                                    ? 'No quotations found for\n${controller.selectedFabricType.value}'
                                    : 'No quotations found',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap "Find Records" or adjust the filters above to search again.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.filteredQuotations.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final quotation = controller.filteredQuotations[index];
                          return _buildQuotationCard(context, quotation, index);
                        },
                      );
                    }),
                  ),
                  
                  // Footer with showing entries info
                //   Obx(() {
                //     if (controller.filteredQuotations.isEmpty) {
                //       return const SizedBox.shrink();
                //     }
                //     return Container(
                //       padding: const EdgeInsets.all(16),
                //       decoration: BoxDecoration(
                //         color: Colors.grey[50],
                //         border: Border(
                //           top: BorderSide(color: Colors.grey[300]!),
                //         ),
                //       ),
                //       child: Text(
                //         'Showing 1 to ${controller.filteredQuotations.length} of ${controller.filteredQuotations.length} entries',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.grey[700],
                //         ),
                //       ),
                //     );
                //   }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotationCard(BuildContext context, Quotation quotation, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    _navigateToQuotationScreen(quotation);
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('View'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17a2b8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Quotation No.', quotation.quotationNo),
                  const SizedBox(width: 10),
                  _buildDetailRow('Customer Name', quotation.customerName),
                  const SizedBox(width: 10),
                  _buildDetailRow('Type', quotation.fabricType),
                  const SizedBox(width: 10),
                  _buildDetailRow('Date', quotation.dated),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _navigateToQuotationScreen(Quotation quotation) {
    switch (quotation.fabricType) {
      case 'Grey Fabric':
        Get.to(
          () => GreyFabricCostingScreen(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      case 'Export Grey Fabric':
        Get.to(
          () => ExportGreyPage(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      case 'Export Processed Fabric':
        Get.to(
          () => ExportProcessedFabricPage(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      case 'Export Madeups Fabric':
        Get.to(
          () => ExportMadeupsPage(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      case 'Export Multi Madeups Fabric':
        Get.to(
          () => MultiMadeupsPage(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      case 'Towel Costing Sheet':
        Get.to(
          () => TowelCostingPage(
            quotation: quotation,
            viewMode: true,
          ),
          transition: Transition.rightToLeft,
        );
        break;
      default:
        Get.snackbar(
          'Error',
          'Unknown fabric type: ${quotation.fabricType}',
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }
}