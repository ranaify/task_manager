import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/pages/sign_in_page.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_page.dart';
import 'bottom_nav_page/main_bottom_nav_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String name = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextPage();
  }

  Future<void> moveToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await  AuthController.isUserLoggedIn();
    if(isLoggedIn){
      // Navigator.pushReplacementNamed(context, MainBottomNavPage.name);
      Get.offAllNamed(MainBottomNavPage.name);
    }else{
      // Navigator.pushReplacementNamed(context, SignInPage.name);
      Get.offAllNamed(SignInPage.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundPage(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
