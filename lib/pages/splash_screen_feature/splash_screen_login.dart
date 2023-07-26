import 'dart:async';
import 'package:chatapp_firebase/pages/authentication_feature/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashscreenl extends StatefulWidget {
  const splashscreenl({super.key});

  @override
  State<splashscreenl> createState() => _splashscreenStatel();

  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 2),
            ()=>      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()))
    );
  }
}

class _splashscreenStatel extends State<splashscreenl> {

  splashscreenl ss=splashscreenl();
  void initState(){
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Lottie.asset("assets/animation/c.json", height:250, reverse: true, repeat: true, fit: BoxFit.fitHeight)
        )
    );
  }
}
