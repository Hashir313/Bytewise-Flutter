import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task8/ui/home_page.dart';
class SplashServices{
  void isLogin(BuildContext context){
    Timer(const Duration(seconds: 12), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }
}