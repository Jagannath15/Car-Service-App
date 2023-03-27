import 'package:car_repair_app/SCREENS/AUTHENTICATION/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth user=FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async{
            await  user.signOut();
            SharedPreferences _prefs=await SharedPreferences.getInstance();
            _prefs.setBool("loggedin", false);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StartScreen()), (route) => false);
          },
          icon:Icon(Icons.reply_rounded,color: Colors.red,),iconSize: 50, ),
      ),
      body: Center(
        child: Text("hello"),
      ),
    );
  }
}