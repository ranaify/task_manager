import 'package:flutter/material.dart';
import 'package:task_manager/ui/pages/sign_in_page.dart';
import '../controller/auth_controller.dart';
import '../pages/update_profile_page.dart';
import '../utils/app_colors.dart';
class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,  this.fromUpdateProfile = false,
  });

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(),
          SizedBox(width: 10,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                if(!fromUpdateProfile){
                  Navigator.pushNamed(context, UpdateProfilePage.name);
                }

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel!.fullName ?? "", style: TextStyle(fontSize: 16, color: Colors.white),),
                  Text(AuthController.userModel!.email ?? "", style: TextStyle(fontSize: 16, color: Colors.white)),

                ],
              ),
            ),
          ),
          IconButton(onPressed: () async{
            await AuthController.logoutUser();
            Navigator.pushNamedAndRemoveUntil(context, SignInPage.name, (predicate)=>false);
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
