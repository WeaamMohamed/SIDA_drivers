import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:path/path.dart' as Path;
import '../globalvariables.dart';
import '../shared/componenents/my_components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
class VehicleInfoScreen extends StatefulWidget {

  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {

  TextEditingController carBrandController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController carLicensePlateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File imageFile;
  String _url;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        //  backgroundColor: Colors.red,


        centerTitle: true,

        title: Text("Vehicle Information",
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  mainAxisSize: MainAxisSize.max,

                children: [


                  _upperPart(),

                  //  Spacer(),

                  customBlackButton(
                      onTap: (){
                        if(formKey.currentState.validate())
                        {
                          print("car brand: "+carBrandController.text);
                          print("car model: "+carModelController.text);
                          print("color: "+colorController.text);
                          print("license: "+carLicensePlateController.text);
                          print("updated.");
                          drivers_ref.child(currentUser.uid).child('carDetails').update({'carBrand': carBrandController.text , 'carModel' :carModelController.text,'carColor' :colorController.text,'carLicensePlate':carLicensePlateController.text });

                        }
                      }),





                ],),
            ),),
        ),
      ) ,);
  }

  @override
  void initState() {

    // TODO: implement initState
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

  Widget _upperPart() => Column(
    children: [
      Container(
        //  color: Colors.grey.shade400,
        height: MediaQuery.of(context).size.height * 0.15,

        child: Stack(
          children: [
            Center(
              child: Container(
                height: 0.2*MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image:  _url == null
                                          ? AssetImage(
                  "assets/images/defaultCar.png",
                  ):
                      NetworkImage(_url),



                      fit: BoxFit.cover,
                    )
                ),
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
                child:  IconButton(icon: Icon(Icons.edit, color: Colors.black,), onPressed: ()
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
      SizedBox(height: 20,),
      customTextFormField(
        label: "Car Brand",
        textController: carBrandController,
        validator:  (value) {
          if (value.isEmpty) {
            return 'car Brand must not be empty.';
          }
          return null;
        },

        textInputType: TextInputType.text,

      ),
      SizedBox(height: 20,),

      customTextFormField(
        label: "Car Model",
        textController: carModelController,
        validator:  (value) {
          if (value.isEmpty) {
            return 'Car Model must not be empty.';
          }
          return null;
        },
        textInputType: TextInputType.text,

      ),
      SizedBox(height: 20,),
      customTextFormField(
        label: "Color",
        textController: colorController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Color must not be empty.';
          }
          return null;
        },
        textInputType: TextInputType.text,

      ),

      SizedBox(height: 20,),
      customTextFormField(
        hint: "مثال: أ ف ل 3245",
        label: "Car License Plate",
        textController: carLicensePlateController,
        validator: (value) {
          if (value.isEmpty) {
            return 'License Plate must not be empty.';
          }
          return null;
        },
        textInputType: TextInputType.text,

      ),

    ],
  );

  Widget bottomsheet()
  {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20
          ,vertical: 20),
      child: Column(
        children: <Widget>[
          Text('Upload Car photo',
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
              ),
              FlatButton.icon(
                icon: Icon( Icons.delete),
                onPressed: (){
                  deletePhoto();
                  Navigator.pop(context);
                },
                label: Text('Remove'),
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
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child('CarPhoto').child(Path.basename(imageFile.path));
      print("##################################");
      print(imageFile);
      print(imageFile.path);
      drivers_ref.child(currentUser.uid).child('CarPhoto').update({"Path": imageFile.path});

      StorageUploadTask storageUploadTask = ref.putFile(imageFile);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Car photo updated successfully!"),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
      drivers_ref.child(currentUser.uid).child('CarPhoto').update({"URL": _url});


    } catch (ex) {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  void loadImage() async {

    String myUrl='';
    try {
      await drivers_ref.child( currentUser.uid).child('CarPhoto').once().then((DataSnapshot snapshot) async {

        setState(() {
          myUrl = snapshot.value['URL'];
        });
      });
    }
    catch(e)
    { print("you got error: $e");
    _url=null;
    return;
    }

    setState(() {
      _url=myUrl;
      print(_url);
      // imageFile = File(path);
    });
  }
  void deletePhoto() async
  {
    String myPath='';
    if ( _url != null)
    {
      try {
        await drivers_ref.child( currentUser.uid).child('CarPhoto').once().then((DataSnapshot snapshot) async {
          setState(() {
            myPath = snapshot.value['Path'];
            print("=____________++++++++++++++++++++++");
            print(myPath);
          });
        });
      }
      catch(e)
      { print("you got error: $e");}
      StorageReference ref = storage.ref().child('DriversImages').child(currentUser.uid).child('CarPhoto').child(Path.basename(myPath));
      ref. delete();
      drivers_ref.child( currentUser.uid).child('CarPhoto').remove();
      setState(() {
        _url = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("photo is removed"),
      ));
    }
    else
    {
      print("_-----------------_");
      print(_url);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No photo to remove!"),
      ));
    }
  }
}
