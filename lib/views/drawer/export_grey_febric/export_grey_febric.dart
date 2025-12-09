import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/export_grey_febric/export_grey_febric_controller.dart';
import 'package:costex_app/utils/detail_value_helper.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation_controller.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class ExportGreyPage extends StatelessWidget {
  final Quotation? quotation;
  final bool viewMode;
  
  const ExportGreyPage({Key? key, this.quotation, this.viewMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExportGreyController controller = Get.put(ExportGreyController());
    
    // Load quotation data if in view mode
    if (viewMode && quotation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadQuotationData(controller, quotation!);
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'EXPORT GREY FABRIC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await SessionService.instance.clearSession();
              Get.offAll(() => const LoginPage());
            },
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const AppDrawer(), // Your existing drawer
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  'Export Grey Fabric Costing Sheet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Form
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // Customer Name (Full Width)
                      CustomTextField(
                        label: 'Customer Name',
                        hintText: 'Customer Name',
                        controller: controller.customerNameController,
                        readOnly: viewMode,
                      ),
                      const SizedBox(height: 20),

                      // Quality (Full Width)
                      CustomTextField(
                        label: 'Quality',
                        hintText: 'Quality',
                        controller: controller.qualityController,
                        readOnly: viewMode,
                      ),
                      const SizedBox(height: 20),

                      // Row 1: Warp Count, Weft Count
                      _buildRow([
                        _buildField('Warp Count', controller.warpCountController),
                        _buildField('Weft Count', controller.weftCountController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Reeds', controller.reedsController),
                        _buildField('Picks', controller.picksController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 2: Grey Width
                      _buildRow([
                        _buildField('Grey Width', controller.greyWidthController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('P/C Ratio', controller.pcRatioController, isNumeric: false),
                        _buildField('Loom', controller.loomController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),

                      // Row 3: Weave
                      _buildRow([
                        _buildField('Weave', controller.weaveController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),

                      // Row 4: Warp Rate/Lbs, Weft Rate/Lbs
                      _buildRow([
                        _buildField('Warp Rate/Lbs', controller.warpRateController),
                        _buildField('Weft Rate/Lbs', controller.weftRateController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Coversion/Picks', controller.coversionPickController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 5: Warp Weight, Weft Weight
                      _buildRow([
                        _buildCalculatedField('Warp Weight', controller.warpWeightController),
                        _buildCalculatedField('Weft Weight', controller.weftWeightController),
                      ]),
                      const SizedBox(height: 20),
                      // Total Weight in separate row
                      _buildRow([
                        _buildCalculatedField('Total Weight', controller.totalWeightController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 6: Warp Price, Weft Price, Coversion Charges
                      _buildRow([
                        _buildCalculatedField('Warp Price', controller.warpPriceController),
                        _buildCalculatedField('Weft Price', controller.weftPriceController),
                      ]),
                      const SizedBox(height: 20),

                       _buildRow([
                                                _buildCalculatedField('Coversion Charges', controller.coversionChargesController),

                      ]),
                      const SizedBox(height: 20),


                      // Row 7: Grey Fabric Price, Profit %, Fabric Price Final (using FOB Price Final as equivalent)
                      _buildRow([
                        _buildCalculatedField('Grey Fabric Price', controller.greyFabricPriceController),
                        _buildField('Profit %', controller.profitPercentController),
                        
                      ]),
                      const SizedBox(height: 20),

                       _buildRow([
                       _buildCalculatedField('FOB Price Final', controller.fobPriceFinalController),
                      ]),

                      const SizedBox(height: 20),

                      // Additional Export-specific fields
                      _buildRow([
                        _buildField('Mending/MT', controller.mendingMTController),
                        _buildField('Packing Type', controller.packingTypeController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Packing Charges/MT', controller.packingChargesController),
                        _buildField('Wastage %', controller.wastageController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Container Size', controller.containerSizeController, isNumeric: false),
                        _buildField('Container Capacity', controller.containerCapacityController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildCalculatedField('FOB Price in PKR', controller.fobPricePKRController),
                        _buildField('Rate of Exchange', controller.rateOfExchangeController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildCalculatedField('FOB Price in \$', controller.fobPriceDollarController),
                        _buildField('Freight in \$', controller.freightInDollarController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildCalculatedField('Freight Calculation in \$', controller.freightCalculationController),
                        _buildCalculatedField('C & F Price in \$', controller.cfPriceController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Commission', controller.commissionController),
                        _buildField('Port', controller.portController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('OverHead %', controller.overheadPercentController),
                        _buildCalculatedField('C & F Price Final', controller.cfPriceFinalController),
                      ]),
                      const SizedBox(height: 32),

                      // Action Buttons
                      Obx(() => Row(
                            children: [
                              if (!viewMode) ...[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.saveQuotation,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDC143C),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : const Text(
                                            'SAVE QUOTATION',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.generatePDF,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDC143C),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'GENERATE PDF',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // On mobile/tablet narrow width, arrange according to widget type:
        // - Input widgets should be two-per-row
        // - Calculated fields can be displayed side-by-side when multiple in a row
        final isNarrow = constraints.maxWidth < 1000;

        List<Widget> buildStacked() {
          final rows = <Widget>[];
          final inputsBuffer = <Widget>[];

          void flushInputsBuffer() {
            if (inputsBuffer.isEmpty) return;
            // For 2 items: pair them side-by-side
            // For 3 items: display all 3 side-by-side
            // For 1 item: full width
            if (inputsBuffer.length == 1) {
              rows.add(Row(children: [Expanded(child: inputsBuffer[0])]));
            } else if (inputsBuffer.length == 2) {
              rows.add(Row(
                children: [
                  Expanded(child: inputsBuffer[0]),
                  const SizedBox(width: 16),
                  Expanded(child: inputsBuffer[1]),
                ],
              ));
            } else {
              // 3 or more items: display all side-by-side
              rows.add(Row(
                children: inputsBuffer
                    .asMap()
                    .entries
                    .map((entry) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: entry.key < inputsBuffer.length - 1 ? 16 : 0),
                            child: entry.value,
                          ),
                        ))
                    .toList(),
              ));
            }
            rows.add(const SizedBox(height: 16));
            inputsBuffer.clear();
          }

          for (final child in children) {
            // Only treat SizedBox.shrink() as a special case (empty space)
            if (child is SizedBox && child.key != null) {
              // Skip empty space widgets
              continue;
            } else {
              inputsBuffer.add(child);
            }
          }
          // flush remaining inputs
          flushInputsBuffer();
          if (rows.isNotEmpty) rows.removeLast();
          return rows;
        }

        if (isNarrow) {
          return Column(children: buildStacked());
        }

        // On wide screens: show all widgets side-by-side based on count
        if (children.isEmpty) return const SizedBox.shrink();
        
        // Filter out SizedBox.shrink() widgets
        final filteredChildren = children.where((child) => !(child is SizedBox && child.key != null)).toList();
        
        if (filteredChildren.isEmpty) return const SizedBox.shrink();
        
        if (filteredChildren.length == 1) {
          return Column(
            children: [
              Row(children: [Expanded(child: filteredChildren[0])]),
            ],
          );
        } else if (filteredChildren.length == 2) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: filteredChildren[0]),
                  const SizedBox(width: 16),
                  Expanded(child: filteredChildren[1]),
                ],
              ),
            ],
          );
        } else {
          // 3 or more items: display all side-by-side
          return Column(
            children: [
              Row(
                children: filteredChildren
                    .asMap()
                    .entries
                    .map((entry) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: entry.key < filteredChildren.length - 1 ? 16 : 0),
                            child: entry.value,
                          ),
                        ))
                    .toList(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isNumeric = true}) {
    if (isNumeric) {
      return NumericTextField(
        label: label,
        hintText: '0',
        controller: controller,
        readOnly: viewMode,
      );
    }
    return CustomTextField(
      label: label,
      hintText: label,
      controller: controller,
      readOnly: viewMode,
    );
  }
  
  void _loadQuotationData(ExportGreyController controller, Quotation quotation) {
    final details = quotation.details;
    controller.customerNameController.text = detailValue(details, 'customerName') ?? quotation.customerName;

    final mapping = <String, TextEditingController>{
      'quality': controller.qualityController,
      'warpCount': controller.warpCountController,
      'weftCount': controller.weftCountController,
      'reeds': controller.reedsController,
      'picks': controller.picksController,
      'greyWidth': controller.greyWidthController,
      'pcRatio': controller.pcRatioController,
      'loom': controller.loomController,
      'weave': controller.weaveController,
      'warpRate': controller.warpRateController,
      'weftRate': controller.weftRateController,
      'conversionPick': controller.coversionPickController,
      'warpWeight': controller.warpWeightController,
      'weftWeight': controller.weftWeightController,
      'totalWeight': controller.totalWeightController,
      'warpPrice': controller.warpPriceController,
      'weftPrice': controller.weftPriceController,
      'conversionCharges': controller.coversionChargesController,
      'greyFabricPrice': controller.greyFabricPriceController,
      'mendingMt': controller.mendingMTController,
      'packingType': controller.packingTypeController,
      'packingCharges': controller.packingChargesController,
      'wastage': controller.wastageController,
      'containerSize': controller.containerSizeController,
      'containerCapacity': controller.containerCapacityController,
      'fobPricePkr': controller.fobPricePKRController,
      'exchangeRate': controller.rateOfExchangeController,
      'fobPriceDollar': controller.fobPriceDollarController,
      'freightDollar': controller.freightInDollarController,
      'freightCalculation': controller.freightCalculationController,
      'cFPriceDollar': controller.cfPriceController,
      'commission': controller.commissionController,
      'port': controller.portController,
      'profitPercent': controller.profitPercentController,
      'overheadPercent': controller.overheadPercentController,
      'fobFinalPrice': controller.fobPriceFinalController,
      'cFFinalPrice': controller.cfPriceFinalController,
    };

    final aliasMap = <String, List<String>>{
      'weave': ['wave'],
      'warpRate': ['warpRateLbs'],
      'weftRate': ['weftRateLbs'],
      'conversionPick': ['coversionPick', 'coverationPick'],
      'mendingMt': ['mending', 'mending_mt'],
      'profitPercent': ['profit'],
      'overheadPercent': ['overhead'],
      'freightCalculation': ['freightCalculationDollar'],
      'cFPriceDollar': ['c_f_price_dollar'],
      'fobFinalPrice': ['fobFinal'],
      'cFFinalPrice': ['c_f_final_price'],
    };

    populateControllers(details, mapping, aliasMap: aliasMap);
  }

  Widget _buildCalculatedField(String label, TextEditingController controller) {
    return HighlightedNumericTextField(
      label: label,
      hintText: '0.0000',
      controller: controller,
      readOnly: true,
    );
  }
}

// Note: Make sure to import your AppDrawer from home_page.dart
// import 'package:costex_app/pages/home/home_page.dart' show AppDrawer;