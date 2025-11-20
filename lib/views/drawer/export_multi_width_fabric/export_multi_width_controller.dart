import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/pdf_printer.dart';

class MultiMadeupsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  MultiMadeupsController({this.viewMode = false});

  final bool viewMode;

  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;
  late TabController tabController;
  final customerNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  
  // ============== BASIC DETAILS CONTROLLERS ==============
  final warp1Controller = TextEditingController();
  final weft1Controller = TextEditingController();
  final reed1Controller = TextEditingController();
  final pick1Controller = TextEditingController();
  final greyWidth1Controller = TextEditingController();
  final finishWidth1Controller = TextEditingController();
  
  final warp2Controller = TextEditingController();
  final weft2Controller = TextEditingController();
  final reed2Controller = TextEditingController();
  final pick2Controller = TextEditingController();
  final greyWidth2Controller = TextEditingController();
  final finishWidth2Controller = TextEditingController();
  
  final warp3Controller = TextEditingController();
  final weft3Controller = TextEditingController();
  final reed3Controller = TextEditingController();
  final pick3Controller = TextEditingController();
  final greyWidth3Controller = TextEditingController();
  final finishWidth3Controller = TextEditingController();
  
  final warp4Controller = TextEditingController();
  final weft4Controller = TextEditingController();
  final reed4Controller = TextEditingController();
  final pick4Controller = TextEditingController();
  final greyWidth4Controller = TextEditingController();
  final finishWidth4Controller = TextEditingController();
  
  // ============== CONSUMPTION DETAILS CONTROLLERS ==============
  final generalProductName1Controller = TextEditingController();
  final generalProductName2Controller = TextEditingController();
  final generalProductName3Controller = TextEditingController();
  final generalProductName4Controller = TextEditingController();
  
  // Product 1 - 4 rows
  final productName1_1Controller = TextEditingController();
  final size1_1Controller = TextEditingController();
  final size2_1_1Controller = TextEditingController();
  final cutSize1_1Controller = TextEditingController();
  final greyWidth1_1Controller = TextEditingController();
  final finishWidth1_1Controller = TextEditingController();
  final pcs1_1Controller = TextEditingController();
  final consumption1_1Controller = TextEditingController();
  final consumptionPrice1_1Controller = TextEditingController();
  final selectedGV1_1 = 'GV'.obs;
  final selectedFW1_1 = 'FW'.obs;
  
  final productName1_2Controller = TextEditingController();
  final size1_2Controller = TextEditingController();
  final size2_1_2Controller = TextEditingController();
  final cutSize1_2Controller = TextEditingController();
  final greyWidth1_2Controller = TextEditingController();
  final finishWidth1_2Controller = TextEditingController();
  final pcs1_2Controller = TextEditingController();
  final consumption1_2Controller = TextEditingController();
  final consumptionPrice1_2Controller = TextEditingController();
  final selectedGV1_2 = 'GV'.obs;
  final selectedFW1_2 = 'FW'.obs;
  
  final productName1_3Controller = TextEditingController();
  final size1_3Controller = TextEditingController();
  final size2_1_3Controller = TextEditingController();
  final cutSize1_3Controller = TextEditingController();
  final greyWidth1_3Controller = TextEditingController();
  final finishWidth1_3Controller = TextEditingController();
  final pcs1_3Controller = TextEditingController();
  final consumption1_3Controller = TextEditingController();
  final consumptionPrice1_3Controller = TextEditingController();
  final selectedGV1_3 = 'GV'.obs;
  final selectedFW1_3 = 'FW'.obs;
  
  final productName1_4Controller = TextEditingController();
  final size1_4Controller = TextEditingController();
  final size2_1_4Controller = TextEditingController();
  final cutSize1_4Controller = TextEditingController();
  final greyWidth1_4Controller = TextEditingController();
  final finishWidth1_4Controller = TextEditingController();
  final pcs1_4Controller = TextEditingController();
  final consumption1_4Controller = TextEditingController();
  final consumptionPrice1_4Controller = TextEditingController();
  final selectedGV1_4 = 'GV'.obs;
  final selectedFW1_4 = 'FW'.obs;
  
  final total1Controller = TextEditingController();
  
  // Product 2 - 4 rows
  final productName2_1Controller = TextEditingController();
  final size2_1Controller = TextEditingController();
  final size2_2_1Controller = TextEditingController();
  final cutSize2_1Controller = TextEditingController();
  final greyWidth2_1Controller = TextEditingController();
  final finishWidth2_1Controller = TextEditingController();
  final pcs2_1Controller = TextEditingController();
  final consumption2_1Controller = TextEditingController();
  final consumptionPrice2_1Controller = TextEditingController();
  final selectedGV2_1 = 'GV'.obs;
  final selectedFW2_1 = 'FW'.obs;
  
  final productName2_2Controller = TextEditingController();
  final size2_2Controller = TextEditingController();
  final size2_2_2Controller = TextEditingController();
  final cutSize2_2Controller = TextEditingController();
  final greyWidth2_2Controller = TextEditingController();
  final finishWidth2_2Controller = TextEditingController();
  final pcs2_2Controller = TextEditingController();
  final consumption2_2Controller = TextEditingController();
  final consumptionPrice2_2Controller = TextEditingController();
  final selectedGV2_2 = 'GV'.obs;
  final selectedFW2_2 = 'FW'.obs;
  
  final productName2_3Controller = TextEditingController();
  final size2_3Controller = TextEditingController();
  final size2_2_3Controller = TextEditingController();
  final cutSize2_3Controller = TextEditingController();
  final greyWidth2_3Controller = TextEditingController();
  final finishWidth2_3Controller = TextEditingController();
  final pcs2_3Controller = TextEditingController();
  final consumption2_3Controller = TextEditingController();
  final consumptionPrice2_3Controller = TextEditingController();
  final selectedGV2_3 = 'GV'.obs;
  final selectedFW2_3 = 'FW'.obs;
  
  final productName2_4Controller = TextEditingController();
  final size2_4Controller = TextEditingController();
  final size2_2_4Controller = TextEditingController();
  final cutSize2_4Controller = TextEditingController();
  final greyWidth2_4Controller = TextEditingController();
  final finishWidth2_4Controller = TextEditingController();
  final pcs2_4Controller = TextEditingController();
  final consumption2_4Controller = TextEditingController();
  final consumptionPrice2_4Controller = TextEditingController();
  final selectedGV2_4 = 'GV'.obs;
  final selectedFW2_4 = 'FW'.obs;
  
  final total2Controller = TextEditingController();
  
  // Product 3 - 4 rows
  final productName3_1Controller = TextEditingController();
  final size3_1Controller = TextEditingController();
  final size2_3_1Controller = TextEditingController();
  final cutSize3_1Controller = TextEditingController();
  final greyWidth3_1Controller = TextEditingController();
  final finishWidth3_1Controller = TextEditingController();
  final pcs3_1Controller = TextEditingController();
  final consumption3_1Controller = TextEditingController();
  final consumptionPrice3_1Controller = TextEditingController();
  final selectedGV3_1 = 'GV'.obs;
  final selectedFW3_1 = 'FW'.obs;
  
  final productName3_2Controller = TextEditingController();
  final size3_2Controller = TextEditingController();
  final size2_3_2Controller = TextEditingController();
  final cutSize3_2Controller = TextEditingController();
  final greyWidth3_2Controller = TextEditingController();
  final finishWidth3_2Controller = TextEditingController();
  final pcs3_2Controller = TextEditingController();
  final consumption3_2Controller = TextEditingController();
  final consumptionPrice3_2Controller = TextEditingController();
  final selectedGV3_2 = 'GV'.obs;
  final selectedFW3_2 = 'FW'.obs;
  
  final productName3_3Controller = TextEditingController();
  final size3_3Controller = TextEditingController();
  final size2_3_3Controller = TextEditingController();
  final cutSize3_3Controller = TextEditingController();
  final greyWidth3_3Controller = TextEditingController();
  final finishWidth3_3Controller = TextEditingController();
  final pcs3_3Controller = TextEditingController();
  final consumption3_3Controller = TextEditingController();
  final consumptionPrice3_3Controller = TextEditingController();
  final selectedGV3_3 = 'GV'.obs;
  final selectedFW3_3 = 'FW'.obs;
  
  final productName3_4Controller = TextEditingController();
  final size3_4Controller = TextEditingController();
  final size2_3_4Controller = TextEditingController();
  final cutSize3_4Controller = TextEditingController();
  final greyWidth3_4Controller = TextEditingController();
  final finishWidth3_4Controller = TextEditingController();
  final pcs3_4Controller = TextEditingController();
  final consumption3_4Controller = TextEditingController();
  final consumptionPrice3_4Controller = TextEditingController();
  final selectedGV3_4 = 'GV'.obs;
  final selectedFW3_4 = 'FW'.obs;
  
  final total3Controller = TextEditingController();
  
  // Product 4 - 4 rows
  final productName4_1Controller = TextEditingController();
  final size4_1Controller = TextEditingController();
  final size2_4_1Controller = TextEditingController();
  final cutSize4_1Controller = TextEditingController();
  final greyWidth4_1Controller = TextEditingController();
  final finishWidth4_1Controller = TextEditingController();
  final pcs4_1Controller = TextEditingController();
  final consumption4_1Controller = TextEditingController();
  final consumptionPrice4_1Controller = TextEditingController();
  final selectedGV4_1 = 'GV'.obs;
  final selectedFW4_1 = 'FW'.obs;
  
  final productName4_2Controller = TextEditingController();
  final size4_2Controller = TextEditingController();
  final size2_4_2Controller = TextEditingController();
  final cutSize4_2Controller = TextEditingController();
  final greyWidth4_2Controller = TextEditingController();
  final finishWidth4_2Controller = TextEditingController();
  final pcs4_2Controller = TextEditingController();
  final consumption4_2Controller = TextEditingController();
  final consumptionPrice4_2Controller = TextEditingController();
  final selectedGV4_2 = 'GV'.obs;
  final selectedFW4_2 = 'FW'.obs;
  
  final productName4_3Controller = TextEditingController();
  final size4_3Controller = TextEditingController();
  final size2_4_3Controller = TextEditingController();
  final cutSize4_3Controller = TextEditingController();
  final greyWidth4_3Controller = TextEditingController();
  final finishWidth4_3Controller = TextEditingController();
  final pcs4_3Controller = TextEditingController();
  final consumption4_3Controller = TextEditingController();
  final consumptionPrice4_3Controller = TextEditingController();
  final selectedGV4_3 = 'GV'.obs;
  final selectedFW4_3 = 'FW'.obs;
  
  final productName4_4Controller = TextEditingController();
  final size4_4Controller = TextEditingController();
  final size2_4_4Controller = TextEditingController();
  final cutSize4_4Controller = TextEditingController();
  final greyWidth4_4Controller = TextEditingController();
  final finishWidth4_4Controller = TextEditingController();
  final pcs4_4Controller = TextEditingController();
  final consumption4_4Controller = TextEditingController();
  final consumptionPrice4_4Controller = TextEditingController();
  final selectedGV4_4 = 'GV'.obs;
  final selectedFW4_4 = 'FW'.obs;
  
  final total4Controller = TextEditingController();
  
  // ============== FABRIC DETAILS CONTROLLERS ==============
  final quality1Controller = TextEditingController();
  final loom1Controller = TextEditingController();
  final weave1Controller = TextEditingController();
  final warpRateLbs1Controller = TextEditingController();
  final weftRateLbs1Controller = TextEditingController();
  final conversionPick1Controller = TextEditingController();
  final warpWeight1Controller = TextEditingController();
  final weftWeight1Controller = TextEditingController();
  final totalWeight1Controller = TextEditingController();
  final warpPrice1Controller = TextEditingController();
  final weftPrice1Controller = TextEditingController();
  final conversion1Controller = TextEditingController();
  final greyFabricPrice1Controller = TextEditingController();
  final mendingMT1Controller = TextEditingController();
  final processinginch1Controller = TextEditingController();
  final processingCharges1Controller = TextEditingController();
  final wastage1Controller = TextEditingController();
  final finishFabricCost1Controller = TextEditingController();
  
  final quality2Controller = TextEditingController();
  final loom2Controller = TextEditingController();
  final weave2Controller = TextEditingController();
  final warpRateLbs2Controller = TextEditingController();
  final weftRateLbs2Controller = TextEditingController();
  final conversionPick2Controller = TextEditingController();
  final warpWeight2Controller = TextEditingController();
  final weftWeight2Controller = TextEditingController();
  final totalWeight2Controller = TextEditingController();
  final warpPrice2Controller = TextEditingController();
  final weftPrice2Controller = TextEditingController();
  final conversion2Controller = TextEditingController();
  final greyFabricPrice2Controller = TextEditingController();
  final mendingMT2Controller = TextEditingController();
  final processinginch2Controller = TextEditingController();
  final processingCharges2Controller = TextEditingController();
  final wastage2Controller = TextEditingController();
  final finishFabricCost2Controller = TextEditingController();
  
  final quality3Controller = TextEditingController();
  final loom3Controller = TextEditingController();
  final weave3Controller = TextEditingController();
  final warpRateLbs3Controller = TextEditingController();
  final weftRateLbs3Controller = TextEditingController();
  final conversionPick3Controller = TextEditingController();
  final warpWeight3Controller = TextEditingController();
  final weftWeight3Controller = TextEditingController();
  final totalWeight3Controller = TextEditingController();
  final warpPrice3Controller = TextEditingController();
  final weftPrice3Controller = TextEditingController();
  final conversion3Controller = TextEditingController();
  final greyFabricPrice3Controller = TextEditingController();
  final mendingMT3Controller = TextEditingController();
  final processinginch3Controller = TextEditingController();
  final processingCharges3Controller = TextEditingController();
  final wastage3Controller = TextEditingController();
  final finishFabricCost3Controller = TextEditingController();
  
  final quality4Controller = TextEditingController();
  final loom4Controller = TextEditingController();
  final weave4Controller = TextEditingController();
  final warpRateLbs4Controller = TextEditingController();
  final weftRateLbs4Controller = TextEditingController();
  final conversionPick4Controller = TextEditingController();
  final warpWeight4Controller = TextEditingController();
  final weftWeight4Controller = TextEditingController();
  final totalWeight4Controller = TextEditingController();
  final warpPrice4Controller = TextEditingController();
  final weftPrice4Controller = TextEditingController();
  final conversion4Controller = TextEditingController();
  final greyFabricPrice4Controller = TextEditingController();
  final mendingMT4Controller = TextEditingController();
  final processinginch4Controller = TextEditingController();
  final processingCharges4Controller = TextEditingController();
  final wastage4Controller = TextEditingController();
  final finishFabricCost4Controller = TextEditingController();
  
  // ============== FREIGHT DETAILS CONTROLLERS ==============
  // FIXED: Use generalProductName controllers instead of separate freight controllers
  final consumptionPrice1Controller = TextEditingController();
  final stitching1Controller = TextEditingController();
  final accessories1Controller = TextEditingController();
  final polyBag1Controller = TextEditingController();
  final miscellaneous1Controller = TextEditingController();
  final packingCharges1Controller = TextEditingController();
  final containerSize1Controller = TextEditingController();
  final containerCapacity1Controller = TextEditingController();
  final rateOfExchange1Controller = TextEditingController();
  final fobPricePKR1Controller = TextEditingController();
  final fobPriceDollar1Controller = TextEditingController();
  final freightDollar1Controller = TextEditingController();
  final port1Controller = TextEditingController();
  final freightCalculation1Controller = TextEditingController();
  final cfPriceDollar1Controller = TextEditingController();
  final profitPercent1Controller = TextEditingController();
  final commissionPercent1Controller = TextEditingController();
  final overheadPercent1Controller = TextEditingController();
  final fobPriceFinal1Controller = TextEditingController();
  final cfPriceFinal1Controller = TextEditingController();
  final fobTotalDuvetSet1Controller = TextEditingController();
  final cfTotalDuvetSet1Controller = TextEditingController();
  
  final consumptionPrice2Controller = TextEditingController();
  final stitching2Controller = TextEditingController();
  final accessories2Controller = TextEditingController();
  final polyBag2Controller = TextEditingController();
  final miscellaneous2Controller = TextEditingController();
  final packingCharges2Controller = TextEditingController();
  final containerSize2Controller = TextEditingController();
  final containerCapacity2Controller = TextEditingController();
  final rateOfExchange2Controller = TextEditingController();
  final fobPricePKR2Controller = TextEditingController();
  final fobPriceDollar2Controller = TextEditingController();
  final freightDollar2Controller = TextEditingController();
  final port2Controller = TextEditingController();
  final freightCalculation2Controller = TextEditingController();
  final cfPriceDollar2Controller = TextEditingController();
  final profitPercent2Controller = TextEditingController();
  final commissionPercent2Controller = TextEditingController();
  final overheadPercent2Controller = TextEditingController();
  final fobPriceFinal2Controller = TextEditingController();
  final cfPriceFinal2Controller = TextEditingController();
  final fobTotalDuvetSet2Controller = TextEditingController();
  final cfTotalDuvetSet2Controller = TextEditingController();
  
  final consumptionPrice3Controller = TextEditingController();
  final stitching3Controller = TextEditingController();
  final accessories3Controller = TextEditingController();
  final polyBag3Controller = TextEditingController();
  final miscellaneous3Controller = TextEditingController();
  final packingCharges3Controller = TextEditingController();
  final containerSize3Controller = TextEditingController();
  final containerCapacity3Controller = TextEditingController();
  final rateOfExchange3Controller = TextEditingController();
  final fobPricePKR3Controller = TextEditingController();
  final fobPriceDollar3Controller = TextEditingController();
  final freightDollar3Controller = TextEditingController();
  final port3Controller = TextEditingController();
  final freightCalculation3Controller = TextEditingController();
  final cfPriceDollar3Controller = TextEditingController();
  final profitPercent3Controller = TextEditingController();
  final commissionPercent3Controller = TextEditingController();
  final overheadPercent3Controller = TextEditingController();
  final fobPriceFinal3Controller = TextEditingController();
  final cfPriceFinal3Controller = TextEditingController();
  final fobTotalDuvetSet3Controller = TextEditingController();
  final cfTotalDuvetSet3Controller = TextEditingController();
  
  final consumptionPrice4Controller = TextEditingController();
  final stitching4Controller = TextEditingController();
  final accessories4Controller = TextEditingController();
  final polyBag4Controller = TextEditingController();
  final miscellaneous4Controller = TextEditingController();
  final packingCharges4Controller = TextEditingController();
  final containerSize4Controller = TextEditingController();
  final containerCapacity4Controller = TextEditingController();
  final rateOfExchange4Controller = TextEditingController();
  final fobPricePKR4Controller = TextEditingController();
  final fobPriceDollar4Controller = TextEditingController();
  final freightDollar4Controller = TextEditingController();
  final port4Controller = TextEditingController();
  final freightCalculation4Controller = TextEditingController();
  final cfPriceDollar4Controller = TextEditingController();
  final profitPercent4Controller = TextEditingController();
  final commissionPercent4Controller = TextEditingController();
  final overheadPercent4Controller = TextEditingController();
  final fobPriceFinal4Controller = TextEditingController();
  final cfPriceFinal4Controller = TextEditingController();
  final fobTotalDuvetSet4Controller = TextEditingController();
  final cfTotalDuvetSet4Controller = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    _initializeCalculatedFields();
    if (!viewMode) {
      _setupListeners();
    }
  }
  
  // FIXED: Comprehensive initialization of all calculated fields
  void _initializeCalculatedFields() {
    // Initialize all fabric calculated fields
    for (int i = 1; i <= 4; i++) {
      _getFabricCalculatedControllers(i).forEach((c) => c.text = '0.0000');
    }
    
    // Initialize all consumption calculated fields
    for (int product = 1; product <= 4; product++) {
      for (int row = 1; row <= 4; row++) {
        final controllers = _getConsumptionRowControllers(product, row);
        controllers[7].text = '0.0000'; // consumption
        controllers[8].text = '0.0000'; // consumptionPrice
      }
    }
    
    // Initialize all totals
    total1Controller.text = '0.0000';
    total2Controller.text = '0.0000';
    total3Controller.text = '0.0000';
    total4Controller.text = '0.0000';
    
    // Initialize all consumption prices
    consumptionPrice1Controller.text = '0.0000';
    consumptionPrice2Controller.text = '0.0000';
    consumptionPrice3Controller.text = '0.0000';
    consumptionPrice4Controller.text = '0.0000';

  // Ensure basic grey widths have sensible defaults so dropdowns map correctly
  greyWidth1Controller.text = greyWidth1Controller.text.isEmpty ? '0' : greyWidth1Controller.text;
  greyWidth2Controller.text = greyWidth2Controller.text.isEmpty ? '0' : greyWidth2Controller.text;
  greyWidth3Controller.text = greyWidth3Controller.text.isEmpty ? '0' : greyWidth3Controller.text;
  greyWidth4Controller.text = greyWidth4Controller.text.isEmpty ? '0' : greyWidth4Controller.text;
    
    // Initialize all freight calculated fields
    for (int i = 1; i <= 4; i++) {
      _getFreightCalculatedControllers(i).forEach((c) => c.text = '0.0000');
    }
    
    // Initialize grand totals
    fobTotalDuvetSet1Controller.text = '0.0000';
    cfTotalDuvetSet1Controller.text = '0.0000';
  }
  
  List<TextEditingController> _getFabricCalculatedControllers(int product) {
    switch (product) {
      case 1: return [warpWeight1Controller, weftWeight1Controller, totalWeight1Controller, warpPrice1Controller, weftPrice1Controller, conversion1Controller, greyFabricPrice1Controller, processingCharges1Controller, finishFabricCost1Controller];
      case 2: return [warpWeight2Controller, weftWeight2Controller, totalWeight2Controller, warpPrice2Controller, weftPrice2Controller, conversion2Controller, greyFabricPrice2Controller, processingCharges2Controller, finishFabricCost2Controller];
      case 3: return [warpWeight3Controller, weftWeight3Controller, totalWeight3Controller, warpPrice3Controller, weftPrice3Controller, conversion3Controller, greyFabricPrice3Controller, processingCharges3Controller, finishFabricCost3Controller];
      case 4: return [warpWeight4Controller, weftWeight4Controller, totalWeight4Controller, warpPrice4Controller, weftPrice4Controller, conversion4Controller, greyFabricPrice4Controller, processingCharges4Controller, finishFabricCost4Controller];
      default: return [];
    }
  }
  
  List<TextEditingController> _getFreightCalculatedControllers(int product) {
    switch (product) {
      case 1: return [fobPricePKR1Controller, fobPriceDollar1Controller, freightCalculation1Controller, cfPriceDollar1Controller, fobPriceFinal1Controller, cfPriceFinal1Controller];
      case 2: return [fobPricePKR2Controller, fobPriceDollar2Controller, freightCalculation2Controller, cfPriceDollar2Controller, fobPriceFinal2Controller, cfPriceFinal2Controller];
      case 3: return [fobPricePKR3Controller, fobPriceDollar3Controller, freightCalculation3Controller, cfPriceDollar3Controller, fobPriceFinal3Controller, cfPriceFinal3Controller];
      case 4: return [fobPricePKR4Controller, fobPriceDollar4Controller, freightCalculation4Controller, cfPriceDollar4Controller, fobPriceFinal4Controller, cfPriceFinal4Controller];
      default: return [];
    }
  }
  
  double _parseDouble(String value) {
    if (value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }
  
  void _setupListeners() {
    for (int product = 1; product <= 4; product++) {
      _setupProductListeners(product);
    }
    
    _setupFabricCostListeners();
  }
  
  void _setupFabricCostListeners() {
    finishFabricCost1Controller.addListener(() => _recalculateAllConsumptionRows());
    finishFabricCost2Controller.addListener(() => _recalculateAllConsumptionRows());
    finishFabricCost3Controller.addListener(() => _recalculateAllConsumptionRows());
    finishFabricCost4Controller.addListener(() => _recalculateAllConsumptionRows());
    
    greyFabricPrice1Controller.addListener(() => _recalculateAllConsumptionRows());
    greyFabricPrice2Controller.addListener(() => _recalculateAllConsumptionRows());
    greyFabricPrice3Controller.addListener(() => _recalculateAllConsumptionRows());
    greyFabricPrice4Controller.addListener(() => _recalculateAllConsumptionRows());
    
    mendingMT1Controller.addListener(() => _recalculateAllConsumptionRows());
    mendingMT2Controller.addListener(() => _recalculateAllConsumptionRows());
    mendingMT3Controller.addListener(() => _recalculateAllConsumptionRows());
    mendingMT4Controller.addListener(() => _recalculateAllConsumptionRows());
    
    wastage1Controller.addListener(() => _recalculateAllConsumptionRows());
    wastage2Controller.addListener(() => _recalculateAllConsumptionRows());
    wastage3Controller.addListener(() => _recalculateAllConsumptionRows());
    wastage4Controller.addListener(() => _recalculateAllConsumptionRows());
  }
  
  void _setupProductListeners(int product) {
    final basicControllers = _getBasicControllers(product);
    final fabricControllers = _getFabricControllers(product);
    final freightControllers = _getFreightControllers(product);
    
    for (var controller in basicControllers) {
      controller.addListener(() => _calculateAll(product));
    }
    
    for (var controller in fabricControllers) {
      controller.addListener(() => _calculateAll(product));
    }
    
    for (var controller in freightControllers) {
      controller.addListener(() => _calculateAll(product));
    }
    
    for (int row = 1; row <= 4; row++) {
      _setupConsumptionRowListeners(product, row);
    }
  }
  
  List<TextEditingController> _getBasicControllers(int product) {
    switch (product) {
      case 1: return [warp1Controller, weft1Controller, reed1Controller, pick1Controller, greyWidth1Controller, finishWidth1Controller];
      case 2: return [warp2Controller, weft2Controller, reed2Controller, pick2Controller, greyWidth2Controller, finishWidth2Controller];
      case 3: return [warp3Controller, weft3Controller, reed3Controller, pick3Controller, greyWidth3Controller, finishWidth3Controller];
      case 4: return [warp4Controller, weft4Controller, reed4Controller, pick4Controller, greyWidth4Controller, finishWidth4Controller];
      default: return [];
    }
  }
  
  List<TextEditingController> _getFabricControllers(int product) {
    switch (product) {
      case 1: return [warpRateLbs1Controller, weftRateLbs1Controller, conversionPick1Controller, mendingMT1Controller, processinginch1Controller, wastage1Controller];
      case 2: return [warpRateLbs2Controller, weftRateLbs2Controller, conversionPick2Controller, mendingMT2Controller, processinginch2Controller, wastage2Controller];
      case 3: return [warpRateLbs3Controller, weftRateLbs3Controller, conversionPick3Controller, mendingMT3Controller, processinginch3Controller, wastage3Controller];
      case 4: return [warpRateLbs4Controller, weftRateLbs4Controller, conversionPick4Controller, mendingMT4Controller, processinginch4Controller, wastage4Controller];
      default: return [];
    }
  }
  
  List<TextEditingController> _getFreightControllers(int product) {
    switch (product) {
      case 1: return [stitching1Controller, accessories1Controller, polyBag1Controller, miscellaneous1Controller, packingCharges1Controller, containerCapacity1Controller, rateOfExchange1Controller, freightDollar1Controller, profitPercent1Controller, commissionPercent1Controller, overheadPercent1Controller];
      case 2: return [stitching2Controller, accessories2Controller, polyBag2Controller, miscellaneous2Controller, packingCharges2Controller, containerCapacity2Controller, rateOfExchange2Controller, freightDollar2Controller, profitPercent2Controller, commissionPercent2Controller, overheadPercent2Controller];
      case 3: return [stitching3Controller, accessories3Controller, polyBag3Controller, miscellaneous3Controller, packingCharges3Controller, containerCapacity3Controller, rateOfExchange3Controller, freightDollar3Controller, profitPercent3Controller, commissionPercent3Controller, overheadPercent3Controller];
      case 4: return [stitching4Controller, accessories4Controller, polyBag4Controller, miscellaneous4Controller, packingCharges4Controller, containerCapacity4Controller, rateOfExchange4Controller, freightDollar4Controller, profitPercent4Controller, commissionPercent4Controller, overheadPercent4Controller];
      default: return [];
    }
  }
  
  // FIXED: Added listener for consumption price changes to trigger total recalculation
  void _setupConsumptionRowListeners(int product, int row) {
    final controllers = _getConsumptionRowControllers(product, row);
    
    // Listen to cutSize and pcs for consumption calculation
    for (var controller in [controllers[3], controllers[6]]) {
      controller.addListener(() => _calculateConsumptionRow(product, row));
    }
    
    // FIXED: Listen to consumptionPrice controller to trigger total recalculation
    controllers[8].addListener(() => _calculateConsumptionTotal(product));
    
    final gvObs = _getGVObservable(product, row);
    ever(gvObs, (_) => _calculateConsumptionRow(product, row));
    
    final fwObs = _getFWObservable(product, row);
    ever(fwObs, (_) => _calculateConsumptionRow(product, row));
  }
  
  void _recalculateAllConsumptionRows() {
    for (int product = 1; product <= 4; product++) {
      for (int row = 1; row <= 4; row++) {
        _calculateConsumptionRow(product, row);
      }
    }
  }
  
  List<TextEditingController> _getConsumptionRowControllers(int product, int row) {
    if (product == 1) {
      switch (row) {
        case 1: return [productName1_1Controller, size1_1Controller, size2_1_1Controller, cutSize1_1Controller, greyWidth1_1Controller, finishWidth1_1Controller, pcs1_1Controller, consumption1_1Controller, consumptionPrice1_1Controller];
        case 2: return [productName1_2Controller, size1_2Controller, size2_1_2Controller, cutSize1_2Controller, greyWidth1_2Controller, finishWidth1_2Controller, pcs1_2Controller, consumption1_2Controller, consumptionPrice1_2Controller];
        case 3: return [productName1_3Controller, size1_3Controller, size2_1_3Controller, cutSize1_3Controller, greyWidth1_3Controller, finishWidth1_3Controller, pcs1_3Controller, consumption1_3Controller, consumptionPrice1_3Controller];
        case 4: return [productName1_4Controller, size1_4Controller, size2_1_4Controller, cutSize1_4Controller, greyWidth1_4Controller, finishWidth1_4Controller, pcs1_4Controller, consumption1_4Controller, consumptionPrice1_4Controller];
      }
    } else if (product == 2) {
      switch (row) {
        case 1: return [productName2_1Controller, size2_1Controller, size2_2_1Controller, cutSize2_1Controller, greyWidth2_1Controller, finishWidth2_1Controller, pcs2_1Controller, consumption2_1Controller, consumptionPrice2_1Controller];
        case 2: return [productName2_2Controller, size2_2Controller, size2_2_2Controller, cutSize2_2Controller, greyWidth2_2Controller, finishWidth2_2Controller, pcs2_2Controller, consumption2_2Controller, consumptionPrice2_2Controller];
        case 3: return [productName2_3Controller, size2_3Controller, size2_2_3Controller, cutSize2_3Controller, greyWidth2_3Controller, finishWidth2_3Controller, pcs2_3Controller, consumption2_3Controller, consumptionPrice2_3Controller];
        case 4: return [productName2_4Controller, size2_4Controller, size2_2_4Controller, cutSize2_4Controller, greyWidth2_4Controller, finishWidth2_4Controller, pcs2_4Controller, consumption2_4Controller, consumptionPrice2_4Controller];
      }
    } else if (product == 3) {
      switch (row) {
        case 1: return [productName3_1Controller, size3_1Controller, size2_3_1Controller, cutSize3_1Controller, greyWidth3_1Controller, finishWidth3_1Controller, pcs3_1Controller, consumption3_1Controller, consumptionPrice3_1Controller];
        case 2: return [productName3_2Controller, size3_2Controller, size2_3_2Controller, cutSize3_2Controller, greyWidth3_2Controller, finishWidth3_2Controller, pcs3_2Controller, consumption3_2Controller, consumptionPrice3_2Controller];
        case 3: return [productName3_3Controller, size3_3Controller, size2_3_3Controller, cutSize3_3Controller, greyWidth3_3Controller, finishWidth3_3Controller, pcs3_3Controller, consumption3_3Controller, consumptionPrice3_3Controller];
        case 4: return [productName3_4Controller, size3_4Controller, size2_3_4Controller, cutSize3_4Controller, greyWidth3_4Controller, finishWidth3_4Controller, pcs3_4Controller, consumption3_4Controller, consumptionPrice3_4Controller];
      }
    } else {
      switch (row) {
        case 1: return [productName4_1Controller, size4_1Controller, size2_4_1Controller, cutSize4_1Controller, greyWidth4_1Controller, finishWidth4_1Controller, pcs4_1Controller, consumption4_1Controller, consumptionPrice4_1Controller];
        case 2: return [productName4_2Controller, size4_2Controller, size2_4_2Controller, cutSize4_2Controller, greyWidth4_2Controller, finishWidth4_2Controller, pcs4_2Controller, consumption4_2Controller, consumptionPrice4_2Controller];
        case 3: return [productName4_3Controller, size4_3Controller, size2_4_3Controller, cutSize4_3Controller, greyWidth4_3Controller, finishWidth4_3Controller, pcs4_3Controller, consumption4_3Controller, consumptionPrice4_3Controller];
        case 4: return [productName4_4Controller, size4_4Controller, size2_4_4Controller, cutSize4_4Controller, greyWidth4_4Controller, finishWidth4_4Controller, pcs4_4Controller, consumption4_4Controller, consumptionPrice4_4Controller];
      }
    }
    return [];
  }
  
  RxString _getGVObservable(int product, int row) {
    if (product == 1) {
      switch (row) {
        case 1: return selectedGV1_1;
        case 2: return selectedGV1_2;
        case 3: return selectedGV1_3;
        case 4: return selectedGV1_4;
      }
    } else if (product == 2) {
      switch (row) {
        case 1: return selectedGV2_1;
        case 2: return selectedGV2_2;
        case 3: return selectedGV2_3;
        case 4: return selectedGV2_4;
      }
    } else if (product == 3) {
      switch (row) {
        case 1: return selectedGV3_1;
        case 2: return selectedGV3_2;
        case 3: return selectedGV3_3;
        case 4: return selectedGV3_4;
      }
    } else {
      switch (row) {
        case 1: return selectedGV4_1;
        case 2: return selectedGV4_2;
        case 3: return selectedGV4_3;
        case 4: return selectedGV4_4;
      }
    }
    return selectedGV1_1;
  }
  
  RxString _getFWObservable(int product, int row) {
    if (product == 1) {
      switch (row) {
        case 1: return selectedFW1_1;
        case 2: return selectedFW1_2;
        case 3: return selectedFW1_3;
        case 4: return selectedFW1_4;
      }
    } else if (product == 2) {
      switch (row) {
        case 1: return selectedFW2_1;
        case 2: return selectedFW2_2;
        case 3: return selectedFW2_3;
        case 4: return selectedFW2_4;
      }
    } else if (product == 3) {
      switch (row) {
        case 1: return selectedFW3_1;
        case 2: return selectedFW3_2;
        case 3: return selectedFW3_3;
        case 4: return selectedFW3_4;
      }
    } else {
      switch (row) {
        case 1: return selectedFW4_1;
        case 2: return selectedFW4_2;
        case 3: return selectedFW4_3;
        case 4: return selectedFW4_4;
      }
    }
    return selectedFW1_1;
  }
  
  void _calculateAll(int product) {
    _calculateFabricDetails(product);
    _updateConsumptionDropdowns();
    
    for (int p = 1; p <= 4; p++) {
      _calculateConsumptionTotal(p);
    }
    
    for (int p = 1; p <= 4; p++) {
      _calculateFreightDetails(p);
    }
  }
  
  void _updateConsumptionDropdowns() {
    for (int product = 1; product <= 4; product++) {
      for (int row = 1; row <= 4; row++) {
        _calculateConsumptionRow(product, row);
      }
    }
  }
  
  void _calculateFabricDetails(int product) {
    final basic = _getBasicValues(product);
    final fabric = _getFabricValues(product);
    
    final warpWeight = basic['warp']! != 0 && basic['greyWidth']! != 0
        ? ((basic['reed']! * basic['greyWidth']!) / 800) / basic['warp']! * 1.0936
        : 0.0;
    
    final weftWeight = basic['weft']! != 0 && basic['greyWidth']! != 0
        ? ((basic['pick']! * basic['greyWidth']!) / 800) / basic['weft']! * 1.0936
        : 0.0;
    
    final totalWeight = warpWeight + weftWeight;
    final warpPrice = fabric['warpRate']! * warpWeight;
    final weftPrice = fabric['weftRate']! * weftWeight;
    final conversion = fabric['conversionPick']! * basic['pick']!;
    final greyFabricPrice = warpPrice + weftPrice + conversion;
    final processingCharges = fabric['processingInch']! * basic['finishWidth']!;
    final fobPricePKR = greyFabricPrice + fabric['mendingMT']!;
    final fobAfterWastage = (fobPricePKR * fabric['wastage']! / 100) + fobPricePKR;
    final finishFabricCost = fobAfterWastage + processingCharges;
    
    _setFabricCalculatedValues(product, {
      'warpWeight': warpWeight,
      'weftWeight': weftWeight,
      'totalWeight': totalWeight,
      'warpPrice': warpPrice,
      'weftPrice': weftPrice,
      'conversion': conversion,
      'greyFabricPrice': greyFabricPrice,
      'processingCharges': processingCharges,
      'finishFabricCost': finishFabricCost,
      'fobAfterWastage': fobAfterWastage,
    });
  }

  // FIXED: Improved fabric cost selection logic matching JavaScript
  void _calculateConsumptionRow(int product, int row) {
    final controllers = _getConsumptionRowControllers(product, row);
    final cutSize = _parseDouble(controllers[3].text);
    final pcs = _parseDouble(controllers[6].text);
    
    if (pcs == 0 || cutSize == 0) {
      controllers[7].text = '0.0000';
      controllers[8].text = '0.0000';
      return; // Don't call _calculateConsumptionTotal here to avoid listener loop
    }
    
    final consumption = (cutSize / 39.37) / pcs;
    controllers[7].text = consumption.toStringAsFixed(4);
    
    final gvObs = _getGVObservable(product, row);
    final selectedGVRaw = gvObs.value;

    // Parse selected GV value robustly. It may be numeric ('10'),
    // or use the internal unique form '<label>_<index>' (e.g. '10_1').
    double selectedGVValue = 0.0;
    // try plain parse first
    selectedGVValue = _parseDouble(selectedGVRaw);
    if (selectedGVValue == 0.0) {
      // try underscore-separated form
      if (selectedGVRaw.contains('_')) {
        final parts = selectedGVRaw.split('_');
        selectedGVValue = _parseDouble(parts[0]);
      }
    }

    final greyWidth1 = _parseDouble(greyWidth1Controller.text);
    final greyWidth2 = _parseDouble(greyWidth2Controller.text);
    final greyWidth3 = _parseDouble(greyWidth3Controller.text);
    final greyWidth4 = _parseDouble(greyWidth4Controller.text);
    
  final finishCost1 = _parseDouble(finishFabricCost1Controller.text);
  final finishCost2 = _parseDouble(finishFabricCost2Controller.text);
    
    final greyPrice3 = _parseDouble(greyFabricPrice3Controller.text);
    final mending3 = _parseDouble(mendingMT3Controller.text);
    final wastage3 = _parseDouble(wastage3Controller.text);
    final fobPKR3 = greyPrice3 + mending3;
    final fobAfterWastage3 = (fobPKR3 * wastage3 / 100) + fobPKR3;
    
    final greyPrice4 = _parseDouble(greyFabricPrice4Controller.text);
    final mending4 = _parseDouble(mendingMT4Controller.text);
    final wastage4 = _parseDouble(wastage4Controller.text);
    final fobPKR4 = greyPrice4 + mending4;
    final fobAfterWastage4 = (fobPKR4 * wastage4 / 100) + fobPKR4;
    
    double fabricCost = 0.0;
    
    // FIXED: Removed the "GV" or "FW" fallback logic to match JavaScript exactly
  final selectedValue = selectedGVValue;

  if (_areEqual(selectedValue, greyWidth1)) {
      fabricCost = finishCost1;
    }
    else if (_areEqual(selectedValue, greyWidth2)) {
      fabricCost = finishCost2;
    }
    else if (_areEqual(selectedValue, greyWidth3)) {
      fabricCost = fobAfterWastage3;
    }
    else if (_areEqual(selectedValue, greyWidth4)) {
      fabricCost = fobAfterWastage4;
    }
    else {
      fabricCost = 0.0;
    }
    
  final consumptionPrice = consumption * fabricCost;
  controllers[8].text = consumptionPrice.toStringAsFixed(4);

  // Ensure the product total is updated immediately (listener also handles it).
  _calculateConsumptionTotal(product);
  }
  
  bool _areEqual(double a, double b) {
    return (a - b).abs() < 0.0001;
  }
  
  // FIXED: This now gets called by the listener properly
  void _calculateConsumptionTotal(int product) {
    double total = 0.0;
    
    for (int row = 1; row <= 4; row++) {
      final controllers = _getConsumptionRowControllers(product, row);
      total += _parseDouble(controllers[8].text);
    }
    
    final totalController = _getTotalController(product);
    totalController.text = total.toStringAsFixed(4);
    
    final consumptionPriceController = _getConsumptionPriceController(product);
    consumptionPriceController.text = total.toStringAsFixed(4);
    
    _calculateFreightDetails(product);
  }

  void _calculateFreightDetails(int product) {
    final freight = _getFreightValues(product);
    final total = _parseDouble(_getTotalController(product).text);
    final finishFabricCost = _getFinishFabricCost(product);
    
    final finishFabricCostLast = finishFabricCost + 
                                  freight['stitching']! + 
                                  freight['accessories']! + 
                                  freight['polyBag']! + 
                                  freight['miscellaneous']! + 
                                  freight['packingCharges']! + 
                                  total;
    
    final greyFabricPrice = _parseDouble(_getGreyFabricPriceController(product).text);
    final mendingMT = _getMendingMT(product);
    final wastage = _getWastage(product);
    
    final fobPricePKR = greyFabricPrice + mendingMT;
    final fobAfterWastage = (fobPricePKR * wastage / 100) + fobPricePKR;
    
    final exchangeRate = freight['rateOfExchange']!;
    double fobDollar = 0.0;
    if (exchangeRate > 0 && exchangeRate.isFinite) {
      fobDollar = finishFabricCostLast / exchangeRate;
      if (!fobDollar.isFinite || fobDollar.isNaN) {
        fobDollar = 0.0;
      }
    }
    
    final containerCapacity = freight['containerCapacity']!;
    final freightDollar = freight['freightDollar']!;
    double freightCalculation = 0.0;
    if (containerCapacity > 0 && containerCapacity.isFinite) {
      freightCalculation = freightDollar / containerCapacity;
      if (!freightCalculation.isFinite || freightCalculation.isNaN) {
        freightCalculation = 0.0;
      }
    }
    
    final cfPrice = freightCalculation + fobDollar;
    
    final profitPercent = freight['profitPercent']!;
    final commissionPercent = freight['commissionPercent']!;
    final overheadPercent = freight['overheadPercent']!;
    final fobFinal = (profitPercent * fobDollar / 100) + 
                     (commissionPercent * fobDollar / 100) + 
                     (overheadPercent * fobDollar / 100) + 
                     fobDollar;
    
    final cfFinal = (profitPercent * cfPrice / 100) + 
                    (commissionPercent * cfPrice / 100) + 
                    (overheadPercent * cfPrice / 100) + 
                    cfPrice;
    
    _setFreightCalculatedValues(product, {
      'fobPricePKR': fobAfterWastage,
      'fobPriceDollar': fobDollar,
      'freightCalculation': freightCalculation,
      'cfPriceDollar': cfPrice,
      'fobPriceFinal': fobFinal,
      'cfPriceFinal': cfFinal,
    });
    
    _calculateGrandTotals();
  }

  double _getMendingMT(int product) {
    switch (product) {
      case 1: return _parseDouble(mendingMT1Controller.text);
      case 2: return _parseDouble(mendingMT2Controller.text);
      case 3: return _parseDouble(mendingMT3Controller.text);
      case 4: return _parseDouble(mendingMT4Controller.text);
      default: return 0.0;
    }
  }

  double _getWastage(int product) {
    switch (product) {
      case 1: return _parseDouble(wastage1Controller.text);
      case 2: return _parseDouble(wastage2Controller.text);
      case 3: return _parseDouble(wastage3Controller.text);
      case 4: return _parseDouble(wastage4Controller.text);
      default: return 0.0;
    }
  }
  
  Map<String, double> _getBasicValues(int product) {
    final controllers = _getBasicControllers(product);
    return {
      'warp': _parseDouble(controllers[0].text),
      'weft': _parseDouble(controllers[1].text),
      'reed': _parseDouble(controllers[2].text),
      'pick': _parseDouble(controllers[3].text),
      'greyWidth': _parseDouble(controllers[4].text),
      'finishWidth': _parseDouble(controllers[5].text),
    };
  }
  
  Map<String, double> _getFabricValues(int product) {
    switch (product) {
      case 1: return {'warpRate': _parseDouble(warpRateLbs1Controller.text), 'weftRate': _parseDouble(weftRateLbs1Controller.text), 'conversionPick': _parseDouble(conversionPick1Controller.text), 'mendingMT': _parseDouble(mendingMT1Controller.text), 'processingInch': _parseDouble(processinginch1Controller.text), 'wastage': _parseDouble(wastage1Controller.text)};
      case 2: return {'warpRate': _parseDouble(warpRateLbs2Controller.text), 'weftRate': _parseDouble(weftRateLbs2Controller.text), 'conversionPick': _parseDouble(conversionPick2Controller.text), 'mendingMT': _parseDouble(mendingMT2Controller.text), 'processingInch': _parseDouble(processinginch2Controller.text), 'wastage': _parseDouble(wastage2Controller.text)};
      case 3: return {'warpRate': _parseDouble(warpRateLbs3Controller.text), 'weftRate': _parseDouble(weftRateLbs3Controller.text), 'conversionPick': _parseDouble(conversionPick3Controller.text), 'mendingMT': _parseDouble(mendingMT3Controller.text), 'processingInch': _parseDouble(processinginch3Controller.text), 'wastage': _parseDouble(wastage3Controller.text)};
      case 4: return {'warpRate': _parseDouble(warpRateLbs4Controller.text), 'weftRate': _parseDouble(weftRateLbs4Controller.text), 'conversionPick': _parseDouble(conversionPick4Controller.text), 'mendingMT': _parseDouble(mendingMT4Controller.text), 'processingInch': _parseDouble(processinginch4Controller.text), 'wastage': _parseDouble(wastage4Controller.text)};
      default: return {};
    }
  }
  
  Map<String, double> _getFreightValues(int product) {
    switch (product) {
      case 1: return {'stitching': _parseDouble(stitching1Controller.text), 'accessories': _parseDouble(accessories1Controller.text), 'polyBag': _parseDouble(polyBag1Controller.text), 'miscellaneous': _parseDouble(miscellaneous1Controller.text), 'packingCharges': _parseDouble(packingCharges1Controller.text), 'containerCapacity': _parseDouble(containerCapacity1Controller.text), 'rateOfExchange': _parseDouble(rateOfExchange1Controller.text), 'freightDollar': _parseDouble(freightDollar1Controller.text), 'profitPercent': _parseDouble(profitPercent1Controller.text), 'commissionPercent': _parseDouble(commissionPercent1Controller.text), 'overheadPercent': _parseDouble(overheadPercent1Controller.text)};
      case 2: return {'stitching': _parseDouble(stitching2Controller.text), 'accessories': _parseDouble(accessories2Controller.text), 'polyBag': _parseDouble(polyBag2Controller.text), 'miscellaneous': _parseDouble(miscellaneous2Controller.text), 'packingCharges': _parseDouble(packingCharges2Controller.text), 'containerCapacity': _parseDouble(containerCapacity2Controller.text), 'rateOfExchange': _parseDouble(rateOfExchange2Controller.text), 'freightDollar': _parseDouble(freightDollar2Controller.text), 'profitPercent': _parseDouble(profitPercent2Controller.text), 'commissionPercent': _parseDouble(commissionPercent2Controller.text), 'overheadPercent': _parseDouble(overheadPercent2Controller.text)};
      case 3: return {'stitching': _parseDouble(stitching3Controller.text), 'accessories': _parseDouble(accessories3Controller.text), 'polyBag': _parseDouble(polyBag3Controller.text), 'miscellaneous': _parseDouble(miscellaneous3Controller.text), 'packingCharges': _parseDouble(packingCharges3Controller.text), 'containerCapacity': _parseDouble(containerCapacity3Controller.text), 'rateOfExchange': _parseDouble(rateOfExchange3Controller.text), 'freightDollar': _parseDouble(freightDollar3Controller.text), 'profitPercent': _parseDouble(profitPercent3Controller.text), 'commissionPercent': _parseDouble(commissionPercent3Controller.text), 'overheadPercent': _parseDouble(overheadPercent3Controller.text)};
      case 4: return {'stitching': _parseDouble(stitching4Controller.text), 'accessories': _parseDouble(accessories4Controller.text), 'polyBag': _parseDouble(polyBag4Controller.text), 'miscellaneous': _parseDouble(miscellaneous4Controller.text), 'packingCharges': _parseDouble(packingCharges4Controller.text), 'containerCapacity': _parseDouble(containerCapacity4Controller.text), 'rateOfExchange': _parseDouble(rateOfExchange4Controller.text), 'freightDollar': _parseDouble(freightDollar4Controller.text), 'profitPercent': _parseDouble(profitPercent4Controller.text), 'commissionPercent': _parseDouble(commissionPercent4Controller.text), 'overheadPercent': _parseDouble(overheadPercent4Controller.text)};
      default: return {};
    }
  }
  
  double _getFinishFabricCost(int product) {
    switch (product) {
      case 1: return _parseDouble(finishFabricCost1Controller.text);
      case 2: return _parseDouble(finishFabricCost2Controller.text);
      case 3: return _parseDouble(finishFabricCost3Controller.text);
      case 4: return _parseDouble(finishFabricCost4Controller.text);
      default: return 0.0;
    }
  }
  
  TextEditingController _getTotalController(int product) {
    switch (product) {
      case 1: return total1Controller;
      case 2: return total2Controller;
      case 3: return total3Controller;
      case 4: return total4Controller;
      default: return total1Controller;
    }
  }
  
  TextEditingController _getConsumptionPriceController(int product) {
    switch (product) {
      case 1: return consumptionPrice1Controller;
      case 2: return consumptionPrice2Controller;
      case 3: return consumptionPrice3Controller;
      case 4: return consumptionPrice4Controller;
      default: return consumptionPrice1Controller;
    }
  }
  
  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return '0.0000';
    return value.toStringAsFixed(4);
  }
  
  void _setFabricCalculatedValues(int product, Map<String, double> values) {
    switch (product) {
      case 1:
        warpWeight1Controller.text = _formatResult(values['warpWeight']!);
        weftWeight1Controller.text = _formatResult(values['weftWeight']!);
        totalWeight1Controller.text = _formatResult(values['totalWeight']!);
        warpPrice1Controller.text = _formatResult(values['warpPrice']!);
        weftPrice1Controller.text = _formatResult(values['weftPrice']!);
        conversion1Controller.text = _formatResult(values['conversion']!);
        greyFabricPrice1Controller.text = _formatResult(values['greyFabricPrice']!);
        processingCharges1Controller.text = _formatResult(values['processingCharges']!);
        finishFabricCost1Controller.text = _formatResult(values['finishFabricCost']!);
        break;
      case 2:
        warpWeight2Controller.text = _formatResult(values['warpWeight']!);
        weftWeight2Controller.text = _formatResult(values['weftWeight']!);
        totalWeight2Controller.text = _formatResult(values['totalWeight']!);
        warpPrice2Controller.text = _formatResult(values['warpPrice']!);
        weftPrice2Controller.text = _formatResult(values['weftPrice']!);
        conversion2Controller.text = _formatResult(values['conversion']!);
        greyFabricPrice2Controller.text = _formatResult(values['greyFabricPrice']!);
        processingCharges2Controller.text = _formatResult(values['processingCharges']!);
        finishFabricCost2Controller.text = _formatResult(values['finishFabricCost']!);
        break;
      case 3:
        warpWeight3Controller.text = _formatResult(values['warpWeight']!);
        weftWeight3Controller.text = _formatResult(values['weftWeight']!);
        totalWeight3Controller.text = _formatResult(values['totalWeight']!);
        warpPrice3Controller.text = _formatResult(values['warpPrice']!);
        weftPrice3Controller.text = _formatResult(values['weftPrice']!);
        conversion3Controller.text = _formatResult(values['conversion']!);
        greyFabricPrice3Controller.text = _formatResult(values['greyFabricPrice']!);
        processingCharges3Controller.text = _formatResult(values['processingCharges']!);
        finishFabricCost3Controller.text = _formatResult(values['finishFabricCost']!);
        break;
      case 4:
        warpWeight4Controller.text = _formatResult(values['warpWeight']!);
        weftWeight4Controller.text = _formatResult(values['weftWeight']!);
        totalWeight4Controller.text = _formatResult(values['totalWeight']!);
        warpPrice4Controller.text = _formatResult(values['warpPrice']!);
        weftPrice4Controller.text = _formatResult(values['weftPrice']!);
        conversion4Controller.text = _formatResult(values['conversion']!);
        greyFabricPrice4Controller.text = _formatResult(values['greyFabricPrice']!);
        processingCharges4Controller.text = _formatResult(values['processingCharges']!);
        finishFabricCost4Controller.text = _formatResult(values['finishFabricCost']!);
        break;
    }
  }
  
  void _setFreightCalculatedValues(int product, Map<String, double> values) {
    switch (product) {
      case 1:
        fobPricePKR1Controller.text = values['fobPricePKR']!.toStringAsFixed(4);
        fobPriceDollar1Controller.text = values['fobPriceDollar']!.toStringAsFixed(4);
        freightCalculation1Controller.text = values['freightCalculation']!.toStringAsFixed(4);
        cfPriceDollar1Controller.text = values['cfPriceDollar']!.toStringAsFixed(4);
        fobPriceFinal1Controller.text = values['fobPriceFinal']!.toStringAsFixed(4);
        cfPriceFinal1Controller.text = values['cfPriceFinal']!.toStringAsFixed(4);
        break;
      case 2:
        fobPricePKR2Controller.text = values['fobPricePKR']!.toStringAsFixed(4);
        fobPriceDollar2Controller.text = values['fobPriceDollar']!.toStringAsFixed(4);
        freightCalculation2Controller.text = values['freightCalculation']!.toStringAsFixed(4);
        cfPriceDollar2Controller.text = values['cfPriceDollar']!.toStringAsFixed(4);
        fobPriceFinal2Controller.text = values['fobPriceFinal']!.toStringAsFixed(4);
        cfPriceFinal2Controller.text = values['cfPriceFinal']!.toStringAsFixed(4);
        break;
      case 3:
        fobPricePKR3Controller.text = values['fobPricePKR']!.toStringAsFixed(4);
        fobPriceDollar3Controller.text = values['fobPriceDollar']!.toStringAsFixed(4);
        freightCalculation3Controller.text = values['freightCalculation']!.toStringAsFixed(4);
        cfPriceDollar3Controller.text = values['cfPriceDollar']!.toStringAsFixed(4);
        fobPriceFinal3Controller.text = values['fobPriceFinal']!.toStringAsFixed(4);
        cfPriceFinal3Controller.text = values['cfPriceFinal']!.toStringAsFixed(4);
        break;
      case 4:
        fobPricePKR4Controller.text = values['fobPricePKR']!.toStringAsFixed(4);
        fobPriceDollar4Controller.text = values['fobPriceDollar']!.toStringAsFixed(4);
        freightCalculation4Controller.text = values['freightCalculation']!.toStringAsFixed(4);
        cfPriceDollar4Controller.text = values['cfPriceDollar']!.toStringAsFixed(4);
        fobPriceFinal4Controller.text = values['fobPriceFinal']!.toStringAsFixed(4);
        cfPriceFinal4Controller.text = values['cfPriceFinal']!.toStringAsFixed(4);
        break;
    }
  }
  
  TextEditingController _getGreyFabricPriceController(int product) {
    switch (product) {
      case 1: return greyFabricPrice1Controller;
      case 2: return greyFabricPrice2Controller;
      case 3: return greyFabricPrice3Controller;
      case 4: return greyFabricPrice4Controller;
      default: return greyFabricPrice1Controller;
    }
  }

  String _text(TextEditingController controller) => controller.text.trim();
  
  void _calculateGrandTotals() {
    final fobTotal = _parseDouble(fobPriceDollar1Controller.text) +
                     _parseDouble(fobPriceDollar2Controller.text) +
                     _parseDouble(fobPriceDollar3Controller.text) +
                     _parseDouble(fobPriceDollar4Controller.text);
    
    final cfTotal = _parseDouble(cfPriceDollar1Controller.text) +
                    _parseDouble(cfPriceDollar2Controller.text) +
                    _parseDouble(cfPriceDollar3Controller.text) +
                    _parseDouble(cfPriceDollar4Controller.text);
    
    final fobTotalStr = fobTotal.toStringAsFixed(4);
    final cfTotalStr = cfTotal.toStringAsFixed(4);
    
    fobTotalDuvetSet1Controller.text = fobTotalStr;
    cfTotalDuvetSet1Controller.text = cfTotalStr;
  }
  
  @override
  void onClose() {
    tabController.dispose();
    customerNameController.dispose();
    super.onClose();
  }
  
  Future<void> saveQuotation() async {
    if (customerNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter customer name before saving.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFC107),
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    final companyId = _session.companyId;
    final companyName = _session.companyName;
    if (companyId == null || companyName.isEmpty) {
      Get.snackbar(
        'Error',
        'Company information not found. Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    final payload = <String, dynamic>{
      'company_id': companyId,
      'company_name': companyName,
      'customer_name': _text(customerNameController),
    };

    final warpControllers = [warp1Controller, warp2Controller, warp3Controller, warp4Controller];
    final weftControllers = [weft1Controller, weft2Controller, weft3Controller, weft4Controller];
    final reedControllers = [reed1Controller, reed2Controller, reed3Controller, reed4Controller];
    final pickControllers = [pick1Controller, pick2Controller, pick3Controller, pick4Controller];
    final greyWidthControllers = [greyWidth1Controller, greyWidth2Controller, greyWidth3Controller, greyWidth4Controller];
    final finishWidthControllers = [finishWidth1Controller, finishWidth2Controller, finishWidth3Controller, finishWidth4Controller];

    for (int i = 0; i < 4; i++) {
      final idx = i + 1;
      payload['warp_$idx'] = _text(warpControllers[i]);
      payload['weft_$idx'] = _text(weftControllers[i]);
      payload['reed_$idx'] = _text(reedControllers[i]);
      payload['pick_$idx'] = _text(pickControllers[i]);
      payload['grey_width_$idx'] = _text(greyWidthControllers[i]);
      payload['finish_width_$idx'] = _text(finishWidthControllers[i]);
    }

    final generalProductControllers = [
      generalProductName1Controller,
      generalProductName2Controller,
      generalProductName3Controller,
      generalProductName4Controller,
    ];

    for (int group = 1; group <= 4; group++) {
      final generalValue = _text(generalProductControllers[group - 1]);
      payload['product_name$group'] = generalValue;
      payload['r${group}_name0'] = generalValue;
      payload['r${group}_total'] = _text(_getTotalController(group));

      for (int row = 1; row <= 4; row++) {
        final ctrls = _getConsumptionRowControllers(group, row);
        payload['r${group}_name$row'] = ctrls.isNotEmpty ? _text(ctrls[0]) : '';
        payload['r${group}_size${row}_1'] = ctrls.length > 1 ? _text(ctrls[1]) : '';
        payload['r${group}_size${row}_2'] = ctrls.length > 2 ? _text(ctrls[2]) : '';
        payload['r${group}_size${row}_3'] = '';
        payload['r${group}_cutsize$row'] = ctrls.length > 3 ? _text(ctrls[3]) : '';
        payload['r${group}_gw$row'] = ctrls.length > 4 ? _text(ctrls[4]) : '';
        payload['r${group}_fw$row'] = ctrls.length > 5 ? _text(ctrls[5]) : '';
        payload['r${group}_pcs$row'] = ctrls.length > 6 ? _text(ctrls[6]) : '';
        payload['r${group}_consump$row'] = ctrls.length > 7 ? _text(ctrls[7]) : '';
        payload['r${group}_consump_price$row'] = ctrls.length > 8 ? _text(ctrls[8]) : '';
      }
    }

    final qualities = [quality1Controller, quality2Controller, quality3Controller, quality4Controller];
    final looms = [loom1Controller, loom2Controller, loom3Controller, loom4Controller];
    final weaves = [weave1Controller, weave2Controller, weave3Controller, weave4Controller];
    final warpRates = [warpRateLbs1Controller, warpRateLbs2Controller, warpRateLbs3Controller, warpRateLbs4Controller];
    final weftRates = [weftRateLbs1Controller, weftRateLbs2Controller, weftRateLbs3Controller, weftRateLbs4Controller];
    final conversionPicks = [conversionPick1Controller, conversionPick2Controller, conversionPick3Controller, conversionPick4Controller];
    final warpWeights = [warpWeight1Controller, warpWeight2Controller, warpWeight3Controller, warpWeight4Controller];
    final weftWeights = [weftWeight1Controller, weftWeight2Controller, weftWeight3Controller, weftWeight4Controller];
    final totalWeights = [totalWeight1Controller, totalWeight2Controller, totalWeight3Controller, totalWeight4Controller];
    final warpPrices = [warpPrice1Controller, warpPrice2Controller, warpPrice3Controller, warpPrice4Controller];
    final weftPrices = [weftPrice1Controller, weftPrice2Controller, weftPrice3Controller, weftPrice4Controller];
    final conversions = [conversion1Controller, conversion2Controller, conversion3Controller, conversion4Controller];
    final greyFabricPrices = [greyFabricPrice1Controller, greyFabricPrice2Controller, greyFabricPrice3Controller, greyFabricPrice4Controller];
    final mendingMTs = [mendingMT1Controller, mendingMT2Controller, mendingMT3Controller, mendingMT4Controller];
    final processingInches = [processinginch1Controller, processinginch2Controller, processinginch3Controller, processinginch4Controller];
    final processingCharges = [processingCharges1Controller, processingCharges2Controller, processingCharges3Controller, processingCharges4Controller];
    final wastageControllers = [wastage1Controller, wastage2Controller, wastage3Controller, wastage4Controller];
    final finishFabricCosts = [finishFabricCost1Controller, finishFabricCost2Controller, finishFabricCost3Controller, finishFabricCost4Controller];

    for (int i = 0; i < 4; i++) {
      final idx = i + 1;
      payload['quality_$idx'] = _text(qualities[i]);
      payload['loom_$idx'] = _text(looms[i]);
      payload['weave_$idx'] = _text(weaves[i]);
      payload['warp_rate$idx'] = _text(warpRates[i]);
      payload['weft_rate$idx'] = _text(weftRates[i]);
      payload['conversion_pick$idx'] = _text(conversionPicks[i]);
      payload['warp_weight$idx'] = _text(warpWeights[i]);
      payload['weft_weight$idx'] = _text(weftWeights[i]);
      payload['total_weight$idx'] = _text(totalWeights[i]);
      payload['warp_price$idx'] = _text(warpPrices[i]);
      payload['weft_price$idx'] = _text(weftPrices[i]);
      payload['conversion$idx'] = _text(conversions[i]);
      payload['grey_fabric_price$idx'] = _text(greyFabricPrices[i]);
      payload['mending_mt$idx'] = _text(mendingMTs[i]);
      payload['processing_inch$idx'] = _text(processingInches[i]);
      payload['processing_charges$idx'] = _text(processingCharges[i]);
      payload['wastage$idx'] = _text(wastageControllers[i]);
      payload['finish_fabric_cost$idx'] = _text(finishFabricCosts[i]);
    }

    final consumptionPrices = [consumptionPrice1Controller, consumptionPrice2Controller, consumptionPrice3Controller, consumptionPrice4Controller];
    final stitchingControllers = [stitching1Controller, stitching2Controller, stitching3Controller, stitching4Controller];
    final accessoriesControllers = [accessories1Controller, accessories2Controller, accessories3Controller, accessories4Controller];
    final polyBagControllers = [polyBag1Controller, polyBag2Controller, polyBag3Controller, polyBag4Controller];
    final miscControllers = [miscellaneous1Controller, miscellaneous2Controller, miscellaneous3Controller, miscellaneous4Controller];
    final packingChargeControllers = [packingCharges1Controller, packingCharges2Controller, packingCharges3Controller, packingCharges4Controller];
    final containerSizeControllers = [containerSize1Controller, containerSize2Controller, containerSize3Controller, containerSize4Controller];
    final containerCapacityControllers = [containerCapacity1Controller, containerCapacity2Controller, containerCapacity3Controller, containerCapacity4Controller];
    final exchangeRateControllers = [rateOfExchange1Controller, rateOfExchange2Controller, rateOfExchange3Controller, rateOfExchange4Controller];
    final fobPricePkrControllers = [fobPricePKR1Controller, fobPricePKR2Controller, fobPricePKR3Controller, fobPricePKR4Controller];
    final fobPriceDollarControllers = [fobPriceDollar1Controller, fobPriceDollar2Controller, fobPriceDollar3Controller, fobPriceDollar4Controller];
    final freightDollarControllers = [freightDollar1Controller, freightDollar2Controller, freightDollar3Controller, freightDollar4Controller];
    final portControllers = [port1Controller, port2Controller, port3Controller, port4Controller];
    final freightCalculationControllers = [freightCalculation1Controller, freightCalculation2Controller, freightCalculation3Controller, freightCalculation4Controller];
    final cfPriceControllers = [cfPriceDollar1Controller, cfPriceDollar2Controller, cfPriceDollar3Controller, cfPriceDollar4Controller];
    final profitPercentControllers = [profitPercent1Controller, profitPercent2Controller, profitPercent3Controller, profitPercent4Controller];
    final commissionPercentControllers = [commissionPercent1Controller, commissionPercent2Controller, commissionPercent3Controller, commissionPercent4Controller];
    final overheadControllers = [overheadPercent1Controller, overheadPercent2Controller, overheadPercent3Controller, overheadPercent4Controller];
    final fobPriceFinalControllers = [fobPriceFinal1Controller, fobPriceFinal2Controller, fobPriceFinal3Controller, fobPriceFinal4Controller];
    final cfPriceFinalControllers = [cfPriceFinal1Controller, cfPriceFinal2Controller, cfPriceFinal3Controller, cfPriceFinal4Controller];

    for (int i = 0; i < 4; i++) {
      final idx = i + 1;
      payload['consumption_price$idx'] = _text(consumptionPrices[i]);
      payload['stitching$idx'] = _text(stitchingControllers[i]);
      payload['accessories$idx'] = _text(accessoriesControllers[i]);
      payload['poly_bag$idx'] = _text(polyBagControllers[i]);
      payload['misc_$idx'] = _text(miscControllers[i]);
      payload['packing_charges$idx'] = _text(packingChargeControllers[i]);
      payload['container_size$idx'] = _text(containerSizeControllers[i]);
      payload['container_capacity$idx'] = _text(containerCapacityControllers[i]);
      payload['exchange_rate$idx'] = _text(exchangeRateControllers[i]);
      payload['fob_price_pkr$idx'] = _text(fobPricePkrControllers[i]);
      payload['fob_price_dolar$idx'] = _text(fobPriceDollarControllers[i]);
      payload['friehgt_dolar$idx'] = _text(freightDollarControllers[i]);
      payload['port_$idx'] = _text(portControllers[i]);
      payload['freight_cal$idx'] = _text(freightCalculationControllers[i]);
      payload['cf_price$idx'] = _text(cfPriceControllers[i]);
      payload['profit_percent$idx'] = _text(profitPercentControllers[i]);
      payload['commission_percent$idx'] = _text(commissionPercentControllers[i]);
      payload['overhead$idx'] = _text(overheadControllers[i]);
      payload['fob_price_final$idx'] = _text(fobPriceFinalControllers[i]);
      payload['cf_final_price$idx'] = _text(cfPriceFinalControllers[i]);
    }

    payload['fob_total_duvetset'] = _text(fobTotalDuvetSet1Controller);
    payload['cf_total_duvetset'] = _text(cfTotalDuvetSet1Controller);

    try {
      isLoading.value = true;
      final response = await _apiService.saveMultiMadeupsFabricQuote(payload: payload);
      Get.snackbar(
        'Success',
        response['message']?.toString() ?? 'Quotation saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } on ApiException catch (error) {
      Get.snackbar(
        'Error',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> generatePDF() async {
    try {
      isLoading.value = true;
      // Build comprehensive page containing all form fields
      final rows = <List<String>>[];

      rows.addAll([
        ['Customer', customerNameController.text],
        // Basic details per width
        ['Warp 1', warp1Controller.text],
        ['Weft 1', weft1Controller.text],
        ['Reed 1', reed1Controller.text],
        ['Pick 1', pick1Controller.text],
        ['Grey Width 1', greyWidth1Controller.text],
        ['Finish Width 1', finishWidth1Controller.text],

        ['Warp 2', warp2Controller.text],
        ['Weft 2', weft2Controller.text],
        ['Reed 2', reed2Controller.text],
        ['Pick 2', pick2Controller.text],
        ['Grey Width 2', greyWidth2Controller.text],
        ['Finish Width 2', finishWidth2Controller.text],

        ['Warp 3', warp3Controller.text],
        ['Weft 3', weft3Controller.text],
        ['Reed 3', reed3Controller.text],
        ['Pick 3', pick3Controller.text],
        ['Grey Width 3', greyWidth3Controller.text],
        ['Finish Width 3', finishWidth3Controller.text],

        ['Warp 4', warp4Controller.text],
        ['Weft 4', weft4Controller.text],
        ['Reed 4', reed4Controller.text],
        ['Pick 4', pick4Controller.text],
        ['Grey Width 4', greyWidth4Controller.text],
        ['Finish Width 4', finishWidth4Controller.text],
      ]);

      // Consumption & products (flattened for PDF)
      for (int p = 1; p <= 4; p++) {
        rows.add(['', '']);
        rows.add(['Product Group', 'Product $p']);
        for (int r = 1; r <= 4; r++) {
          final ctrls = _getConsumptionRowControllers(p, r);
          rows.add(['Product Name', ctrls[0].text]);
          rows.add(['Size', ctrls[1].text]);
          rows.add(['Cut Size', ctrls[3].text]);
          rows.add(['Grey Width', ctrls[4].text]);
          rows.add(['Finish Width', ctrls[5].text]);
          rows.add(['PCS', ctrls[6].text]);
          rows.add(['Consumption', ctrls[7].text]);
          rows.add(['Consumption Price', ctrls[8].text]);
        }
        rows.add(['Total', _getTotalController(p).text]);
      }

      // Fabric details per product
      for (int i = 1; i <= 4; i++) {
        final fabric = _getFabricCalculatedControllers(i);
        rows.add(['', '']);
        rows.add(['Fabric Details', 'Product $i']);
        rows.add(['Warp Weight', fabric[0].text]);
        rows.add(['Weft Weight', fabric[1].text]);
        rows.add(['Total Weight', fabric[2].text]);
        rows.add(['Warp Price', fabric[3].text]);
        rows.add(['Weft Price', fabric[4].text]);
        rows.add(['Conversion', fabric[5].text]);
        rows.add(['Grey Fabric Price', fabric[6].text]);
        rows.add(['Processing Charges', fabric[7].text]);
        rows.add(['Finish Fabric Cost', fabric[8].text]);
      }

      // Freight / export details per product
      for (int i = 1; i <= 4; i++) {
        final freight = _getFreightCalculatedControllers(i);
        rows.add(['', '']);
        rows.add(['Freight Details', 'Product $i']);
        rows.add(['Consumption Price', _getConsumptionPriceController(i).text]);
        rows.add(['Stitching', _getFreightControllers(i)[0].text]);
        rows.add(['Accessories', _getFreightControllers(i)[1].text]);
        rows.add(['Poly Bag', _getFreightControllers(i)[2].text]);
        rows.add(['Miscellaneous', _getFreightControllers(i)[3].text]);
        rows.add(['Packing Charges', _getFreightControllers(i)[4].text]);
        rows.add(['Container Capacity', _getFreightControllers(i)[5].text]);
        rows.add(['Rate of Exchange', _getFreightControllers(i)[6].text]);
        rows.add(['FOB Price PKR', freight[0].text]);
  rows.add(['FOB Price \$', freight[1].text]);
        rows.add(['Freight Calculation', freight[2].text]);
  rows.add(['C&F Price \$', freight[3].text]);
        rows.add(['FOB Final', freight[4].text]);
        rows.add(['C&F Final', freight[5].text]);
      }

      final pages = [
        {'title': 'Export Multi-Width Fabric', 'rows': rows}
      ];

      try {
        await printPagesDirect(pages, header: 'Export Multi-Width Fabric');
        Get.snackbar('Success', 'PDF generated successfully', snackPosition: SnackPosition.BOTTOM, backgroundColor: const Color(0xFF4CAF50), colorText: Colors.white, margin: const EdgeInsets.all(16));
      } catch (e) {
        Get.snackbar('Error', 'Failed to generate PDF: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: const Color(0xFFF44336), colorText: Colors.white, margin: const EdgeInsets.all(16));
      }
    } finally {
      isLoading.value = false;
    }
  }
}