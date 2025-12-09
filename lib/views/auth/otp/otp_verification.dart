import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _codeController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();

    if (code.length != 6) {
      Get.snackbar('Invalid code', 'Please enter the 6-digit code sent to your email.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await _apiService.verifyOtp(
        email: widget.email,
        otp: code,
      );

      if (!mounted) return;

      setState(() => _isLoading = false);

      Get.snackbar(
        
        'Success',
        response['message']?.toString() ?? 'OTP verified successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: const Duration(seconds: 40),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );

      await SessionService.instance.clearSession();
      Get.offAll(() => const LoginPage());
    } on ApiException catch (error) {
      setState(() => _isLoading = false);
      Get.snackbar(
        'Error',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } catch (error) {
      setState(() => _isLoading = false);
      Get.snackbar(
        'Error',
        'OTP verification failed: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _resendCode() async {
    // TODO: implement resend code API
    Get.snackbar('Code sent', 'A new verification code has been sent to ${widget.email}.',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'We sent a 6-digit verification code to:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: 'Verification code',
                hintText: 'Enter 6-digit code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyCode,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: _isLoading
                  ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator())
                  : const Text('Verify',style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: _resendCode,
              child: const Text('Resend code',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
