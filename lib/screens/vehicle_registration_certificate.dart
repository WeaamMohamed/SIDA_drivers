import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';

class VehicleRegistrationCertificate extends StatefulWidget {

  @override
  _VehicleRegistrationCertificateState createState() => _VehicleRegistrationCertificateState();
}

class _VehicleRegistrationCertificateState extends State<VehicleRegistrationCertificate> {
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
            Spacer(),
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
