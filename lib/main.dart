import 'package:car_repair_app/SCREENS/AUTHENTICATION/Signup.dart';
import 'package:car_repair_app/SCREENS/HOME/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SCREENS/AUTHENTICATION/Login.dart';
import 'UTILS/constants.dart';
import 'UTILS/inputfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login=false;
    getstate();
  }
  
  @override


  void getstate() async{
    SharedPreferences _prefs=await SharedPreferences.getInstance();

    setState(() {
       login=_prefs.getBool("loggedin");
    });
   
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),

        //  primarySwatch: Colors.blue,
        primaryColor: Color(0xff857ffd),
      ),
      home: login==false?StartScreen():HomePage(),
    );
  }
}


