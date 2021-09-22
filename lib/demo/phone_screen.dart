import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sida_drivers_app/demo/phone_auth_model.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var phoneNumberController = TextEditingController();
  var smsCodeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String _verificationCode;
  PhoneAuthModel phoneAuthModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff010039),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              customTextFormField(
                  //   textColor: Colors.white,
                  textInputType: TextInputType.phone,
                  textController: phoneNumberController,
                  validator: (String val) {
                    if (val.isEmpty) return "Please enter your number";

                    return null;
                  },
                  label: "Phone Number"),
              SizedBox(
                height: 20,
              ),
              customTextFormField(
                  textInputType: TextInputType.phone,
                  textController: smsCodeController,
                  // textColor: Colors.white,

                  validator: (String val) {
                    return null;
                  },
                  label: "sms code"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      // FirebaseAuth.instance.signInWithPhoneNumber("+2" + phoneNumberController.text)
                      //     .then((value){
                      //
                      //
                      // }).catchError((error){
                      //   defaultToast(message: error.toString(), state: ToastState.ERROR);
                      // });
                      //

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+2${phoneNumberController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          // ANDROID ONLY!

                          // Sign the user in (or link) with the auto-generated credential
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          print(credential.smsCode);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            defaultToast(
                                message:
                                    'The provided phone number is not valid.',
                                state: ToastState.ERROR);
                          } else {
                            defaultToast(
                                message: e.message, state: ToastState.ERROR);
                          }
                        },
                        codeSent: (String verificationId, int resendToken) async {
                          // Update the UI - wait for the user to enter the SMS code
                          //  smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.

                          setState(() {
                            _verificationCode = verificationId;
                          });


                        },

                        //after 60 seconds another code will be sent.try
                        timeout: Duration(seconds: 60),
                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            _verificationCode = verificationId;

                          });
                        },
                      );
                    }
                  },
                  child: Text("next")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+2${phoneNumberController.text}',
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      await FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) async {
                        if (value.user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                  (route) => false);
                        }
                      });
                    },
                    //     (PhoneAuthCredential credential) async {
                    //   // ANDROID ONLY!
                    //
                    //   // Sign the user in (or link) with the auto-generated credential
                    //
                    //   await FirebaseAuth.instance
                    //       .signInWithCredential(credential);
                    // },
                    verificationFailed: (FirebaseAuthException e) {
                      if (e.code == 'invalid-phone-number') {
                        defaultToast(
                            message: 'The provided phone number is not valid.',
                            state: ToastState.ERROR);
                      } else {
                        defaultToast(
                            message: e.message, state: ToastState.ERROR);
                      }
                    },
                    codeSent: (String verificationId, int resendToken) async {
                      // Update the UI - wait for the user to enter the SMS code
                      //  smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.

                      setState(() {
                        _verificationCode = verificationId;
                      });


                      // // Create a PhoneAuthCredential with the code
                      // PhoneAuthCredential credential =
                      //     PhoneAuthProvider.credential(
                      //         verificationId: verificationId,
                      //         smsCode: smsCodeController.text);
                      //
                      // // Sign the user in (or link) with the credential
                      // await FirebaseAuth.instance
                      //     .signInWithCredential(credential);
                    },

                    //after 60 seconds another code will be sent.try
                    timeout: Duration(seconds: 60),
                    codeAutoRetrievalTimeout: (String verificationId) {
                      setState(() {
                        _verificationCode = verificationId;

                      });
                    },
                  );
                },
                child: Text("send code again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
