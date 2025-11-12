// quotation_model.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Quotation {
  final int id;
  final String fabricType;
  final String quotationNo;
  final String dated;
  final String customerName;
  final Map<String, dynamic> details;

  Quotation({
    required this.id,
    required this.fabricType,
    required this.quotationNo,
    required this.dated,
    required this.customerName,
    required this.details,
  });
}



class QuotationsController extends GetxController {
  // Selected fabric type
  final RxString selectedFabricType = ''.obs;
  
  // All quotations
  final RxList<Quotation> allQuotations = <Quotation>[].obs;
  
  // Filtered quotations based on fabric type
  final RxList<Quotation> filteredQuotations = <Quotation>[].obs;
  
  // Search query
  final RxString searchQuery = ''.obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Available fabric types
  final List<String> fabricTypes = [
    'Choose Type',
    'Grey Fabric',
    'Export Grey Fabric',
    'Export Processed Fabric',
    'Export Madeups Fabric',
    'Export Multi Madeups Fabric',
    'Towel Costing Sheet',
  ];

  @override
  void onInit() {
    super.onInit();
    loadDummyQuotations();
    
    // Listen to changes
    ever(selectedFabricType, (_) => filterQuotations());
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
          customerName: 'Maria Garcia',
          details: {
            'towelType': 'Bath Towel',
            'size': '27x54',
            'weight': '500',
            'dyeingCharges': '200',
            'totalPrice': '1800.00',
          },
        ),
      ];
      
      filteredQuotations.value = allQuotations;
      isLoading.value = false;
    });
  }

  void updateFabricType(String? type) {
    if (type != null && type != 'Choose Type') {
      selectedFabricType.value = type;
    } else {
      selectedFabricType.value = '';
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
    
    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((q) {
        return q.quotationNo.toLowerCase().contains(query) ||
               q.customerName.toLowerCase().contains(query) ||
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
    searchQuery.value = '';
    filteredQuotations.value = allQuotations;
  }
}