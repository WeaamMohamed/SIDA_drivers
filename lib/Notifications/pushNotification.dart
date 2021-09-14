import 'dart:async';
import 'dart:async';
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
        print("onMessage: $message");

      },
      /// after click to the notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      /// get notifications if the app minimized
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
   Future<String> getToken() async
   {
     String token = await firebaseMessaging.getToken();
     print("+>>>>>>>>>>>>>>>>>>>>>>>>>>.this is token");
     print(token);
     drivers_ref.child(FirebaseAuth.instance.currentUser.uid).child('token').set(token);
     firebaseMessaging.subscribeToTopic('allDrivers');
     firebaseMessaging.subscribeToTopic('allUsers');
   }

}