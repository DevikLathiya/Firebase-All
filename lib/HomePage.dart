import 'package:firebase/Cloud%20Firestore/Add%20&%20Update%20Data.dart';
import 'package:firebase/Components/constants.dart';
import 'package:firebase/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Components/default_button.dart';
import 'LoginPage.dart';
import 'Realtime DB/RealTime Firebase.dart';

class Home extends StatefulWidget {
  Map m;
    Home(this.m);
  // Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex=0;
    List  _pages = [
    const MainPage(),
    ProfileScreen({}),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[selectedIndex],
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 60),
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            decoration:  BoxDecoration(color: Colors.grey.shade400.withOpacity(.60),
              borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: GNav(
                gap: 8, color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(10),
                rippleColor: Colors.white, hoverColor: Colors.white,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                 tabs:  [
                  const GButton(
                    icon: Icons.home,iconSize: 30,
                    text: 'Home',
                  ),
                  const GButton(
                    icon: Icons.person,iconSize: 30,
                    text: 'Profile',
                  ),
                ]
            ),
          ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultButton(
                text: "Firebase Cloud",
                press: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdate(),));
                },
              ),
              DefaultButton(
                text: "Firebase RealTime",
                press: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FbRealTIme(),));
                },
              ),
              DefaultButton(
                text: "Logout",
                press: () async {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
