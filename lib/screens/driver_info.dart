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

class DriverInfo extends StatefulWidget {

  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File imageFile;
  String _url;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:  AppBar(
        //  backgroundColor: Colors.red,


        centerTitle: true,

        title: Text("Driver Information",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black,),),


      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height -  MediaQuery.of(context).padding.top ,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  mainAxisSize: MainAxisSize.max,

              children: [


                Container(
                  height: MediaQuery.of(context).size.height * 0.55,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Container(
                        //  color: Colors.grey.shade400,
                        height: MediaQuery.of(context).size.height * 0.15,

                        child: Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage: imageFile == null
                                    ? AssetImage("assets/images/profile_pic.jpg")
                                    : FileImage(File(imageFile.path)),

                                minRadius: 43,
                                maxRadius: 43,
                              ),


                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.5,
                              top: MediaQuery.of(context).size.height * 0.085,

                              child: Container(

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: Offset(2,7),
                                    )]
                                ),

                                padding: EdgeInsets.all(8),
                                child: IconButton(icon: Icon(Icons.edit, color: Colors.black,), onPressed: ()
                                  {
                                    print("helllllllo");
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder:((builder)=> bottomsheet()),
                                    );
                                  }),
                              ),
                            )
                          ],
                        ),
                      ),

                      customTextFormField(
                        label: "Name (Registered)",
                        textController: nameController,
                        validator:  (value) {
                          if (value.isEmpty) {
                            return 'name must not be empty.';
                          }
                          return null;
                        },

                        textInputType: TextInputType.name,

                      ),

                      customTextFormField(
                        label: "Gender",
                        textController: genderController,
                        validator:  (value) {
                          if (value.isEmpty) {
                            return 'gender must not be empty.';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,

                      ),
                      customTextFormField(
                        label: "Age",
                        textController: ageController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Phone number must not be empty.';
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,

                      ),



                    ],
                  ),
                ),

                Spacer(),

                customBlackButton(
                    onTap: (){

                      if(formKey.currentState.validate())
                      {
                        print("updated.");

                      }

                    }),







              ],),),
        ),
      ) ,);
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
      imageFile = PickedFile;
    });
    uploadImage(context);
  }

  void uploadImage(context) async {

    try {
    ///TODO:Delete the old photo
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://sida-51cb9.appspot.com');
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child(Path.basename(imageFile.path));
      StorageUploadTask storageUploadTask = ref.putFile(imageFile);
      print(imageFile);
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
      drivers_ref.child(currentUser.uid).update({"ProfilePhoto":imageFile.path});
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
      imageFile = File(path);
    });
  }
}
