import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../../data/services/network_caller.dart';
import '../widgets/background_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _issSignUpProcess = false;
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
                    'Join With Us',
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
                      controller: _firstNameController,
                      decoration: InputDecoration(hintText: "First Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "First Name is required";
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Last Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Last Name is required";
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(hintText: "Mobile"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Mobile is required";
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
                    visible: _issSignUpProcess == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: _onTapSignUp,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        )),
                  ),
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

  void _onTapSignUp() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _issSignUpProcess = true;
    setState(() {});

    Map<String, dynamic> requestParams = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestParams);
    _issSignUpProcess = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
     showSnackBarMessage(context, "New user registration successful!");
    } else {
      showSnackBarMessage(context, response.errorMessage)        ;

    }
  }

  void _clearTextField() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _mobileController.clear();
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
                    // Navigator.pop(context);
                    Get.back();
                  })
          ]),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
