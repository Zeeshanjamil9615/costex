import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/views/auth/login/login.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (_codeController.text.trim().length != 6) {
      Get.snackbar('Invalid code', 'Please enter the 6-digit code sent to your email.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _isLoading = true);
    // TODO: replace with real verification API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // On success navigate to login
    Get.offAll(() => const LoginPage());
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
