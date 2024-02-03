import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/utils/utilities.dart';
import 'package:twentyone/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  bool loading = false ;
  final databaseRef = FirebaseDatabase.instance.ref('Story');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: ("what is in your mind "),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(
              loading: loading,
                title: "Add", ontap: (){
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
              databaseRef.child(id
                  ).set({
                'title': postController.text.toString(),
                'id':id,
              }).then((value){
                Util().toastMessage("Post added");
                setState(() {
                  loading = false;
                });
              }).onError((error, stackTrace){
                Util().toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });
            })
          ],
        ),
      ),
    );
  }
}
