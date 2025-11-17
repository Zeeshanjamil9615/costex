import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/export_processed_fabric/export_processed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';

class ExportProcessedFabricPage extends StatelessWidget {
  const ExportProcessedFabricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExportProcessedFabricController controller = Get.put(ExportProcessedFabricController());

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
            onPressed: () {
              Get.offAll(() => LoginPage());

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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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
                        controller: controller.customerNameController,
                        required: true,
                      ),
                      const SizedBox(height: 20),

                      // Row 1: Basic Fabric Properties
                      _sectionCard(
                        "Fabric Properties",
                        [
                          _inputWrap([
                            CustomTextField(label: 'Quality', controller: controller.qualityController),
                            NumericTextField(label: 'Warp Count', controller: controller.warpCountController),
                            NumericTextField(label: 'Weft Count', controller: controller.weftCountController),
                            NumericTextField(label: 'Reeds', controller: controller.reedsController),
                            NumericTextField(label: 'Picks', controller: controller.picksController),
                            NumericTextField(label: 'Grey Width', controller: controller.greyWidthController),
                          ]),
                          const SizedBox(height: 8),
                          _inputWrap([
                            NumericTextField(label: 'Finish Width', controller: controller.finishWidthController),
                            CustomTextField(label: 'P/C Ratio', controller: controller.pcRatioController),
                            CustomTextField(label: 'Loom', controller: controller.loomController),
                            CustomTextField(label: 'Weave', controller: controller.weaveController),
                            NumericTextField(label: 'Warp Rate/Lbs', controller: controller.warpRateLbsController),
                            NumericTextField(label: 'Weft Rate/Lbs', controller: controller.weftRateLbsController),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row 2: Weight & Pricing
                      _sectionCard(
                        "Weight & Pricing",
                        [
                          _inputWrap([
                            // Conversion/Pick is INPUT field (not calculated)
                            NumericTextField(label: 'Conversion/Pick', controller: controller.coversionPickController),
                            HighlightedNumericTextField(label: 'Warp Weight', controller: controller.warpWeightController, readOnly: true),
                            HighlightedNumericTextField(label: 'Weft Weight', controller: controller.weftWeightController, readOnly: true),
                            HighlightedNumericTextField(label: 'Total Weight', controller: controller.totalWeightController, readOnly: true),
                            // Warp/Weft prices - can be auto-calculated or manually entered
                            HighlightedNumericTextField(label: 'Warp Price', controller: controller.warpPriceController,readOnly: true),
                            HighlightedNumericTextField(label: 'Weft Price', controller: controller.weftPriceController,readOnly: true),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row 3: Charges & Processing
                      _sectionCard(
                        "Charges & Processing",
                        [
                          _inputWrap([
                            HighlightedNumericTextField(label: 'Conversion Charges', controller: controller.coversionChargesController, readOnly: true),
                            HighlightedNumericTextField(label: 'Grey Fabric Price', controller: controller.greyFabricPriceController, readOnly: true),
                            NumericTextField(label: 'Mending/MT', controller: controller.mendingMTController),
                            _buildProcessTypeDropdown(controller),
                            Obx(() => NumericTextField(label: controller.processRateLabel, controller: controller.processRateController)),
                            Obx(() => HighlightedNumericTextField(label: controller.processChargesLabel, controller: controller.processChargesController, readOnly: true)),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row 4: Packing & Container
                      _sectionCard(
                        "Packing & Container",
                        [
                          _inputWrap([
                            CustomTextField(label: 'Packing Type', controller: controller.packingTypeController),
                            NumericTextField(label: 'Packing Charges/MT', controller: controller.packingChargesMTController),
                            NumericTextField(label: 'Wastage %', controller: controller.wastagePercentController),
                            CustomTextField(label: 'Container Size', controller: controller.containerSizeController),
                            NumericTextField(label: 'Container Capacity', controller: controller.containerCapacityController),
                            HighlightedNumericTextField(label: 'FOB Price in PKR', controller: controller.fobPricePKRController, readOnly: true),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row 5: Freight & Exchange
                      _sectionCard(
                        "Freight & Final Cost",
                        [
                          _inputWrap([
                            NumericTextField(label: 'Rate of Exchange', controller: controller.rateOfExchangeController),
                            HighlightedNumericTextField(label: 'FOB Price in \$', controller: controller.fobPriceDollarController, readOnly: true),
                            CustomTextField(label: 'Port', controller: controller.portController),
                            NumericTextField(label: 'Freight in \$', controller: controller.freightInDollarController),
                            HighlightedNumericTextField(label: 'Freight Calculation \$', controller: controller.freightCalculationController, readOnly: true),
                            HighlightedNumericTextField(label: 'C & F Price in \$', controller: controller.cfPriceInDollarController, readOnly: true),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row 6: Commission & Profit
                      _sectionCard(
                        "Commission & Profit",
                        [
                          _inputWrap([
                            NumericTextField(label: 'Commission %', controller: controller.commissionController),
                            NumericTextField(label: 'Profit %', controller: controller.profitController),
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
                onChanged: controller.changeProcessType,
              ),
            )),
      ],
    );
  }
}

Widget _sectionCard(String header, List<Widget> children) {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.only(bottom: 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    ),
  );
}

Widget _inputWrap(List<Widget> children) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Arrange read-only/highlighted widgets full-width, inputs two-per-row
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
              rows.add(Row(
                children: [
                  Expanded(child: first),
                  const SizedBox(width: 16),
                  Expanded(child: second),
                ],
              ));
            } else {
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

      // Wide layout: pair inputs two-per-row; read-only spans full width
      final widgets = <Widget>[];
      final inputs = <Widget>[];

      void flushWide() {
        if (inputs.isEmpty) return;
        if (inputs.length == 1) {
          widgets.add(Row(children: [Expanded(child: Padding(padding: const EdgeInsets.only(right: 0), child: inputs[0]))]));
        } else {
          widgets.add(Row(
            children: inputs.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: w))).toList(),
          ));
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