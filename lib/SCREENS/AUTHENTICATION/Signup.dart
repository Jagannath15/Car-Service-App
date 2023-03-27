import 'dart:ffi';

import 'package:car_repair_app/UTILS/inputfield.dart';
import 'package:car_repair_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../../UTILS/constants.dart';
import 'Login.dart';

class SignUpPAge extends StatelessWidget {
 SignUpPAge({super.key});
  
  @override
  Widget build(BuildContext context) {
    Future Signup(String email, String pass) async {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }


    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Color primary = Color(0xff857ffd);
    Color second = Color(0xff4b4b6f);

    TextEditingController _email = new TextEditingController();
    TextEditingController _pass = new TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    "Are you a new User?\nSign up",
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
                ),
              ],
            ),
            SizedBox(height: h*0.03,),
            inputfield(
                second: second,
                cnt: _email,
                text: "Enter Email",
                hide: false,
                i: Icon(Icons.mail)
                ),
            SizedBox(
              height: h * 0.015,
            ),
            inputfield(
                second: second,
                cnt: _pass,
                text: "Create a Password",
                hide: true,
                i: Icon(Icons.lock)),           
            SizedBox(
              height: h * 0.019,
            ),
            InkWell(
              onTap: () => {
              if (_email.text.length <= 0 || _pass.text.length <= 0)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Your Email or Password field is empty"),backgroundColor: Colors.red,)),
                  }
                else if( !_email.text.contains("@")){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Enter valid Email id"),backgroundColor: Colors.red,)),
                        
                      }
    
                 else if ((_email.text.length >= 5 || _pass.text.length >= 6))
                  {
                    Signup(_email.text, _pass.text),
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "You have succesfully registered\nYou will be redirected to Sign in page"),backgroundColor: Colors.greenAccent,)),
                    Duration(seconds: 5),
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StartScreen()))
                  }
              else
                 {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text("Enter valid email and password\nPassword must be atleast of 6 letters"),backgroundColor: Colors.red,)),
                  },
              },
              child: Container(
                alignment: Alignment.center,
                height: 51,
                width: w,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15, top: 5),
                child: Text(
                  "Already have a account?",
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
