import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_components.dart';

class IdentityConfirmation extends StatefulWidget {

  @override
  _IdentityConfirmationState createState() => _IdentityConfirmationState();
}

class _IdentityConfirmationState extends State<IdentityConfirmation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar:  AppBar(
        //  backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Identity confirmation",
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
      body: Padding(
        padding: EdgeInsets.only(top: 30,
        left: 15,
        right: 15,
        bottom: 20),
        child: Column(
          children: [


            Center(
              child: Container(
                width: size.width * 0.8,
                child: Text(
                  "Show your driver's license in front of you and take a picture, it is not allowed to take pictures with sunglasses",
                textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(height: 30,),


            // SvgPicture.asset("assets/images/identity.svg",
              //  fit: BoxFit.contain,
           // ),


            Container(
             height: size.height * 0.2 ,

             width: size.width * 0.7,
          //  color: Colors.white,
             child: Stack(
               children: [
                 Positioned(
                   top: 0,
                   left: 0,
                   child: Container(
                     height: size.height * 0.2  - 15,
                     width: size.width * 0.7 - 20,
                    color: Colors.grey.shade300,
                   ),
                 ),
                 Positioned(
                   bottom: 5,
                   right: 0,
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
                     child: Icon(Icons.edit, color: Colors.black,
                     size: 30,),
                   ),
                 ),

               ],
             ),
             // child: SvgPicture.asset("assets/images/identity.svg",

                // fit: BoxFit.cover,
                // ),

            ),
            Spacer(),
            customBlackButton(
              onTap: (){}
              ,title: "Next",
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
