import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';

class PaymentScreen extends StatefulWidget {

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(translate(context,'Payment'), style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20, color: Colors.black,),),
        elevation: 0,
        backgroundColor: Colors.white,

        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
            )),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                              translate(context,'Commission'),
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
                              translate(context,'Due date'),
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

            _divider(),
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(translate(context,'Payment Amount'), style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 8,),
            Row(
              children: [

                Icon(Icons.edit, color: Colors.black, size: 28,),
                SizedBox(width: 5,), 
                Text("100.00", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
                Spacer(),
                Text(
                  "EGP",
                  style: TextStyle(fontSize: 20,),
                )
              ],
            ),
            SizedBox(height: 20,),
            Divider(
              color: Color(0xffE5E5E5),
              thickness: 2,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 25),
              child: Text(translate(context,'Minimum payment amount: '),),
            ),

            Text(translate(context,'Payment Method'), style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 20,),
            Row(
              children: [
                SvgPicture.asset("assets/images/money_icon.svg"),
                SizedBox(width: 10,),
                Text(translate(context,'Fawry Cash'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),)
              ],
            )
          ],
        ),
      ),


    );
  }

  Widget _divider() => Divider(
  color: Color(0xffE5E5E5),
  thickness: 2,
  height: 50,
  );
}
