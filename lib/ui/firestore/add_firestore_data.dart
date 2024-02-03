import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/utils/utilities.dart';
import 'package:twentyone/widgets/round_button.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {

  final postController = TextEditingController();
  bool loading = false ;
  final databaseRef = FirebaseDatabase.instance.ref('Story');
  final FireStore = FirebaseFirestore.instance.collection('Product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data"),
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
              FireStore.doc(id).set({
                'title':postController.text.toString(),
                'id':id
              }).then((value) {
                setState(() {
                  loading = false;
                });
                Util().toastMessage('Post added');
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
                });
                Util().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
