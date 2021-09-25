import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import '../globalvariables.dart';
import '../shared/componenents/my_components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';


class PhotoHandler extends StatefulWidget {
   File imageFile;
   
  PhotoHandler({this.imageFile});
  @override
  _PhotoHandlerState createState() => _PhotoHandlerState();
}

class _PhotoHandlerState extends State<PhotoHandler> {
  String _url;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Widget bottomsheet()
  {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20
          ,vertical: 20),
      child: Column(
        children: <Widget>[
          Text('Choose Profile Picture',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          SizedBox( height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon( Icons.camera),
                onPressed: (){
                  takephoto(ImageSource.camera);
                  Navigator.pop(context);

                },
                label: Text('Camera'),
              ),
              FlatButton.icon(
                icon: Icon( Icons.image),
                onPressed: (){
                  takephoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text('Gallery'),
              )

            ],

          )
        ],
      ),
    );
  }
  void takephoto ( ImageSource source) async {

    var PickedFile = await ImagePicker.pickImage(source: source);

    setState(() {
     widget.imageFile = PickedFile;
    });
    uploadImage(context);
  }

  void uploadImage(context) async {

    try {
      ///TODO:Delete the old photo
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://sida-51cb9.appspot.com');
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child(Path.basename(  widget.imageFile.path));
      print("##################################");
      print(  widget.imageFile);
      print(  widget.imageFile.path);
      StorageUploadTask storageUploadTask = ref.putFile(  widget.imageFile);
      print(  widget.imageFile);
      print(storageUploadTask);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile photo updated "),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
      drivers_ref.child(currentUser.uid).update({"ProfilePhoto":widget.imageFile.path});
    } catch (ex) {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  void loadImage() async {
    String path='';
    try {

      await drivers_ref.child( currentUser.uid).once().then((DataSnapshot snapshot) async {
        setState(() {
          path = snapshot.value['ProfilePhoto'];
          print("=____________++++++++++++++++++++++");
          print(path);

        });
      });
    }
    catch(e)
    { print("you got error: $e");}

    setState(() {
      widget.imageFile = File(path);
    });
  }
}


