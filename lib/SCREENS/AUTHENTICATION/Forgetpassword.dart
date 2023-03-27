import 'package:car_repair_app/UTILS/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../UTILS/constants.dart';

class ForgetPass extends StatelessWidget {
  
   ForgetPass({super.key});

  final _auth = FirebaseAuth.instance;
     Future<AuthStatus> resetPassword({required String email}) async {
    await _auth
        .sendPasswordResetEmail(email: email);
        return AuthStatus.successful;
  
  }
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Color primary = Color(0xff857ffd);
    Color second = Color(0xff4b4b6f);

    TextEditingController email=TextEditingController();
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top:h*0.1,left: 8,right: 8),
            child: Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: second,
                        letterSpacing: 0.5,
  
                        ), 
                      
                  ),
          ),
          SizedBox(height: h*0.025,),
          inputfield(second: second, cnt: email, text: "Enter Email", hide: false,i: Icon(Icons.mail),)  ,
          SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
                      "* we will send you a message to reset your password",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: second,
                          letterSpacing: 0.3
             
                          ),          
                    ),
           ),

            InkWell(
              onTap:(){resetPassword(email: email.text); },
              child: Container(
                  alignment: Alignment.center,
                  height: 51,
                  width: w,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Send Mail",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
            ),

  
        ],
      )
    );
  }
}