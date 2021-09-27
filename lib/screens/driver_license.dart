import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:sida_drivers_app/screens/vehicle_info.dart';
import '../globalvariables.dart';
import '../shared/componenents/my_components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'criminal_records_and_taxi_application_file.dart';

class DriverLicense extends StatefulWidget {

  @override
  _DriverLicenseState createState() => _DriverLicenseState();
}

class _DriverLicenseState extends State<DriverLicense> {

  File imageFile;
  String _url1='';
  String _url2='';
  final ImagePicker picker = ImagePicker();
  var _licenseNumberController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        //  backgroundColor: Colors.red,

        centerTitle: true,

        title: Text("Driver License",
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
          child: Icon(Icons.arrow_back, color: Colors.black,
          ),
        ),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20,),
        child: Column(
         // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [


                    Center(
                      child: customEditImage(context: context,
                          myUrl: _url1,
                          myOnpressed: (){
                            showModalBottomSheet<void>(
                              context: context,
                              builder:((builder)=> bottomsheet('1')),
                            );
                          }
                          ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text("Front Side", style: TextStyle(

                        fontWeight: FontWeight.bold,
                        color: Color(0xffA9ACB6),
                      ),),
                    ),

                    SizedBox(height: 30,),

                    Center(
                      child: customEditImage(context: context,
                        myUrl: _url2,
                        myOnpressed: (){
                          showModalBottomSheet<void>(
                            context: context,
                            builder:((builder)=> bottomsheet('2')),
                          );
                        }
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text("Back Side", style: TextStyle(

                        fontWeight: FontWeight.bold,
                        color: Color(0xffA9ACB6),
                      ),),
                    ),
                    customTextFormField(
                        label: "Driver license number",
                        textController: _licenseNumberController,
                        textInputType: TextInputType.number,
                        validator: (String val){
                          if(val.isEmpty)
                          {
                            return "Please enter your license numer";
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
            //
            // Center(
            //   child: customEditImage(context: context,
            //       //TODO:
            //       onTap: (){}),
            // ),
            // SizedBox(height: 10,),
            // Center(
            //   child: Text("Front Side", style: TextStyle(
            //
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xffA9ACB6),
            //   ),),
            // ),
            //
            // SizedBox(height: 30,),
            //
            // Center(
            //   child: customEditImage(context: context,
            //       //TODO:
            //       onTap: (){
            //         print('tapped');
            //       }),
            // ),
            // SizedBox(height: 10,),
            // Center(
            //   child: Text("Back Side", style: TextStyle(
            //
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xffA9ACB6),
            //   ),),
            // ),
            // customTextFormField(
            //   label: "Driver license number",
            //   textController: _licenseNumberController,
            //   textInputType: TextInputType.number,
            //   validator: (String val){
            //     if(val.isEmpty)
            //       {
            //         return "Please enter your license numer";
            //       }
            //     return null;
            //   }
            // ),
           // Spacer(),
            customBlackButton
              (//TODO: next
                onTap: (){
                  if (_url1 != null && _url2 != null )
                    {
                      Navigator.push(context,  MaterialPageRoute(builder: (context)=> CriminalRecordsAndTaxiApplicationFile()));

                      drivers_ref.child(currentUser.uid).update({"driverLicenseNumber ":  _licenseNumberController.text});

                    }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("you must upload photos!"),
                    ));
                  }

                }
            )


          ],
        ),
      ),
    );
  }
  @override
  void initState() {

    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    loadImage('1');
    loadImage('2');

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }

  Widget bottomsheet(String side)
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
                  takephoto(ImageSource.camera,side);
                  Navigator.pop(context);

                },
                label: Text('Camera'),
              ),
              FlatButton.icon(
                icon: Icon( Icons.image),
                onPressed: (){
                  takephoto(ImageSource.gallery, side);
                  Navigator.pop(context);
                },
                label: Text('Gallery'),
              ),
            ],

          )
        ],
      ),
    );
  }
  void takephoto ( ImageSource source, String side) async {

    var PickedFile = await ImagePicker.pickImage(source: source);

    setState(() {
      imageFile = PickedFile;
    });
    uploadImage(context,side);
  }

  void uploadImage(context , String side) async {

    try {
      ///TODO:Delete the old photo
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child('DriverLicense').child(Path.basename(imageFile.path));
      print("##################################");
      print(imageFile);
      print(imageFile.path);
      if ( side == '1')
        drivers_ref.child(currentUser.uid).child('Photos').child('DriverLicense').child('Front').update({"Path": imageFile.path});
      else if ( side == '2')
        drivers_ref.child(currentUser.uid).child('Photos').child('DriverLicense').child('Back').update({"Path": imageFile.path});

      StorageUploadTask storageUploadTask = ref.putFile(imageFile);
      showDialog(context: context, builder:  ((builder)=> Center(child: CircularProgressIndicator( color: Colors.grey))));
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("photo uploaded successfully!"),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        if ( side == '1')
          _url1 = url;
        else if ( side == '2')
          _url2 = url;
      });
      if ( side == '1')
        drivers_ref.child(currentUser.uid).child('Photos').child('DriverLicense').child('Front').update({"URL": _url1});
      else if ( side == '2')
        drivers_ref.child(currentUser.uid).child('Photos').child('DriverLicense').child('Back').update({"URL": _url2});

    } catch (ex) {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  void loadImage( String side) async {
    String myUrl = '';
    if (side == '1') {
      try {
        await drivers_ref.child(currentUser.uid).child('Photos').child(
            'DriverLicense').child('Front').once().then((
            DataSnapshot snapshot) async {
          setState(() {
            myUrl = snapshot.value['URL'];
            _url1 = myUrl;
          });
        });
      }
      catch (e) {
        print("you got error: $e");
      }
    }
    else if (side == '2') {
      try {
        await drivers_ref.child(currentUser.uid).child('Photos').child(
            'DriverLicense').child('Back').once().then((
            DataSnapshot snapshot) async {
          setState(() {
            myUrl = snapshot.value['URL'];
            _url2 = myUrl;
          });
        });
      }
      catch (e) {
        print("you got error: $e");
        return;
      }
    }
  }
}
