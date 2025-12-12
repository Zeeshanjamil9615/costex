// quotation_model.dart
import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quotation {
  final int id;
  final String fabricType;
  final String quotationNo;
  final String dated;
  final String customerName;
  final String username;
  final String quality;
  final Map<String, dynamic> details;

  Quotation({
    required this.id,
    required this.fabricType,
    required this.quotationNo,
    required this.dated,
    required this.customerName,
    required this.username,
    required this.quality,
    required this.details,
  });
}

class QuotationsController extends GetxController {
  static const String allFabricType = 'All';

  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;

  // Selected fabric type
  final RxString selectedFabricType = allFabricType.obs;
  
  // All quotations
  final RxList<Quotation> allQuotations = <Quotation>[].obs;
  
  // Filtered quotations based on fabric type
  final RxList<Quotation> filteredQuotations = <Quotation>[].obs;
  
  // Search query
  final RxString searchQuery = ''.obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Available fabric types
  final List<String> fabricTypes = const [
    allFabricType,
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
    ever(selectedFabricType, (_) => filterQuotations());
    ever(searchQuery, (_) => filterQuotations());
  }

  @override
  void onReady() {
    super.onReady();
    fetchQuotations();
  }

  void updateFabricType(String? type) {
    if (type == null || type.isEmpty) {
      selectedFabricType.value = allFabricType;
      return;
    }
    selectedFabricType.value = type;
  }

  bool get _isAllSelected => selectedFabricType.value == allFabricType;

  bool get isFilterActive =>
      !_isAllSelected || searchQuery.value.isNotEmpty;

