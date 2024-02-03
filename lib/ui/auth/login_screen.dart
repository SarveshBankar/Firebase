
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twentyone/ui/auth/login_with_phone.dart';
import 'package:twentyone/ui/auth/signup_screen.dart';
import 'package:twentyone/ui/posts/post_screen.dart';
import 'package:twentyone/utils/utilities.dart';

import '../../widgets/round_button.dart';
import '../forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
  void login (){
    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
          Util().toastMessage(value.user!.email.toString());

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostScreen()));

          setState(() {
            loading = false;
          });

    }).onError((error, stackTrace){
      //debugPrint(error.toString()); 
      Util().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true ;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text("Login Screen"),

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
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline_sharp),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Entre email';
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
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_open_rounded),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Entre Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
              ),
              RoundButton(
              title: 'Login',
                loading: loading,
                ontap: (){
                if(_formKey.currentState!.validate()){
                  login();
                }
                },
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: Text("Sign up"))
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>ForgotPassword()));
                }, child: Text("Forgot password")),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Center(
                      child: Text("Login with Phone number"),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
