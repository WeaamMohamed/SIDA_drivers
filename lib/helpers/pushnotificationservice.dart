import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_drivers_app/models/tripdetails.dart';
import 'dart:io' show Platform;
import 'dart:async';
import '../../globalvariables.dart';
import 'notificationDialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PushNotificationService{

  final FirebaseMessaging fcm = FirebaseMessaging();
  Future initialize(context) async {
    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> initialize");
    // if(Platform.isIOS){
    //   fcm.requestNotificationPermissions(IosNotificationSettings());
    // }

    fcm.configure(
      /// the driver opened the app
      onMessage: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideID(message), context);
        fetchRideInfo(getRideID(message),context);

      },
      /// after click to the notification
      onLaunch: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideID(message), context);
        fetchRideInfo(getRideID(message),context);

      },
      /// get notifications if the app minimized
      onResume: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideID(message), context);
        fetchRideInfo(getRideID(message),context);

      },

    );

  }

  Future<String> getToken() async{

    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> get token");

    String token = await fcm.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('Drivers/${currentUser.uid}/token');
    tokenRef.set(token);

    //fcm.unsubscribeFromTopic('allDrivers');
    //fcm.unsubscribeFromTopic('allUsers');

    fcm.subscribeToTopic('alldrivers');
    fcm.subscribeToTopic('allusers');

  }

  String getRideID(Map<String, dynamic> message){

    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> get rider id");

    String rideID = '';

    if(Platform.isAndroid){
      rideID = message['data']['ride_request_id'];
      //print('ride_id: $rideID');
    }
    else{
      rideID = message['ride_request_id'];
      print('ride_id: $rideID');
    }
    print(rideID);
    return rideID;
  }

  void fetchRideInfo(String rideID, context)
  {
    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> yaraaaaaab");
    DatabaseReference rideRef = FirebaseDatabase.instance.reference().child('rideRequests/$rideID');
    rideRef.once().then((DataSnapshot dataSnapShot)
    {
      print(dataSnapShot.value);
          if(dataSnapShot.value != null)
          {
              assetsAudioPlayer.open(Audio('assets/sounds/alert.mp3'));
              assetsAudioPlayer.play();
              double pickupLat = double.parse(dataSnapShot.value['pickup_location']['latitude'].toString());
              double pickupLng = double.parse(dataSnapShot.value['pickup_location']['longitude'].toString());
              String pickupAddress = dataSnapShot.value['pickup_address'].toString();

              double dropoffLat = double.parse(dataSnapShot.value['dropoff_location']['latitude'].toString());
              double dropoffLng = double.parse(dataSnapShot.value['dropoff_location']['longitude'].toString());
              String dropoffAddress = dataSnapShot.value['dropoff_address'];

              String paymentMethod = dataSnapShot.value['payment_method'];

              //String riderName = dataSnapShot.value["rider_name"];
            //  String riderPhone = dataSnapShot.value['rider_phone'];

              TripDetails tripDetails = TripDetails();
              
              tripDetails.rideID = rideID;
              tripDetails.pickupAddress = pickupAddress;
              tripDetails.dropoffAddress = dropoffAddress;
              tripDetails.pickupLocation = LatLng(pickupLat, pickupLng);
              tripDetails.dropoffLocation = LatLng(dropoffLat, dropoffLng);
              tripDetails.paymentMethod = paymentMethod;
              //tripDetails.riderName = riderName;
            //  tripDetails.riderPhone = riderPhone;

              print("=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Information :: ");
              print(tripDetails.pickupAddress);
              print(tripDetails.dropoffAddress);
              //print(tripDetails.riderName);
              print("whyyyyyyyyyyy?>>>>>>>>>>>>>>>>>>>>>>>>>>>");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ReceiveRide(tripDetails: tripDetails,)));


            }
            else
            print("don't say it!");
        });
  }
}