import 'dart:ffi';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';

import '../firebase_db.dart';
import 'Name_page.dart';


enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

String myphoneNumber='';
String my_verificationcode='';
class PhoneNumberPage extends StatefulWidget {
  static const String id = 'phonenumberpage';

  PhoneNumberPage({this.app});
  final FirebaseApp app;
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  String verificationId;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  String dropdownvalue = '+2';
  String code_country;
  bool is_disabled = true;
  bool is_exists = false; 
  var formKey = GlobalKey<FormState>();
  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {

    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });
    //  if(authCredential?.user != null)
      {
        try {
          await drivers_ref.child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snapshot) async {
            if ( snapshot.value != null)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            }
            else
            {

              Navigator.push(context, MaterialPageRoute(builder: (context)=> NamePage()));
            }
          });
        }
        catch(e)
        { print("you got error: ${e}");}
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      print("your error ${e.message}");
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    void onpressed_phone () async
    {
      is_disabled=true;
      final form= formKey.currentState;
      print("**********___________________________***********************");
      print(form.validate());
      if(form.validate())
      {
        setState(() {

          showLoading = true;
        });

        await _auth.verifyPhoneNumber(
          phoneNumber: '+2'+myphoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            setState(() {
              showLoading = false;
            });
            //signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          verificationFailed: (verificationFailed) async {
            setState(() {
              showLoading = false;
            });
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text(verificationFailed.message)));
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              showLoading = false;
              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
              this.verificationId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) async {

          },
        );
      }
    }
    void onpressed_code () async {
      PhoneAuthCredential phoneAuthCredential =
      PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: my_verificationcode);
      signInWithPhoneAuthCredential(phoneAuthCredential);
    }
    ///---------------------------------------------------------------------
    getMobileFormWidget(context) {
      return  Stack(
        children: [
          SingleChildScrollView(
            child: Container(

              child:  Column(
                children: [
                  SizedBox(height: screenHeight*0.05,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton( onPressed: (){},
                      icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                  ),
                  SizedBox(height: screenHeight*0.07,),
                  Text('Enter your phone number:',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15.0 )),
                  SizedBox(height: screenHeight*0.06,),
                  Form(
                    key:formKey,
                    child: SizedBox(
                      width: 0.6* screenWidth,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: 'phone number',
                          hintStyle:TextStyle(color: Colors.white) ,

                        ),
                        onChanged: (val) {
                          setState(() {
                            myphoneNumber= phoneController.text;
                          });
                          setState(() {
                            if (val.length >= 1)
                              is_disabled= false;
                          });
                        },
                        validator: (val) {
                          print("##############333");
                          print(val.length);
                          print(val);
                          if(val.isEmpty){return "Please fill in your Phone Number";}
                          final number = num.tryParse(val);
                          if (number == null) {
                            return "Invalid phone number!";
                          }
                          if(val.length != 11  ){return "Phone number must be 11 digits!";}
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.5,),
                ],
              ),
            ),
          ),

        ],
      );
    }
    ///-------------------------------------------------------
    getOtpFormWidget(context) {
      return  Stack(
        children: [
          Container(
            child:  Column(
              children: [
                SizedBox(height: screenHeight*0.05,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton( onPressed: (){
                    setState(() {
                      currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                    });
                  },
                    icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                ),
                SizedBox(height: screenHeight*0.02,),
                SizedBox(height: 0.02 * screenHeight),
                Center(
                  child: Text(' Enter the verification code sent to ' ,
                      style: TextStyle(
                          color: Colors.white, fontSize: 17.0)),
                ),
                SizedBox(height: screenHeight*0.01,),
                Center(
                  child: Text( myphoneNumber,
                      style: TextStyle(
                          color: Colors.blue, fontSize: 17.0)),
                ),
                SizedBox(height: 0.05 * screenHeight),
                PinCodeTextField(
                    autoDisposeControllers: false,
                    controller: otpController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    appContext: context,
                    textStyle: TextStyle( color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),
                    length: 6,
                    onChanged: (value)
                    {    print(value);
                    setState(() {
                      my_verificationcode=otpController.text;
                    });

                    setState(() {
                      if (value.length >= 1)
                        is_disabled= false;
                    });
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 60,
                      fieldWidth: 40,
                      inactiveColor: HexColor("#2C2B69"),
                      activeColor:Colors.amber,
                      selectedColor:  Colors.blue,
                      inactiveFillColor: Colors.red,
                    ),
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        //     blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      //  is_disabled=false;
                    }
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_bg_opacity.png"),
              fit: BoxFit.cover,
            )
        ),
        child: showLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
        padding: const EdgeInsets.all(16),
      ),
      bottomNavigationBar:      SizedBox(
        width: screenWidth,
        height: 0.09 * screenHeight,
        child: RaisedButton(
          color: HexColor("#FFBB00"),
          onPressed: is_disabled ? null :
          currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE ? onpressed_phone:onpressed_code,
          child:   Text(' Next', style: TextStyle( color: Colors.white, fontSize: 20.0 )),),
      ),
    );
  }
}
