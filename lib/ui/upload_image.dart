import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twentyone/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance ;
  Future getGalleryImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        print("No Image Picked");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
        title: Text("Upload Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getGalleryImage();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: _image != null? Image.file(_image!.absolute):
                  Center(child :Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: "Upload", ontap: ()async{
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/foldername'+'1234');
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

              await Future.value(uploadTask);
            })
          ],
        ),
      ),
    );
  }
}
