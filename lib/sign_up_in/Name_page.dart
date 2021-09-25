import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';
import 'package:sida_drivers_app/sign_up_in/phone_number_page.dart';
import 'package:sida_drivers_app/shared/componenents/constants.dart';
import 'package:sida_drivers_app/shared/network/local/cache_helper.dart';

class NamePage extends StatefulWidget {

  //final String userID;
  //NamePage(  this.userID,{Key key}):super(key: key);
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {

  // final fb =FirebaseDatabase.instance;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool  is_disabled = true;
  int char_num=0;


  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    //  final ref = fb.reference();
    return Scaffold(

      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    HexColor("#2C2B69"),
                    HexColor("#121212"),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/splash_bg_opacity.png"),
                  fit: BoxFit.cover,
                )
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
              child: new Container(
                decoration: new BoxDecoration(color:  HexColor("#2C2B69").withOpacity(0.02)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.05,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton( onPressed: (){
                    CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: true);
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
                  },
                    icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                ),
                SizedBox(height: 0.05 * screenHeight),
                Center(
                  child: Text('Enter your name:',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0 )),
                ),
                SizedBox(height: 0.05 * screenHeight),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key:formKey1,
                    child: SizedBox(
                      width: 0.8* screenWidth,
                      child: TextFormField(
                        controller: firstNamecontroller,
                        obscureText: false,
                        style: TextStyle( color: Colors.white,fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "First name",
                            hintStyle: TextStyle(color:Colors.white)
                        ),
                        onChanged: (val){
                          setState(() {
                            char_num = val.length;
                          });
                          setState(() {
                            if (val.length == 1)
                              is_disabled= false;
                          });
                        },
                        validator: (val) {
                          if(val.isEmpty){return "Please fill in your Name";}
                          if(val.length>15){return "your Name can't exceed 15 characters";}
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right:20),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(char_num.toString()+'/15' , style: TextStyle( color: Colors.grey, fontSize: 10),)),
                ),

                SizedBox(height: .05 * screenHeight),
                /// last name
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key:formKey2,
                    child: SizedBox(
                      width: 0.8* screenWidth,
                      child: TextFormField(
                        controller: lastNamecontroller,
                        obscureText: false,
                        style: TextStyle( color: Colors.white,fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Last name",
                          hintStyle: TextStyle(color:Colors.white)
                        ),
                        onChanged: (val){
                          setState(() {
                            char_num = val.length;
                          });
                          setState(() {
                            if (val.length == 1)
                              is_disabled= false;
                          });
                        },
                        validator: (val) {
                          if(val.isEmpty){return "Please fill in your Name";}
                          if(val.length>15){return "your Name can't exceed 15 characters";}
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right:20),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(char_num.toString()+'/15' , style: TextStyle( color: Colors.grey, fontSize: 10),)),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:  SizedBox(
        width: screenWidth,
        height: 0.09 * screenHeight,
        child: RaisedButton(
          color: HexColor("#FFBB00"),
          onPressed: is_disabled ? null : ()async
          {
            final form1= formKey1.currentState;
            final form2= formKey2.currentState;
            if(form1.validate() && form2.validate())
            {

              drivers_ref.child(currentUser.uid).set({'Phone': myphoneNumber ,
                'FirstName' :firstNamecontroller.text,'LastName' :lastNamecontroller.text, 'enable' : 'false'})
              .then((value) {
                CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: true);
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));

              }).catchError((error){
                defaultToast(message: error.toString(), state: ToastState.ERROR);
              });


              //drivers_ref.child().update({'FirstName':  });
              //drivers_ref.child(currentUser.uid).update({'LastName':  });
              //drivers_ref.child(currentUser.uid).update({'FirstName': firstNamecontroller.text });
              //drivers_ref.child(currentUser.uid).update({'LastName': lastNamecontroller.text });
            }
          },
          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0 )),),
      ),

    );
  }
}
