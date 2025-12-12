import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/pdf_printer.dart';
import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';

class ExportMadeupsController extends GetxController {
  final ApiService _apiService = ApiService();
  // Text Controllers
  final customerNameController = TextEditingController();
  
  // Product Information
  final productNameController = TextEditingController();
  final productSizeController = TextEditingController();
  
  // Basic Information - Row 1
  final qualityController = TextEditingController();
  final warpCountController = TextEditingController();
  final weftCountController = TextEditingController();
  final reedsController = TextEditingController();
  final picksController = TextEditingController();
  final greyWidthController = TextEditingController();
  
  // Basic Information - Row 2
  final finishWidthController = TextEditingController();
  final pcRatioController = TextEditingController();
  final loomController = TextEditingController();
  final weaveController = TextEditingController();
  final warpRateLbsController = TextEditingController();
  final weftRateLbsController = TextEditingController();
  
  // Basic Information - Row 3 (MISSING FIELDS ADDED)
  final conversionPickController = TextEditingController();
  final warpWeightController = TextEditingController();
  final weftWeightController = TextEditingController();
  final totalWeightController = TextEditingController();
  final warpPriceController = TextEditingController();
  final weftPriceController = TextEditingController();
  
  // Basic Information - Row 4 (MISSING FIELDS ADDED)
  final conversionChargesController = TextEditingController();
  final fabricPriceMeterController = TextEditingController();
  final mendingMTController = TextEditingController();
  final processTypeController = TextEditingController();
  final processRateController = TextEditingController();
  final processChargesController = TextEditingController();
  
  // Pricing Details - Row 5 (MISSING FIELDS ADDED)
  final packingTypeController = TextEditingController();
  final packingChargesMTController = TextEditingController();
  final wastagePercentController = TextEditingController();
  final finishFabricCostController = TextEditingController();
  final consumptionController = TextEditingController();
  final consumptionPriceController = TextEditingController();
  
  // Pricing Details - Row 6 (MISSING FIELDS ADDED)
  final stitchingController = TextEditingController();
  final accessoriesController = TextEditingController();
  final polyBagController = TextEditingController();
  final miscellaneousController = TextEditingController();
  final containerSizeController = TextEditingController();
  final containerCapacityController = TextEditingController();
  
  // Export Pricing - Row 7
  final rateOfExchangeController = TextEditingController();
  final fobPricePKRController = TextEditingController();
  final fobPriceDollarController = TextEditingController();
  final freightInDollarController = TextEditingController();
  final rateController = TextEditingController();
  final freightCalculationController = TextEditingController();
  
  // Final Calculation - Row 8
  final cfPriceInDollarController = TextEditingController();
  final commissionController = TextEditingController();
  final profitController = TextEditingController();
  final overheadController = TextEditingController();
  final cfPriceFinalController = TextEditingController();
  final fobPriceFinalController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Loading state
  final isLoading = false.obs;

  // Process Type dropdown items
  final List<String> processTypes = [
    'Process Type',
    'Dyeing',
    'Printing',
    'Bleaching',
    'Processing',
  ];
  final selectedProcessType = 'Process Type'.obs;

  @override
  void onInit() {
    super.onInit();
    _setupCalculations();
  }

  @override
  void onClose() {
    // Dispose all controllers
    customerNameController.dispose();
    productNameController.dispose();
    productSizeController.dispose();
    qualityController.dispose();
    warpCountController.dispose();
    weftCountController.dispose();
    reedsController.dispose();
    picksController.dispose();
    greyWidthController.dispose();
    finishWidthController.dispose();
    pcRatioController.dispose();
    loomController.dispose();
    weaveController.dispose();
    warpRateLbsController.dispose();
    weftRateLbsController.dispose();
    conversionPickController.dispose();
    warpWeightController.dispose();
    weftWeightController.dispose();
    totalWeightController.dispose();
    warpPriceController.dispose();
    weftPriceController.dispose();
    conversionChargesController.dispose();
    fabricPriceMeterController.dispose();
    mendingMTController.dispose();
    processTypeController.dispose();
    processRateController.dispose();
    processChargesController.dispose();
    packingTypeController.dispose();
    packingChargesMTController.dispose();
    wastagePercentController.dispose();
    finishFabricCostController.dispose();
    consumptionController.dispose();
    consumptionPriceController.dispose();
    stitchingController.dispose();
    accessoriesController.dispose();
    polyBagController.dispose();
    miscellaneousController.dispose();
    containerSizeController.dispose();
    containerCapacityController.dispose();
    rateOfExchangeController.dispose();
    fobPricePKRController.dispose();
    fobPriceDollarController.dispose();
    freightInDollarController.dispose();
    rateController.dispose();
    freightCalculationController.dispose();
    cfPriceInDollarController.dispose();
    commissionController.dispose();
    overheadController.dispose();
    profitController.dispose();
    cfPriceFinalController.dispose();
    fobPriceFinalController.dispose();
    super.onClose();
  }

