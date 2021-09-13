import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';

class DriverLicense extends StatefulWidget {

  @override
  _DriverLicenseState createState() => _DriverLicenseState();
}

class _DriverLicenseState extends State<DriverLicense> {


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
                          //TODO:
                          onTap: (){}),
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
                          //TODO:
                          onTap: (){
                            print('tapped');
                          }),
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
                onTap: (){}
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
}
