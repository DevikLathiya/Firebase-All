import 'package:flutter/material.dart';
import '../Components/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
   Map map ;

   ProfileScreen(this.map);
  // ProfileScreen(this.map);

  @override
  Widget build(BuildContext context) {

    print(map);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: kPrimarysColor.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              },
            ),
          ],
        ),
      )
    );
  }
}