  void _setupCalculations() {
    // Add listeners for all input fields that trigger calculations
    warpCountController.addListener(_calculateAll);
    weftCountController.addListener(_calculateAll);
    reedsController.addListener(_calculateAll);
    picksController.addListener(_calculateAll);
    greyWidthController.addListener(_calculateAll);
    finishWidthController.addListener(_calculateAll);
    warpRateLbsController.addListener(_calculateAll);
    weftRateLbsController.addListener(_calculateAll);
    conversionPickController.addListener(_calculateAll);
    mendingMTController.addListener(_calculateAll);
    packingChargesMTController.addListener(_calculateAll);
    wastagePercentController.addListener(_calculateAll);
    processRateController.addListener(_calculateAll);
    consumptionController.addListener(_calculateAll);
    stitchingController.addListener(_calculateAll);
    accessoriesController.addListener(_calculateAll);
    polyBagController.addListener(_calculateAll);
    miscellaneousController.addListener(_calculateAll);
    rateOfExchangeController.addListener(_calculateAll);
    freightInDollarController.addListener(_calculateAll);
    containerCapacityController.addListener(_calculateAll);
    commissionController.addListener(_calculateAll);
    overheadController.addListener(_calculateAll);
    profitController.addListener(_calculateAll);
  }

  // Main calculation method - implements all formulas from JavaScript
  void _calculateAll() {
    // Parse all input values
    final warpCount = double.tryParse(warpCountController.text) ?? 0;
    final weftCount = double.tryParse(weftCountController.text) ?? 0;
    final reeds = double.tryParse(reedsController.text) ?? 0;
    final picks = double.tryParse(picksController.text) ?? 0;
    final greyWidth = double.tryParse(greyWidthController.text) ?? 0;
    final finishWidth = double.tryParse(finishWidthController.text) ?? 0;
    final warpRate = double.tryParse(warpRateLbsController.text) ?? 0;
    final weftRate = double.tryParse(weftRateLbsController.text) ?? 0;
    final conversionPick = double.tryParse(conversionPickController.text) ?? 0;
    final mendingMT = double.tryParse(mendingMTController.text) ?? 0;
    final packingCharges = double.tryParse(packingChargesMTController.text) ?? 0;
    final wastage = double.tryParse(wastagePercentController.text) ?? 0;
    final processInch = double.tryParse(processRateController.text) ?? 0;
    final consumption = double.tryParse(consumptionController.text) ?? 0;
    final stitching = double.tryParse(stitchingController.text) ?? 0;
    final accessories = double.tryParse(accessoriesController.text) ?? 0;
    final polyBag = double.tryParse(polyBagController.text) ?? 0;
    final miscellaneous = double.tryParse(miscellaneousController.text) ?? 0;
    final exchangeRate = double.tryParse(rateOfExchangeController.text) ?? 0;
    final freightDollar = double.tryParse(freightInDollarController.text) ?? 0;
    final containerCapacity = double.tryParse(containerCapacityController.text) ?? 0;
    final commission = double.tryParse(commissionController.text) ?? 0;
    final overhead = double.tryParse(overheadController.text) ?? 0;
    final profit = double.tryParse(profitController.text) ?? 0;

    // 1. Calculate Warp Weight
    double warpWeight = 0;
    if (warpCount > 0) {
      warpWeight = ((((reeds * greyWidth) / 800) / warpCount) * 1.0936);
    }
    warpWeightController.text = warpWeight.toStringAsFixed(4);

    // 2. Calculate Weft Weight
    double weftWeight = 0;
    if (weftCount > 0) {
      weftWeight = ((((picks * greyWidth) / 800) / weftCount) * 1.0936);
    }
    weftWeightController.text = weftWeight.toStringAsFixed(4);

    // 3. Calculate Total Weight
    final totalWeight = warpWeight + weftWeight;
    totalWeightController.text = totalWeight.toStringAsFixed(4);

    // 4. Calculate Warp Price
    final warpPrice = warpRate * warpWeight;
    warpPriceController.text = warpPrice.toStringAsFixed(4);

    // 5. Calculate Weft Price
    final weftPrice = weftRate * weftWeight;
    weftPriceController.text = weftPrice.toStringAsFixed(4);

    // 6. Calculate Conversion Charges
    final conversionCharges = conversionPick * picks;
    conversionChargesController.text = conversionCharges.toStringAsFixed(4);

    // 7. Calculate Grey Fabric Price
    final greyFabricPrice = warpPrice + weftPrice + conversionCharges;
    fabricPriceMeterController.text = greyFabricPrice.toStringAsFixed(4);

    // 8. Calculate FOB Price (before wastage)
    final fobPrice = greyFabricPrice + mendingMT + packingCharges;

    // 9. Calculate Process Charges
    final processCharges = finishWidth * processInch;
    processChargesController.text = processCharges.toStringAsFixed(4);

    // 10. Calculate Finish Fabric Cost
    final finishFabricCost = (fobPrice * wastage / 100) + fobPrice + processCharges;
    finishFabricCostController.text = finishFabricCost.toStringAsFixed(4);

    // 11. Calculate FOB Price PKR (with wastage, without process charges)
    final fobPricePKR = (fobPrice * wastage / 100) + fobPrice;
    fobPricePKRController.text = fobPricePKR.toStringAsFixed(4);

    // 12. Calculate Consumption Price
    final consumptionPrice = consumption * finishFabricCost;
    consumptionPriceController.text = consumptionPrice.toStringAsFixed(4);

    // 13. Calculate Final Cost (for FOB calculation)
    final finalCost = finishFabricCost + stitching + accessories + polyBag + miscellaneous + consumptionPrice;

    // 14. Calculate FOB Price Dollar
    double fobPriceDollar = 0;
    if (exchangeRate > 0) {
      fobPriceDollar = finalCost / exchangeRate;
    }
    fobPriceDollarController.text = fobPriceDollar.toStringAsFixed(4);

    // 15. Calculate FOB Final Price (with commission, overhead, profit)
    final fobFinalPrice = (commission * fobPriceDollar / 100) + 
                          (profit * fobPriceDollar / 100) + 
                          (overhead * fobPriceDollar / 100) + 
                          fobPriceDollar;
    fobPriceFinalController.text = fobFinalPrice.toStringAsFixed(4);

    // 16. Calculate Freight Calculation
    double freightCalculation = 0;
    if (containerCapacity > 0) {
      freightCalculation = freightDollar / containerCapacity;
    }
    freightCalculationController.text = freightCalculation.toStringAsFixed(4);

    // 17. Calculate C&F Price Dollar
    final cfPriceDollar = fobPriceDollar + freightCalculation;
    cfPriceInDollarController.text = cfPriceDollar.toStringAsFixed(4);

    // 18. Calculate C&F Final Price (with commission, overhead, and profit)
    final cfFinalPrice = (commission * cfPriceDollar / 100) + 
                         (profit * cfPriceDollar / 100) + 
                         (overhead * cfPriceDollar / 100) + 
                         cfPriceDollar;
    cfPriceFinalController.text = cfFinalPrice.toStringAsFixed(4);
  }

