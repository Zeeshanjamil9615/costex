import 'package:costex_app/views/drawer/export_multi_width_fabric/export_multi_width_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';

class MultiMadeupsPage extends StatelessWidget {
  const MultiMadeupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MultiMadeupsController controller = Get.put(MultiMadeupsController());

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
          'MULTI MADEUPS COSTING',
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
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'BASIC'),
            Tab(text: 'CONSUMPTION'),
            Tab(text: 'FABRIC'),
            Tab(text: 'FREIGHT'),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Form(
        key: controller.formKey,
        child: TabBarView(
          controller: controller.tabController,
          children: [
            _buildBasicDetailsTab(controller),
            _buildConsumptionDetailsTab(controller),
            _buildFabricDetailsTab(controller),
            _buildFreightDetailsTab(controller),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Obx(() => Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.saveQuotation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
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
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.generatePDF,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
      ),
    );
  }

  Widget _buildBasicDetailsTab(MultiMadeupsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Basic Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Customer Name',
                  hintText: 'Customer Name',
                  controller: controller.customerNameController,
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    _buildProductCard('Product 1', controller, 1),
                    const SizedBox(height: 12),
                    _buildProductCard('Product 2', controller, 2),
                    const SizedBox(height: 12),
                    _buildProductCard('Product 3', controller, 3),
                    const SizedBox(height: 12),
                    _buildProductCard('Product 4', controller, 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(String title, MultiMadeupsController controller, int productNum) {
    final List<TextEditingController> ctrls = _getBasicControllers(controller, productNum);
    final labelList = [
      'Warp', 'Weft', 'Reed', 'Pick', 'Grey Width', 'Finish Width'
    ];
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.17),
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 8),
            for (int i = 0; i < ctrls.length; i++) ...[
              CustomTextField(
                label: labelList[i],
                hintText: labelList[i],
                controller: ctrls[i],
              ),
              if (i < ctrls.length - 1) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  List<TextEditingController> _getBasicControllers(MultiMadeupsController c, int productNum) {
    switch (productNum) {
      case 1:
        return [c.warp1Controller, c.weft1Controller, c.reed1Controller, c.pick1Controller, c.greyWidth1Controller, c.finishWidth1Controller];
      case 2:
        return [c.warp2Controller, c.weft2Controller, c.reed2Controller, c.pick2Controller, c.greyWidth2Controller, c.finishWidth2Controller];
      case 3:
        return [c.warp3Controller, c.weft3Controller, c.reed3Controller, c.pick3Controller, c.greyWidth3Controller, c.finishWidth3Controller];
      case 4:
        return [c.warp4Controller, c.weft4Controller, c.reed4Controller, c.pick4Controller, c.greyWidth4Controller, c.finishWidth4Controller];
      default:
        return [];
    }
  }

  Widget _buildConsumptionDetailsTab(MultiMadeupsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Consumption Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 16),
                _buildConsumptionSection('Product 1', controller, 1),
                const SizedBox(height: 24),
                _buildConsumptionSection('Product 2', controller, 2),
                const SizedBox(height: 24),
                _buildConsumptionSection('Product 3', controller, 3),
                const SizedBox(height: 24),
                _buildConsumptionSection('Product 4', controller, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsumptionSection(String title, MultiMadeupsController controller, int productNum) {
    final generalProductNameController = _getGeneralProductNameController(controller, productNum);
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.13),
              spreadRadius: 0,
              blurRadius: 13,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          initiallyExpanded: productNum == 1,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: const Text(
            'Enter up to 4 items. Amounts auto-total below.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          children: [
            // General Product Name field at the top
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomTextField(
                label: 'Product Name',
                hintText: 'Product Name',
                controller: generalProductNameController,
              ),
            ),
            // Vertical layout – no header, each line stacked for readability
            const SizedBox(height: 8),
            // Table Rows
            ...List.generate(4, (index) => _buildConsumptionRow(controller, productNum, index + 1)),
            const SizedBox(height: 8),
            // Total Row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: HighlightedNumericTextField(
                      hintText: '0',
                      controller: _getTotalController(controller, productNum),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsumptionRow(MultiMadeupsController controller, int productNum, int rowNum) {
    final controllers = _getConsumptionControllers(controller, productNum, rowNum);
    final gvObs = _getGVObservable(controller, productNum, rowNum);
    final fwObs = _getFWObservable(controller, productNum, rowNum);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isCompact = constraints.maxWidth < 420;
          final bool isMedium = constraints.maxWidth >= 420 && constraints.maxWidth < 640;

          Widget widthWithDropdown(TextEditingController c, RxString obs, String hint) {
            return Row(
              children: [
                Expanded(child: NumericTextField(hintText: hint, controller: c)),
                const SizedBox(width: 6),
                Obx(() {
                  // Get grey widths from Basic Details
                  final greyWidth1 = controller.greyWidth1Controller.text.isEmpty ? '0' : controller.greyWidth1Controller.text;
                  final greyWidth2 = controller.greyWidth2Controller.text.isEmpty ? '0' : controller.greyWidth2Controller.text;
                  final greyWidth3 = controller.greyWidth3Controller.text.isEmpty ? '0' : controller.greyWidth3Controller.text;
                  final greyWidth4 = controller.greyWidth4Controller.text.isEmpty ? '0' : controller.greyWidth4Controller.text;
                  
                  final List<String> items = obs == gvObs 
                      ? ['GV', greyWidth1, greyWidth2, greyWidth3, greyWidth4]
                      : ['FW', greyWidth1, greyWidth2, greyWidth3, greyWidth4];
                  
                  // Ensure current value is in the list, otherwise use first item
                  String currentValue = obs.value;
                  if (!items.contains(currentValue)) {
                    currentValue = items.isNotEmpty ? items[0] : 'GV';
                    obs.value = currentValue;
                  }
                  
                  return Container(
                    width: 56,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentValue,
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        items: items
                            .map((u) => DropdownMenuItem(value: u, child: Text(u, style: const TextStyle(fontSize: 12))))
                            .toList(),
                        onChanged: (v) { if (v != null) obs.value = v; },
                      ),
                    ),
                  );
                }),
              ],
            );
          }

          List<Widget> buildWide() => [
            Text('#$rowNum', style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(flex: 2, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: CustomTextField(hintText: 'Product Name', controller: controllers[0]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[1]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[2]))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'CutSize', controller: controllers[3]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[4], gvObs, 'Grey Width'))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[5], fwObs, 'Finish Width'))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Pcs', controller: controllers[6]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption', controller: controllers[7], readOnly: true))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption Price', controller: controllers[8], readOnly: true))),
            ]),
          ];

          List<Widget> buildMedium() => [
            Text('#$rowNum', style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(flex: 2, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: CustomTextField(hintText: 'Product Name', controller: controllers[0]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[1]))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[2]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'CutSize', controller: controllers[3]))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[4], gvObs, 'Grey Width'))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[5], fwObs, 'Finish Width'))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Pcs', controller: controllers[6]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption', controller: controllers[7], readOnly: true))),
            ]),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption Price', controller: controllers[8], readOnly: true)),
          ];

          List<Widget> buildCompact() => [
            Text('#$rowNum', style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 6),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: CustomTextField(hintText: 'Product Name', controller: controllers[0])),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[1]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Size', controller: controllers[2]))),
            ]),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'CutSize', controller: controllers[3])),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[4], gvObs, 'Grey Width')),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: widthWithDropdown(controllers[5], fwObs, 'Finish Width')),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: NumericTextField(hintText: 'Pcs', controller: controllers[6]))),
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption', controller: controllers[7], readOnly: true))),
            ]),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: HighlightedNumericTextField(hintText: 'Consumption Price', controller: controllers[8], readOnly: true)),
          ];

          final children = isCompact ? buildCompact() : (isMedium ? buildMedium() : buildWide());
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
        },
      ),
    );
  }

  List<TextEditingController> _getConsumptionControllers(MultiMadeupsController c, int productNum, int rowNum) {
    // Returns: [productName, size1, size2, cutSize, greyWidth, finishWidth, pcs, consumption, consumptionPrice]
    if (productNum == 1) {
      switch (rowNum) {
        case 1: return [c.productName1_1Controller, c.size1_1Controller, c.size2_1_1Controller, c.cutSize1_1Controller, c.greyWidth1_1Controller, c.finishWidth1_1Controller, c.pcs1_1Controller, c.consumption1_1Controller, c.consumptionPrice1_1Controller];
        case 2: return [c.productName1_2Controller, c.size1_2Controller, c.size2_1_2Controller, c.cutSize1_2Controller, c.greyWidth1_2Controller, c.finishWidth1_2Controller, c.pcs1_2Controller, c.consumption1_2Controller, c.consumptionPrice1_2Controller];
        case 3: return [c.productName1_3Controller, c.size1_3Controller, c.size2_1_3Controller, c.cutSize1_3Controller, c.greyWidth1_3Controller, c.finishWidth1_3Controller, c.pcs1_3Controller, c.consumption1_3Controller, c.consumptionPrice1_3Controller];
        case 4: return [c.productName1_4Controller, c.size1_4Controller, c.size2_1_4Controller, c.cutSize1_4Controller, c.greyWidth1_4Controller, c.finishWidth1_4Controller, c.pcs1_4Controller, c.consumption1_4Controller, c.consumptionPrice1_4Controller];
      }
    } else if (productNum == 2) {
      switch (rowNum) {
        case 1: return [c.productName2_1Controller, c.size2_1Controller, c.size2_2_1Controller, c.cutSize2_1Controller, c.greyWidth2_1Controller, c.finishWidth2_1Controller, c.pcs2_1Controller, c.consumption2_1Controller, c.consumptionPrice2_1Controller];
        case 2: return [c.productName2_2Controller, c.size2_2Controller, c.size2_2_2Controller, c.cutSize2_2Controller, c.greyWidth2_2Controller, c.finishWidth2_2Controller, c.pcs2_2Controller, c.consumption2_2Controller, c.consumptionPrice2_2Controller];
        case 3: return [c.productName2_3Controller, c.size2_3Controller, c.size2_2_3Controller, c.cutSize2_3Controller, c.greyWidth2_3Controller, c.finishWidth2_3Controller, c.pcs2_3Controller, c.consumption2_3Controller, c.consumptionPrice2_3Controller];
        case 4: return [c.productName2_4Controller, c.size2_4Controller, c.size2_2_4Controller, c.cutSize2_4Controller, c.greyWidth2_4Controller, c.finishWidth2_4Controller, c.pcs2_4Controller, c.consumption2_4Controller, c.consumptionPrice2_4Controller];
      }
    } else if (productNum == 3) {
      switch (rowNum) {
        case 1: return [c.productName3_1Controller, c.size3_1Controller, c.size2_3_1Controller, c.cutSize3_1Controller, c.greyWidth3_1Controller, c.finishWidth3_1Controller, c.pcs3_1Controller, c.consumption3_1Controller, c.consumptionPrice3_1Controller];
        case 2: return [c.productName3_2Controller, c.size3_2Controller, c.size2_3_2Controller, c.cutSize3_2Controller, c.greyWidth3_2Controller, c.finishWidth3_2Controller, c.pcs3_2Controller, c.consumption3_2Controller, c.consumptionPrice3_2Controller];
        case 3: return [c.productName3_3Controller, c.size3_3Controller, c.size2_3_3Controller, c.cutSize3_3Controller, c.greyWidth3_3Controller, c.finishWidth3_3Controller, c.pcs3_3Controller, c.consumption3_3Controller, c.consumptionPrice3_3Controller];
        case 4: return [c.productName3_4Controller, c.size3_4Controller, c.size2_3_4Controller, c.cutSize3_4Controller, c.greyWidth3_4Controller, c.finishWidth3_4Controller, c.pcs3_4Controller, c.consumption3_4Controller, c.consumptionPrice3_4Controller];
      }
    } else {
      switch (rowNum) {
        case 1: return [c.productName4_1Controller, c.size4_1Controller, c.size2_4_1Controller, c.cutSize4_1Controller, c.greyWidth4_1Controller, c.finishWidth4_1Controller, c.pcs4_1Controller, c.consumption4_1Controller, c.consumptionPrice4_1Controller];
        case 2: return [c.productName4_2Controller, c.size4_2Controller, c.size2_4_2Controller, c.cutSize4_2Controller, c.greyWidth4_2Controller, c.finishWidth4_2Controller, c.pcs4_2Controller, c.consumption4_2Controller, c.consumptionPrice4_2Controller];
        case 3: return [c.productName4_3Controller, c.size4_3Controller, c.size2_4_3Controller, c.cutSize4_3Controller, c.greyWidth4_3Controller, c.finishWidth4_3Controller, c.pcs4_3Controller, c.consumption4_3Controller, c.consumptionPrice4_3Controller];
        case 4: return [c.productName4_4Controller, c.size4_4Controller, c.size2_4_4Controller, c.cutSize4_4Controller, c.greyWidth4_4Controller, c.finishWidth4_4Controller, c.pcs4_4Controller, c.consumption4_4Controller, c.consumptionPrice4_4Controller];
      }
    }
    return [];
  }

  RxString _getGVObservable(MultiMadeupsController c, int productNum, int rowNum) {
    if (productNum == 1) {
      switch (rowNum) {
        case 1: return c.selectedGV1_1;
        case 2: return c.selectedGV1_2;
        case 3: return c.selectedGV1_3;
        case 4: return c.selectedGV1_4;
      }
    } else if (productNum == 2) {
      switch (rowNum) {
        case 1: return c.selectedGV2_1;
        case 2: return c.selectedGV2_2;
        case 3: return c.selectedGV2_3;
        case 4: return c.selectedGV2_4;
      }
    } else if (productNum == 3) {
      switch (rowNum) {
        case 1: return c.selectedGV3_1;
        case 2: return c.selectedGV3_2;
        case 3: return c.selectedGV3_3;
        case 4: return c.selectedGV3_4;
      }
    } else {
      switch (rowNum) {
        case 1: return c.selectedGV4_1;
        case 2: return c.selectedGV4_2;
        case 3: return c.selectedGV4_3;
        case 4: return c.selectedGV4_4;
      }
    }
    return c.selectedGV1_1;
  }

  RxString _getFWObservable(MultiMadeupsController c, int productNum, int rowNum) {
    if (productNum == 1) {
      switch (rowNum) {
        case 1: return c.selectedFW1_1;
        case 2: return c.selectedFW1_2;
        case 3: return c.selectedFW1_3;
        case 4: return c.selectedFW1_4;
      }
    } else if (productNum == 2) {
      switch (rowNum) {
        case 1: return c.selectedFW2_1;
        case 2: return c.selectedFW2_2;
        case 3: return c.selectedFW2_3;
        case 4: return c.selectedFW2_4;
      }
    } else if (productNum == 3) {
      switch (rowNum) {
        case 1: return c.selectedFW3_1;
        case 2: return c.selectedFW3_2;
        case 3: return c.selectedFW3_3;
        case 4: return c.selectedFW3_4;
      }
    } else {
      switch (rowNum) {
        case 1: return c.selectedFW4_1;
        case 2: return c.selectedFW4_2;
        case 3: return c.selectedFW4_3;
        case 4: return c.selectedFW4_4;
      }
    }
    return c.selectedFW1_1;
  }

  TextEditingController _getGeneralProductNameController(MultiMadeupsController c, int productNum) {
    switch (productNum) {
      case 1: return c.generalProductName1Controller;
      case 2: return c.generalProductName2Controller;
      case 3: return c.generalProductName3Controller;
      case 4: return c.generalProductName4Controller;
      default: return c.generalProductName1Controller;
    }
  }

  TextEditingController _getTotalController(MultiMadeupsController c, int productNum) {
    switch (productNum) {
      case 1: return c.total1Controller;
      case 2: return c.total2Controller;
      case 3: return c.total3Controller;
      case 4: return c.total4Controller;
      default: return c.total1Controller;
    }
  }

  Widget _buildFabricDetailsTab(MultiMadeupsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fabric Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFabricVertical(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
// FABRIC TAB - FIXED: All calculated fields now use HighlightedNumericTextField with readOnly: true

Widget _buildFabricVertical(MultiMadeupsController c) {
  final fields = [
    ['Quality', c.quality1Controller, c.quality2Controller, c.quality3Controller, c.quality4Controller, false],
    ['Loom', c.loom1Controller, c.loom2Controller, c.loom3Controller, c.loom4Controller, false],
    ['Weave', c.weave1Controller, c.weave2Controller, c.weave3Controller, c.weave4Controller, false],
    ['Warp Rate/Lbs', c.warpRateLbs1Controller, c.warpRateLbs2Controller, c.warpRateLbs3Controller, c.warpRateLbs4Controller, false],
    ['Weft Rate/Lbs', c.weftRateLbs1Controller, c.weftRateLbs2Controller, c.weftRateLbs3Controller, c.weftRateLbs4Controller, false],
    ['Conversion/Pick', c.conversionPick1Controller, c.conversionPick2Controller, c.conversionPick3Controller, c.conversionPick4Controller, false],
    ['Warp Weight', c.warpWeight1Controller, c.warpWeight2Controller, c.warpWeight3Controller, c.warpWeight4Controller, true],
    ['Weft Weight', c.weftWeight1Controller, c.weftWeight2Controller, c.weftWeight3Controller, c.weftWeight4Controller, true],
    ['Total Weight', c.totalWeight1Controller, c.totalWeight2Controller, c.totalWeight3Controller, c.totalWeight4Controller, true],
    ['Warp Price', c.warpPrice1Controller, c.warpPrice2Controller, c.warpPrice3Controller, c.warpPrice4Controller, true], // FIXED: Now read-only
    ['Weft Price', c.weftPrice1Controller, c.weftPrice2Controller, c.weftPrice3Controller, c.weftPrice4Controller, true], // FIXED: Now read-only
    ['Conversion', c.conversion1Controller, c.conversion2Controller, c.conversion3Controller, c.conversion4Controller, true], // FIXED: Now read-only
    ['Grey Fabric Price', c.greyFabricPrice1Controller, c.greyFabricPrice2Controller, c.greyFabricPrice3Controller, c.greyFabricPrice4Controller, true],
    ['Mending/MT', c.mendingMT1Controller, c.mendingMT2Controller, c.mendingMT3Controller, c.mendingMT4Controller, false],
    ['Processing/inch', c.processinginch1Controller, c.processinginch2Controller, c.processinginch3Controller, c.processinginch4Controller, false],
    ['Processing Charges', c.processingCharges1Controller, c.processingCharges2Controller, c.processingCharges3Controller, c.processingCharges4Controller, true],
    ['Wastage %', c.wastage1Controller, c.wastage2Controller, c.wastage3Controller, c.wastage4Controller, false],
    ['Finish Fabric Cost', c.finishFabricCost1Controller, c.finishFabricCost2Controller, c.finishFabricCost3Controller, c.finishFabricCost4Controller, true],
  ];

  return Column(
    children: fields.map((field) {
      final label = field[0] as String;
      final isCalculated = field[5] as bool;
      return Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primary, width: 1.5),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _fabricInput(field[1] as TextEditingController, isCalculated),
                        _fabricInput(field[2] as TextEditingController, isCalculated),
                        _fabricInput(field[3] as TextEditingController, isCalculated),
                        _fabricInput(field[4] as TextEditingController, isCalculated),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _fabricInput(TextEditingController controller, bool isCalculated) {
  return SizedBox(
    width: 141,
    child: isCalculated
        ? HighlightedNumericTextField(hintText: '0', controller: controller, readOnly: true)
        : NumericTextField(hintText: '0', controller: controller),
  );
}


// COMPLETE KEY SECTIONS WITH FIXES:


  

  

  Widget _buildFreightDetailsTab(MultiMadeupsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Freight Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFreightTable(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
// FIXED FREIGHT TAB - Replace _buildFreightTable method in your view file

Widget _buildFreightTable(MultiMadeupsController c) {
  final regularFields = [
    // FIXED: Use generalProductName controllers instead of separate freight controllers
    ['Product Name', c.generalProductName1Controller, c.generalProductName2Controller, c.generalProductName3Controller, c.generalProductName4Controller, false, true],
    ['Consumption Price', c.consumptionPrice1Controller, c.consumptionPrice2Controller, c.consumptionPrice3Controller, c.consumptionPrice4Controller, true, false],
    ['Stitching', c.stitching1Controller, c.stitching2Controller, c.stitching3Controller, c.stitching4Controller, false, false],
    ['Accessories', c.accessories1Controller, c.accessories2Controller, c.accessories3Controller, c.accessories4Controller, false, false],
    ['Poly Bag', c.polyBag1Controller, c.polyBag2Controller, c.polyBag3Controller, c.polyBag4Controller, false, false],
    ['Miscellaneous', c.miscellaneous1Controller, c.miscellaneous2Controller, c.miscellaneous3Controller, c.miscellaneous4Controller, false, false],
    ['Packing charges', c.packingCharges1Controller, c.packingCharges2Controller, c.packingCharges3Controller, c.packingCharges4Controller, false, false],
    ['Container Size', c.containerSize1Controller, c.containerSize2Controller, c.containerSize3Controller, c.containerSize4Controller, false, true],
    ['Container Capacity', c.containerCapacity1Controller, c.containerCapacity2Controller, c.containerCapacity3Controller, c.containerCapacity4Controller, false, false],
    ['Rate of Exchange', c.rateOfExchange1Controller, c.rateOfExchange2Controller, c.rateOfExchange3Controller, c.rateOfExchange4Controller, false, false],
    ['FOB Price in PKR', c.fobPricePKR1Controller, c.fobPricePKR2Controller, c.fobPricePKR3Controller, c.fobPricePKR4Controller, true, false],
    ['FOB Price in \$', c.fobPriceDollar1Controller, c.fobPriceDollar2Controller, c.fobPriceDollar3Controller, c.fobPriceDollar4Controller, true, false],
    ['Freight in \$', c.freightDollar1Controller, c.freightDollar2Controller, c.freightDollar3Controller, c.freightDollar4Controller, false, false],
    ['Port', c.port1Controller, c.port2Controller, c.port3Controller, c.port4Controller, false, true],
    ['Freight Calculation', c.freightCalculation1Controller, c.freightCalculation2Controller, c.freightCalculation3Controller, c.freightCalculation4Controller, true, false],
    ['C & F Price in \$', c.cfPriceDollar1Controller, c.cfPriceDollar2Controller, c.cfPriceDollar3Controller, c.cfPriceDollar4Controller, true, false],
    ['Profit %', c.profitPercent1Controller, c.profitPercent2Controller, c.profitPercent3Controller, c.profitPercent4Controller, false, false],
    ['Commission %', c.commissionPercent1Controller, c.commissionPercent2Controller, c.commissionPercent3Controller, c.commissionPercent4Controller, false, false],
    ['Overhead %', c.overheadPercent1Controller, c.overheadPercent2Controller, c.overheadPercent3Controller, c.overheadPercent4Controller, false, false],
    ['FOB Price Final', c.fobPriceFinal1Controller, c.fobPriceFinal2Controller, c.fobPriceFinal3Controller, c.fobPriceFinal4Controller, true, false],
    ['C&F Price Final', c.cfPriceFinal1Controller, c.cfPriceFinal2Controller, c.cfPriceFinal3Controller, c.cfPriceFinal4Controller, true, false],
  ];

  return Column(
    children: [
      ...regularFields.map((field) {
        final label = field[0] as String;
        final isCalculated = field[5] as bool;
        final isText = field[6] as bool;
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.13),
                  spreadRadius: 0,
                  blurRadius: 13,
                  offset: const Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BCD4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _freightLabeledInput(field[1] as TextEditingController, isCalculated, isText, '1'),
                    const SizedBox(width: 8),
                    _freightLabeledInput(field[2] as TextEditingController, isCalculated, isText, '2'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _freightLabeledInput(field[3] as TextEditingController, isCalculated, isText, '3'),
                    const SizedBox(width: 8),
                    _freightLabeledInput(field[4] as TextEditingController, isCalculated, isText, '4'),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
      // Single FOB Total DuvetSet field
      Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.13),
                spreadRadius: 0,
                blurRadius: 13,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'FOB Total DuvetSet',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              HighlightedNumericTextField(
                hintText: '0',
                controller: c.fobTotalDuvetSet1Controller,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
      // Single C&F Total DuvetSet field
      Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.13),
                spreadRadius: 0,
                blurRadius: 13,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'C&F Total DuvetSet',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              HighlightedNumericTextField(
                hintText: '0',
                controller: c.cfTotalDuvetSet1Controller,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _freightLabeledInput(TextEditingController controller, bool isCalculated, bool isText, String productLabel) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product $productLabel', style: const TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 4),
        isCalculated
            ? HighlightedNumericTextField(hintText: '0', controller: controller, readOnly: true)
            : isText
                ? CustomTextField(hintText: 'Enter text', controller: controller)
                : NumericTextField(hintText: '0', controller: controller),
      ],
    ),
  );
}}