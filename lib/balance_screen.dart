
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_drivers_app/colors.dart';
import 'package:sida_drivers_app/payment_screen.dart';

import 'my_components.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customAmberColor1,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [customAmberColor1, customAmberColor2])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 3),
              margin: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Balance",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  Row(
                    children: [
                      Text(
                        "400.00",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "EGP",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Your Profit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "300.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Commission",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "-100.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          offset: Offset(0.0, 6),
                          blurRadius: 7,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: customHomeButton(
                        context: context,
                        withIcon: false,
                        title: "Checkout",
                        onTap: () {}),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){

                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> PaymentScreen(),),);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        ("Payment"),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),

                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      //  crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child:
                              SvgPicture.asset("assets/images/money_icon.svg"),
                          margin: EdgeInsets.all(10
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "20.09.2021",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      "Commission",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Due date",
                                    ),
                                    Text(
                                      "100.00  EGP",
                                      style: TextStyle(
                                          color: Color(0xff54AE61),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //Expanded(child: Container()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
