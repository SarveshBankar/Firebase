import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:twentyone/ui/auth/login_screen.dart';
import 'package:twentyone/ui/posts/addpost.dart';
import 'package:twentyone/utils/utilities.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Story');
  final SearchFilter = TextEditingController();
  final editController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Post Screen "),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>LoginScreen()));
            }).onError((error, stackTrace){
              Util().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined),)
        ],
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: SearchFilter,
              decoration: InputDecoration(
                hintText: 'Search Data ',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value ){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text("Loading"),
                itemBuilder: (context,snapshot,animation,index){
                  final title = snapshot.child('title').value.toString();

                  if(SearchFilter.text.isEmpty){
                    return  ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) =>[
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                showMyDilog(title,
                                    snapshot.child('id').value.toString());
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                          ),
                            
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(
                                    snapshot.child('id').value.toString()).remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ),

                          ),
                        ],
                      ),
                    );
                  }else if (title.toLowerCase().contains(SearchFilter.text.toLowerCase().toLowerCase())){
                    return  ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  }else {
                    return Container();
                  }
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void>showMyDilog(String title,String id)async{
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: 'Add here '
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title' : editController.text.toLowerCase()
                }).then((value) => {
                  Util().toastMessage('Post Updated')
                }).onError((error, stackTrace) => {
                  Util().toastMessage(error.toString())
                });
              }, child: Text('Update')),
            ],
          );
    });
  }
}
// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
//
// if(!snapshot.hasData){
// return CircularProgressIndicator();
// }else{
// Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list = [];
// list.clear();
// list=map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context,index){
// return ListTile(
// title: Text(list[index]['title']),
// subtitle: Text(list[index]['id']),
// );
// });
// }
//
// },
// )),