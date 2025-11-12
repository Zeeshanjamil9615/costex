import 'package:costex_app/views/drawer/grey_febric_costing_sheet/grey_febric_costing_controller.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class GreyFabricCostingScreen extends StatelessWidget {
  const GreyFabricCostingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GreyFabricCostingController());

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
          'GREY FABRIC COSTING SHEET',
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
                  'Grey Fabric Costing Sheet',
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
                child: Column(
                  children: [
                    // Customer Name (Full Width)
                    CustomTextField(
                      label: 'Customer Name',
                      hintText: 'Customer Name',
                      controller: controller.customerNameController,
                    ),
                    const SizedBox(height: 20),

                    // Quality (Full Width)
                    CustomTextField(
                      label: 'Quality',
                      hintText: 'Quality',
                      controller: controller.qualityController,
                    ),
                    const SizedBox(height: 20),

                    // Row 1: Warp Count, Weft Count, Reeds
                    _buildRow([
                      _buildField('Warp Count', controller.warpCountController),
                      _buildField('Weft Count', controller.weftCountController),
                      _buildField('Reeds', controller.reedsController),
                    ]),
                    const SizedBox(height: 20),

                    // Row 2: Picks, Grey Width, P/C Ratio
                    _buildRow([
                      _buildField('Picks', controller.picksController),
                      _buildField('Grey Width', controller.greyWidthController),
                      _buildField('P/C Ratio', controller.pcRatioController, isNumeric: false),
                    ]),
                    const SizedBox(height: 20),

                    // Row 3: Loom, Weave, Warp Rate/Lbs
                    _buildRow([
                      _buildField('Loom', controller.loomController, isNumeric: false),
                      _buildField('Weave', controller.weaveController, isNumeric: false),
                      _buildField('Warp Rate/Lbs', controller.warpRateController),
                    ]),
                    const SizedBox(height: 20),

                    // Row 4: Weft Rate/Lbs, Coversion/Picks
                    _buildRow([
                      _buildField('Weft Rate/Lbs', controller.weftRateController),
                      _buildField('Coversion/Picks', controller.coversionPicksController),
                      const SizedBox.shrink(), // Empty space for alignment
                    ]),
                    const SizedBox(height: 20),

                    // Row 5: Warp Weight, Weft Weight, Total Weight
                    _buildRow([
                      _buildCalculatedFieldWithGetter('Warp Weight', () => controller.warpWeight),
                      _buildCalculatedFieldWithGetter('Weft Weight', () => controller.weftWeight),
                      _buildCalculatedFieldWithGetter('Total Weight', () => controller.totalWeight),
                    ]),
                    const SizedBox(height: 20),

                    // Row 6: Warp Price, Weft Price, Coversion Charges
                    _buildRow([
                      _buildCalculatedFieldWithGetter('Warp Price', () => controller.warpPrice),
                      _buildCalculatedFieldWithGetter('Weft Price', () => controller.weftPrice),
                      _buildCalculatedFieldWithGetter('Coversion Charges', () => controller.coversionCharges),
                    ]),
                    const SizedBox(height: 20),

                    // Row 7: Grey Fabric Price, Profit %, Fabric Price Final
                    _buildRow([
                      _buildCalculatedFieldWithGetter('Grey Fabric Price', () => controller.greyFabricPrice),
                      _buildField('Profit %', controller.profitPercentController),
                      _buildCalculatedFieldWithGetter('Fabric Price Final', () => controller.fabricPriceFinal),
                    ]),
                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.saveQuotation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDC143C),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
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
                            onPressed: controller.generatePDF,
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
                    ),
                  ],
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
        // On mobile, stack fields vertically
        if (constraints.maxWidth < 1000) {
          return Column(
            children: children
                .where((child) => child is! SizedBox || child.key != null)
                .expand((child) => [child, const SizedBox(height: 16)])
                .toList()
              ..removeLast(),
          );
        }
        // On desktop/tablet, show in grid
        return Row(
          children: children
              .map((child) => Expanded(
                    child: child is SizedBox && child.key == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: child,
                          ),
                  ))
              .toList(),
        );
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

  Widget _buildCalculatedFieldWithGetter(String label, double Function() getValue) {
    return Obx(() {
      // Trigger rebuild when any dependency changes
      final value = getValue();
      return _ReadOnlyHighlightedField(
        label: label,
        value: value.toStringAsFixed(4),
      );
    });
  }
}

// Custom widget for read-only highlighted fields
class _ReadOnlyHighlightedField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyHighlightedField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.blue[200]!,
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}