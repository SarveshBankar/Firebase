import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/ui/auth/login_screen.dart';
import 'package:twentyone/ui/posts/post_screen.dart';
import 'package:twentyone/ui/upload_image.dart';

import '../ui/firestore/firestore_list_screen.dart';


class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 2),
              ()=>Navigator.push(context,
                  MaterialPageRoute(builder:(context) => LoginScreen()
          )));
    }else
      Timer(Duration(seconds: 2),
              ()=>Navigator.push(context,
                  MaterialPageRoute(builder:(context) => LoginScreen()
          )));
  }
  }

