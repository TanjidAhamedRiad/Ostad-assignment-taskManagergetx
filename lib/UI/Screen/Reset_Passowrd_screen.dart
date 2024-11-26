
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Reset_Password_Controller.dart';
import '../Utils/app_colors.dart';
import '../Widgets/Center_Circular_Progress_Indicator.dart';
import '../Widgets/screenBackground.dart';
import 'SignInScreen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email, this.otp});
  final String email;
  final String? otp;

  final ResetPasswordController resetPasswordController = Get.find<ResetPasswordController>();


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
                  "Set Password",
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Minimum number of password should be 8 letters",
                  style: textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                buildResetPasswordForm(),
                const SizedBox(height: 30),
                buildHaveAnAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResetPasswordForm() {
    return Form(
      key: resetPasswordController.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: resetPasswordController.passwordCtrl,
            validator: (value) => value!.isEmpty ? 'Enter Password' : null,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: resetPasswordController.confirmPasswordCtrl,
            validator: (value) {
              if (value!.isEmpty) return 'Enter Password';
              if (value != resetPasswordController.passwordCtrl.text) return 'Password does not match';
              return null;
            },
            decoration: const InputDecoration(hintText: "Confirm Password"),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Visibility(
              visible: !resetPasswordController.recoveryPassInProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: ElevatedButton(
                onPressed: () => resetPasswordController.changePassword(
                  email,
                  otp,
                  resetPasswordController.passwordCtrl.text.trim(),
                  onSuccess: () {
                   // showSnackBarMessage(context, 'Password changed successfully', true);
                  Get.to(SignInScreen());

                  },
                  onError: (message) {
                  },
                ),
                child: const Icon(Icons.arrow_circle_right_outlined),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildHaveAnAccountSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
          text: "Have an account? ",
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = () {
               Get.offAllNamed(SignInScreen.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
