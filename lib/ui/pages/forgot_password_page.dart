import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/pages/pin_verification_page.dart';
import '../widgets/background_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String name = '/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
                    'You Email Address',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'A 6 digits OTP will be sent to your email Address',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, PinVerificationPage.name);
                        Get.toNamed(PinVerificationPage.name);
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      )),
                  SizedBox(height: 48),
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

  Widget _buildSingUpSection() {
    return RichText(
      text: TextSpan(
          text: "Have an account?",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: " Sign In",
                style: TextStyle(
                  color: Colors.green,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  // Navigator.pop(context);
                  Get.back();
                })
          ]),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}


