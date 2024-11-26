import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/UI/Utils/app_colors.dart';
import 'package:task_manager/UI/Widgets/screenBackground.dart';
import '../Controllers/forgot_password_otp_Controller.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  final String email;

  ForgotPasswordOtpScreen({super.key, required this.email});

  final ForgotPasswordOtpController _controller =
  Get.put(ForgotPasswordOtpController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Pin Verification",
                  style:
                  textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "A 6-digit verification OTP has been sent to your email address.",
                  style: textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                buildOTPInputForm(),
                const SizedBox(height: 30),
                buildHaveAnAccountSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOTPInputForm() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _controller.otpCtrl,
          length: 6,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: Get.context!,
        ),
        const SizedBox(height: 20),
        Obx(
              () => ElevatedButton(
            onPressed: _controller.otpInProgress.value
                ? null
                : () => _controller.verifyOtp(email),
            child: _controller.otpInProgress.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      ],
    );
  }

  Widget buildHaveAnAccountSection() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.5),
              text: "Have an account? ",
              children: [
                TextSpan(
                  style: const TextStyle(color: AppColors.themeColor),
                  text: 'Sign In',
                  recognizer: TapGestureRecognizer()
                    ..onTap = _controller.navigateToSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
