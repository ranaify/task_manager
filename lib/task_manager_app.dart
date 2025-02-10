import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/add_new_task_page.dart';
import 'package:task_manager/ui/pages/forgot_password_page.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/main_bottom_nav_page.dart';
import 'package:task_manager/ui/pages/pin_verification_page.dart';
import 'package:task_manager/ui/pages/reset_password_page.dart';
import 'package:task_manager/ui/pages/sign_in_page.dart';
import 'package:task_manager/ui/pages/sign_up_page.dart';
import 'package:task_manager/ui/pages/splash_page.dart';
import 'package:task_manager/ui/pages/update_profile_page.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding:  EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          helperStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
        )
      ),
      onGenerateRoute: (RouteSettings settings){
       late Widget widget;
        if(settings.name == SplashPage.name){
          widget = const SplashPage();
        } else if(settings.name == SignInPage.name){
          widget = const SignInPage();
        } else if(settings.name == SignUpPage.name) {
          widget = const SignUpPage();
        } else if (settings.name == ForgotPasswordPage.name) {
          widget = const ForgotPasswordPage();
        } else if (settings.name == PinVerificationPage.name) {
          widget = const PinVerificationPage();
        } else if (settings.name == ResetPasswordPage.name) {
          widget = const ResetPasswordPage();
        } else if (settings.name == MainBottomNavPage.name) {
          widget = const MainBottomNavPage();
        } else if (settings.name == AddNewTaskPage.name) {
          widget = const AddNewTaskPage();
        }  else if (settings.name == UpdateProfilePage.name) {
          widget = const UpdateProfilePage();
        }
        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
