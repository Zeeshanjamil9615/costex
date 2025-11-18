import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/utils/pdf_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExportGreyController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;

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
  final pcRatioController = TextEditingController();
  final loomController = TextEditingController();
  final weaveController = TextEditingController();
  final warpRateController = TextEditingController(); // Added
  final weftRateController = TextEditingController(); // Added
  final coversionPickController = TextEditingController(); // Added (as per UI naming)
  
  // Row 3 - Calculated fields
  final warpWeightController = TextEditingController();
  final weftWeightController = TextEditingController();
  final totalWeightController = TextEditingController();
  final warpPriceController = TextEditingController();
  final weftPriceController = TextEditingController();
  final coversionChargesController = TextEditingController(); // Added (as per UI naming)
  
  // Row 4
  final greyFabricPriceController = TextEditingController();
  final mendingMTController = TextEditingController();
  final packingTypeController = TextEditingController();
  final packingChargesController = TextEditingController(); // Added
  final wastageController = TextEditingController(); // Added
  final containerSizeController = TextEditingController();
  
  // Row 5
  final containerCapacityController = TextEditingController();
  final fobPricePKRController = TextEditingController();
  final rateOfExchangeController = TextEditingController();
  final fobPriceDollarController = TextEditingController();
  final freightInDollarController = TextEditingController(); // Added (as per UI naming)
  
  // Row 6
  final freightCalculationController = TextEditingController(); // Added (as per UI naming)
  final cfPriceController = TextEditingController(); // Added
  final commissionController = TextEditingController();
  final portController = TextEditingController();
  
  // Row 7
  final profitPercentController = TextEditingController();
  final overheadPercentController = TextEditingController();
  final fobPriceFinalController = TextEditingController();
  final cfPriceFinalController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Loading state
  final isLoading = false.obs;

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
    pcRatioController.dispose();
    loomController.dispose();
    weaveController.dispose();
    warpRateController.dispose();
    weftRateController.dispose();
    coversionPickController.dispose();
    warpWeightController.dispose();
    weftWeightController.dispose();
    totalWeightController.dispose();
    warpPriceController.dispose();
    weftPriceController.dispose();
    coversionChargesController.dispose();
    greyFabricPriceController.dispose();
    mendingMTController.dispose();
    packingTypeController.dispose();
    packingChargesController.dispose();
    wastageController.dispose();
    containerSizeController.dispose();
    containerCapacityController.dispose();
    fobPricePKRController.dispose();
    rateOfExchangeController.dispose();
    fobPriceDollarController.dispose();
    freightInDollarController.dispose();
    freightCalculationController.dispose();
    cfPriceController.dispose();
    commissionController.dispose();
    portController.dispose();
    profitPercentController.dispose();
    overheadPercentController.dispose();
    fobPriceFinalController.dispose();
    cfPriceFinalController.dispose();
    super.onClose();
  }

  void _setupCalculations() {
    // Core inputs affecting warp/weft/price calculations
    reedsController.addListener(_recalculateCore);
    greyWidthController.addListener(_recalculateCore);
    warpCountController.addListener(_recalculateCore);
    picksController.addListener(_recalculateCore);
    weftCountController.addListener(_recalculateCore);
    warpRateController.addListener(_recalculateCore);
    weftRateController.addListener(_recalculateCore);
    coversionPickController.addListener(_recalculateCore);
    profitPercentController.addListener(_recalculateCore);

    // Also recompute totals if any calculated field changes directly
    warpWeightController.addListener(_calculateTotalWeight);
    weftWeightController.addListener(_calculateTotalWeight);
    warpPriceController.addListener(_calculateGreyFabricPrice);
    weftPriceController.addListener(_calculateGreyFabricPrice);
    coversionChargesController.addListener(_calculateGreyFabricPrice);

    // Other independent calculations
    fobPricePKRController.addListener(_calculateFOBDollar);
    rateOfExchangeController.addListener(_calculateFOBDollar);

    // FOB PKR depends on grey fabric price, mending, packing, wastage
    greyFabricPriceController.addListener(_calculateFobPKR);
    mendingMTController.addListener(_calculateFobPKR);
    packingChargesController.addListener(_calculateFobPKR);
    wastageController.addListener(_calculateFobPKR);

    // FOB Final depends on FOB dollar and percentages
    fobPriceDollarController.addListener(_calculateFobFinal);
    overheadPercentController.addListener(_calculateFobFinal);
    profitPercentController.addListener(_calculateFobFinal);
    commissionController.addListener(_calculateFobFinal);

    // C&F price depends on FOB dollar and freight calculation
    freightCalculationController.addListener(_calculateCFPrice);
    fobPriceDollarController.addListener(_calculateCFPrice);

    // C&F final depends on C&F price and percentages
    cfPriceController.addListener(_calculateCFFinal);
    overheadPercentController.addListener(_calculateCFFinal);
    profitPercentController.addListener(_calculateCFFinal);
    commissionController.addListener(_calculateCFFinal);

    containerCapacityController.addListener(_calculateFreight);
    freightInDollarController.addListener(_calculateFreight);
  }

  // Central recalculation for script parity
  void _recalculateCore() {
    final reeds = _toD(reedsController.text);
    final width = _toD(greyWidthController.text);
    final warpCount = _toD(warpCountController.text);
    final picks = _toD(picksController.text);
    final weftCount = _toD(weftCountController.text);
    final warpRate = _toD(warpRateController.text);
    final weftRate = _toD(weftRateController.text);
    final conversionPerPick = _toD(coversionPickController.text);
    final profitPct = _toD(profitPercentController.text);

    // warp weight = ((((reeds*width)/800)/wrap_count)*1.0936)
    double warpWeight = 0;
    if (warpCount > 0) {
      warpWeight = (((reeds * width) / 800.0) / warpCount) * 1.0936;
    }
    warpWeightController.text = warpWeight.toStringAsFixed(4);

    // weft weight = ((((picks*width)/800)/weft_count)*1.0936)
    double weftWeight = 0;
    if (weftCount > 0) {
      weftWeight = (((picks * width) / 800.0) / weftCount) * 1.0936;
    }
    weftWeightController.text = weftWeight.toStringAsFixed(4);

    // total weight
    final totalWeight = warpWeight + weftWeight;
    totalWeightController.text = totalWeight.toStringAsFixed(4);

    // warp price = warp_rate * warp_weight
    final warpPrice = warpRate * warpWeight;
    warpPriceController.text = warpPrice.toStringAsFixed(4);

    // weft price = weft_rate * weft_weight
    final weftPrice = weftRate * weftWeight;
    weftPriceController.text = weftPrice.toStringAsFixed(4);

    // conversion charges = conversion_pick * picks
    final conversionCharges = conversionPerPick * picks;
    coversionChargesController.text = conversionCharges.toStringAsFixed(4);

    // grey fabric price = conversion + weft price + warp price
    final greyFabric = conversionCharges + weftPrice + warpPrice;
    greyFabricPriceController.text = greyFabric.toStringAsFixed(4);

    // final price = grey fabric price + profit%
    final profitAmount = greyFabric * (profitPct / 100.0);
    final finalPrice = greyFabric + profitAmount;
    fobPriceFinalController.text = finalPrice.toStringAsFixed(4);
  }

  double _toD(String v) => double.tryParse(v.trim()) ?? 0.0;

  // Calculate Total Weight
  void _calculateTotalWeight() {
    final warpWeight = double.tryParse(warpWeightController.text) ?? 0;
    final weftWeight = double.tryParse(weftWeightController.text) ?? 0;
    final total = warpWeight + weftWeight;
    totalWeightController.text = total.toStringAsFixed(4);
  }

  // Calculate Grey Fabric Price
  void _calculateGreyFabricPrice() {
    final warpPrice = double.tryParse(warpPriceController.text) ?? 0;
    final weftPrice = double.tryParse(weftPriceController.text) ?? 0;
    final conversionCharges = double.tryParse(coversionChargesController.text) ?? 0;
    final total = warpPrice + weftPrice + conversionCharges;
    greyFabricPriceController.text = total.toStringAsFixed(4);
    // Grey fabric price impacts FOB PKR chain
    _calculateFobPKR();
  }

  // FOB Price in PKR = mending + grey fabric price + packing charges, then wastage%
  void _calculateFobPKR() {
    final greyFabric = double.tryParse(greyFabricPriceController.text) ?? 0;
    final mending = double.tryParse(mendingMTController.text) ?? 0;
    final packing = double.tryParse(packingChargesController.text) ?? 0;
    final wastagePct = double.tryParse(wastageController.text) ?? 0;
    double base = mending + greyFabric + packing;
    if (wastagePct > 0) {
      base = base + (wastagePct * base / 100.0);
    }
    fobPricePKRController.text = base.toStringAsFixed(4);
    // Chain to FOB Dollar
    _calculateFOBDollar();
  }

  // Calculate FOB Price in Dollar
  void _calculateFOBDollar() {
    final fobPKR = double.tryParse(fobPricePKRController.text) ?? 0;
    final rate = double.tryParse(rateOfExchangeController.text) ?? 0;
    if (rate > 0) {
      final fobDollar = fobPKR / rate;
      fobPriceDollarController.text = fobDollar.toStringAsFixed(4);
    } else {
      fobPriceDollarController.text = '0.0000';
    }
    _calculateFobFinal();
    _calculateCFPrice();
  }

  // Calculate Freight Calculation
  void _calculateFreight() {
    final capacity = double.tryParse(containerCapacityController.text) ?? 0;
    final freight = double.tryParse(freightInDollarController.text) ?? 0;
    if (capacity > 0) {
      final freightCalc = freight / capacity;
      freightCalculationController.text = freightCalc.toStringAsFixed(4);
    } else {
      freightCalculationController.text = '0.0000';
    }
    _calculateCFPrice();
  }

  // FOB Final (Dollar) = FOB Dollar + overhead% + profit% + commission%
  void _calculateFobFinal() {
    final fobDollar = double.tryParse(fobPriceDollarController.text) ?? 0;
    final overheadPct = double.tryParse(overheadPercentController.text) ?? 0;
    final profitPct = double.tryParse(profitPercentController.text) ?? 0;
    final commissionPct = double.tryParse(commissionController.text) ?? 0;
    final multiplier = 1 + (overheadPct + profitPct + commissionPct) / 100.0;
    final finalDollar = fobDollar * multiplier;
    fobPriceFinalController.text = finalDollar.toStringAsFixed(4);
  }

  // C & F Price (Dollar) = FOB Dollar + Freight Calculation
  void _calculateCFPrice() {
    final fobDollar = double.tryParse(fobPriceDollarController.text) ?? 0;
    final freightCalc = double.tryParse(freightCalculationController.text) ?? 0;
    final cf = fobDollar + freightCalc;
    cfPriceController.text = cf.toStringAsFixed(4);
    _calculateCFFinal();
  }

  // C & F Final = C & F Price + overhead% + profit% + commission%
  void _calculateCFFinal() {
    final cf = double.tryParse(cfPriceController.text) ?? 0;
    final overheadPct = double.tryParse(overheadPercentController.text) ?? 0;
    final profitPct = double.tryParse(profitPercentController.text) ?? 0;
    final commissionPct = double.tryParse(commissionController.text) ?? 0;
    final multiplier = 1 + (overheadPct + profitPct + commissionPct) / 100.0;
    final cfFinal = cf * multiplier;
    cfPriceFinalController.text = cfFinal.toStringAsFixed(4);
  }

  // Save quotation
  Future<void> saveQuotation() async {
  if (formKey.currentState?.validate() ?? true) {
      try {
        isLoading.value = true;

        final companyId = _session.companyId;
        if (companyId == null) {
          Get.snackbar(
            'Error',
            'Company information missing. Please login again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFF44336),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(16),
          );
          return;
        }

        final payload = {
          'company_id': companyId,
          'company_name': _session.companyName,
          'customer_name': _text(customerNameController),
          'quality': _text(qualityController),
          'warp_count': _number(warpCountController),
          'weft_count': _number(weftCountController),
          'reeds': _number(reedsController),
          'picks': _number(picksController),
          'grey_width': _number(greyWidthController),
          'pc_ratio': _text(pcRatioController),
          'loom': _text(loomController),
          'weave': _text(weaveController),
          'warp_rate_lbs': _number(warpRateController),
          'weft_rate_lbs': _number(weftRateController),
          'conversion_pick': _number(coversionPickController),
          'warp_weight': _number(warpWeightController),
          'weft_weight': _number(weftWeightController),
          'total_weight': _number(totalWeightController),
          'warp_price': _number(warpPriceController),
          'weft_price': _number(weftPriceController),
          'conversion_charges': _number(coversionChargesController),
          'grey_fabric_price': _number(greyFabricPriceController),
          'mending_mt': _number(mendingMTController),
          'packing_type': _text(packingTypeController),
          'packing charges': _number(packingChargesController),
          'wastage': _number(wastageController),
          'container_size': _text(containerSizeController),
          'container_capacity': _number(containerCapacityController),
          'fob_price_pkr': _number(fobPricePKRController),
          'exchange_rate': _number(rateOfExchangeController),
          'fob_price_dollar': _number(fobPriceDollarController),
          'freight in \$': _number(freightInDollarController),
          'freight_calculation_dollar': _number(freightCalculationController),
          'c & f price in \$': _number(cfPriceController),
          'commission': _number(commissionController),
          'port': _text(portController),
          'profit': _number(profitPercentController),
          'overhead': _number(overheadPercentController),
          'fob price final': _number(fobPriceFinalController),
          'c & f price final': _number(cfPriceFinalController),
        };

        final response = await _apiService.saveExportGreyFabricQuote(
          payload: payload,
        );

        Get.snackbar(
          'Success',
          response['message']?.toString() ??
              'Export grey fabric quotation saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
      } on ApiException catch (error) {
        Get.snackbar(
          'Error',
          error.message,
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
    } else {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFC107),
        colorText: Colors.black87,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  // Generate PDF
  Future<void> generatePDF() async {
  if (formKey.currentState?.validate() ?? true) {
      try {
        isLoading.value = true;

        final rows = <List<String>>[];
        rows.addAll([
          ['Customer', customerNameController.text],
          ['Quality', qualityController.text],
          ['Warp Count', warpCountController.text],
          ['Weft Count', weftCountController.text],
          ['Reeds', reedsController.text],
          ['Picks', picksController.text],
          ['Grey Width', greyWidthController.text],
          ['P/C Ratio', pcRatioController.text],
          ['Loom', loomController.text],
          ['Weave', weaveController.text],
          ['Warp Rate', warpRateController.text],
          ['Weft Rate', weftRateController.text],
          ['Conversion/Pick', coversionPickController.text],

          ['Warp Weight', warpWeightController.text],
          ['Weft Weight', weftWeightController.text],
          ['Total Weight', totalWeightController.text],
          ['Warp Price', warpPriceController.text],
          ['Weft Price', weftPriceController.text],
          ['Conversion Charges', coversionChargesController.text],

          ['Grey Fabric Price', greyFabricPriceController.text],
          ['Mending/MT', mendingMTController.text],
          ['Packing Type', packingTypeController.text],
          ['Packing Charges', packingChargesController.text],
          ['Wastage %', wastageController.text],
          ['Container Size', containerSizeController.text],

          ['Container Capacity', containerCapacityController.text],
          ['FOB Price PKR', fobPricePKRController.text],
          ['Rate of Exchange', rateOfExchangeController.text],
          ['FOB Price \$', fobPriceDollarController.text],
          ['Freight in \$', freightInDollarController.text],
          ['Freight Calculation', freightCalculationController.text],

          ['C&F Price', cfPriceController.text],
          ['Commission', commissionController.text],
          ['Port', portController.text],
          ['Profit %', profitPercentController.text],
          ['Overhead %', overheadPercentController.text],
          ['FOB Final', fobPriceFinalController.text],
          ['C&F Final', cfPriceFinalController.text],
        ]);

        final pages = [ {'title': 'Export Grey Fabric', 'rows': rows} ];
        try {
          await printPagesDirect(pages, header: 'Export Grey Fabric');
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
    } else {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFC107),
        colorText: Colors.black87,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  // Clear form
  void clearForm() {
    formKey.currentState?.reset();
    customerNameController.clear();
    qualityController.clear();
    warpCountController.clear();
    weftCountController.clear();
    reedsController.clear();
    picksController.clear();
    greyWidthController.clear();
    pcRatioController.clear();
    loomController.clear();
    weaveController.clear();
    warpRateController.clear();
    weftRateController.clear();
    coversionPickController.clear();
    warpWeightController.clear();
    weftWeightController.clear();
    totalWeightController.clear();
    warpPriceController.clear();
    weftPriceController.clear();
    coversionChargesController.clear();
    greyFabricPriceController.clear();
    mendingMTController.clear();
    packingTypeController.clear();
    packingChargesController.clear();
    wastageController.clear();
    containerSizeController.clear();
    containerCapacityController.clear();
    fobPricePKRController.clear();
    rateOfExchangeController.clear();
    fobPriceDollarController.clear();
    freightInDollarController.clear();
    freightCalculationController.clear();
    cfPriceController.clear();
    commissionController.clear();
    portController.clear();
    profitPercentController.clear();
    overheadPercentController.clear();
    fobPriceFinalController.clear();
    cfPriceFinalController.clear();
  }

  // Validators
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String _text(TextEditingController controller) => controller.text.trim();

  String _number(TextEditingController controller) {
    final value = controller.text.trim();
    if (value.isEmpty) return '0';
    return value;
  }
}