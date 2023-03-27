import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class inputfield extends StatelessWidget {
   bool hide;
   inputfield({
    Key? key,
    required this.second,
    required this.cnt,
    required this.text,
    required this.hide,
     required this.i,
   
  }) : super(key: key);

  final Color second;
  final TextEditingController cnt;
  final String text;
  Icon i;
 
  

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        obscureText: hide,
       controller: cnt,
       cursorColor:second,
       cursorHeight: 24,
         decoration: InputDecoration(
           hintText: text,
           prefixIcon: i,
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color:second ),
             borderRadius: BorderRadius.circular(10)
           ) ,
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color:second ),
             borderRadius: BorderRadius.circular(10)
           ) ,
         ),
      ),
    );
  }
}