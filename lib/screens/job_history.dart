import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';
import 'package:sida_drivers_app/screens/payment_screen.dart';

import '../globalvariables.dart';

class JobHistory extends StatefulWidget {
  @override
  _JobHistoryState createState() => _JobHistoryState();
}

class _JobHistoryState extends State<JobHistory> {

  String rides_num='';
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
  ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
        Column(
          children: [
            ///1- yellow container
            Container(
              width: screenWidth,
              height: screenHeight*0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    HexColor("#FEBA3F"),
                    HexColor("#FED444"),
                  ],
                ),),
              child: Column(
                children: [
                  SizedBox(height: 0.09 * screenHeight),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen()));
                      }, icon: Icon(Icons.west)),
                      SizedBox(width: 0.2 * screenWidth),
                      Align(
                        alignment: Alignment.center,
                        child: Text(translate(context,'Job History'),
                            style: TextStyle(
                                color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                 Container(
                   height:   screenHeight*0.08,
                   child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10);
                      },
                      itemCount: 52,
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentDateSelectedIndex = index;
                              selectedDate =
                                  DateTime.now().add(Duration(days: index));

                              print(DateTime.now());
                              print( Duration(days: index *7 ));
                              print( DateTime.now().add(Duration(days: index *7 )).month);

                            });
                          },
                          child: Container(
                            height: screenHeight*0.1,
                            width: screenWidth*0.3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(250),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400],
                                      offset: Offset(3, 3),
                                      blurRadius: 5)
                                ],
                                color: currentDateSelectedIndex == index
                                    ? Colors.amber
                                    : Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      listOfMonths[DateTime.now().add(Duration(days: index *7 )).month - 1]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: currentDateSelectedIndex == index
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                    Text(
                                      " ~ " +listOfMonths[DateTime.now().add(Duration(days: index *7 )).month - 1]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: currentDateSelectedIndex == index
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateTime.now()
                                      .add(Duration(days: index))
                                      .day
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: currentDateSelectedIndex == index
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                 )
                ],
              )
            ),
            ///1- white part
            Column(
              children: [
                SizedBox(height: 0.05* screenHeight),
                Text("Total profit ( ${tripCount} rides)", style: TextStyle(
                  color:Colors.black, fontSize: 16
                ),),
                SizedBox(height: 0.03 * screenHeight),
                Text("${earnings} EGP", style: TextStyle(
                    color:Colors.black, fontSize: 20,fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 0.02* screenHeight),
                SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                SizedBox(height: 0.05* screenHeight),
              ],
            )
          ],
        )
        ],
      ),
    );
  }



}
