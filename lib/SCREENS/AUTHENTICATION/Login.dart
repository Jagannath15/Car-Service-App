import 'package:car_repair_app/SCREENS/AUTHENTICATION/Forgetpassword.dart';
import 'package:car_repair_app/SCREENS/HOME/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../UTILS/constants.dart';
import '../../UTILS/inputfield.dart';
import 'Signup.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {

   Future login(String email,String pass) async{
   
      try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: pass
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User does not exist with "+_email.text)));
  } else if (e.code == 'wrong-password') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is wrong")));
  }
  
}

    }



    Future<UserCredential>  signwithgoogle() async{  
      final GoogleSignInAccount? guser=await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication _gauth=await guser!.authentication;

                  final cred=GoogleAuthProvider.credential(
                    accessToken: _gauth.accessToken,
                    idToken: _gauth.idToken
                  );
                  UserCredential u=await FirebaseAuth.instance.signInWithCredential(cred);
                   SharedPreferences _prefs = await SharedPreferences.getInstance();   
                     _prefs.setBool("loggedin", true);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                  return u;
  
    }
 


    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Color primary = Color(0xff857ffd);
    Color second = Color(0xff4b4b6f);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                //  alignment: Alignment.center,
                  width: w,
                  margin: EdgeInsets.only(left: 8,right: 8,bottom: 10),
                  child: Text(
                    "Welcome Back User\nLog In",
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        color: second),
                  ),
                ),
                Lottie.asset(
                  "Assets/85846-carr (1).json",
                  height: h * 0.46,
                  width: w,
                  alignment: Alignment.topCenter
                ),
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ), GestureDetector(
              onTap: () async {
                  signwithgoogle();
                  
              },
              child: Container(
                alignment: Alignment.center,
                height: 51,
                width: w,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

           
            SizedBox(
              height: h * 0.013,
            ),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  indent: 10,
                  thickness: 2,
                )),
                Text(
                  " or continue ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:second
                  ),
                ),
                Expanded(
                    child: Divider(
                  endIndent: 10,
                  thickness: 2,
                ))
              ],
            ),
            SizedBox(
              height: h * 0.013,
            ),
           


           inputfield(
              second: second,
              cnt: _email,
              text: "Enter Email",
              hide: false,
              i: Icon(
                Icons.mail,
                color: second,
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            inputfield(
                second: second,
                cnt: _pass,
                text: "Enter Password",
                hide: true,
                i: Icon(
                  Icons.lock,
                  color: second,
                )),
                SizedBox(height: 5,),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPass())),
                child: Text("Forget Password",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
            ),

            InkWell(
              onTap: () async  {  
                
                if(_email.text.contains(RegExp(r'A-Za-z'+'A-Za-z0-9'+'@')) || _pass.text.length<=0){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid Email and Password ")));
                }
                else if(_email.text.contains("@") || _pass.text.length>=6){
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      login(_email.text, _pass.text);
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                     _prefs.setBool("loggedin", true);
                  }   
                
              },
              child: Container(
                alignment: Alignment.center,
                height: 51,
                width: w,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Sign in with Email",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),



            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPAge()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15, top: 5),
                child: Text(
                  "Create new Account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: second,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}