import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/Data/Models/Network_Response.dart';
import 'package:task_manager/Data/Services/Network_Caller.dart';
import 'package:task_manager/Data/Utils/Urls.dart';
import 'package:task_manager/UI/Controllers/Signup_controller.dart';
import 'package:task_manager/UI/Utils/app_colors.dart';
import 'package:task_manager/UI/Widgets/screenBackground.dart';
import '../Widgets/Center_Circular_Progress_Indicator.dart';
import '../Widgets/SnackBarMessage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final SignUpController signUpController = Get.put(SignUpController());
  bool inProgress = false;

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
              const SizedBox(
                height: 80,
              ),
              Text(
                "Join With Us",
                style: textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              SignUpForm(),
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
                  recognizer: TapGestureRecognizer()..onTap = onTapSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SignUpForm() {
    return Form(
      key: _globalKey,
      child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              controller:  signUpController.emailCtrl,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Valid Email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller:  signUpController.firstNameCtrl,
              decoration: const InputDecoration(
                hintText: "First Name",
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Valid First name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: signUpController.lastNameCtrl,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Valid last name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller:  signUpController.phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Mobile",
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Valid number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller:  signUpController.passCtrl,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Valid password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<SignUpController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: onTapNextButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                );
              }
            ),
          ],
        ),
    );
  }

  void onTapNextButton() {
    if (_globalKey.currentState!.validate()) {
      signUpController.signUp();
    }
  }


  void onTapSignIn() {
    Navigator.pop(context);
  }


}
