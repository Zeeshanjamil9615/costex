import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



// quotation_model.dart
class Quotation {
  final int id;
  final String fabricType;
  final String quotationNo;
  final String dated;
  final String userName;
  final String customerName;
  final Map<String, dynamic> details;

  Quotation({
    required this.id,
    required this.fabricType,
    required this.quotationNo,
    required this.dated,
    required this.userName,
    required this.customerName,
    required this.details,
  });
}

// quotations_controller.dart

class UserQuotationController extends GetxController {
  // Selected fabric type
  final RxString selectedFabricType = ''.obs;
  
  // Selected user
  final RxString selectedUser = 'All'.obs;
  
  // All quotations
  final RxList<Quotation> allQuotations = <Quotation>[].obs;
  
  // Filtered quotations based on fabric type and user
  final RxList<Quotation> filteredQuotations = <Quotation>[].obs;
  
  // Search query
  final RxString searchQuery = ''.obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Entries per page
  final RxInt entriesPerPage = 10.obs;
  
  // Available fabric types
  final List<String> fabricTypes = [
    'Grey Fabric',
    'Export Grey Fabric',
    'Export Processed Fabric',
    'Export Madeups Fabric',
    'Export Multi Madeups Fabric',
    'Towel Costing Sheet',
  ];
  
  // Available users
  final RxList<String> availableUsers = <String>['All'].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyQuotations();
    
    // Listen to changes
    ever(selectedFabricType, (_) => filterQuotations());
    ever(selectedUser, (_) => filterQuotations());
    ever(searchQuery, (_) => filterQuotations());
  }

  void loadDummyQuotations() {
    isLoading.value = true;
    
    Future.delayed(const Duration(milliseconds: 500), () {
      allQuotations.value = [
        Quotation(
          id: 1,
          fabricType: 'Grey Fabric',
          quotationNo: 'QT-001',
          dated: '28-10-2025',
          userName: 'John Smith',
          customerName: 'Aarafat',
          details: {
            'quality': '30x30/76x56 114',
            'warpCount': '30',
            'weftCount': '30',
            'reeds': '76',
            'picks': '56',
            'greyWidth': '114',
            'pcRatio': '5050',
            'loom': 'suzler',
            'weave': 'plain',
            'warpRate': '300',
            'weftRate': '300',
            'coverationPick': '70',
            'warpWeight': '0.3948',
            'weftWeight': '0.2909',
            'totalWeight': '0.6857',
            'warpPrice': '118.44',
            'weftPrice': '87.27',
            'coverationCharges': '3920',
            'greyFabricPrice': '4125.71',
            'profit': '0',
            'fabricPriceFinal': '4125.71',
          },
        ),
        Quotation(
          id: 2,
          fabricType: 'Grey Fabric',
          quotationNo: 'QT-002',
          dated: '10-08-2021',
          userName: 'Sarah Johnson',
          customerName: 'Gay Blevins',
          details: {
            'quality': '40x40/80x60 120',
            'warpCount': '40',
            'weftCount': '40',
            'reeds': '80',
            'picks': '60',
            'greyWidth': '120',
            'pcRatio': '6040',
            'loom': 'rapier',
            'weave': 'twill',
            'warpRate': '320',
            'weftRate': '320',
            'coverationPick': '75',
            'warpWeight': '0.4200',
            'weftWeight': '0.3150',
            'totalWeight': '0.7350',
            'warpPrice': '134.40',
            'weftPrice': '100.80',
            'coverationCharges': '4200',
            'greyFabricPrice': '4435.20',
            'profit': '0',
            'fabricPriceFinal': '4435.20',
          },
        ),
        Quotation(
          id: 3,
          fabricType: 'Export Processed Fabric',
          quotationNo: 'QT-003',
          dated: '15-09-2024',
          userName: 'Ahmed Khan',
          customerName: 'Sarah Johnson',
          details: {
            'quality': '50x50/90x70 130',
            'processType': 'Bleached',
            'finishedWidth': '58',
            'gsm': '150',
            'processRate': '450',
            'totalPrice': '5200.50',
          },
        ),
        Quotation(
          id: 4,
          fabricType: 'Export Madeups Fabric',
          quotationNo: 'QT-004',
          dated: '20-10-2025',
          userName: 'John Smith',
          customerName: 'Ahmed Khan',
          details: {
            'productType': 'Bed Sheet',
            'size': '90x100',
            'weight': '250',
            'stitchingCharges': '150',
            'packingCharges': '50',
            'totalPrice': '3500.00',
          },
        ),
        Quotation(
          id: 5,
          fabricType: 'Towel Costing Sheet',
          quotationNo: 'QT-005',
          dated: '22-10-2025',
          userName: 'Sarah Johnson',
          customerName: 'Maria Garcia',
          details: {
            'towelType': 'Bath Towel',
            'size': '27x54',
            'weight': '500',
            'dyeingCharges': '200',
            'totalPrice': '1800.00',
          },
        ),
        Quotation(
          id: 6,
          fabricType: 'Export Grey Fabric',
          quotationNo: 'QT-006',
          dated: '01-11-2025',
          userName: 'Ahmed Khan',
          customerName: 'David Miller',
          details: {
            'quality': '35x35/70x65 110',
            'warpCount': '35',
            'weftCount': '35',
            'reeds': '70',
            'picks': '65',
            'greyWidth': '110',
            'totalPrice': '3800.50',
          },
        ),
      ];
      
      // Extract unique users
      Set<String> users = allQuotations.map((q) => q.userName).toSet();
      availableUsers.value = ['All', ...users.toList()];
      
      filteredQuotations.value = allQuotations;
      isLoading.value = false;
    });
  }

  void updateFabricType(String? type) {
    if (type != null) {
      selectedFabricType.value = type;
    }
  }

  void updateSelectedUser(String? user) {
    if (user != null) {
      selectedUser.value = user;
    }
  }

  void updateEntriesPerPage(int? entries) {
    if (entries != null) {
      entriesPerPage.value = entries;
    }
  }

  void filterQuotations() {
    List<Quotation> filtered = allQuotations;
    
    // Filter by fabric type
    if (selectedFabricType.value.isNotEmpty) {
      filtered = filtered
          .where((q) => q.fabricType == selectedFabricType.value)
          .toList();
    }
    
    // Filter by user
    if (selectedUser.value != 'All') {
      filtered = filtered
          .where((q) => q.userName == selectedUser.value)
          .toList();
    }
    
    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((q) {
        return q.quotationNo.toLowerCase().contains(query) ||
               q.customerName.toLowerCase().contains(query) ||
               q.userName.toLowerCase().contains(query) ||
               q.dated.contains(query);
      }).toList();
    }
    
    filteredQuotations.value = filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void showFabricRecords() {
    if (selectedFabricType.value.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select a fabric type first',
        backgroundColor: const Color(0xFFFF5722),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }
    filterQuotations();
  }

  void resetFilter() {
    selectedFabricType.value = '';
    selectedUser.value = 'All';
    searchQuery.value = '';
    filteredQuotations.value = allQuotations;
  }
}