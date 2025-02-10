import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_page.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(
        fromUpdateProfile: true,
      ),
      body: BackgroundPage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Text(
                      'Update Profile',
                      style: textTheme.titleLarge,
                    ),
                    SizedBox(height: 24),
                    _buildPhotoPicker(),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "First Name"),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Last Name"),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Mobile"),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        )),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  Container _buildPhotoPicker() {
    return Container(
                 height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text("Photo", style: TextStyle(color: Colors.white),),
                      ),
                      SizedBox(width: 12,),
                      Text("No item selected", maxLines: 1,)

                    ],
                  ),
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
