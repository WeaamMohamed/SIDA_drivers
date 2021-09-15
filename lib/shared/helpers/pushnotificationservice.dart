import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../firebase_db.dart';

class PushNotificationService{

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();


  Future initialize(context) async {

    if(Platform.isIOS){
      firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }

    firebaseMessaging.configure(
      /// the driver opened the app
      onMessage: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        getRideRequestID(message);
      },
      /// after click to the notification
      onLaunch: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        getRideRequestID(message);

      },
      /// get notifications if the app minimized
      onResume: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        getRideRequestID(message);

      },

    );

  }

  Future<String> getToken() async{

    String token = await firebaseMessaging.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('Drivers/${currentUser.uid}/token');
    tokenRef.set(token);

    firebaseMessaging.subscribeToTopic('alldrivers');
    firebaseMessaging.subscribeToTopic('allusers');

  }

  String getRideRequestID(Map<String, dynamic> message){

    String rideRequestID = '';

    if(Platform.isAndroid){
      rideRequestID = message['data']['ride_request_id'];
    }
    else{
     rideRequestID = message['ride_request_id'];
      print('ride_request_id: $rideRequestID');
    }

    return rideRequestID;
  }
}