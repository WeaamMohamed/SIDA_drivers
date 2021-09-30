import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_drivers_app/helpers/helpermethods.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';
import 'package:sida_drivers_app/models/tripdetails.dart';

import '../globalvariables.dart';
import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';
import 'home_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final TripDetails tripDetails;
  final int fareAmount;
  PaymentSuccessScreen({this.tripDetails, this.fareAmount});

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  double horizontalPadding = 20;
  String  extraTimeTraveledFare ="";
  String distanceTraveledFare =" ";
  String waitingTimeFare =" ";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: customAmberColor1,
      //   title: Text(
      //     translate(context,'Payment Success'),
      //     style: TextStyle(
      //       fontSize: 22,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          //  height: size.height,
          child: Column(children: [
            //  Container(height: size.height,),

            Container(
              height: size.height * 0.45,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                        gradient: LinearGradient(
                          colors: [customAmberColor1, customAmberColor2],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        )),
                    height: size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Text(
                          translate(context,'Payment Success'),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: _textWithOpacity(
                              text: translate(context,'The passenger will pay you'), ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.fareAmount.toString(),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "EGP",
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: horizontalPadding,
                    right: horizontalPadding,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding: EdgeInsets.all(40),
                        width: double.infinity,
                        // height: size.height * 0.2,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              offset: Offset(0.0, 2),
                              blurRadius: 7,
                              spreadRadius: 1.2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            _textWithOpacity(text: translate(context,'Commission'),),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                (widget.fareAmount * 0.2).toStringAsFixed(  (widget.fareAmount * 0.2).truncateToDouble() ==   (widget.fareAmount * 0.2) ? 0 : 1),

                                  //.truncateToDouble().toString(),
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "EGP",
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //
                  //     margin: EdgeInsets.only(bottom: 25),
                  //     padding: EdgeInsets.all(40),
                  //   width: double.infinity,
                  //  // height: size.height * 0.2,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //
                  //         color: Colors.grey[400],
                  //         offset: Offset(0.0, 2),
                  //         blurRadius: 7,
                  //         spreadRadius: 1.2,
                  //
                  //       ),
                  //
                  //     ],
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Colors.white,
                  //   ),
                  //   child:
                  //       Column(
                  //         children: [
                  //
                  //           _textWithOpacity(text: translate(context,'Commission'),),
                  //           SizedBox(height: 20,),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "31.74",
                  //                 style: TextStyle(
                  //                   fontSize: 35,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 8,
                  //               ),
                  //               Text(
                  //                 "EGP",
                  //                 style: TextStyle(
                  //                   fontSize: 35,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //
                  //
                  // ),
                  // SizedBox(height: 40,),

                  SvgPicture.asset(
                    "assets/images/down_arrow.svg",
                  ),

                  Container(
                      padding: EdgeInsets.all(40),
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      // height: size.height * 0.2,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            offset: Offset(0.0, 2),
                            blurRadius: 7,
                            spreadRadius: 1.2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          _textWithOpacity(text: translate(context,'Your Profit'),),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (widget.fareAmount * 0.8).toStringAsFixed(  (widget.fareAmount * 0.8).truncateToDouble() ==   (widget.fareAmount * 0.8) ? 0 : 1),

                             //   (widget.fareAmount * 0.8).truncateToDouble().toString(),
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "EGP",
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              (double.parse(widget.tripDetails.tripDistance)/1000).toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              translate(context,'Kilometres'),
                              style: TextStyle(
                                color: Color(0xff8D90A1),
                              ),
                            )
                          ],
                        ),
                        _verticalDivider(),
                        Column(
                          children: [
                            Text(
                              (double.parse(widget.tripDetails.tripTime)/60).toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              translate(context,'Trip time'),
                              style: TextStyle(
                                color: Color(0xff8D90A1),
                              ),
                            )
                          ],
                        ),
                        _verticalDivider(),
                        Column(
                          children: [
                            Text(
                              widget.tripDetails.rideType,
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              translate(context,'Car'),
                              style: TextStyle(
                                color: Color(0xff8D90A1),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  ///
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        translate(context,'Your Fare'),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  _fareDetailsItem(text: translate(context,'Base fare'), details: widget.tripDetails.rideType == 'Any SIDA' ? "11.00 EGP": "12.00 EGP"),
                  _fareDetailsItem(text: translate(context,'Distance'), details: distanceTraveledFare  +' EGP'),
                  _fareDetailsItem(text: translate(context,'Time'), details: extraTimeTraveledFare +' EGP' ),

                  // SizedBox(height: 10,),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Text(
                        translate(context,'Normal Fare'),
                      ),
                      Spacer(),
                      Text("22.67 EGP"),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  _fareDetailsItem(text: translate(context,'Surge '), details: "0.00 EGP"),
                  //  SizedBox(height: 15,),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Text(
                        translate(context,'Subtotal'),
                      ),
                      Spacer(),
                      Text("65.67 EGP"),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  _fareDetailsItem(text: translate(context,'Wait Time'), details: waitingTimeFare +' EGP'),
                  _fareDetailsItem(
                      text: translate(context,'Rounding'),
                      details: "- 0.5 EGP",
                      textColor: Color(0xff54AE61)),
                  _divider(),
                  SizedBox(height: 25,),
                  Row(

                    children: [
                      Text(
                        "43.4",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "EGP",
                        style: TextStyle(
                            fontSize: 20, ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  _divider(),
                  SizedBox(height: 25,),
                  customHomeButton(
                    context: context,
                    withIcon: false,
                    title: translate(context,'Done'),
                    onTap: (){
          Navigator.pop(context);
          HelperMethods.enableHomeLiveLocationUpdates();
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()));
                    }),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _fareDetailsItem({
    String text ='',
    String details='',
    Color textColor = const Color(0xff8D90A1),
  }) =>
      Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(color: Color(0xff8D90A1)),
              ),
              Spacer(),
              Text(details ?? '', style: TextStyle(color: textColor)),
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );

  Widget _divider() => Divider(
        color: Color(0xffC2C9D9),
        thickness: 1,
      );

  Widget _verticalDivider() => VerticalDivider(
        color: Color(0xffD4D7D9),
        thickness: 2,
      );

  Widget _textWithOpacity({String text}) => Text(
        text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 16,
        ),
      );

  @override
  void initState() {

    getFareDetails();
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0.0),
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }
 void getFareDetails() async
 {
   try {
     await newRequest_ref.child( widget.tripDetails.rideID).child('fareDetails').once().then((DataSnapshot snapshot) async {
       setState(() {
         distanceTraveledFare = snapshot.value['distanceTraveledFare'];
         extraTimeTraveledFare = snapshot.value['extraTimeTraveledFare'];
         waitingTimeFare = snapshot.value['waitingTimeFare'];
         print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
         print(extraTimeTraveledFare);
         print   (distanceTraveledFare);
         print   (waitingTimeFare);


       });
     });
   }
   catch(e)
   { print("you got error: $e");}
   try {
     await newRequest_ref.child( widget.tripDetails.rideID).once().then((DataSnapshot snapshot) async {
       setState(() {

         widget.tripDetails.tripTime=snapshot.value['tripTime'].toString();
         widget.tripDetails.tripDistance=snapshot.value['tripDistance'].toString();
       });
     });
   }
   catch(e)
   { print("you got error: $e");}

 }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();
  }
}
