import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TowelCostingController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  // COSTING TAB - Header Fields
  final dateController = TextEditingController();
  final clientNameController = TextEditingController();
  
  // COSTING TAB - Pile, Weft, Ground, Fancy
  final pileCountController = TextEditingController();
  final pileRateController = TextEditingController();
  final pileAgeController = TextEditingController();
  final pileAmountController = TextEditingController();
  
  final weftCountController = TextEditingController();
  final weftRateController = TextEditingController();
  final weftAgeController = TextEditingController();
  final weftAmountController = TextEditingController();
  
  final groundCountController = TextEditingController();
  final groundRateController = TextEditingController();
  final groundAgeController = TextEditingController();
  final groundAmountController = TextEditingController();
  
  final fancyCountController = TextEditingController();
  final fancyRateController = TextEditingController();
  final fancyAgeController = TextEditingController();
  final fancyAmountController = TextEditingController();
  
  // COSTING TAB - Brand Names
  final pileNameController = TextEditingController();
  final weftNameController = TextEditingController();
  final groundNameController = TextEditingController();
  final fancyNameController = TextEditingController();
  
  // COSTING TAB - GST and Total
  final gstPercentController = TextEditingController();
  final totalAmountController = TextEditingController();
  
  // FABRIC TAB - Grey Fabric Cost
  final yarnController = TextEditingController();
  final waistage4Controller = TextEditingController();
  final yarnTotalController = TextEditingController();
  final wavingChargesController = TextEditingController();
  final greyFabricInPoundController = TextEditingController();
  final greyFabricInKgController = TextEditingController();
  final viscousSizingController = TextEditingController();
  final yarnFreightController = TextEditingController();
  final greyTotalController = TextEditingController();
  
  // FABRIC TAB - Sharing Cost
  final valourChargesController = TextEditingController();
  final waistageShareController = TextEditingController();
  final totalCostShareController = TextEditingController();
  final waistageCostController = TextEditingController();
  final valourFabricController = TextEditingController();
  
  // FABRIC TAB - Processing Cost
  final processingController = TextEditingController();
  final waistageProcessController = TextEditingController();
  final totalCostProcessController = TextEditingController();
  final waistageCostProcessController = TextEditingController();
  final dyedFabricController = TextEditingController();
  
  // STITCHING TAB - Towel
  final stitchingTowelController = TextEditingController();
  final bPercentTowelController = TextEditingController();
  final totalCostTowelController = TextEditingController();
  final waistageCostTowelController = TextEditingController();
  final towelRateController = TextEditingController();
  
  // STITCHING TAB - Bathrobe 1
  final lengthBathrobe1Controller = TextEditingController();
  final sleeveBathrobe1Controller = TextEditingController();
  final lengthMarginBathrobe1Controller = TextEditingController();
  final sleeveMarginBathrobe1Controller = TextEditingController();
  final pocketsBathrobe1Controller = TextEditingController();
  final cuttingWasteBathrobe1Controller = TextEditingController();
  final fabricCounsumptionBathrobe1Controller = TextEditingController();
  final gsmBathrobe1Controller = TextEditingController();
  final wtMtrBathrobe1Controller = TextEditingController();
  final wtPcBathrobe1Controller = TextEditingController();
  final fabricCostBathrobe1Controller = TextEditingController();
  final labourBathrobe1Controller = TextEditingController();
  final bPercentBathrobe1Controller = TextEditingController();
  final totalCostBathrobe1Controller = TextEditingController();
  final bCostBathrobe1Controller = TextEditingController();
  final bathrobeRateBathrobe1Controller = TextEditingController();
  
  // STITCHING TAB - Bathrobe 2
  final lengthBathrobe2Controller = TextEditingController();
  final lengthMarginBathrobe2Controller = TextEditingController();
  final fabricUseBathrobe2Controller = TextEditingController();
  final cuttingWasteBathrobe2Controller = TextEditingController();
  final fabricCounsumptionBathrobe2Controller = TextEditingController();
  final gsmBathrobe2Controller = TextEditingController();
  final wtMtrBathrobe2Controller = TextEditingController();
  final wtPcBathrobe2Controller = TextEditingController();
  final fabricCostBathrobe2Controller = TextEditingController();
  final labourBathrobe2Controller = TextEditingController();
  final bPercentBathrobe2Controller = TextEditingController();
  final totalCostBathrobe2Controller = TextEditingController();
  final bCostBathrobe2Controller = TextEditingController();
  final bathrobeRateBathrobe2Controller = TextEditingController();
  
  // EX FACTORY TAB - Towel
  final profitPercentTowelController = TextEditingController();
  final profitAmountTowelController = TextEditingController();
  final exFactoryTowelController = TextEditingController();
  
  // EX FACTORY TAB - Bathrobe 1
  final profitPercentBathrobe1Controller = TextEditingController();
  final profitAmountBathrobe1Controller = TextEditingController();
  final exFactoryBathrobe1Controller = TextEditingController();
  
  // EX FACTORY TAB - Bathrobe 2
  final profitPercentBathrobe2Controller = TextEditingController();
  final profitAmountBathrobe2Controller = TextEditingController();
  final exFactoryBathrobe2Controller = TextEditingController();
  
  // EXPORT TAB - Freight/Kg (15 fields)
  final freightKgController = TextEditingController();
  final subTotalKgController = TextEditingController();
  final bankChargesPercentKgController = TextEditingController();
  final bankPercentTotalKgController = TextEditingController();
  final gst17PercentKgController = TextEditingController();
  final gst17TotalKgController = TextEditingController();
  final overheadChargesPercentKgController = TextEditingController();
  final overheadTotalKgController = TextEditingController();
  final profitPercentKgController = TextEditingController();
  final profitPercentTotalKgController = TextEditingController();
  final commissionPercentKgController = TextEditingController();
  final commissionPercentTotalKgController = TextEditingController();
  final totalKgController = TextEditingController();
  final usdRateKgController = TextEditingController();
  final dollarKgController = TextEditingController();
  
  // EXPORT TAB - Freight/Pc (7 fields)
  final freightPcController = TextEditingController();
  final subTotalPcController = TextEditingController();
  final profitPercentPcController = TextEditingController();
  final profitAmountPcController = TextEditingController();
  final totalPcController = TextEditingController();
  final usdRatePcController = TextEditingController();
  final dollarPcController = TextEditingController();
  
  // EXPORT TAB - Freight/Pc2 (10 fields)
  final freightPc2Controller = TextEditingController();
  final subTotalPc2Controller = TextEditingController();
  final bankChargesPc2Controller = TextEditingController();
  final gstPercentPc2Controller = TextEditingController();
  final profitPercentPc2Controller = TextEditingController();
  final commissionPc2Controller = TextEditingController();
  final intermediateTotal2Controller = TextEditingController();
  final totalPc2Controller = TextEditingController();
  final usdRatePc2Controller = TextEditingController();
  final dollarPc2Controller = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  // Store full-precision intermediate values
  final Map<String, double> _fullValues = {};
  bool _enableCalcLog = true;

  void _logCalc(String label, double? value) {
    if (!_enableCalcLog) return;
    debugPrint('[CALC] $label => ${value ?? double.nan}');
  }

  void _printCalculationReport() {
    if (!_enableCalcLog) return;
    debugPrint('--- Calculation report (displayed values) ---');
    debugPrint('Fabric Tab: yarn=${yarnController.text}, waistage4=${waistage4Controller.text}, yarnTotal=${yarnTotalController.text}, gfip=${greyFabricInPoundController.text}, gfik=${greyFabricInKgController.text}, greyTotal=${greyTotalController.text}');
    debugPrint('Sharing/Processing: totalCostShare=${totalCostShareController.text}, waistageCost=${waistageCostController.text}, valourFabric=${valourFabricController.text}, totalCostProcess=${totalCostProcessController.text}, waistageCostProcess=${waistageCostProcessController.text}, dyedFabric=${dyedFabricController.text}');
    debugPrint('Towel: totalCost=${totalCostTowelController.text}, towelRate=${towelRateController.text}');
    debugPrint('Bathrobe1: wtPc=${wtPcBathrobe1Controller.text}, fabricCost=${fabricCostBathrobe1Controller.text}, total=${totalCostBathrobe1Controller.text}, rate=${bathrobeRateBathrobe1Controller.text}');
    debugPrint('Bathrobe2: wtPc=${wtPcBathrobe2Controller.text}, fabricCost=${fabricCostBathrobe2Controller.text}, total=${totalCostBathrobe2Controller.text}, rate=${bathrobeRateBathrobe2Controller.text}');
    debugPrint('Export PC: subTotalPc=${subTotalPcController.text}, totalPc=${totalPcController.text}, \$ Pc=${dollarPcController.text}');
    debugPrint('Export PC2: subTotalPc2=${subTotalPc2Controller.text}, intermediate2=${intermediateTotal2Controller.text}, totalPc2=${totalPc2Controller.text}, \$ Pc2=${dollarPc2Controller.text}');
    debugPrint('--- end report ---');
  }

  // Helper: round to match JavaScript toFixed() behavior
  String _round(double value, int decimals) {
    if (decimals < 0) decimals = 0;
    if (value.isNaN || value.isInfinite) return '0' + (decimals > 0 ? '.' + List.filled(decimals, '0').join() : '');
    return value.toStringAsFixed(decimals);
  }
  
  // Helper: actual truncate (for specific fields that don't round)
  String _truncate(double value, int decimals) {
    if (decimals < 0) decimals = 0;
    if (value.isNaN || value.isInfinite) return '0' + (decimals > 0 ? '.' + List.filled(decimals, '0').join() : '');
    final factor = pow(10, decimals).toDouble();
    final truncated = (value * factor).truncate() / factor;
    return truncated.toStringAsFixed(decimals);
  }
  
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    _setupListeners();
  }
  
  void _setupListeners() {
    // Individual amount calculations
    pileRateController.addListener(_calculatePileAmount);
    pileAgeController.addListener(_calculatePileAmount);
    
    weftRateController.addListener(_calculateWeftAmount);
    weftAgeController.addListener(_calculateWeftAmount);
    
    groundRateController.addListener(_calculateGroundAmount);
    groundAgeController.addListener(_calculateGroundAmount);
    
    fancyRateController.addListener(_calculateFancyAmount);
    fancyAgeController.addListener(_calculateFancyAmount);
    
    // Master calculation listener
    final allInputs = [
      pileAmountController, weftAmountController, groundAmountController, fancyAmountController,
      wavingChargesController, viscousSizingController, yarnFreightController,
      valourChargesController, waistageShareController,
      processingController, waistageProcessController,
      stitchingTowelController, bPercentTowelController,
      lengthBathrobe1Controller, sleeveBathrobe1Controller, lengthMarginBathrobe1Controller,
      sleeveMarginBathrobe1Controller, pocketsBathrobe1Controller, gsmBathrobe1Controller,
      labourBathrobe1Controller, bPercentBathrobe1Controller,
      lengthBathrobe2Controller, lengthMarginBathrobe2Controller, gsmBathrobe2Controller,
      labourBathrobe2Controller, bPercentBathrobe2Controller,
      profitPercentTowelController, profitPercentBathrobe1Controller, profitPercentBathrobe2Controller,
      freightKgController, bankChargesPercentKgController, gst17PercentKgController,
      overheadChargesPercentKgController, profitPercentKgController, commissionPercentKgController,
      usdRateKgController,
      freightPcController, profitPercentPcController, usdRatePcController,
      freightPc2Controller, bankChargesPc2Controller, gstPercentPc2Controller,
      profitPercentPc2Controller, commissionPc2Controller, usdRatePc2Controller,
      gstPercentController,
    ];
    
    for (var ctrl in allInputs) {
      ctrl.addListener(_calculateAll);
    }
  }
  
  double _parseDouble(String text) => double.tryParse(text.trim()) ?? 0.0;
  
  // COSTING TAB FORMULAS
  void _calculatePileAmount() {
    final rate = _parseDouble(pileRateController.text);
    final age = _parseDouble(pileAgeController.text);
    final amount = (rate * age) / 10000;
    pileAmountController.text = _truncate(amount, 2);
    _fullValues['pileAmount'] = _parseDouble(pileAmountController.text);
  }
  
  void _calculateWeftAmount() {
    final rate = _parseDouble(weftRateController.text);
    final age = _parseDouble(weftAgeController.text);
    final amount = (rate * age) / 10000;
    weftAmountController.text = _truncate(amount, 2);
    _fullValues['weftAmount'] = _parseDouble(weftAmountController.text);
  }
  
  void _calculateGroundAmount() {
    final rate = _parseDouble(groundRateController.text);
    final age = _parseDouble(groundAgeController.text);
    final amount = (rate * age) / 10000;
    groundAmountController.text = _truncate(amount, 2);
    _fullValues['groundAmount'] = _parseDouble(groundAmountController.text);
  }
  
  void _calculateFancyAmount() {
    final rate = _parseDouble(fancyRateController.text);
    final age = _parseDouble(fancyAgeController.text);
    final amount = (rate * age) / 10000;
    fancyAmountController.text = _truncate(amount, 2);
    _fullValues['fancyAmount'] = _parseDouble(fancyAmountController.text);
  }
  
  void _calculateAll() {
    // ======================
    // FABRIC TAB CALCULATIONS
    // ======================
    
    // Grey Yarn Total
    final pileAmt = _fullValues['pileAmount'] ?? _parseDouble(pileAmountController.text);
    final weftAmt = _fullValues['weftAmount'] ?? _parseDouble(weftAmountController.text);
    final groundAmt = _fullValues['groundAmount'] ?? _parseDouble(groundAmountController.text);
    final fancyAmt = _fullValues['fancyAmount'] ?? _parseDouble(fancyAmountController.text);

    final greyYarn = pileAmt + weftAmt + groundAmt + fancyAmt;
    yarnController.text = _round(greyYarn, 1);
    _fullValues['greyYarn'] = _parseDouble(yarnController.text);
    _logCalc('greyYarn', _fullValues['greyYarn']);
    
    // Grey Waistage (4%) - TRUNCATE not round
    final greyWaistage = (greyYarn / 100) * 4;
    waistage4Controller.text = _truncate(greyWaistage, 2);
    _fullValues['greyWaistage'] = _parseDouble(waistage4Controller.text);
    _logCalc('greyWaistage', _fullValues['greyWaistage']);

    // Yarn Total
    final yarnTotal = _parseDouble(yarnController.text) + _parseDouble(waistage4Controller.text);
    yarnTotalController.text = _round(yarnTotal, 3);
    _fullValues['yarnTotal'] = _parseDouble(yarnTotalController.text);
    _logCalc('yarnTotal', _fullValues['yarnTotal']);
    
    // Grey Fabric In Pound
    final wavingCharges = _parseDouble(wavingChargesController.text);
    final greyFabricInPound = _parseDouble(yarnTotalController.text) + wavingCharges;
    greyFabricInPoundController.text = _round(greyFabricInPound, 3);
    _fullValues['greyFabricInPound'] = _parseDouble(greyFabricInPoundController.text);
    _logCalc('greyFabricInPound', _fullValues['greyFabricInPound']);
    
    // Grey Fabric In Kg (MULTIPLY by 2.20462)
    final greyFabricInKg = _parseDouble(greyFabricInPoundController.text) * 2.20462;
    greyFabricInKgController.text = _round(greyFabricInKg, 2);
    _fullValues['greyFabricInKg'] = _parseDouble(greyFabricInKgController.text);
    _logCalc('greyFabricInKg', _fullValues['greyFabricInKg']);
    
    // Grey Total
    final viscousSizing = _parseDouble(viscousSizingController.text);
    final yarnFreight = _parseDouble(yarnFreightController.text);
    final greyTotal = _parseDouble(greyFabricInKgController.text) + viscousSizing + yarnFreight;
    greyTotalController.text = _round(greyTotal, 2);
    _fullValues['greyTotal'] = _parseDouble(greyTotalController.text);
    _logCalc('greyTotal', _fullValues['greyTotal']);
    
    // Sharing Cost
    final valourCharges = _parseDouble(valourChargesController.text);
    final waistageShare = _parseDouble(waistageShareController.text);
    final sharingTotalCost = valourCharges + _parseDouble(greyTotalController.text);
    totalCostShareController.text = _round(sharingTotalCost, 2);
    _fullValues['sharingTotalCost'] = _parseDouble(totalCostShareController.text);
    _logCalc('sharingTotalCost', _fullValues['sharingTotalCost']);
    
    final sharingWaistageCost = (_parseDouble(totalCostShareController.text) / 100) * waistageShare;
    waistageCostController.text = _round(sharingWaistageCost, 2);
    
    final valourFabric = _parseDouble(totalCostShareController.text) + _parseDouble(waistageCostController.text);
    valourFabricController.text = _round(valourFabric, 2);
    
    // Processing Cost
    final processing = _parseDouble(processingController.text);
    final waistageProcess = _parseDouble(waistageProcessController.text);
    final processingTotalCost = _parseDouble(valourFabricController.text) + processing;
    totalCostProcessController.text = _round(processingTotalCost, 2);
    _fullValues['processingTotalCost'] = _parseDouble(totalCostProcessController.text);
    _logCalc('processingTotalCost', _fullValues['processingTotalCost']);
    
    final processingWaistageCost = (_parseDouble(totalCostProcessController.text) / 100) * waistageProcess;
    waistageCostProcessController.text = _round(processingWaistageCost, 2);
    
    final dyedFabric = _parseDouble(totalCostProcessController.text) + _parseDouble(waistageCostProcessController.text);
    dyedFabricController.text = _round(dyedFabric, 2);
    _fullValues['dyedFabric'] = _parseDouble(dyedFabricController.text);
    _logCalc('dyedFabric', _fullValues['dyedFabric']);
    
    // ========================
    // STITCHING TAB CALCULATIONS
    // ========================
    
    // TOWEL STITCHING
    final stitchingTowel = _parseDouble(stitchingTowelController.text);
    final bPercentTowel = _parseDouble(bPercentTowelController.text);
    final towelTotalCost = dyedFabric + stitchingTowel;
    totalCostTowelController.text = _round(towelTotalCost, 2);
    
    final towelWaistageCost = (towelTotalCost / 100) * bPercentTowel;
    waistageCostTowelController.text = _round(towelWaistageCost, 2);
    
    final towelRate = towelTotalCost + towelWaistageCost;
    towelRateController.text = _round(towelRate, 2);
    
    // BATHROBE 1 STITCHING
    final length1 = _parseDouble(lengthBathrobe1Controller.text);
    final sleeve1 = _parseDouble(sleeveBathrobe1Controller.text);
    final lMargin1 = _parseDouble(lengthMarginBathrobe1Controller.text);
    final sMargin1 = _parseDouble(sleeveMarginBathrobe1Controller.text);
    final pockets1 = _parseDouble(pocketsBathrobe1Controller.text);
    
    final totalCuttingWaste1 = length1 + sleeve1 + lMargin1 + sMargin1 + pockets1;
    final cuttingWaste1 = (totalCuttingWaste1 / 100) * 8;
    cuttingWasteBathrobe1Controller.text = _truncate(cuttingWaste1, 2);
    
    final fabricConsumption1 = (length1 + sleeve1 + lMargin1 + sMargin1 + pockets1 + cuttingWaste1) / 100;
    fabricCounsumptionBathrobe1Controller.text = _truncate(fabricConsumption1, 2);
    _logCalc('fabricConsumption1', fabricConsumption1);
    
    final gsm1 = _parseDouble(gsmBathrobe1Controller.text);
    final wtMtr1 = gsm1 * 1.5;
    wtMtrBathrobe1Controller.text = _truncate(wtMtr1, 2);
    _logCalc('wtMtr1', wtMtr1);
    
    final wtPc1 = (fabricConsumption1 * wtMtr1) / 1000;
    wtPcBathrobe1Controller.text = _truncate(wtPc1, 2);
    _logCalc('wtPc1', wtPc1);

  final displayedWtPc1 = _parseDouble(wtPcBathrobe1Controller.text);
  final displayedDyed1 = _parseDouble(dyedFabricController.text);
  final fabricCost1 = displayedWtPc1 * displayedDyed1;
  fabricCostBathrobe1Controller.text = _truncate(fabricCost1, 2);
  _logCalc('fabricCost1', fabricCost1);
    final labour1 = _parseDouble(labourBathrobe1Controller.text);
    final bPercent1 = _parseDouble(bPercentBathrobe1Controller.text);
    final totalCost1 = fabricCost1 + labour1;
    totalCostBathrobe1Controller.text = _truncate(totalCost1, 2);
    
    final bCost1 = (totalCost1 / 100) * bPercent1;
    bCostBathrobe1Controller.text = _truncate(bCost1, 2);
    
    final bathrobeRate1 = totalCost1 + bCost1;
    bathrobeRateBathrobe1Controller.text = _truncate(bathrobeRate1, 2);
    
    // BATHROBE 2 STITCHING
    final length2 = _parseDouble(lengthBathrobe2Controller.text);
    final lMargin2 = _parseDouble(lengthMarginBathrobe2Controller.text);
    final fabricUse2 = (length2 + lMargin2) * 2;
    fabricUseBathrobe2Controller.text = _truncate(fabricUse2, 2);
    
    final cuttingWaste2 = (fabricUse2 / 100) * 8;
    cuttingWasteBathrobe2Controller.text = _truncate(cuttingWaste2, 2);
    
    final fabricConsumption2 = (fabricUse2 + cuttingWaste2) / 100;
    fabricCounsumptionBathrobe2Controller.text = _truncate(fabricConsumption2, 2);
    _logCalc('fabricConsumption2', fabricConsumption2);
    
    final gsm2 = _parseDouble(gsmBathrobe2Controller.text);
    final wtMtr2 = gsm2 * 1.5;
    wtMtrBathrobe2Controller.text = _truncate(wtMtr2, 2);
    _logCalc('wtMtr2', wtMtr2);
    
    final wtPc2 = (fabricConsumption2 * wtMtr2) / 1000;
    wtPcBathrobe2Controller.text = _truncate(wtPc2, 2);











    
    _logCalc('wtPc2', wtPc2);
    
  // Use displayed (truncated) wtPc and dyedFabric values for the fabric cost to match UI
  final displayedWtPc2 = _parseDouble(wtPcBathrobe2Controller.text);
  final displayedDyed2 = _parseDouble(dyedFabricController.text);
  final fabricCost2 = displayedWtPc2 * displayedDyed2;
  fabricCostBathrobe2Controller.text = _truncate(fabricCost2, 2);
  _logCalc('fabricCost2', fabricCost2);
    
    final labour2 = _parseDouble(labourBathrobe2Controller.text);
    final bPercent2 = _parseDouble(bPercentBathrobe2Controller.text);
    final totalCost2 = fabricCost2 + labour2;
    totalCostBathrobe2Controller.text = _truncate(totalCost2, 2);
    
    final bCost2 = (totalCost2 / 100) * bPercent2;
    bCostBathrobe2Controller.text = _truncate(bCost2, 2);
    
    final bathrobeRate2 = totalCost2 + bCost2;
    bathrobeRateBathrobe2Controller.text = _truncate(bathrobeRate2, 2);
    
    // ==========================
    // EX FACTORY TAB CALCULATIONS
    // ==========================
    
    // TOWEL EX FACTORY
    final profitPercentTowel = _parseDouble(profitPercentTowelController.text);
    final profitAmountTowel = (towelRate / 100) * profitPercentTowel;
    profitAmountTowelController.text = _truncate(profitAmountTowel, 2);
    
    final exFactoryTowel = towelRate + profitAmountTowel;
    exFactoryTowelController.text = _truncate(exFactoryTowel, 2);
    
    // BATHROBE 1 EX FACTORY
    final profitPercentBath1 = _parseDouble(profitPercentBathrobe1Controller.text);
    final profitAmountBath1 = (bathrobeRate1 / 100) * profitPercentBath1;
    profitAmountBathrobe1Controller.text = _truncate(profitAmountBath1, 2);
    
    final exFactoryBath1 = bathrobeRate1 + profitAmountBath1;
    exFactoryBathrobe1Controller.text = _truncate(exFactoryBath1, 2);
    
    // BATHROBE 2 EX FACTORY
    final profitPercentBath2 = _parseDouble(profitPercentBathrobe2Controller.text);
    final profitAmountBath2 = (bathrobeRate2 / 100) * profitPercentBath2;
    profitAmountBathrobe2Controller.text = _truncate(profitAmountBath2, 2);
    
    final exFactoryBath2 = bathrobeRate2 + profitAmountBath2;
    exFactoryBathrobe2Controller.text = _truncate(exFactoryBath2, 2);
    
    // ======================
    // EXPORT TAB CALCULATIONS
    // ======================
    
    // FREIGHT/KG - Cascading through Bank→GST→Overhead, then Profit+Commission from same base
    final freightKg = _parseDouble(freightKgController.text);
    var runningTotalKg = freightKg + exFactoryTowel;
    subTotalKgController.text = _truncate(runningTotalKg, 2);
    
    // Bank Charges - cascade
    final bankChargesPercentKg = _parseDouble(bankChargesPercentKgController.text);
    final bankChargesTotalKg = (runningTotalKg * bankChargesPercentKg) / 100;
    bankPercentTotalKgController.text = _truncate(bankChargesTotalKg, 2);
    runningTotalKg = runningTotalKg + bankChargesTotalKg;
    
    // GST - cascade from new total
    final gst17PercentKg = _parseDouble(gst17PercentKgController.text);
    final gst17TotalKg = (runningTotalKg * gst17PercentKg) / 100;
    gst17TotalKgController.text = _truncate(gst17TotalKg, 2);
    runningTotalKg = runningTotalKg + gst17TotalKg;
    
    // Overhead - cascade from new total
    final overheadChargesPercentKg = _parseDouble(overheadChargesPercentKgController.text);
    final overheadTotalKg = (runningTotalKg * overheadChargesPercentKg) / 100;
    overheadTotalKgController.text = _truncate(overheadTotalKg, 2);
    runningTotalKg = runningTotalKg + overheadTotalKg;
    
    // Profit and Commission - both from SAME base (after overhead)
    final baseBeforeProfitCommission = runningTotalKg;
    
    final profitPercentKg = _parseDouble(profitPercentKgController.text);
    final profitTotalKg = (baseBeforeProfitCommission * profitPercentKg) / 100;
    profitPercentTotalKgController.text = _truncate(profitTotalKg, 2);
    
    final commissionPercentKg = _parseDouble(commissionPercentKgController.text);
    final commissionTotalKg = (baseBeforeProfitCommission * commissionPercentKg) / 100;
    commissionPercentTotalKgController.text = _truncate(commissionTotalKg, 2);
    
    // Total = base + profit + commission
    final totalKg = baseBeforeProfitCommission + profitTotalKg + commissionTotalKg;
    totalKgController.text = _truncate(totalKg, 2);
    
    // USD conversion
    final usdRateKg = _parseDouble(usdRateKgController.text);
    if (usdRateKg > 0) {
      final dollarKg = totalKg / usdRateKg;
      dollarKgController.text = _truncate(dollarKg, 2);
    } else {
      dollarKgController.text = '0.00';
    }
    
    // FREIGHT/PC - Simple profit calculation
    final freightPc = _parseDouble(freightPcController.text);
    final subTotalPc = freightPc + exFactoryBath1;
    subTotalPcController.text = _truncate(subTotalPc, 2);
    
    final profitPercentPc = _parseDouble(profitPercentPcController.text);
    final profitAmountPc = (subTotalPc * profitPercentPc) / 100;
    profitAmountPcController.text = _truncate(profitAmountPc, 2);
    
    final totalPc = subTotalPc + profitAmountPc;
    totalPcController.text = _truncate(totalPc, 2);
    
    final usdRatePc = _parseDouble(usdRatePcController.text);
    if (usdRatePc > 0) {
      final dollarPc = totalPc / usdRatePc;
      dollarPcController.text = _truncate(dollarPc, 2);
    } else {
      dollarPcController.text = '0.00';
    }
    
    // FREIGHT/PC2 - Only uses Profit % (matches web behavior)
    final freightPc2 = _parseDouble(freightPc2Controller.text);
    final subTotalPc2 = freightPc2 + exFactoryBath2;
    subTotalPc2Controller.text = _truncate(subTotalPc2, 2);
    
    // Only profit percentage is used (other fields ignored to match web)
    final profitPercentPc2 = _parseDouble(profitPercentPc2Controller.text);
    final profitAmountPc2 = (subTotalPc2 * profitPercentPc2) / 100;
    
    // Total = subTotal + profit amount
    final totalPc2Value = subTotalPc2 + profitAmountPc2;
    
    // Intermediate and Total show same value
    intermediateTotal2Controller.text = _truncate(profitAmountPc2, 2);
    totalPc2Controller.text = _truncate(totalPc2Value, 2);
    
    // USD conversion
    final usdRatePc2 = _parseDouble(usdRatePc2Controller.text);
    if (usdRatePc2 > 0) {
      final dollarPc2 = totalPc2Value / usdRatePc2;
      dollarPc2Controller.text = _truncate(dollarPc2, 2);
    } else {
      dollarPc2Controller.text = '0.00';
    }
    
    // COSTING TAB - GST Total Amount
    final gstPercent = _parseDouble(gstPercentController.text);




    final gstAmount = (exFactoryTowel * gstPercent) / 100;
    totalAmountController.text = _truncate(gstAmount, 2);

    // Print all calculations if logging enabled
    if (_enableCalcLog) {
      debugPrint('--- Calculation dump ---');
      _fullValues.forEach((k, v) => debugPrint('  $k => $v'));
      debugPrint('--- end dump ---');
      _printCalculationReport();
    }
  }
  
  @override
  void onClose() {
    tabController.dispose();
    dateController.dispose();
    clientNameController.dispose();
    pileCountController.dispose();
    pileRateController.dispose();
    pileAgeController.dispose();
    pileAmountController.dispose();
    weftCountController.dispose();
    weftRateController.dispose();
    weftAgeController.dispose();
    weftAmountController.dispose();
    groundCountController.dispose();
    groundRateController.dispose();
    groundAgeController.dispose();
    groundAmountController.dispose();
    fancyCountController.dispose();
    fancyRateController.dispose();
    fancyAgeController.dispose();
    fancyAmountController.dispose();
    pileNameController.dispose();
    weftNameController.dispose();
    groundNameController.dispose();
    fancyNameController.dispose();
    gstPercentController.dispose();
    totalAmountController.dispose();
    yarnController.dispose();
    waistage4Controller.dispose();
    yarnTotalController.dispose();
    wavingChargesController.dispose();
    greyFabricInPoundController.dispose();
    greyFabricInKgController.dispose();
    viscousSizingController.dispose();
    yarnFreightController.dispose();
    greyTotalController.dispose();
    valourChargesController.dispose();
    waistageShareController.dispose();
    totalCostShareController.dispose();
    waistageCostController.dispose();
    valourFabricController.dispose();
    processingController.dispose();
    waistageProcessController.dispose();
    totalCostProcessController.dispose();
    waistageCostProcessController.dispose();
    dyedFabricController.dispose();
    stitchingTowelController.dispose();
    bPercentTowelController.dispose();
    totalCostTowelController.dispose();
    waistageCostTowelController.dispose();
    towelRateController.dispose();
    lengthBathrobe1Controller.dispose();
    sleeveBathrobe1Controller.dispose();
    lengthMarginBathrobe1Controller.dispose();
    sleeveMarginBathrobe1Controller.dispose();
    pocketsBathrobe1Controller.dispose();
    cuttingWasteBathrobe1Controller.dispose();
    fabricCounsumptionBathrobe1Controller.dispose();
    gsmBathrobe1Controller.dispose();
    wtMtrBathrobe1Controller.dispose();
    wtPcBathrobe1Controller.dispose();
    fabricCostBathrobe1Controller.dispose();
    labourBathrobe1Controller.dispose();
    bPercentBathrobe1Controller.dispose();
    totalCostBathrobe1Controller.dispose();
    bCostBathrobe1Controller.dispose();
    bathrobeRateBathrobe1Controller.dispose();
    lengthBathrobe2Controller.dispose();
    lengthMarginBathrobe2Controller.dispose();
    fabricUseBathrobe2Controller.dispose();
    cuttingWasteBathrobe2Controller.dispose();
    fabricCounsumptionBathrobe2Controller.dispose();
    gsmBathrobe2Controller.dispose();
    wtMtrBathrobe2Controller.dispose();
    wtPcBathrobe2Controller.dispose();
    fabricCostBathrobe2Controller.dispose();
    labourBathrobe2Controller.dispose();
    bPercentBathrobe2Controller.dispose();
    totalCostBathrobe2Controller.dispose();
    bCostBathrobe2Controller.dispose();
    bathrobeRateBathrobe2Controller.dispose();
    profitPercentTowelController.dispose();
    profitAmountTowelController.dispose();
    exFactoryTowelController.dispose();
    profitPercentBathrobe1Controller.dispose();
    profitAmountBathrobe1Controller.dispose();
    exFactoryBathrobe1Controller.dispose();
    profitPercentBathrobe2Controller.dispose();
    profitAmountBathrobe2Controller.dispose();
    exFactoryBathrobe2Controller.dispose();
    freightKgController.dispose();
    subTotalKgController.dispose();
    bankChargesPercentKgController.dispose();
    bankPercentTotalKgController.dispose();
    gst17PercentKgController.dispose();
    gst17TotalKgController.dispose();
    overheadChargesPercentKgController.dispose();
    overheadTotalKgController.dispose();
    profitPercentKgController.dispose();
    profitPercentTotalKgController.dispose();
    commissionPercentKgController.dispose();
    commissionPercentTotalKgController.dispose();
    totalKgController.dispose();
    usdRateKgController.dispose();
    dollarKgController.dispose();
    freightPcController.dispose();
    subTotalPcController.dispose();
    profitPercentPcController.dispose();
    profitAmountPcController.dispose();
    totalPcController.dispose();
    usdRatePcController.dispose();
    dollarPcController.dispose();
    freightPc2Controller.dispose();
    subTotalPc2Controller.dispose();
    bankChargesPc2Controller.dispose();
    gstPercentPc2Controller.dispose();
    profitPercentPc2Controller.dispose();
    commissionPc2Controller.dispose();
    intermediateTotal2Controller.dispose();
    totalPc2Controller.dispose();
    usdRatePc2Controller.dispose();
    dollarPc2Controller.dispose();
    super.onClose();
  }
  
  Future<void> saveQuotation() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Quotation saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
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
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'PDF generated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }
}