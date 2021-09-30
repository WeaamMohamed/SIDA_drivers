import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';

import '../shared/componenents/my_components.dart';
import 'home_screen.dart';

class DriverRegistrationCompleted extends StatefulWidget {

  @override
  _DriverRegistrationCompletedState createState() => _DriverRegistrationCompletedState();
}

class _DriverRegistrationCompletedState extends State<DriverRegistrationCompleted> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      // appBar:  AppBar(
      //   //  backgroundColor: Colors.red,
      //   centerTitle: true,
      //   title: Text(translate(context,'Driver Registration'),
      //     style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.black
      //     ),),
      //   elevation: 0,
      //   backgroundColor: Colors.white.withOpacity(0),
      //   // leading: InkWell(
      //   //   onTap: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   child: Icon(Icons.arrow_back, color: Colors.black,),),
      //
      //
      // ),
      backgroundColor: Colors.white,
      appBar: customAppBar(context: context,
        title:translate(context,'Driver Registration'),),

      body: Padding(
        padding: EdgeInsets.only(top: 30,
            left: 15,
            right: 15,
            bottom: 20),
        child: Column(
          children: [



            SizedBox(height: 30,),
            SvgPicture.asset("assets/images/check_icon.svg", height: 40,),
            SizedBox(height: 40,),
            Center(
              child: Container(
                width: size.width * 0.8,
                child: Text(
                  translate(context,'The request has been sent successfully.'),
                  textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: size.width * 0.8,
                child: Text(
                  translate(context,'Once the application has been reviewed, you will receive a valid notification or our customer service representative will call you, note that the verification process takes up to 24 hours from the time the documents are sent to the review.'),
                  textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(height: 30,),

            // SvgPicture.asset("assets/images/identity.svg",
            //  fit: BoxFit.contain,
            // ),



            Spacer(),
            customBlackButton(
              onTap: (){
                Navigator.push(context,  MaterialPageRoute(builder: (context)=> HomeScreen()));


              }
              ,title: translate(context,'Done'),
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
