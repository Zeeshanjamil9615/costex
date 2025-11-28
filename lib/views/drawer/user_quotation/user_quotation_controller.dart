import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation_controller.dart'
    show Quotation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOption {
  UserOption({
    required this.id,
    required this.name,
    required this.value,
  });

  final String id;
  final String name;
  final String value;
}

class UserQuotationController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;

  final RxString selectedFabricType = 'All'.obs;
  final RxString selectedUser = ''.obs;
  final RxList<Quotation> allQuotations = <Quotation>[].obs;
  final RxList<Quotation> filteredQuotations = <Quotation>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isUsersLoading = false.obs;
  final RxInt entriesPerPage = 10.obs;
  final RxList<UserOption> userOptions = <UserOption>[].obs;

  final List<String> fabricTypes = const [
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
    _loadUsers();
    ever(searchQuery, (_) => filterQuotations());
  }

  Future<void> _loadUsers() async {
    final companyId = _session.companyId;
    if (companyId == null || companyId.isEmpty) {
      _showError('Session Expired', 'Company information not found. Please login again.');
      return;
    }

    try {
      isUsersLoading.value = true;
      final response = await _apiService.getUsers(companyId: companyId);
      final options = response
          .where((user) => (user['value'] ?? '').toString().isNotEmpty)
          .map((user) => UserOption(
                id: user['id']?.toString() ?? '',
                name: user['name']?.toString() ?? '',
                value: user['value']?.toString() ?? '',
              ))
          .toList();
      userOptions.assignAll(options);
    } on ApiException catch (error) {
      _showError('Error', error.message);
    } catch (error) {
      _showError('Error', 'Failed to load users: $error');
    } finally {
      isUsersLoading.value = false;
    }
  }

  void updateFabricType(String? type) {
    if (type == null || type == 'Choose Type') {
      selectedFabricType.value = '';
      return;
    }
    selectedFabricType.value = type;
  }

  void updateSelectedUser(String? user) {
    selectedUser.value = user ?? '';
  }

  void updateEntriesPerPage(int? entries) {
    if (entries != null) {
      entriesPerPage.value = entries;
    }
  }

  Future<void> showFabricRecords() async {
    await _fetchUserQuotations();
  }

  Future<void> _fetchUserQuotations() async {
    if (selectedFabricType.value.isEmpty) {
      _showWarning('Selection Required', 'Please select a fabric type first.');
      return;
    }

    if (selectedUser.value.isEmpty) {
      _showWarning('Selection Required', 'Please select a user first.');
      return;
    }

    final companyId = _session.companyId;
    if (companyId == null || companyId.isEmpty) {
      _showError('Session Expired', 'Company information not found. Please login again.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiService.getUserFabricRecords(
        companyId: companyId,
        fabricType: selectedFabricType.value,
        username: selectedUser.value,
      );

      final records = response['records'];
      if (records is! List || records.isEmpty) {
        allQuotations.clear();
        filteredQuotations.clear();
        _showInfo('No Records', 'No quotations found for the selected filters.');
        return;
      }

      final parsed = records
          .whereType<Map>()
          .map((record) => _mapRecordToQuotation(
                selectedFabricType.value,
                record.map((key, value) => MapEntry(key.toString(), value)),
                response['table']?.toString(),
              ))
          .toList();

      allQuotations.assignAll(parsed);
      filterQuotations();
    } on ApiException catch (error) {
      _showError('Error', error.message);
    } catch (error) {
      _showError('Error', 'Failed to fetch quotations: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void filterQuotations() {
    List<Quotation> filtered = List<Quotation>.from(allQuotations);
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((quotation) {
        final user = quotation.username.toLowerCase();
        final customer = quotation.customerName.toLowerCase();
        final number = quotation.quotationNo.toLowerCase();
        final date = quotation.dated.toLowerCase();
        return user.contains(query) || customer.contains(query) || number.contains(query) || date.contains(query);
      }).toList();
    }
    filteredQuotations.assignAll(filtered);
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void resetFilter() {
    selectedFabricType.value = '';
    selectedUser.value = '';
    searchQuery.value = '';
    filteredQuotations.assignAll(allQuotations);
  }

  Quotation _mapRecordToQuotation(
    String fabricType,
    Map<String, dynamic> record, [
    String? tableName,
  ]) {
    final normalized = _normalizeRecord(record);
    final idValue = normalized['id']?.toString() ?? '';
    final timestamp = normalized['timestamp']?.toString() ??
        normalized['dated']?.toString() ??
        '';
    final userRaw = normalized['userName']?.toString() ??
        normalized['user_name']?.toString() ??
        '';

    final displayUser = userRaw.contains(',')
        ? userRaw.split(',').last.trim()
        : userRaw;

    final resolvedType = fabricType.isNotEmpty ? fabricType : _resolveFabricType(tableName);

    final customerName = normalized['customerName']?.toString() ??
        normalized['customer_name']?.toString() ??
        '-';

    final quality = normalized['quality']?.toString() ??
        normalized['productName']?.toString() ??
        normalized['qualityArray']?.toString() ??
        '-';

    return Quotation(
      id: int.tryParse(idValue) ?? 0,
      fabricType: resolvedType,
      quotationNo: idValue.isNotEmpty ? 'QT-$idValue' : '-',
      dated: timestamp.isNotEmpty ? timestamp.split(' ').first : '-',
      customerName: customerName,
      username: displayUser,
      quality: quality,
      details: normalized,
    );
  }

  String _resolveFabricType(String? table) {
    switch (table) {
      case 'tbl_grey_fabric':
        return 'Grey Fabric';
      case 'tbl_export_grey_fabric':
        return 'Export Grey Fabric';
      case 'tbl_export_processed_fabric':
        return 'Export Processed Fabric';
      case 'tbl_export_madeups_fabric':
        return 'Export Madeups Fabric';
      case 'tbl_multi_madeups_costing':
      case 'tbl_export_multi_fabric':
        return 'Export Multi Madeups Fabric';
      case 'tbl_towel_costing_sheet':
        return 'Towel Costing Sheet';
      default:
        return 'Quotation';
    }
  }

  Map<String, dynamic> _normalizeRecord(Map<String, dynamic> original) {
    final Map<String, dynamic> newMap = Map.from(original);

    original.forEach((key, value) {
      final parts = key.split('_');
      if (parts.length > 1) {
        var camel = parts.first;
        for (var i = 1; i < parts.length; i++) {
          final segment = parts[i];
          if (segment.isEmpty) continue;
          camel += segment[0].toUpperCase() + segment.substring(1);
        }
        newMap[camel] = value;
      }

      switch (key) {
        case 'wave':
          newMap['weave'] = value;
          break;
        case 'user_name':
          newMap['userName'] = value;
          final split = value.toString().split(',');
          if (split.length > 1) {
            newMap['userDisplayName'] = split.last.trim();
          }
          break;
        case 'customer_name':
          newMap['customerName'] = value;
          break;
        case 'company_name':
          newMap['companyName'] = value;
          break;
        case 'warp_rate_lbs':
          newMap['warpRateLbs'] = value;
          break;
        case 'weft_rate_lbs':
          newMap['weftRateLbs'] = value;
          break;
        case 'pc_ratio':
          newMap['pcRatio'] = value;
          break;
        case 'grey_width':
          newMap['greyWidth'] = value;
          break;
        case 'finish_width':
          newMap['finishWidth'] = value;
          break;
        case 'mending_mt':
          newMap['mendingMT'] = value;
          break;
        case 'packing_charges':
          newMap['packingCharges'] = value;
          break;
        case 'packing_charges_mt':
          newMap['packingChargesMT'] = value;
          break;
        case 'wastage':
          newMap['wastagePercent'] = value;
          break;
        case 'container_size':
          newMap['containerSize'] = value;
          break;
        case 'container_capacity':
          newMap['containerCapacity'] = value;
          break;
        case 'exchange_rate':
          newMap['rateOfExchange'] = value;
          break;
        case 'fob_price_pkr':
          newMap['fobPricePKR'] = value;
          break;
        case 'fob_price_dollar':
          newMap['fobPriceDollar'] = value;
          break;
        case 'freight_dollar':
          newMap['freightInDollar'] = value;
          break;
        case 'freight_calculation_dollar':
          newMap['freightCalculation'] = value;
          break;
        case 'c_f_price_dollar':
          newMap['cfPriceInDollar'] = value;
          break;
        case 'commission':
          newMap['commissionPercent'] = value;
          break;
        case 'profit':
          newMap['profitPercent'] = value;
          break;
        case 'overhead':
          newMap['overheadPercent'] = value;
          break;
        case 'fob_final_price':
          newMap['fobPriceFinal'] = value;
          break;
        case 'c_f_final_price':
          newMap['cfPriceFinal'] = value;
          break;
      }
    });

    return newMap;
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFF44336),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void _showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFF5722),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void _showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF17a2b8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
