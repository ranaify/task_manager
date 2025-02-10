import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/main_bottom_nav_page.dart';
import 'package:task_manager/ui/pages/sign_up_page.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../controller/auth_controller.dart';
import '../widgets/background_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSignInProcess = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundPage(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Get Started With',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Email is required";
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Password is required";
                        }
                        if (value!.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _isSignInProcess == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, MainBottomNavPage.name);
                          Get.offAllNamed(MainBottomNavPage.name);
                        },
                        child: Text("Log In")),
                  ),
                  SizedBox(height: 48),
                  Center(
                      child: TextButton(
                          onPressed: _onTapSignIn,
                          /* () {Navigator.pushNamed(context, ForgotPasswordPage.name);},*/
                          child: Text("Forgot Password? "))),
                  SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        _buildSingUpSection(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignIn() {
    if (_formKey.currentState!.validate()) {
      _signInUser();
    }
  }

  Future<void> _signInUser() async {
    _isSignInProcess = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.logInUrl, body: requestBody);
    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['user']);
      await AuthController.saveUserData(token, userModel);
      // Navigator.pushReplacementNamed(context, MainBottomNavPage.name);
      Get.offAllNamed(MainBottomNavPage.name);
    } else {
      _isSignInProcess = false;
      setState(() {});
      if(response.statusCode==401){
        showSnackBarMessage(context, "Wrong email or password");

      }else{
      showSnackBarMessage(context, response.errorMessage);
      }
    }
  }

  Widget _buildSingUpSection() {
    return RichText(
      text: TextSpan(
          text: "Don not have an account?",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: " Sign Up",
                style: TextStyle(
                  color: Colors.green,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigator.pushNamed(context, SignUpPage.name);
                    Get.toNamed(SignUpPage.name);
                  })
          ]),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
