// view_quotation_page.dart
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/drawer/my_quotation/my_quotation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class ViewQuotationPage extends StatelessWidget {
  final Quotation quotation;

  const ViewQuotationPage({Key? key, required this.quotation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          quotation.fabricType.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Handle logout
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View ${quotation.fabricType} Costing Sheet',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Quotation No: ${quotation.quotationNo}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Customer Info Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Customer Name:',
                    quotation.customerName,
                    isHighlighted: true,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Dated:', quotation.dated),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Details Section based on fabric type
            if (quotation.fabricType == 'Grey Fabric')
              _buildGreyFabricDetails(quotation.details)
            else if (quotation.fabricType == 'Export Processed Fabric')
              _buildProcessedFabricDetails(quotation.details)
            else if (quotation.fabricType == 'Export Madeups Fabric')
              _buildMadeupsDetails(quotation.details)
            else if (quotation.fabricType == 'Towel Costing Sheet')
              _buildTowelDetails(quotation.details)
            else
              _buildGenericDetails(quotation.details),
            
            const SizedBox(height: 16),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _generatePDF(quotation);
                      },
                      icon: const Icon(Icons.picture_as_pdf, size: 20),
                      label: const Text(
                        'GENERATE PDF',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC3545),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back, size: 20),
                      label: const Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyFabricDetails(Map<String, dynamic> details) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Fabric Specifications'),
          const SizedBox(height: 16),
          _buildDetailField('Quality', details['quality']),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Warp Count', details['warpCount']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weft Count', details['weftCount']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Reeds', details['reeds']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Picks', details['picks']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Grey Width', details['greyWidth']),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Production Details'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('P/C Ratio', details['pcRatio']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Loom', details['loom']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Weave', details['weave']),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Rate & Weight'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Warp Rate', details['warpRate'], isHighlighted: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weft Rate', details['weftRate'], isHighlighted: true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Coveration Pick', details['coverationPick'], isHighlighted: true),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Warp Weight', details['warpWeight']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weft Weight', details['weftWeight']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Total Weight', details['totalWeight']),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Pricing'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Warp Price', details['warpPrice']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weft Price', details['weftPrice']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Coveration Charges', details['coverationCharges'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Grey Fabric Price', details['greyFabricPrice'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Profit %', details['profit']),
          const SizedBox(height: 12),
          _buildDetailField('Fabric Price Final', details['fabricPriceFinal'], isHighlighted: true, isBold: true),
        ],
      ),
    );
  }

  Widget _buildProcessedFabricDetails(Map<String, dynamic> details) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Processed Fabric Details'),
          const SizedBox(height: 16),
          _buildDetailField('Quality', details['quality']),
          const SizedBox(height: 12),
          _buildDetailField('Process Type', details['processType']),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Finished Width', details['finishedWidth']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('GSM', details['gsm']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Process Rate', details['processRate'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Total Price', details['totalPrice'], isHighlighted: true, isBold: true),
        ],
      ),
    );
  }

  Widget _buildMadeupsDetails(Map<String, dynamic> details) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Madeups Details'),
          const SizedBox(height: 16),
          _buildDetailField('Product Type', details['productType']),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Size', details['size']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weight', details['weight']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Stitching Charges', details['stitchingCharges'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Packing Charges', details['packingCharges'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Total Price', details['totalPrice'], isHighlighted: true, isBold: true),
        ],
      ),
    );
  }

  Widget _buildTowelDetails(Map<String, dynamic> details) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Towel Details'),
          const SizedBox(height: 16),
          _buildDetailField('Towel Type', details['towelType']),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailField('Size', details['size']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailField('Weight', details['weight']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailField('Dyeing Charges', details['dyeingCharges'], isHighlighted: true),
          const SizedBox(height: 12),
          _buildDetailField('Total Price', details['totalPrice'], isHighlighted: true, isBold: true),
        ],
      ),
    );
  }

  Widget _buildGenericDetails(Map<String, dynamic> details) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Details'),
          const SizedBox(height: 16),
          ...details.entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildDetailField(
                  _formatKey(entry.key),
                  entry.value.toString(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5722),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDetailField(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isHighlighted
                ? const Color(0xFFE3F2FD)
                : Colors.grey[100],
            border: Border.all(
              color: isHighlighted ? Colors.blue[200]! : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlighted = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? const Color(0xFFE3F2FD)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatKey(String key) {
    return key
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(0)}',
        )
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _generatePDF(Quotation quotation) {
    Get.snackbar(
      'PDF Generation',
      'PDF generated successfully for ${quotation.quotationNo}',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}