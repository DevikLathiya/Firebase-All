import 'package:firebase/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Components/default_button.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _otp = TextEditingController();

  // google login---
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String verifyId="";

  @override
  void initState() {
    super.initState();
// firebase login user check
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
        // Name, email address, and profile photo URL
        Map m = {
          "user" : user.displayName,
          "email" : user.email,
          "phone" : user.phoneNumber,
          "photo" : user.photoURL,
        };

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(m),));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: (20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.black, fontSize: (28), fontWeight: FontWeight.bold,),
                  ),
                  const Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Mobile No",
                          hintText: "Enter your Mobile No",
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      const SizedBox(height: (30)),
                      DefaultButton(
                        text: "Send OTP",
                        press: () async {
                        if (_phone.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter Mobile No"), padding: EdgeInsets.all(15)));
                        } else if (_phone.text.length <=9) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter Valid Mobile No"), padding: EdgeInsets.all(15)));
                        } else
                            {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91 ${_phone.text}',
                                verificationCompleted: (PhoneAuthCredential credential) async {
                                  await auth.signInWithCredential(credential);
                                },

                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    print('The provided phone number is not valid.');
                                  }
                                },

                                codeSent: (String verificationId, int? resendToken) {
                                  verifyId = verificationId ;
                                  setState(() {});
                                },
                                codeAutoRetrievalTimeout: (String verificationId) {},
                              );
                            }
                        },
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        controller: _otp,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "OTP",
                          hintText: "Enter OTP",
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 30),

                      DefaultButton(text: "Verify OTP",
                        press: () async {
                        if(_otp.text.isEmpty)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Enter OTP"), padding: EdgeInsets.all(15)));
                          }
                        else
                          {
                            String smsCode = _otp.text;
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyId, smsCode:smsCode);
                            print("verifyId "+ verifyId);
                            print("providerId "+ credential.providerId);
                            print("credential "+ credential.smsCode.toString());
                            await auth.signInWithCredential(credential).then((value) {
                              print("User : $value");
                              Map m = {
                                "user" : value.user!.displayName,
                                "email" : value.user!.email,
                                "phone" : value.user!.phoneNumber,
                                "photo" : value.user!.photoURL,
                              };
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen(m),));
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen({}),));
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap: () {
                        signInWithGoogle().then((value) {
                          print(value);
                          Map m = {
                            "user" : value.user!.displayName,
                            "email" : value.user!.email,
                            "phone" : value.user!.phoneNumber,
                            "photo" : value.user!.photoURL,
                          };
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(m),));
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                        });
                      },child: SvgPicture.asset("assets/icons/google-icon.svg", height: 35,)),

                      const SizedBox(width: 40,),

                      InkWell(onTap: () {},child: SvgPicture.asset("assets/icons/facebook-2.svg", height: 35,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
/* Center(
        child: ElevatedButton(onPressed: () {
         //googleUser = await GoogleSignIn().signIn();
          signInWithGoogle().then((value) {
            String name = value.user!.displayName.toString();
            String email = value.user!.email.toString();
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home(name,email),));
          });
        }, child: const Text("Google"),),
      )*/