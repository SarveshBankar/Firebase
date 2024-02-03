import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/utils/utilities.dart';
import 'package:twentyone/widgets/round_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 10,),
            RoundButton(title: 'Forgot', ontap: (){
              auth.sendPasswordResetEmail(
                  email: emailController.text.toString()).then((value) {
                Util().toastMessage("Please check email to recover");

              }).onError((error, stackTrace) {
                Util().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
