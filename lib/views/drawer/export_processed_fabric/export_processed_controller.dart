import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/pdf_printer.dart';
import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';

class ExportProcessedFabricController extends GetxController {
  final ApiService _apiService = ApiService();
  // Text Controllers
  final customerNameController = TextEditingController();
  
  // Row 1
  final qualityController = TextEditingController();
  final warpCountController = TextEditingController();
  final weftCountController = TextEditingController();
  final reedsController = TextEditingController();
  final picksController = TextEditingController();
  final greyWidthController = TextEditingController();
  
  // Row 2
  final finishWidthController = TextEditingController();
  final pcRatioController = TextEditingController();
  final loomController = TextEditingController();
  final weaveController = TextEditingController();
  final warpRateLbsController = TextEditingController();
  final weftRateLbsController = TextEditingController();
  
  // Row 3 - Calculated & Input
  final coversionPickController = TextEditingController(); // INPUT field
  final warpWeightController = TextEditingController(); // CALCULATED
  final weftWeightController = TextEditingController(); // CALCULATED
  final totalWeightController = TextEditingController(); // CALCULATED
  final warpPriceController = TextEditingController(); // INPUT or CALCULATED
  final weftPriceController = TextEditingController(); // INPUT or CALCULATED
  
  // Row 4
  final coversionChargesController = TextEditingController(); // CALCULATED
  final greyFabricPriceController = TextEditingController(); // CALCULATED
  final mendingMTController = TextEditingController();
  final processTypeController = TextEditingController();
  final processRateController = TextEditingController();
  final processChargesController = TextEditingController(); // CALCULATED
  
  // Row 5
  final packingTypeController = TextEditingController();
  final packingChargesMTController = TextEditingController();
  final wastagePercentController = TextEditingController();
  final containerSizeController = TextEditingController();
  final containerCapacityController = TextEditingController();
  final fobPricePKRController = TextEditingController(); // CALCULATED
  
  // Row 6
  final rateOfExchangeController = TextEditingController();
  final fobPriceDollarController = TextEditingController(); // CALCULATED
  final portController = TextEditingController();
  final freightInDollarController = TextEditingController();
  final freightCalculationController = TextEditingController(); // CALCULATED
  final cfPriceInDollarController = TextEditingController(); // CALCULATED
  