  // Change process type
  void changeProcessType(String? value) {
    if (value != null) {
      selectedProcessType.value = value;
      processTypeController.text = value;
    }
  }

  // Save quotation
  Future<void> saveQuotation() async {
    try {
      isLoading.value = true;

      final companyId = SessionService.instance.companyId;
      final companyName = SessionService.instance.companyName;

      if (companyId == null || companyName.isEmpty) {
        Get.snackbar(
          'Error',
          'Company information not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
        return;
      }

      final payload = <String, dynamic>{
        'company_id': companyId,
        'company_name': companyName,
        'customer_name': customerNameController.text.trim(),
        'quality': qualityController.text.trim(),
        'warp_count': warpCountController.text.trim(),
        'weft_count': weftCountController.text.trim(),
        'reeds': reedsController.text.trim(),
        'picks': picksController.text.trim(),
        'grey_width': greyWidthController.text.trim(),
        'finish_width': finishWidthController.text.trim(),
        'pc_ratio': pcRatioController.text.trim(),
        'loom': loomController.text.trim(),
        'weave': weaveController.text.trim(),
        'warp_rate_lbs': warpRateLbsController.text.trim(),
        'weft_rate_lbs': weftRateLbsController.text.trim(),
        'conversion_pick': conversionPickController.text.trim(),
        'warp_weight': warpWeightController.text.trim(),
        'weft_weight': weftWeightController.text.trim(),
        'total_weight': totalWeightController.text.trim(),
        'warp_price': warpPriceController.text.trim(),
        'weft_price': weftPriceController.text.trim(),
        'conversion_charges': conversionChargesController.text.trim(),
        'grey_fabric_price': fabricPriceMeterController.text.trim(),
        'mending_mt': mendingMTController.text.trim(),
        'packing_type': packingTypeController.text.trim(),
        'packing_charges': packingChargesMTController.text.trim(),
        'wastage': wastagePercentController.text.trim(),
        'container_size': containerSizeController.text.trim(),
        'container_capacity': containerCapacityController.text.trim(),
        'fob_price_pkr': fobPricePKRController.text.trim(),
        'exchange_rate': rateOfExchangeController.text.trim(),
        'fob_price_dollar': fobPriceDollarController.text.trim(),
        'freight_dollar': freightInDollarController.text.trim(),
        'freight_calculation_dollar': freightCalculationController.text.trim(),
        'c_f_price_dollar': cfPriceInDollarController.text.trim(),
        'commission': commissionController.text.trim(),
        'port': rateController.text.trim(),
        'profit': profitController.text.trim(),
        'overhead': overheadController.text.trim(),
        'fob_final_price': fobPriceFinalController.text.trim(),
        'c_f_final_price': cfPriceFinalController.text.trim(),
      };

      // Add process_type and process_inch if not "Process Type"
      if (selectedProcessType.value != 'Process Type') {
        payload['process_type'] = selectedProcessType.value;
        payload['process_inch'] = processRateController.text.trim();
      }

      final response = await _apiService.saveExportMadeupsFabricQuote(payload: payload);

      Get.snackbar(
        'Success',
        response['message']?.toString() ?? 'Quotation saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save quotation: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Generate PDF
  Future<void> generatePDF() async {
    try {
      isLoading.value = true;

      // Build full page data from all form fields (structured rows to mirror the sheet)
      // Build table rows matching the on-screen layout (matching grey_fabric structure for common fields)
      final rows = <List<List<String>>>[
        [
          ['Customer Name', customerNameController.text],
        ],
         [
          ['Product Name', productNameController.text],
          ['Product Size', productSizeController.text],
        ],
        [ 
          ['Quality', qualityController.text],
        ],
        [
          ['Warp Count', warpCountController.text],
          ['Weft Count', weftCountController.text],
        ],
        [
          ['Reeds', reedsController.text],
          ['Picks', picksController.text],
        ],
        [
          ['Grey Width', greyWidthController.text],
        ],
        [
          ['P/C Ratio', pcRatioController.text],
          ['Loom', loomController.text],
        ],
        [
          ['Weave', weaveController.text],
        ],
        [
          ['Warp Rate/Lbs', warpRateLbsController.text],
          ['Weft Rate/Lbs', weftRateLbsController.text],
        ],
        [
          ['Conversion/Picks', conversionPickController.text],
        ],
        [
          ['Warp Weight', warpWeightController.text],
          ['Weft Weight', weftWeightController.text],
        ],
        [
          ['Total Weight', totalWeightController.text],
        ],
        [
          ['Warp Price', warpPriceController.text],
          ['Weft Price', weftPriceController.text],
          ['Conversion Charges', conversionChargesController.text],
        ],
        [
          ['Fabric Price/Meter', fabricPriceMeterController.text],
          ['Profit %', profitController.text],
          ['FOB Price Final', fobPriceFinalController.text],
        ],
        // Additional Madeups-specific fields
       
        [
          ['Finish Width', finishWidthController.text],
        ],
        [
          ['Mending/MT', mendingMTController.text],
          ['Process Type', processTypeController.text],
        ],
        [
          ['Process/Inch', processRateController.text],
          ['Process Charges', processChargesController.text],
        ],
        [
          ['Packing Type', packingTypeController.text],
          ['Packing Charges/MT', packingChargesMTController.text],
        ],
        [
          ['Wastage %', wastagePercentController.text],
          ['Finish Fabric Cost', finishFabricCostController.text],
        ],
        [
          ['Consumption', consumptionController.text],
          ['Consumption Price', consumptionPriceController.text],
        ],
        [
          ['Stitching', stitchingController.text],
          ['Accessories', accessoriesController.text],
        ],
        [
          ['Poly Bag', polyBagController.text],
          ['Miscellaneous', miscellaneousController.text],
        ],
        [
          ['Container Size', containerSizeController.text],
          ['Container Capacity', containerCapacityController.text],
        ],
        [
          ['Rate of Exchange', rateOfExchangeController.text],
          ['FOB Price in PKR', fobPricePKRController.text],
        ],
        [
          ['FOB Price in \$', fobPriceDollarController.text],
          ['Freight in \$', freightInDollarController.text],
        ],
        [
          ['Port', rateController.text],
          ['Freight Calculation \$', freightCalculationController.text],
        ],
        [
          ['C & F Price in \$', cfPriceInDollarController.text],
          ['Commission %', commissionController.text],
        ],
        [
          ['Overhead %', overheadController.text],
          ['C & F Price Final', cfPriceFinalController.text],
        ],
      ];

      final pages = [
        {'title': 'Export Madeups Fabric Sheet', 'rows': rows}
      ];

      // Use printing utility to directly open print dialog (no preview) and await result
      try {
        await printPagesDirect(pages, header: 'Export Madeups Fabric Sheet');
        Get.snackbar(
          'Success',
          'PDF generated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form
  void clearForm() {
    customerNameController.clear();
    productNameController.clear();
    productSizeController.clear();
    qualityController.clear();
    warpCountController.clear();
    weftCountController.clear();
    reedsController.clear();
    picksController.clear();
    greyWidthController.clear();
    finishWidthController.clear();
    pcRatioController.clear();
    loomController.clear();
    weaveController.clear();
    warpRateLbsController.clear();
    weftRateLbsController.clear();
    conversionPickController.clear();
    warpWeightController.clear();
    weftWeightController.clear();
    totalWeightController.clear();
    warpPriceController.clear();
    weftPriceController.clear();
    conversionChargesController.clear();
    fabricPriceMeterController.clear();
    mendingMTController.clear();
    processTypeController.clear();
    processRateController.clear();
    processChargesController.clear();
    packingTypeController.clear();
    packingChargesMTController.clear();
    wastagePercentController.clear();
    finishFabricCostController.clear();
    consumptionController.clear();
    consumptionPriceController.clear();
    stitchingController.clear();
    accessoriesController.clear();
    polyBagController.clear();
    miscellaneousController.clear();
    containerSizeController.clear();
    containerCapacityController.clear();
    rateOfExchangeController.clear();
    fobPricePKRController.clear();
    fobPriceDollarController.clear();
    freightInDollarController.clear();
    rateController.clear();
    freightCalculationController.clear();
    cfPriceInDollarController.clear();
    commissionController.clear();
    overheadController.clear();
    profitController.clear();
    cfPriceFinalController.clear();
    fobPriceFinalController.clear();
    selectedProcessType.value = 'Process Type';
  }
}