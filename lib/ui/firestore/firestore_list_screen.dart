import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utilities.dart';
import '../auth/login_screen.dart';
import 'add_firestore_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final FireStore =
      FirebaseFirestore.instance.collection('Product').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("Product");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        title: Text("FireStore "),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Util().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FireStore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if(snapshot.hasError)
                  return Text('Something went wrong');

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: (){
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                              'title':'Product updated'
                            }).then((value) {
                              Util().toastMessage("Updated");
                            }).onError((error, stackTrace) {
                              Util().toastMessage(error.toString());
                            });
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                          },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFireStoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDilog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: 'Add here '),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
