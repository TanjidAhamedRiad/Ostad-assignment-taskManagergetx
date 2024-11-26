import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:task_manager/UI/Screen/Main_Button_NavBar_Screen.dart';
import 'package:task_manager/UI/Screen/SignInScreen.dart';
import 'package:task_manager/UI/Utils/app_colors.dart';
import 'package:task_manager/controller_binders.dart';

import 'UI/Screen/SplashScreen.dart';

class TaskManagerApp extends StatefulWidget {
   const TaskManagerApp({super.key});
  
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: inputDecoration(),
        elevatedButtonTheme: elevatedBottunThemeData()
        
      ),
      initialBinding: ControllerBinders(),
      initialRoute: '/',
      getPages:  [
        GetPage(name: SplashScreen.name, page: () => const SplashScreen()),
        GetPage(name: MainButtonNavbarScreen.name, page: () => const MainButtonNavbarScreen()),
        GetPage(name: SignInScreen.name, page: () => const SignInScreen()),
      ],
    );
  }


  InputDecorationTheme inputDecoration() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      fillColor: Colors.white,
      filled: true,
      border: inputBorder(),
      enabledBorder: inputBorder(),
      focusedBorder: inputBorder(),
      errorBorder: inputBorder(),
    );
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  
  ElevatedButtonThemeData elevatedBottunThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
      );
  }
}
