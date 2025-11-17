import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/export_grey_febric/export_grey_febric_controller.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class ExportGreyPage extends StatelessWidget {
  const ExportGreyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExportGreyController controller = Get.put(ExportGreyController());

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
                      ),
                      const SizedBox(height: 20),

                      // Row 1: Quality, Warp Count, Weft Count, Reeds, Picks, Grey Width
                      _buildRow([
                        _buildField('Quality', controller.qualityController),
                        _buildField('Warp Count', controller.warpCountController),
                        _buildField('Weft Count', controller.weftCountController),
                        _buildField('Reeds', controller.reedsController),
                        _buildField('Picks', controller.picksController),
                        _buildField('Grey Width', controller.greyWidthController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 2: P/C Ratio, Loom, Weave, Warp Rate/Lbs, Weft Rate/Lbs, Coversion/Pick
                      _buildRow([
                        _buildField('P/C Ratio', controller.pcRatioController),
                        _buildField('Loom', controller.loomController),
                        _buildField('Weave', controller.weaveController),
                        _buildField('Warp Rate/Lbs', controller.warpRateController),
                        _buildField('Weft Rate/Lbs', controller.weftRateController),
                        _buildField('Coversion/Pick', controller.coversionPickController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 3: Warp Weight, Weft Weight, Total Weight, Warp Price, Weft Price, Coversion Charges
                      _buildRow([
                        _buildCalculatedField('Warp Weight', controller.warpWeightController),
                        _buildCalculatedField('Weft Weight', controller.weftWeightController),
                        _buildCalculatedField('Total Weight', controller.totalWeightController),
                        _buildCalculatedField('Warp Price', controller.warpPriceController),
                        _buildCalculatedField('Weft Price', controller.weftPriceController),
                        _buildCalculatedField('Coversion Charges', controller.coversionChargesController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 4: Grey Fabric Price, Mending/MT, Packing Type, Packing Charges/MT, Wastage %, Container Size
                      _buildRow([
                        _buildCalculatedField('Grey Fabric Price', controller.greyFabricPriceController),
                        _buildField('Mending/MT', controller.mendingMTController),
                        _buildField('Packing Type', controller.packingTypeController, isNumeric: false),
                        _buildField('Packing Charges/MT', controller.packingChargesController),
                        _buildField('Wastage %', controller.wastageController),
                        _buildField('Container Size', controller.containerSizeController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),

                      // Row 5: Container Capacity, FOB Price in PKR, Rate of Exchange, FOB Price in $, Freight in $
                      _buildRow([
                        _buildField('Container Capacity', controller.containerCapacityController),
                        _buildField('FOB Price in PKR', controller.fobPricePKRController),
                        _buildField('Rate of Exchange', controller.rateOfExchangeController),
                        _buildCalculatedField('FOB Price in \$', controller.fobPriceDollarController),
                        _buildField('Freight in \$', controller.freightInDollarController),
                      ]),
                      const SizedBox(height: 20),

                      // Row 6: Freight Calculation in $, C & F Price in $, Commission, Port
                      _buildRow([
                        _buildCalculatedField('Freight Calculation in \$', controller.freightCalculationController),
                        _buildField('C & F Price in \$', controller.cfPriceController),
                        _buildField('Commission', controller.commissionController),
                        _buildField('Port', controller.portController, isNumeric: false),
                      ]),
                      const SizedBox(height: 20),

                      // Row 7: Profit %, OverHead %, FOB Price Final, C & F Price Final
                      _buildRow([
                        _buildField('Profit %', controller.profitPercentController),
                        _buildField('OverHead %', controller.overheadPercentController),
                        _buildCalculatedField('FOB Price Final', controller.fobPriceFinalController),
                        _buildCalculatedField('C & F Price Final', controller.cfPriceFinalController),
                      ]),
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
        final isNarrow = constraints.maxWidth < 1000;

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
              rows.add(Row(children: [Expanded(child: first)]));
            }
            rows.add(const SizedBox(height: 16));
          }
            inputsBuffer.clear();
          }

          for (final child in children) {
            final isReadOnly = child is HighlightedNumericTextField || child is SizedBox && child.key != null;
            if (isReadOnly) {
              flushInputs();
              rows.add(child);
              rows.add(const SizedBox(height: 16));
            } else {
              inputsBuffer.add(child);
            }
          }
          flushInputs();
          if (rows.isNotEmpty) rows.removeLast();
          return rows;
        }

        if (isNarrow) {
          return Column(children: buildStacked());
        }

        // Wide: use pairing for inputs, read-only spans full width
        final widgets = <Widget>[];
        final inputs = <Widget>[];

        void flushWide() {
          if (inputs.isEmpty) return;
          if (inputs.length == 1) {
            widgets.add(Row(children: [Expanded(child: Padding(padding: const EdgeInsets.only(right: 0), child: inputs[0]))]));
          } else {
            widgets.add(Row(children: inputs.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: w))).toList()));
          }
          widgets.add(const SizedBox(height: 16));
          inputs.clear();
        }

        for (final child in children) {
          final isReadOnly = child is HighlightedNumericTextField || child is SizedBox && child.key != null;
          if (isReadOnly) {
            flushWide();
            widgets.add(child);
            widgets.add(const SizedBox(height: 16));
          } else {
            inputs.add(child);
            if (inputs.length == 2) flushWide();
          }
        }
        flushWide();
        if (widgets.isNotEmpty) widgets.removeLast();
        return Column(children: widgets);
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
      );
    }
    return CustomTextField(
      label: label,
      hintText: label,
      controller: controller,
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
}

// Note: Make sure to import your AppDrawer from home_page.dart
// import 'package:costex_app/pages/home/home_page.dart' show AppDrawer;