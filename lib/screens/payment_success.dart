import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';

class PaymentSuccessScreen extends StatefulWidget {
  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: customAmberColor1,
      //   title: Text(
      //     "Payment Success",
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
                          "Payment Success",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: _textWithOpacity(
                              text: "The passenger will pay you"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "31.74",
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
                            _textWithOpacity(text: "Commission"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "31.74",
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
                  //           _textWithOpacity(text: "Commission"),
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
                          _textWithOpacity(text: "Your Profit"),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "65.74",
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
                              "4.55",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Kilometres",
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
                              "00:17:22",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "Trip time",
                              style: TextStyle(
                                color: Color(0xff8D90A1),
                              ),
                            )
                          ],
                        ),
                        _verticalDivider(),
                        Column(
                          children: [
                            //TODO: car type
                            Text(
                              "AnySIDA",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "car",
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
                        "Your Fare",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  _fareDetailsItem(text: "Base Fare", details: "20.0 EGP"),
                  _fareDetailsItem(text: "Distance", details: "19 km"),
                  _fareDetailsItem(text: "time", details: "03:45"),

                  // SizedBox(height: 10,),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Text(
                        "Normal Fare",
                      ),
                      Spacer(),
                      Text("22.67 EGP"),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  _fareDetailsItem(text: "Surge x1.4", details: "9.4"),
                  //  SizedBox(height: 15,),
                  _divider(),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Text(
                        "Subtotal",
                      ),
                      Spacer(),
                      Text("65.67 EGP"),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  _fareDetailsItem(text: "Waiting time", details: "5.4 EGP"),
                  _fareDetailsItem(
                      text: "Rounding",
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
                    title: "Done",
                    onTap: (){

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
    String text,
    String details,
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
              Text(details, style: TextStyle(color: textColor)),
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
    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0.0),
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
