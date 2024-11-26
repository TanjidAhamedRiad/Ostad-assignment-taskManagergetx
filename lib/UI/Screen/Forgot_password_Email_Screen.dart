
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/Controllers/forgot_password_email_controller.dart';
import 'package:task_manager/UI/Utils/app_colors.dart';
import 'package:task_manager/UI/Widgets/Center_Circular_Progress_Indicator.dart';
import 'package:task_manager/UI/Widgets/screenBackground.dart';
import 'package:get/get.dart';


class ForgotPasswordEmailScreen extends StatefulWidget {
   const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  ForgotPasswordEmailController forgotPasswordEmailController = Get.find<
      ForgotPasswordEmailController>();
  final controller = Get.find<ForgotPasswordEmailController>();


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Your Email Address",
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "A 6 digit verification otp will be send your email address",
                    style: textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildEmailInputForm(),
                  const SizedBox(
                    height: 30,
                  ),
                  buildHaveAnAccountSection()
                ],
              ),
            ),
          )),
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
                    ..onTap = controller.onTapSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmailInputForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !controller.emailInProgress.value,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  void onTapNextButton() {
    controller.sendOTP();
  }
}