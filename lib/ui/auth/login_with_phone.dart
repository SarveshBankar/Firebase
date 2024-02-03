

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/ui/auth/verify_code.dart';
import 'package:twentyone/utils/utilities.dart';
import 'package:twentyone/widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              controller: phoneNumberController,
              keyboardType:TextInputType.number,
              decoration: InputDecoration(
                hintText: '+91 432 3453 343'
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(title: 'Login',loading: loading, ontap: (){
              setState(() {
                loading = true ;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                  setState(() {
                    loading = false;
                  });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false;
                    });
                  Util().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId ,int? token){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>VerifyCodeScreen(verificationId: verificationId,)));
                  setState(() {
                    loading = false;
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                  Util().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                  });
            }),
          ],
        ),
      ),
    );
  }
}
