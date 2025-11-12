import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:costex_app/views/home/home.dart';
import 'towel_costing_controller.dart';

class TowelCostingPage extends StatelessWidget {
  const TowelCostingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TowelCostingController controller = Get.put(TowelCostingController());

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
          'TOWEL COSTING',
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
          isScrollable: true,
          labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'COSTING'),
            Tab(text: 'FABRIC'),
            Tab(text: 'STITCHING'),
            Tab(text: 'EX FACTORY'),
            Tab(text: 'EXPORT'),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _buildCostingTab(controller),
          _buildFabricTab(controller),
          _buildStitchingTab(controller),
          _buildExFactoryTab(controller),
          _buildExportTab(controller),
        ],
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
                    onPressed: controller.isLoading.value ? null : controller.saveQuotation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        : const Text('SAVE QUOTATION', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.generatePDF,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC143C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('GENERATE PDF', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildCostingTab(TowelCostingController c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bigTabTitle('TOWEL COSTING'),
              _prettyCard([
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Date',
                        hintText: 'Month/Day/Year',
                        controller: c.dateController,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomTextField(
                        label: 'Client Name',
                        hintText: 'Client Name',
                        controller: c.clientNameController,
                      ),
                    ),
                  ],
                )
              ], 'General Info'),
              const SizedBox(height: 18),
              _prettyCard([
                _costingBlock(
                  'Pile Details',
                  ['Count', 'Rate', '%AGE', 'Amount'],
                  [c.pileCountController, c.pileRateController, c.pileAgeController, c.pileAmountController],
                ),
                const SizedBox(height: 12),
                _costingBlock(
                  'Weft Details',
                  ['Count', 'Rate', '%AGE', 'Amount'],
                  [c.weftCountController, c.weftRateController, c.weftAgeController, c.weftAmountController],
                ),
                const SizedBox(height: 12),
                _costingBlock(
                  'Ground Details',
                  ['Count', 'Rate', '%AGE', 'Amount'],
                  [c.groundCountController, c.groundRateController, c.groundAgeController, c.groundAmountController],
                ),
                const SizedBox(height: 12),
                _costingBlock(
                  'Fancy Details',
                  ['Count', 'Rate', '%AGE', 'Amount'],
                  [c.fancyCountController, c.fancyRateController, c.fancyAgeController, c.fancyAmountController],
                ),
              ], 'Costing Sheet'),
              const SizedBox(height: 18),
              _prettyCard([
                ..._verticalBrandFields(c),
              ], 'Brand Name'),
              const SizedBox(height: 18),
              _prettyCard([
                NumericTextField(label: 'GST %', controller: c.gstPercentController),
                const SizedBox(height: 12),
                HighlightedNumericTextField(label: 'Total Amount', controller: c.totalAmountController, readOnly: true),
              ], 'Totals'),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _prettyCard(List<Widget> children, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 0),
      color: const Color(0xFFFAFAFF),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _bigTabTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBackground,
          letterSpacing: 2,
        ),
      ),
    );
  }

  List<Widget> _verticalBrandFields(TowelCostingController c) {
    final names = [
      ['Pile', c.pileNameController],
      ['Weft', c.weftNameController],
      ['Ground', c.groundNameController],
      ['Fancy', c.fancyNameController]
    ];
    return [
      for (final entry in names) ...[
        Row(
          children: [
            Expanded(flex: 1, child: Text(entry[0] as String, style: const TextStyle(fontSize: 13))),
            const SizedBox(width: 10),
            Expanded(flex: 4, child: CustomTextField(hintText: entry[0] as String, controller: entry[1] as TextEditingController)),
          ],
        ),
        const SizedBox(height: 8)
      ]
    ];
  }

  Widget _buildFabricTab(TowelCostingController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('GREY FABRIC COST', [
              _buildField('Yarn', controller.yarnController, isCalculated: true),
              _buildField('Waistage 4%', controller.waistage4Controller, isCalculated: true),
              _buildField('Yarn Total', controller.yarnTotalController, isCalculated: true),
              _buildField('Waving Charges', controller.wavingChargesController),
              _buildField('Grey Fabric In Pound', controller.greyFabricInPoundController, isCalculated: true),
              _buildField('Grey Fabric In kg', controller.greyFabricInKgController, isCalculated: true),
              _buildField('Viscous/sizing', controller.viscousSizingController),
              _buildField('Yarn Freight', controller.yarnFreightController),
              _buildField('Grey Total', controller.greyTotalController, isCalculated: true),
            ]),
            const SizedBox(height: 24),
            _buildSection('SHARING COST', [
              _buildField('Valour Charges', controller.valourChargesController),
              _buildField('Waistage%', controller.waistageShareController),
              _buildField('Total Cost', controller.totalCostShareController, isCalculated: true),
              _buildField('Waistage Cost', controller.waistageCostController, isCalculated: true),
              _buildField('Valour Fabric', controller.valourFabricController, isCalculated: true),
            ]),
            const SizedBox(height: 24),
            _buildSection('PROCESSING COST', [
              _buildField('Processing', controller.processingController),
              _buildField('Waistage%', controller.waistageProcessController),
              _buildField('Total Cost', controller.totalCostProcessController, isCalculated: true),
              _buildField('Waistage Cost', controller.waistageCostProcessController, isCalculated: true),
              _buildField('Dyed Fabric', controller.dyedFabricController, isCalculated: true),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ...fields,
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool isCalculated = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 3,
            child: isCalculated
                ? HighlightedNumericTextField(hintText: '0', controller: controller, readOnly: true)
                : NumericTextField(hintText: '0', controller: controller),
          ),
        ],
      ),
    );
  }

  Widget _buildStitchingTab(TowelCostingController c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bigTabTitle('STITCHING'),
              _prettyCard([
                _stitchingBlock('Towel Stitching', [
                  ['Stitching', c.stitchingTowelController],
                  ['B %', c.bPercentTowelController],
                  ['Total Cost', c.totalCostTowelController, true],
                  ['Waistage Cost', c.waistageCostTowelController, true],
                  ['Towel Rate', c.towelRateController, true],
                ]),
                const SizedBox(height: 16),
                _stitchingBlock('Bathrobe Stitching 1', [
                  ['Length', c.lengthBathrobe1Controller],
                  ['Sleeve', c.sleeveBathrobe1Controller],
                  ['Length Margin', c.lengthMarginBathrobe1Controller],
                  ['Sleeve Margin', c.sleeveMarginBathrobe1Controller],
                  ['Pockets', c.pocketsBathrobe1Controller],
                  ['Cutting Waste', c.cuttingWasteBathrobe1Controller, true],
                  ['Fabric Consumption', c.fabricCounsumptionBathrobe1Controller, true],
                  ['GSM', c.gsmBathrobe1Controller],
                  ['Wt / Mtr', c.wtMtrBathrobe1Controller, true],
                  ['Wt / Pc', c.wtPcBathrobe1Controller, true],
                  ['Fabric Cost', c.fabricCostBathrobe1Controller, true],
                  ['Labour', c.labourBathrobe1Controller],
                  ['B %', c.bPercentBathrobe1Controller],
                  ['Total Cost', c.totalCostBathrobe1Controller, true],
                  ['B Cost', c.bCostBathrobe1Controller, true],
                  ['Bathrobe Rate', c.bathrobeRateBathrobe1Controller, true],
                ]),
                const SizedBox(height: 16),
                _stitchingBlock('Bathrobe Stitching 2', [
                  ['Length', c.lengthBathrobe2Controller],
                  ['Length Margin', c.lengthMarginBathrobe2Controller],
                  ['Fabric Use', c.fabricUseBathrobe2Controller, true],
                  ['Cutting Waste', c.cuttingWasteBathrobe2Controller, true],
                  ['Fabric Consumption', c.fabricCounsumptionBathrobe2Controller, true],
                  ['GSM', c.gsmBathrobe2Controller],
                  ['Wt / Mtr', c.wtMtrBathrobe2Controller, true],
                  ['Wt / Pc', c.wtPcBathrobe2Controller, true],
                  ['Fabric Cost', c.fabricCostBathrobe2Controller, true],
                  ['Labour', c.labourBathrobe2Controller],
                  ['B %', c.bPercentBathrobe2Controller],
                  ['Total Cost', c.totalCostBathrobe2Controller, true],
                  ['B Cost', c.bCostBathrobe2Controller, true],
                  ['Bathrobe Rate', c.bathrobeRateBathrobe2Controller, true],
                ]),
              ], 'TOWEL STITCHING'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stitchingBlock(String title, List<List> fields) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 0),
      color: const Color(0xFFF7F9FD),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15)),
            const SizedBox(height: 12),
            for (final f in fields)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(f[0], style: const TextStyle(fontSize: 15))),
                    Expanded(
                      flex: 5,
                      child: f.length > 2 && f[2] == true
                          ? HighlightedNumericTextField(hintText: '0', controller: f[1], readOnly: true)
                          : NumericTextField(hintText: '0', controller: f[1]),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExFactoryTab(TowelCostingController c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bigTabTitle('EX FACTORY'),
              _prettyCard([
                _exRow('Profit %', c.profitPercentTowelController),
                _exRow('Profit Amount', c.profitAmountTowelController, isCalc: true),
                _exRow('Ex factory', c.exFactoryTowelController, isCalc: true),
              ], 'Towel'),
              const SizedBox(height: 16),
              _prettyCard([
                _exRow('Profit %', c.profitPercentBathrobe1Controller),
                _exRow('Profit Amount', c.profitAmountBathrobe1Controller, isCalc: true),
                _exRow('Ex factory', c.exFactoryBathrobe1Controller, isCalc: true),
              ], 'Bathrobe 1'),
              const SizedBox(height: 16),
              _prettyCard([
                _exRow('Profit %', c.profitPercentBathrobe2Controller),
                _exRow('Profit Amount', c.profitAmountBathrobe2Controller, isCalc: true),
                _exRow('Ex factory', c.exFactoryBathrobe2Controller, isCalc: true),
              ], 'Bathrobe 2'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exRow(String label, TextEditingController controller, {bool isCalc = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 15))),
          Expanded(
            flex: 5,
            child: isCalc
                ? HighlightedNumericTextField(hintText: '0', controller: controller, readOnly: true)
                : NumericTextField(hintText: '0', controller: controller),
          ),
        ],
      ),
    );
  }

  Widget _buildExportTab(TowelCostingController c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bigTabTitle('EXPORT'),
              
              // FREIGHT/KG Section - 15 fields
              _prettyCard([
                _exportRow('Freight/Kg', c.freightKgController),
                _exportRow('Sub Total', c.subTotalKgController, isCalc: true),
                _exportRow('Bank Charges %', c.bankChargesPercentKgController),
                _exportRow('Bank % Total', c.bankPercentTotalKgController, isCalc: true),
                _exportRow('17 GST %', c.gst17PercentKgController),
                _exportRow('17 GST Total', c.gst17TotalKgController, isCalc: true),
                _exportRow('Overhead Charges %', c.overheadChargesPercentKgController),
                _exportRow('Overhead Total', c.overheadTotalKgController, isCalc: true),
                _exportRow('Profit %', c.profitPercentKgController),
                _exportRow('Profit % Total', c.profitPercentTotalKgController, isCalc: true),
                _exportRow('Commission %', c.commissionPercentKgController),
                _exportRow('Commission % Total', c.commissionPercentTotalKgController, isCalc: true),
                _exportRow('Total', c.totalKgController, isCalc: true),
                _exportRow('USD RATE', c.usdRateKgController),
                _exportRow('\$', c.dollarKgController, isCalc: true),
              ], 'FREIGHT/KG'),
              
              const SizedBox(height: 18),
              
              // FREIGHT/PC Section - 7 fields
              _prettyCard([
                _exportRow('Freight/Pc', c.freightPcController),
                _exportRow('Sub Total', c.subTotalPcController, isCalc: true),
                _exportRow('Profit %', c.profitPercentPcController),
                _exportRow('Profit Amount', c.profitAmountPcController, isCalc: true),
                _exportRow('Total', c.totalPcController, isCalc: true),
                _exportRow('USD RATE', c.usdRatePcController),
                _exportRow('\$', c.dollarPcController, isCalc: true),
              ], 'FREIGHT/PC'),
              
              const SizedBox(height: 18),
              
              // FREIGHT/PC2 Section - 10 fields
              _prettyCard([
                _exportRow('Freight/Pc', c.freightPc2Controller),
                _exportRow('Sub Total', c.subTotalPc2Controller, isCalc: true),
                _exportRow('Bank Charges', c.bankChargesPc2Controller),
                _exportRow('GST %', c.gstPercentPc2Controller),
                _exportRow('Profit %', c.profitPercentPc2Controller),
                _exportRow('Commission', c.commissionPc2Controller),
                _exportRow('', c.intermediateTotal2Controller, isCalc: true),
                _exportRow('Total', c.totalPc2Controller, isCalc: true),
                _exportRow('USD RATE', c.usdRatePc2Controller),
                _exportRow('\$', c.dollarPc2Controller, isCalc: true),
              ], 'FREIGHT/PC2'),
              
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exportRow(String label, TextEditingController c, {bool isCalc = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 3,
            child: isCalc
                ? HighlightedNumericTextField(hintText: '0', controller: c, readOnly: true)
                : NumericTextField(hintText: '0', controller: c),
          ),
        ],
      ),
    );
  }

  Widget _costingBlock(String title, List<String> fieldLabels, List<TextEditingController> ctrls) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 0),
      color: const Color(0xFFF7F9FD),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15)),
            const SizedBox(height: 12),
            for (var i = 0; i < fieldLabels.length; i++)
              Row(
                children: [
                  Expanded(flex: 2, child: Text(fieldLabels[i], style: const TextStyle(fontSize: 15))),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: fieldLabels[i] == 'Amount'
                          ? HighlightedNumericTextField(
                              hintText: '0',
                              controller: ctrls[i],
                              readOnly: true,
                            )
                          : NumericTextField(
                              hintText: '0',
                              controller: ctrls[i],
                            ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}