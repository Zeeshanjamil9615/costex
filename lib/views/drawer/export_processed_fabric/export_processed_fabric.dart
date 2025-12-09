import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/export_processed_fabric/export_processed_controller.dart';
import 'package:costex_app/utils/detail_value_helper.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';

class ExportProcessedFabricPage extends StatelessWidget {
  final Quotation? quotation;
  final bool viewMode;
  
  const ExportProcessedFabricPage({Key? key, this.quotation, this.viewMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExportProcessedFabricController controller = Get.put(ExportProcessedFabricController());
    
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
          'EXPORT PROCESSED FABRIC',
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
      drawer: const AppDrawer(),
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
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: const Text(
                  'Export Processed Fabric Costing Sheet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Form Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Name (Full Width)
                      CustomTextField(
                        label: 'Customer Name',
                         hintText: 'Customer Name',
                        controller: controller.customerNameController,
                        required: true,
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
                        _buildField('Warp Rate/Lbs', controller.warpRateLbsController),
                        _buildField('Weft Rate/Lbs', controller.weftRateLbsController),
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
                      // Total Weight in separate row
                      _buildRow([
                                             _buildCalculatedField('Coversion Charges', controller.coversionChargesController),

                      ]),
                      const SizedBox(height: 20),

                      // Row 7: Grey Fabric Price, Profit %, FOB Price Final (using as equivalent to Fabric Price Final)
                      _buildRow([
                        _buildCalculatedField('Grey Fabric Price', controller.greyFabricPriceController),
                        _buildField('Profit %', controller.profitController),
                        
                      ]),
                      const SizedBox(height: 20),
                      // Total Weight in separate row
                      _buildRow([
                       _buildCalculatedField('FOB Price Final', controller.fobPriceFinalController),
                      ]),
                      const SizedBox(height: 20),

                      // Additional Processed Fabric-specific fields
                      _buildRow([
                        _buildField('Finish Width', controller.finishWidthController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Mending/MT', controller.mendingMTController),
                        _buildProcessTypeDropdown(controller),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        Obx(() => _buildField(controller.processRateLabel, controller.processRateController)),
                        Obx(() => _buildCalculatedField(controller.processChargesLabel, controller.processChargesController)),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Packing Type', controller.packingTypeController, isNumeric: false),
                        _buildField('Packing Charges/MT', controller.packingChargesMTController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Wastage %', controller.wastagePercentController),
                        _buildField('Container Size', controller.containerSizeController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Container Capacity', controller.containerCapacityController),
                        _buildCalculatedField('FOB Price in PKR', controller.fobPricePKRController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Rate of Exchange', controller.rateOfExchangeController),
                        _buildCalculatedField('FOB Price in \$', controller.fobPriceDollarController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Port', controller.portController, isNumeric: false),
                        _buildField('Freight in \$', controller.freightInDollarController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildCalculatedField('Freight Calculation \$', controller.freightCalculationController),
                        _buildCalculatedField('C & F Price in \$', controller.cfPriceInDollarController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
                        _buildField('Commission %', controller.commissionController),
                        _buildField('Overhead %', controller.overheadController),
                      ]),
                      const SizedBox(height: 20),
                      _buildRow([
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
                                      disabledBackgroundColor: const Color(0xFFDC143C).withOpacity(0.5),
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
                                    disabledBackgroundColor: const Color(0xFFDC143C).withOpacity(0.5),
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

  Widget _buildCalculatedField(String label, TextEditingController controller) {
    return HighlightedNumericTextField(
      label: label,
      hintText: '0.0000',
      controller: controller,
      readOnly: true,
    );
  }

  Widget _buildProcessTypeDropdown(ExportProcessedFabricController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Process Type',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonFormField<String>(
                value: controller.selectedProcessType.value,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: InputBorder.none,
                ),
                items: controller.processTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: viewMode ? null : controller.changeProcessType,
              ),
            )),
      ],
    );
  }
  
  void _loadQuotationData(ExportProcessedFabricController controller, Quotation quotation) {
    final details = quotation.details;
    controller.customerNameController.text = detailValue(details, 'customerName') ?? quotation.customerName;

    final mapping = <String, TextEditingController>{
      'quality': controller.qualityController,
      'warpCount': controller.warpCountController,
      'weftCount': controller.weftCountController,
      'reeds': controller.reedsController,
      'picks': controller.picksController,
      'greyWidth': controller.greyWidthController,
      'finishWidth': controller.finishWidthController,
      'pcRatio': controller.pcRatioController,
      'loom': controller.loomController,
      'weave': controller.weaveController,
      'warpRate': controller.warpRateLbsController,
      'weftRate': controller.weftRateLbsController,
      'conversionPick': controller.coversionPickController,
      'warpWeight': controller.warpWeightController,
      'weftWeight': controller.weftWeightController,
      'totalWeight': controller.totalWeightController,
      'warpPrice': controller.warpPriceController,
      'weftPrice': controller.weftPriceController,
      'conversionCharges': controller.coversionChargesController,
      'greyFabricPrice': controller.greyFabricPriceController,
      'mendingMt': controller.mendingMTController,
      'processRate': controller.processRateController,
      'processCharges': controller.processChargesController,
      'packingType': controller.packingTypeController,
      'packingCharges': controller.packingChargesMTController,
      'wastage': controller.wastagePercentController,
      'containerSize': controller.containerSizeController,
      'containerCapacity': controller.containerCapacityController,
      'fobPricePkr': controller.fobPricePKRController,
      'exchangeRate': controller.rateOfExchangeController,
      'fobPriceDollar': controller.fobPriceDollarController,
      'freightDollar': controller.freightInDollarController,
      'freightCalculation': controller.freightCalculationController,
      'cFPriceDollar': controller.cfPriceInDollarController,
      'commission': controller.commissionController,
      'profitPercent': controller.profitController,
      'overheadPercent': controller.overheadController,
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

    final processTypeValue = detailValue(details, 'processType');
    if (processTypeValue != null && processTypeValue.isNotEmpty) {
      controller.processTypeController.text = processTypeValue;
      controller.selectedProcessType.value = processTypeValue;
    }
  }
}
