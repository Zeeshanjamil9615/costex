
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/utils/pdf_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GreyFabricCostingController extends GetxController {
  // Text Controllers
  final customerNameController = TextEditingController();
  final qualityController = TextEditingController();
  final warpCountController = TextEditingController();
  final weftCountController = TextEditingController();
  final reedsController = TextEditingController();
  final picksController = TextEditingController();
  final greyWidthController = TextEditingController();
  final pcRatioController = TextEditingController();
  final loomController = TextEditingController();
  final weaveController = TextEditingController();
  final warpRateController = TextEditingController();
  final weftRateController = TextEditingController();
  final coversionPicksController = TextEditingController();
  final profitPercentController = TextEditingController();

  // Reactive variables for input values
  var customerName = ''.obs;
  var quality = ''.obs;
  var warpCount = 0.0.obs;
  var weftCount = 0.0.obs;
  var reeds = 0.0.obs;
  var picks = 0.0.obs;
  var greyWidth = 0.0.obs;
  var pcRatio = ''.obs;
  var loom = ''.obs;
  var weave = ''.obs;
  var warpRate = 0.0.obs;
  var weftRate = 0.0.obs;                      
  var coversionPicks = 0.0.obs;
  var profitPercent = 0.0.obs;

  // Computed values (these will auto-update)
  double get warpWeight {
    if (warpCount.value == 0 || reeds.value == 0 || greyWidth.value == 0) {
      return 0.0;
    }
    // Web parity: ((((reeds*width)/800)/warp_count)*1.0936)
    return (((reeds.value * greyWidth.value) / 800.0) / warpCount.value) * 1.0936;
  }














  double get weftWeight {
    if (weftCount.value == 0 || picks.value == 0 || greyWidth.value == 0) {
      return 0.0;
    }
    // Web parity: ((((picks*width)/800)/weft_count)*1.0936)
    return (((picks.value * greyWidth.value) / 800.0) / weftCount.value) * 1.0936;
  }

  double get totalWeight {
    return warpWeight + weftWeight;
  }

  double get warpPrice {
    return warpWeight * warpRate.value;
  }

  double get weftPrice {
    return weftWeight * weftRate.value;
  }

  double get coversionCharges {
    if (picks.value == 0 || coversionPicks.value == 0) {
      return 0.0;
    }
    // Web parity: conversion_per_pick * picks
    return coversionPicks.value * picks.value;
  }

  double get greyFabricPrice {
    return warpPrice + weftPrice + coversionCharges;
  }

  double get fabricPriceFinal {
    if (profitPercent.value == 0) {
      return greyFabricPrice;
    }
    return greyFabricPrice * (1 + profitPercent.value / 100);
  }

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    // Listen to text field changes and update reactive variables
    customerNameController.addListener(() {
      customerName.value = customerNameController.text;
    });

    qualityController.addListener(() {
      quality.value = qualityController.text;
    });

    warpCountController.addListener(() {
      warpCount.value = double.tryParse(warpCountController.text) ?? 0.0;
    });

    weftCountController.addListener(() {
      weftCount.value = double.tryParse(weftCountController.text) ?? 0.0;
    });

    reedsController.addListener(() {
      reeds.value = double.tryParse(reedsController.text) ?? 0.0;
    });

    picksController.addListener(() {
      picks.value = double.tryParse(picksController.text) ?? 0.0;
    });

    greyWidthController.addListener(() {
      greyWidth.value = double.tryParse(greyWidthController.text) ?? 0.0;
    });

    pcRatioController.addListener(() {
      pcRatio.value = pcRatioController.text;
    });

    loomController.addListener(() {
      loom.value = loomController.text;
    });

    weaveController.addListener(() {
      weave.value = weaveController.text;
    });

    warpRateController.addListener(() {
      warpRate.value = double.tryParse(warpRateController.text) ?? 0.0;
    });

    weftRateController.addListener(() {
      weftRate.value = double.tryParse(weftRateController.text) ?? 0.0;
    });

    coversionPicksController.addListener(() {
      coversionPicks.value = double.tryParse(coversionPicksController.text) ?? 0.0;
    });

    profitPercentController.addListener(() {
      profitPercent.value = double.tryParse(profitPercentController.text) ?? 0.0;
    });
  }

  void saveQuotation() {
    if (customerName.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter customer name',
        backgroundColor: AppColors.error,
        colorText: AppColors.textLight,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Implement your save logic here
    // Example: API call to save quotation data
    
    Get.snackbar(
      'Success',
      'Quotation saved successfully',
      backgroundColor: AppColors.success,
      colorText: AppColors.textLight,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> generatePDF() async {
    if (customerName.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter customer name',
        backgroundColor: AppColors.error,
        colorText: AppColors.textLight,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Build rows for PDF including inputs and computed values
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
      ['Conversion/Picks', coversionPicksController.text],
      ['Profit %', profitPercentController.text],
      ['Warp Weight', warpWeight.toStringAsFixed(4)],
      ['Weft Weight', weftWeight.toStringAsFixed(4)],
      ['Total Weight', totalWeight.toStringAsFixed(4)],
      ['Warp Price', warpPrice.toStringAsFixed(4)],
      ['Weft Price', weftPrice.toStringAsFixed(4)],
      ['Conversion Charges', coversionCharges.toStringAsFixed(4)],
      ['Grey Fabric Price', greyFabricPrice.toStringAsFixed(4)],
      ['Final Fabric Price', fabricPriceFinal.toStringAsFixed(4)],
    ]);

    // Use the printing utility to print directly and await completion
    final pages = [ {'title': 'Grey Fabric Costing', 'rows': rows} ];
    try {
      await printPagesDirect(pages, header: 'Grey Fabric Costing');
      Get.snackbar(
        'Success',
        'PDF generated successfully',
        backgroundColor: AppColors.success,
        colorText: AppColors.textLight,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate PDF: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.textLight,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
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
    coversionPicksController.dispose();
    profitPercentController.dispose();
    super.onClose();
  }
}
