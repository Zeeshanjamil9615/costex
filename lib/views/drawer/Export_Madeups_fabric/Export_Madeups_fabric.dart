import 'package:costex_app/views/drawer/Export_Madeups_fabric/Export_Madeups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';

class ExportMadeupsPage extends StatelessWidget {
  const ExportMadeupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExportMadeupsController controller = Get.put(ExportMadeupsController());

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
          'EXPORT MADEUPS FABRIC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'EXPORT MADEUPS FABRIC',
                  style: TextStyle(
                    color: AppColors.darkBackground,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 22),
                
                // Customer Info Section
                _sectionCard(
                  'Customer Info',
                  [
                    CustomTextField(
                      label: 'Customer Name',
                      controller: controller.customerNameController,
                      required: true,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Product Section
                _sectionCard(
                  'Product',
                  [
                    _rowWrap([
                      CustomTextField(label: 'Product Name', controller: controller.productNameController, required: true),
                      CustomTextField(label: 'Product Size', controller: controller.productSizeController),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Basic Information Section
                _sectionCard(
                  'Basic Information',
                  [
                    _rowWrap([
                      CustomTextField(label: 'Quality', controller: controller.qualityController),
                      NumericTextField(label: 'Warp Count', controller: controller.warpCountController),
                      NumericTextField(label: 'Weft Count', controller: controller.weftCountController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Reeds', controller: controller.reedsController),
                      NumericTextField(label: 'Picks', controller: controller.picksController),
                      NumericTextField(label: 'Grey Width', controller: controller.greyWidthController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Finish Width', controller: controller.finishWidthController),
                      CustomTextField(label: 'P/C Ratio', controller: controller.pcRatioController),
                      CustomTextField(label: 'Loom', controller: controller.loomController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      CustomTextField(label: 'Weave', controller: controller.weaveController),
                      NumericTextField(label: 'Warp Rate/Lbs', controller: controller.warpRateLbsController),
                      NumericTextField(label: 'Weft Rate/Lbs', controller: controller.weftRateLbsController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Conversion/Pick', controller: controller.conversionPickController),
                      HighlightedNumericTextField(label: 'Warp Weight', controller: controller.warpWeightController, readOnly: true),
                      HighlightedNumericTextField(label: 'Weft Weight', controller: controller.weftWeightController, readOnly: true),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      HighlightedNumericTextField(label: 'Total Weight', controller: controller.totalWeightController, readOnly: true),
                      HighlightedNumericTextField(label: 'Warp Price', controller: controller.warpPriceController, readOnly: true),
                      HighlightedNumericTextField(label: 'Weft Price', controller: controller.weftPriceController, readOnly: true),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      HighlightedNumericTextField(label: 'Conversion Charges', controller: controller.conversionChargesController, readOnly: true),
                      HighlightedNumericTextField(label: 'Fabric Price/Meter', controller: controller.fabricPriceMeterController, readOnly: true),
                      NumericTextField(label: 'Mending/MT', controller: controller.mendingMTController),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Pricing Details Section
                _sectionCard(
                  'Pricing Details',
                  [
                    _rowWrap([
                      _buildProcessTypeDropdown(controller),
                      NumericTextField(label: 'Process/Inch', controller: controller.processRateController),
                      HighlightedNumericTextField(label: 'Process Charges', controller: controller.processChargesController, readOnly: true),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      CustomTextField(label: 'Packing Type', controller: controller.packingTypeController),
                      NumericTextField(label: 'Packing Charges/MT', controller: controller.packingChargesMTController),
                      NumericTextField(label: 'Wastage %', controller: controller.wastagePercentController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      HighlightedNumericTextField(label: 'Finish Fabric Cost', controller: controller.finishFabricCostController, readOnly: true),
                      NumericTextField(label: 'Consumption', controller: controller.consumptionController),
                      HighlightedNumericTextField(label: 'Consumption Price', controller: controller.consumptionPriceController, readOnly: true),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Stitching', controller: controller.stitchingController),
                      NumericTextField(label: 'Accessories', controller: controller.accessoriesController),
                      NumericTextField(label: 'Poly Bag', controller: controller.polyBagController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Miscellaneous', controller: controller.miscellaneousController),
                      CustomTextField(label: 'Container Size', controller: controller.containerSizeController),
                      NumericTextField(label: 'Container Capacity', controller: controller.containerCapacityController),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Export Pricing Section
                _sectionCard(
                  'Export Pricing',
                  [
                    _rowWrap([
                      NumericTextField(label: 'Rate of Exchange', controller: controller.rateOfExchangeController),
                      HighlightedNumericTextField(label: 'FOB Price in PKR', controller: controller.fobPricePKRController, readOnly: true),
                      HighlightedNumericTextField(label: 'FOB Price in \$', controller: controller.fobPriceDollarController, readOnly: true),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Freight in \$', controller: controller.freightInDollarController),
                      CustomTextField(label: 'Port', controller: controller.rateController),
                      HighlightedNumericTextField(label: 'Freight Calculation \$', controller: controller.freightCalculationController, readOnly: true),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Final Calculation Section
                _sectionCard(
                  'Final Calculation',
                  [
                    _rowWrap([
                      HighlightedNumericTextField(label: 'C & F Price in \$', controller: controller.cfPriceInDollarController, readOnly: true),
                      NumericTextField(label: 'Commission %', controller: controller.commissionController),
                      NumericTextField(label: 'Profit %', controller: controller.profitController),
                    ]),
                    const SizedBox(height: 12),
                    _rowWrap([
                      NumericTextField(label: 'Overhead %', controller: controller.overheadController),
                      HighlightedNumericTextField(label: 'FOB Price Final', controller: controller.fobPriceFinalController, readOnly: true),
                      HighlightedNumericTextField(label: 'C & F Price Final', controller: controller.cfPriceFinalController, readOnly: true),
                    ]),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Action Buttons
                Obx(() => Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.saveQuotation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC143C),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.generatePDF,
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
      ),
    );
  }

  Widget _buildProcessTypeDropdown(ExportMadeupsController controller) {
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
                onChanged: controller.changeProcessType,
              ),
            )),
      ],
    );
  }
}

Widget _sectionCard(String header, List<Widget> children) {
  return Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 0),
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    ),
  );
}

Widget _rowWrap(List<Widget> children) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 700;

      List<Widget> buildStacked() {
        final rows = <Widget>[];
        final inputsBuffer = <Widget>[];

        void flushInputs() {
          if (inputsBuffer.isEmpty) return;
          for (var i = 0; i < inputsBuffer.length; i += 2) {
            final first = inputsBuffer[i];
            final second = (i + 1) < inputsBuffer.length ? inputsBuffer[i + 1] : null;
            if (second != null) {
              rows.add(Row(children: [
                Expanded(child: first),
                const SizedBox(width: 16),
                Expanded(child: second),
              ]));
            } else {
              // Single remaining input should span full width instead of taking half
              rows.add(Row(children: [Expanded(child: first)]));
            }
            rows.add(const SizedBox(height: 10));
          }
          inputsBuffer.clear();
        }

        for (final child in children) {
          final isReadOnly = child is HighlightedNumericTextField || child is SizedBox && child.key != null;
          if (isReadOnly) {
            flushInputs();
            rows.add(child);
            rows.add(const SizedBox(height: 10));
          } else {
            inputsBuffer.add(child);
          }
        }
        flushInputs();
        if (rows.isNotEmpty) rows.removeLast();
        return rows;
      }

      if (isNarrow) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: buildStacked());
      }

      // Wide: pair inputs, read-only full width
      final widgets = <Widget>[];
      final inputs = <Widget>[];

      void flushWide() {
        if (inputs.isEmpty) return;
        if (inputs.length == 1) {
          widgets.add(Row(children: [Expanded(child: Padding(padding: const EdgeInsets.only(right: 0), child: inputs[0]))]));
        } else {
          widgets.add(Row(children: inputs.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: w))).toList()));
        }
        widgets.add(const SizedBox(height: 10));
        inputs.clear();
      }

      for (final child in children) {
        final isReadOnly = child is HighlightedNumericTextField || child is SizedBox && child.key != null;
        if (isReadOnly) {
          flushWide();
          widgets.add(child);
          widgets.add(const SizedBox(height: 10));
        } else {
          inputs.add(child);
          if (inputs.length == 2) flushWide();
        }
      }
      flushWide();
      if (widgets.isNotEmpty) widgets.removeLast();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
    },
  );
}