import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sida_drivers_app/firebase_db.dart';
///sec 7 first video
class PushNotificationService
{
  final FirebaseMessaging firebaseMessaging =FirebaseMessaging();
  Future initialize()async
  {
    firebaseMessaging.configure(
      /// the driver opened the app
      onMessage: (Map<String, dynamic> message) async {
        getRideRequestId(message);

      },
      /// after click to the notification
      onLaunch: (Map<String, dynamic> message) async {
        getRideRequestId(message);
      },
      /// get notifications if the app minimized
      onResume: (Map<String, dynamic> message) async {
        getRideRequestId(message);
      },
    );
  }
   Future<String> getToken() async
   {
     String token = await firebaseMessaging.getToken();
     print("+>>>>>>>>>>>>>>>>>>>>>>>>>>.this is token");
     print(token);
     drivers_ref.child(FirebaseAuth.instance.currentUser.uid).child('token').set(token);
     firebaseMessaging.subscribeToTopic('alldrivers');
     firebaseMessaging.subscribeToTopic('allusers');
   }
  String getRideRequestId(Map<String, dynamic> message)
  {
    String rideRequestId = "";
    if(Platform.isAndroid)
    {
      rideRequestId = message['data']['ride_request_id'];
    }
    ///TODO:UN COMMENT FOR ios
  //  else
    //{
      //rideRequestId = message['ride_request_id'];
    //}

    return rideRequestId;
  }
}