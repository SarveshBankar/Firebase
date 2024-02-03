import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/firebase_services/splash_services.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  SplashServices splash_screen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash_screen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome",style: TextStyle(fontSize: 50),),
      ),
    );
  }
}
