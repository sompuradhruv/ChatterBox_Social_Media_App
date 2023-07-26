import 'dart:async';
import 'package:chatapp_firebase/pages/bot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashscreenb extends StatefulWidget {
  const splashscreenb({super.key});

  @override
  State<splashscreenb> createState() => _splashscreenStateb();

  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 5),
            ()=>      Navigator.push(context,MaterialPageRoute(builder: (context)=>bot()))
    );
  }
}

class _splashscreenStateb extends State<splashscreenb> {

  splashscreenb ss=splashscreenb();
  void initState(){
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              SizedBox(height: 200),
              Lottie.asset("assets/animation/c.json", height:250, reverse: true, repeat: true, fit: BoxFit.cover),
              Text("Welcome to ChatterBox"),
              Text("An all in one social media application")
            ]
        )
    );
  }
}
