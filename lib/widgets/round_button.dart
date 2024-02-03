import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool loading ;
  final String title;
  final VoidCallback ontap;
  const RoundButton({Key? key,
    required this.title,
    this.loading=false,
    required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading? CircularProgressIndicator( strokeWidth: 3,
          color: Colors.white,) :
        Text(title,style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}