  // Row 7
  final commissionController = TextEditingController();
  final profitController = TextEditingController();
  final overheadController = TextEditingController();
  final fobPriceFinalController = TextEditingController(); // CALCULATED
  final cfPriceFinalController = TextEditingController(); // CALCULATED

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
    'Finishing',
  ];
  final selectedProcessType = 'Process Type'.obs;

  // Dynamic labels for process inputs based on selected process type
  String get processRateLabel {
    final type = selectedProcessType.value.toLowerCase();
    if (type == 'dyeing') return 'Dyeing/Inch';
    if (type == 'bleaching') return 'Bleaching/Inch';
    if (type == 'printing') return 'Printing/Inch';
    if (type == 'finishing') return 'Finishing/Inch';
    return 'Process/Inch';
  }

  String get processChargesLabel {
    final type = selectedProcessType.value.toLowerCase();
    if (type == 'dyeing') return 'Dyeing Charges';
    if (type == 'bleaching') return 'Bleaching Charges';
    if (type == 'printing') return 'Printing Charges';
    if (type == 'finishing') return 'Finishing Charges';
    return 'Process Charges';
  }

  @override
  void onInit() {
    super.onInit();
    _setupCalculations();
  }

  @override
  void onClose() {
    // Dispose all controllers
    customerNameController.dispose();
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
    coversionPickController.dispose();
    warpWeightController.dispose();
    weftWeightController.dispose();
    totalWeightController.dispose();
    warpPriceController.dispose();
    weftPriceController.dispose();
    coversionChargesController.dispose();
    greyFabricPriceController.dispose();
    mendingMTController.dispose();
    processTypeController.dispose();
    processRateController.dispose();
    processChargesController.dispose();
    packingTypeController.dispose();
    packingChargesMTController.dispose();
    wastagePercentController.dispose();
    containerSizeController.dispose();
    containerCapacityController.dispose();
    fobPricePKRController.dispose();
    rateOfExchangeController.dispose();
    fobPriceDollarController.dispose();
    portController.dispose();
    freightInDollarController.dispose();
    freightCalculationController.dispose();
    cfPriceInDollarController.dispose();
    commissionController.dispose();
    profitController.dispose();
    overheadController.dispose();
    fobPriceFinalController.dispose();
    cfPriceFinalController.dispose();
    super.onClose();
  }

  void _setupCalculations() {
    // ROW 3: Weight Calculations
    // Warp weight depends on: reeds, grey_width, warp_count
    reedsController.addListener(_calculateWarpWeight);
    greyWidthController.addListener(() {
      _calculateWarpWeight();
      _calculateWeftWeight();
    });
    warpCountController.addListener(_calculateWarpWeight);

    // Weft weight depends on: picks, grey_width, weft_count
    picksController.addListener(() {
      _calculateWeftWeight();
      _calculateConversionCharges();
    });
    weftCountController.addListener(_calculateWeftWeight);
    
    // Total weight
    warpWeightController.addListener(_calculateTotalWeight);
    weftWeightController.addListener(_calculateTotalWeight);
    
    // ROW 4: Price Calculations
    // Warp/Weft prices can be calculated OR manually entered
    warpRateLbsController.addListener(_calculateWarpPrice);
    warpWeightController.addListener(_calculateWarpPrice);
    weftRateLbsController.addListener(_calculateWeftPrice);
    weftWeightController.addListener(_calculateWeftPrice);

    // Conversion charges = conversion_per_pick * picks
    coversionPickController.addListener(_calculateConversionCharges);

    // Grey fabric price = warp_price + weft_price + conversion_charges
    warpPriceController.addListener(_calculateGreyFabricPrice);
    weftPriceController.addListener(_calculateGreyFabricPrice);
    coversionChargesController.addListener(_calculateGreyFabricPrice);

    // Process charges = finish_width * process_rate
    finishWidthController.addListener(_calculateProcessCharges);
    processRateController.addListener(_calculateProcessCharges);
    
    // ROW 5: FOB Price in PKR
    // Formula: base = mending + grey_fabric_price + packing_charges
    // fob_pkr = base + (wastage% * base / 100) + process_charges
    greyFabricPriceController.addListener(_calculateFOBPricePKR);
    mendingMTController.addListener(_calculateFOBPricePKR);
    processChargesController.addListener(_calculateFOBPricePKR);
    packingChargesMTController.addListener(_calculateFOBPricePKR);
    wastagePercentController.addListener(_calculateFOBPricePKR);
    
    // ROW 6: Exchange and Freight
    fobPricePKRController.addListener(_calculateFOBDollar);
    rateOfExchangeController.addListener(_calculateFOBDollar);
    
    containerCapacityController.addListener(_calculateFreightCalculation);
    freightInDollarController.addListener(_calculateFreightCalculation);
    
    fobPriceDollarController.addListener(_calculateCFPriceDollar);
    freightCalculationController.addListener(_calculateCFPriceDollar);
    
    // ROW 7: Final Prices with Commission/Profit/Overhead
    fobPriceDollarController.addListener(_calculateFOBPriceFinal);
    commissionController.addListener(() {
      _calculateFOBPriceFinal();
      _calculateCFPriceFinal();
    });
    profitController.addListener(() {
      _calculateFOBPriceFinal();
      _calculateCFPriceFinal();
    });
    overheadController.addListener(() {
      _calculateFOBPriceFinal();
      _calculateCFPriceFinal();
    });
    
    cfPriceInDollarController.addListener(_calculateCFPriceFinal);
  }

  // ROW 3 CALCULATIONS
  
  // Calculate Warp Weight
  void _calculateWarpWeight() {
    final reeds = double.tryParse(reedsController.text) ?? 0;
    final width = double.tryParse(greyWidthController.text) ?? 0;
    final warpCount = double.tryParse(warpCountController.text) ?? 0;
    
    if (reeds > 0 && width > 0 && warpCount > 0) {
      final warpWeight = (((reeds * width) / 800.0) / warpCount) * 1.0936;
      warpWeightController.text = warpWeight.toStringAsFixed(4);
    } else {
      warpWeightController.text = '0.0000';
    }
  }

  // Calculate Weft Weight
  void _calculateWeftWeight() {
    final picks = double.tryParse(picksController.text) ?? 0;
    final width = double.tryParse(greyWidthController.text) ?? 0;
    final weftCount = double.tryParse(weftCountController.text) ?? 0;
    
    if (picks > 0 && width > 0 && weftCount > 0) {
      final weftWeight = (((picks * width) / 800.0) / weftCount) * 1.0936;
      weftWeightController.text = weftWeight.toStringAsFixed(4);
    } else {
      weftWeightController.text = '0.0000';
    }
  }

  // Calculate Total Weight
  void _calculateTotalWeight() {
    final warpWeight = double.tryParse(warpWeightController.text) ?? 0;
    final weftWeight = double.tryParse(weftWeightController.text) ?? 0;
    final total = warpWeight + weftWeight;
    totalWeightController.text = total.toStringAsFixed(4);
  }

  // ROW 4 CALCULATIONS
  
  // Calculate Warp Price = rate * weight
  void _calculateWarpPrice() {
    final rate = double.tryParse(warpRateLbsController.text) ?? 0;
    final weight = double.tryParse(warpWeightController.text) ?? 0;
    
    if (rate > 0 && weight > 0) {
      final price = rate * weight;
      warpPriceController.text = price.toStringAsFixed(4);
    }
  }

  // Calculate Weft Price = rate * weight
  void _calculateWeftPrice() {
    final rate = double.tryParse(weftRateLbsController.text) ?? 0;
    final weight = double.tryParse(weftWeightController.text) ?? 0;
    
    if (rate > 0 && weight > 0) {
      final price = rate * weight;
      weftPriceController.text = price.toStringAsFixed(4);
    }
  }

  // Calculate Conversion Charges = conversion_pick * picks
  void _calculateConversionCharges() {
    final conversion = double.tryParse(coversionPickController.text) ?? 0;
    final picks = double.tryParse(picksController.text) ?? 0;
    final charges = conversion * picks;
    coversionChargesController.text = charges.toStringAsFixed(4);
  }

  // Calculate Grey Fabric Price = warp_price + weft_price + conversion_charges
  void _calculateGreyFabricPrice() {
    final warpPrice = double.tryParse(warpPriceController.text) ?? 0;
    final weftPrice = double.tryParse(weftPriceController.text) ?? 0;
    final conversionCharges = double.tryParse(coversionChargesController.text) ?? 0;
    final total = warpPrice + weftPrice + conversionCharges;
    greyFabricPriceController.text = total.toStringAsFixed(4);
  }

  // Calculate Process Charges = finish_width * process_rate
  void _calculateProcessCharges() {
    final finishWidth = double.tryParse(finishWidthController.text) ?? 0;
    final processRate = double.tryParse(processRateController.text) ?? 0;
    final charges = finishWidth * processRate;
    processChargesController.text = charges.toStringAsFixed(4);
  }

  // ROW 5 CALCULATIONS
  
  // Calculate FOB Price in PKR
  // Formula: base = mending + grey_fabric_price + packing_charges
  // fob_pkr = base + (wastage% * base / 100) + process_charges
  void _calculateFOBPricePKR() {
    final greyFabricPrice = double.tryParse(greyFabricPriceController.text) ?? 0;
    final mending = double.tryParse(mendingMTController.text) ?? 0;
    final processCharges = double.tryParse(processChargesController.text) ?? 0;
    final packingCharges = double.tryParse(packingChargesMTController.text) ?? 0;
    final wastagePercent = double.tryParse(wastagePercentController.text) ?? 0;

    // Base calculation (without process charges and wastage)
    final base = mending + greyFabricPrice + packingCharges;
    
    // Add wastage percentage to base, then add process charges
    final fobPrice = base + (wastagePercent * base / 100.0) + processCharges;
    fobPricePKRController.text = fobPrice.toStringAsFixed(4);
  }

  // ROW 6 CALCULATIONS
  
  // Calculate FOB Price in Dollar = fob_pkr / exchange_rate
  void _calculateFOBDollar() {
    final fobPKR = double.tryParse(fobPricePKRController.text) ?? 0;
    final rate = double.tryParse(rateOfExchangeController.text) ?? 0;
    
    if (rate > 0) {
      final fobDollar = fobPKR / rate;
      fobPriceDollarController.text = fobDollar.toStringAsFixed(4);
    } else {
      fobPriceDollarController.text = '0.0000';
    }
  }

  // Calculate Freight Calculation = freight_dollar / container_capacity
  void _calculateFreightCalculation() {
    final capacity = double.tryParse(containerCapacityController.text) ?? 0;
    final freight = double.tryParse(freightInDollarController.text) ?? 0;
    
    if (capacity > 0) {
      final freightCalc = freight / capacity;
      freightCalculationController.text = freightCalc.toStringAsFixed(4);
    } else {
      freightCalculationController.text = '0.0000';
    }
  }

  // Calculate C&F Price in Dollar = fob_dollar + freight_calculation
  void _calculateCFPriceDollar() {
    final fobDollar = double.tryParse(fobPriceDollarController.text) ?? 0;
    final freightCalc = double.tryParse(freightCalculationController.text) ?? 0;
    
    final cfPrice = fobDollar + freightCalc;
    cfPriceInDollarController.text = cfPrice.toStringAsFixed(4);
  }

  // ROW 7 CALCULATIONS
  
  // Calculate FOB Price Final = fob_dollar * (1 + commission% + profit% + overhead%)
  void _calculateFOBPriceFinal() {
    final fobDollar = double.tryParse(fobPriceDollarController.text) ?? 0;
    final commission = double.tryParse(commissionController.text) ?? 0;
    final profit = double.tryParse(profitController.text) ?? 0;
    final overhead = double.tryParse(overheadController.text) ?? 0;
    
    final totalPercent = 1 + (commission / 100) + (profit / 100) + (overhead / 100);
    final fobFinal = fobDollar * totalPercent;
    fobPriceFinalController.text = fobFinal.toStringAsFixed(4);
  }

  // Calculate C&F Price Final = cf_dollar * (1 + commission% + profit% + overhead%)
  void _calculateCFPriceFinal() {
    final cfDollar = double.tryParse(cfPriceInDollarController.text) ?? 0;
    final commission = double.tryParse(commissionController.text) ?? 0;
    final profit = double.tryParse(profitController.text) ?? 0;
    final overhead = double.tryParse(overheadController.text) ?? 0;
    
    final totalPercent = 1 + (commission / 100) + (profit / 100) + (overhead / 100);
    final cfFinal = cfDollar * totalPercent;
    cfPriceFinalController.text = cfFinal.toStringAsFixed(4);
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
    if (formKey.currentState?.validate() ?? true) {
      try {
        isLoading.value = true;

        final companyId = SessionService.instance.companyId;
        final companyName = SessionService.instance.companyName;

        if (companyId == null || companyName.isEmpty) {
          Get.snackbar(
            'Error',
            'Company information not found. Please login again.',
            backgroundColor: const Color(0xFFF44336),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: EdgeInsets.symmetric(vertical: 200),
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
          'pc_ratio': pcRatioController.text.trim(),
          'loom': loomController.text.trim(),
          'weave': weaveController.text.trim(),
          'warp_rate_lbs': warpRateLbsController.text.trim(),
          'weft_rate_lbs': weftRateLbsController.text.trim(),
          'conversion_pick': coversionPickController.text.trim(),
          'warp_weight': warpWeightController.text.trim(),
          'weft_weight': weftWeightController.text.trim(),
          'total_weight': totalWeightController.text.trim(),
          'warp_price': warpPriceController.text.trim(),
          'weft_price': weftPriceController.text.trim(),
          'conversion_charges': coversionChargesController.text.trim(),
          'grey_fabric_price': greyFabricPriceController.text.trim(),
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
          'port': portController.text.trim(),
          'profit': profitController.text.trim(),
          'overhead': overheadController.text.trim(),
          'fob_final_price': fobPriceFinalController.text.trim(),
          'c_f_final_price': cfPriceFinalController.text.trim(),
        };

        // Add process_type if not "Process Type"
        if (selectedProcessType.value != 'Process Type') {
          payload['process_type'] = selectedProcessType.value;
        }

        final response = await _apiService.saveExportProcessedFabricQuote(payload: payload);

        Get.snackbar(
          'Success',
          response['message']?.toString() ?? 'Quotation saved successfully',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } on ApiException catch (e) {
        Get.snackbar(
          'Error',
          e.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to save quotation: $e',
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Generate PDF
  Future<void> generatePDF() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Build table rows matching the on-screen layout (matching grey_fabric structure for common fields)
        final rows = <List<List<String>>>[
          [
            ['Customer Name', customerNameController.text],
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
            ['Conversion/Picks', coversionPickController.text],
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
            ['Conversion Charges', coversionChargesController.text],
          ],
          [
            ['Grey Fabric Price', greyFabricPriceController.text],
            ['Profit %', profitController.text],
            ['FOB Price Final', fobPriceFinalController.text],
          ],
          // Additional Processed Fabric-specific fields
          [
            ['Finish Width', finishWidthController.text],
          ],
          [
            ['Mending/MT', mendingMTController.text],
            ['Process Type', processTypeController.text],
          ],
          [
            [processRateLabel, processRateController.text],
            [processChargesLabel, processChargesController.text],
          ],
          [
            ['Packing Type', packingTypeController.text],
            ['Packing Charges/MT', packingChargesMTController.text],
          ],
          [
            ['Wastage %', wastagePercentController.text],
            ['Container Size', containerSizeController.text],
          ],
          [
            ['Container Capacity', containerCapacityController.text],
            ['FOB Price in PKR', fobPricePKRController.text],
          ],
          [
            ['Rate of Exchange', rateOfExchangeController.text],
            ['FOB Price in \$', fobPriceDollarController.text],
          ],
          [
            ['Port', portController.text],
            ['Freight in \$', freightInDollarController.text],
          ],
          [
            ['Freight Calculation \$', freightCalculationController.text],
            ['C & F Price in \$', cfPriceInDollarController.text],
          ],
          [
            ['Commission %', commissionController.text],
            ['Overhead %', overheadController.text],
          ],
          [
            ['C & F Price Final', cfPriceFinalController.text],
          ],
        ];

        final pages = [
          {'title': 'Export Processed Fabric Sheet', 'rows': rows}
        ];

        try {
          await printPagesDirect(pages, header: 'Export Processed Fabric Sheet');
          Get.snackbar(
            'Success',
            'PDF generated successfully',
            backgroundColor: const Color(0xFF4CAF50),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: EdgeInsets.symmetric(vertical: 200),
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to generate PDF: $e',
            backgroundColor: const Color(0xFFF44336),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: EdgeInsets.symmetric(vertical: 200),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to generate PDF: $e',
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Clear form
  void clearForm() {
    formKey.currentState?.reset();
    // Clear all controllers
    customerNameController.clear();
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
    coversionPickController.clear();
    warpWeightController.clear();
    weftWeightController.clear();
    totalWeightController.clear();
    warpPriceController.clear();
    weftPriceController.clear();
    coversionChargesController.clear();
    greyFabricPriceController.clear();
    mendingMTController.clear();
    processRateController.clear();
    processChargesController.clear();
    packingTypeController.clear();
    packingChargesMTController.clear();
    wastagePercentController.clear();
    containerSizeController.clear();
    containerCapacityController.clear();
    fobPricePKRController.clear();
    rateOfExchangeController.clear();
    fobPriceDollarController.clear();
    portController.clear();
    freightInDollarController.clear();
    freightCalculationController.clear();
    cfPriceInDollarController.clear();
    commissionController.clear();
    profitController.clear();
    overheadController.clear();
    fobPriceFinalController.clear();
    cfPriceFinalController.clear();
    selectedProcessType.value = 'Process Type';
  }
}