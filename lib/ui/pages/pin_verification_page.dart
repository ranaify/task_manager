import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/pages/reset_password_page.dart';
import 'package:task_manager/ui/pages/sign_in_page.dart';
import '../widgets/background_page.dart';

class PinVerificationPage extends StatefulWidget {
  const PinVerificationPage({super.key});

  static const String name = '/pin-verification';

  @override
  State<PinVerificationPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<PinVerificationPage> {
  final TextEditingController _pinController = TextEditingController();
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
                    'Pin Verification',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Maximum 6 digits OTP will be sent to your email Address',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  /// Pin Verification Field
                  buildPinCodeTextField(),
                  SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, ResetPasswordPage.name);
                        Get.toNamed(ResetPasswordPage.name);
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

  PinCodeTextField buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white24,
          selectedColor: Colors.green,
          inactiveFillColor: Colors.white24),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      controller: _pinController,
      appContext: context,
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
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigator.pushNamedAndRemoveUntil(context, SignInPage.name, (value) => false);
                    Get.offAllNamed(SignInPage.name);
                  })
          ]),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
