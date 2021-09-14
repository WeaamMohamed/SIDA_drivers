import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';

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
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/profile_pic.jpg",
                ),
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
                child: Icon(Icons.edit, color: Colors.black,),
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
}
