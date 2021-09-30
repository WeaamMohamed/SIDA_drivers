import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_drivers_app/screens/payment_screen.dart';

import '../globalvariables.dart';

class JobHistory extends StatefulWidget {
  @override
  _JobHistoryState createState() => _JobHistoryState();
}

class _JobHistoryState extends State<JobHistory> {

  String rides_num='';
  String earnings='';

  @override
  void initState() {
    getData();
    super.initState();
  }
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
                        child: Text('Job History',
                            style: TextStyle(
                                color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                ],
              )
            ),
            ///1- white part
            Column(
              children: [
                SizedBox(height: 0.05* screenHeight),
                Text("Total profit ( ${tripCount} rides)", style: TextStyle(
                  color:Colors.black, fontSize: 18
                ),),
                SizedBox(height: 0.01 * screenHeight),
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

  getData() async
  {
    try {
      await drivers_ref.child( currentUser.uid).child('earnings').once().then((DataSnapshot snapshot) async {

        setState(() {
          earnings = snapshot.value;
        });
      });
    }
    catch(e)
    { print("you got error: $e");
    }
  }

}
