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
import 'driver_license.dart';

class VehicleRegistrationCertificate extends StatefulWidget {

  @override
  _VehicleRegistrationCertificateState createState() => _VehicleRegistrationCertificateState();
}

class _VehicleRegistrationCertificateState extends State<VehicleRegistrationCertificate> {

  File imageFile;
  String _url1='';
  String _url2='';
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context: context,
        title:"Vehicle registration certificate" ,),


      body: Container(

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Center(
              child: customEditImage(context: context,
              myUrl: _url1,
              myOnpressed:()
              {
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
              child: customEditImage(context: context, myUrl: _url2,
              myOnpressed: (){
                showModalBottomSheet<void>(
                  context: context,
                  builder:((builder)=> bottomsheet('2')),
                );
              },

             ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text("Back Side", style: TextStyle(

                fontWeight: FontWeight.bold,
                color: Color(0xffA9ACB6),
              ),),
            ),
            Spacer(),
            customBlackButton
              (
              onTap: (){
                if (_url1 != null && _url2 != null )
                Navigator.push(context,  MaterialPageRoute(builder: (context)=> DriverLicense()));
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

    loadImage('1');
    loadImage('2');
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child('VehicleCertificate').child(Path.basename(imageFile.path));
      print("##################################");
      print(imageFile);
      print(imageFile.path);
      if ( side == '1')
      drivers_ref.child(currentUser.uid).child('Photos').child('VehicleCertificate').child('Front').update({"Path": imageFile.path});
     else if ( side == '2')
        drivers_ref.child(currentUser.uid).child('Photos').child('VehicleCertificate').child('Back').update({"Path": imageFile.path});

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
        drivers_ref.child(currentUser.uid).child('Photos').child('VehicleCertificate').child('Front').update({"URL": _url1});
      else if ( side == '2')
        drivers_ref.child(currentUser.uid).child('Photos').child('VehicleCertificate').child('Back').update({"URL": _url2});

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
            'VehicleCertificate').child('Front').once().then((
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
            'VehicleCertificate').child('Back').once().then((
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
