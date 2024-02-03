import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/ui/auth/login_screen.dart';
import 'package:twentyone/utils/utilities.dart';

import '../../widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
  void SignUp(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Util().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sign Up"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child:Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Create an Email',
                      prefixIcon: Icon(Icons.mail_outline_sharp),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Create email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Create a strong Password',
                      prefixIcon: Icon(Icons.lock_open_rounded),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Create Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            RoundButton(
              loading: loading,
              title: 'Sign up',
              ontap: (){
                if(_formKey.currentState!.validate()){
                  SignUp();
                }
              }

            ),
            Row(
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