  void filterQuotations() {
    List<Quotation> filtered = List<Quotation>.from(allQuotations);
    
    // Filter by fabric type
    if (selectedFabricType.value.isNotEmpty && !_isAllSelected) {
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
               q.username.toLowerCase().contains(query) ||
               q.fabricType.toLowerCase().contains(query) ||
               q.quality.toLowerCase().contains(query) ||
               q.dated.contains(query);
      }).toList();
    }
    
    filteredQuotations.value = filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchQuotations() async {
    final companyId = _session.companyId;
    if (companyId == null) {
      Get.snackbar(
        'Session Expired',
        'Company information not found. Please login again.',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 200),
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiService.fetchMyQuotations(
        companyId: companyId,
        fabricType: selectedFabricType.value,
      );

      final records = response['records'];
      if (records is List) {
        final parsed = records
            .whereType<Map>()
            .map((record) => _mapRecordToQuotation(
                  selectedFabricType.value,
                  record.map((key, value) => MapEntry(key.toString(), value)),
                  response['table']?.toString(),
                ))
            .toList();

        allQuotations.value = parsed;
        filterQuotations();

        if (parsed.isEmpty) {
          Get.snackbar(
            'No Records',
            'No quotations found for ${selectedFabricType.value}',
            backgroundColor: const Color(0xFF17a2b8),
            colorText: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 200),
          );
        }
      } else {
        allQuotations.clear();
        filteredQuotations.clear();
      }
    } on ApiException catch (error) {
      Get.snackbar(
        'Error',
        error.message,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 200),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch quotations: $e',
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 200),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetFilter() {
    selectedFabricType.value = allFabricType;
    searchQuery.value = '';
  }

  Quotation _mapRecordToQuotation(
    String fabricType,
    Map<String, dynamic> record, [
    String? tableName,
  ]) {
    final idValue = record['id']?.toString() ?? '';
    final timestamp = record['timestamp']?.toString() ??
        record['dated']?.toString() ??
        record['created_at']?.toString() ??
        '-';

    final resolvedFabricType = _inferFabricType(record, fabricType);

    final Map<String, dynamic> details = {
      ...record,
      if (tableName != null) 'table': tableName,
    };
    _addCamelCaseAliases(details);

    return Quotation(
      id: int.tryParse(idValue) ?? 0,
      fabricType: resolvedFabricType,
      quotationNo: idValue.isNotEmpty ? 'QT-$idValue' : '-',
      dated: timestamp,
      customerName: record['customer_name']?.toString() ?? '-',
      username: record['user_name']?.toString() ?? '',
      quality: record['quality']?.toString() ?? '',
      details: details,
    );
  }

  void _addCamelCaseAliases(Map<String, dynamic> details) {
    final entries = Map<String, dynamic>.from(details);
    for (final entry in entries.entries) {
      final key = entry.key;
      final value = entry.value;
      if (key.contains('_')) {
        final camelKey = _snakeToCamel(key);
        _registerAlias(details, camelKey, value);
        for (final alias in _specialAliases(key, camelKey)) {
          _registerAlias(details, alias, value);
        }
      } else {
        for (final alias in _specialAliases(key, key)) {
          _registerAlias(details, alias, value);
        }
      }
    }
  }

  void _registerAlias(Map<String, dynamic> details, String key, dynamic value) {
    if (key.isEmpty) return;
    details.putIfAbsent(key, () => value);
  }

  String _snakeToCamel(String value) {
    final buffer = StringBuffer();
    bool uppercaseNext = false;
    for (int i = 0; i < value.length; i++) {
      final char = value[i];
      if (char == '_') {
        uppercaseNext = true;
        continue;
      }
      if (uppercaseNext) {
        buffer.write(char.toUpperCase());
        uppercaseNext = false;
      } else {
        buffer.write(buffer.isEmpty ? char.toLowerCase() : char);
      }
    }
    return buffer.toString();
  }

  List<String> _specialAliases(String originalKey, String camelKey) {
    final aliases = <String>[];

    if (camelKey.endsWith('Lbs')) {
      aliases.add(camelKey.substring(0, camelKey.length - 3));
    }

    if (camelKey == 'wave') {
      aliases.add('weave');
    }

    if (camelKey == 'conversionPick') {
      aliases.addAll(['coverationPick', 'coversionPick', 'coversionPicks']);
    }

    if (originalKey.contains('dolar')) {
      aliases.add(camelKey.replaceFirst('dolar', 'Dollar'));
    }

    if (originalKey.contains('friehgt')) {
      aliases.add('freightDollar');
    }

    if (originalKey.contains('fob_price') && camelKey.contains('fobPrice')) {
      aliases.add('fobPrice');
    }

    if (camelKey == 'userName') {
      aliases.addAll(['username', 'addedBy']);
    }

    if (camelKey == 'customerName') {
      aliases.add('clientName');
    }

    return aliases;
  }

  String _inferFabricType(Map<String, dynamic> record, String requestedType) {
    final fallback = (requestedType.isEmpty || requestedType == allFabricType)
        ? 'Grey Fabric'
        : requestedType;

    final keys = record.keys
        .map((key) => key.toString().toLowerCase())
        .toSet();

    bool containsAny(Iterable<String> options) =>
        options.any((option) => keys.contains(option));

    if (containsAny(['pile', 'towel', 'bathrobe_one', 'bathrobe_two'])) {
      return 'Towel Costing Sheet';
    }

    if (containsAny(['warp_counts', 'weft_counts', 'all_product_names', 'all_sizes_1'])) {
      return 'Export Multi Madeups Fabric';
    }

    if (containsAny(['product_name', 'product_size', 'top_product_names']) &&
        !containsAny(['warp_counts', 'all_product_names'])) {
      return 'Export Madeups Fabric';
    }

    if (containsAny(['finish_width', 'process_type', 'fob_price_pkr', 'fob_price_dollar'])) {
      if (containsAny(['process_inch', 'process_charges', 'finish_fabric_cost', 'finish_fabric_price'])) {
        return 'Export Processed Fabric';
      }
      return 'Export Grey Fabric';
    }

    return fallback;
  }
}