import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_drivers_app/shared/helpers/ride_details.dart';
import 'dart:io' show Platform;
import 'dart:async';
import '../../firebase_db.dart';
import 'notificationDialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
class PushNotificationService{

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();


  Future initialize(context) async {

    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> initialize");

    //if(Platform.isIOS){
     // firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
   // }

    firebaseMessaging.configure(
      /// the driver opened the app
      onMessage: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        RetrieveRideRequestInfo(getRideRequestID(message),context);

      },
      /// after click to the notification
      onLaunch: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        RetrieveRideRequestInfo(getRideRequestID(message),context);

      },
      /// get notifications if the app minimized
      onResume: (Map<String, dynamic> message) async {

        //fetchRideInfo(getRideRequestID(message), context);
        RetrieveRideRequestInfo(getRideRequestID(message),context);

      },

    );

  }

  Future<String> getToken() async{
    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> get token");

    String token = await firebaseMessaging.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('Drivers/${currentUser.uid}/token');
    tokenRef.set(token);

    //firebaseMessaging.unsubscribeFromTopic('allDrivers');
    //firebaseMessaging.unsubscribeFromTopic('allUsers');

    firebaseMessaging.subscribeToTopic('alldrivers');
    firebaseMessaging.subscribeToTopic('allusers');

  }

  String getRideRequestID(Map<String, dynamic> message){
    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> get rider id");

    String rideRequestID = '';

    if(Platform.isAndroid){
      rideRequestID = message['data']['ride_request_id'];
      print('ride_request_id: $rideRequestID');
    }
    ///TODO:UNCOMMENT FOR ios
       // else{
      //rideRequestID = message['ride_request_id'];
      //print('ride_request_id: $rideRequestID');
    //}
    return rideRequestID;
  }
  void RetrieveRideRequestInfo(String rideRequestID,BuildContext  context)
  {
    print(" _>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> yaraaaaaab");
    DatabaseReference rideRequests=database.reference().child('rideRequests');
    rideRequests.child(rideRequestID).once().then((DataSnapshot dataSnapShot)

        {
print(dataSnapShot.value);
          if( dataSnapShot.value != null)
            {
              print("whyyyyyyyyyyy?");
              assetsAudioPlayer.open(Audio('sounds/alert.mp3'));
              assetsAudioPlayer.play();

              double pickUpLocationLat = double.parse(dataSnapShot.value['pickup_location']['latitude'].toString());
              double pickUpLocationLng = double.parse(dataSnapShot.value['pickup_location']['longitude'].toString());
              String pickUpAddress = dataSnapShot.value['pickup_address'].toString();

              double dropOffLocationLat = double.parse(dataSnapShot.value['dropoff_location']['latitude'].toString());
              double dropOffLocationLng = double.parse(dataSnapShot.value['dropoff_location']['longitude'].toString());
              String dropOffAddress = dataSnapShot.value['dropoff_address'].toString();

              String paymentMethod = dataSnapShot.value['payment_method'].toString();

              //String rider_name = dataSnapShot.value["Name"];
              String rider_phone = dataSnapShot.value["Phonenumber"];

              RideDetails rideDetails = RideDetails();
              rideDetails.ride_request_id = rideRequestID;
              rideDetails.pickup_address = pickUpAddress;
              rideDetails.dropoff_address = dropOffAddress;
              rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
              rideDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
              rideDetails.payment_method = paymentMethod;
             // rideDetails.rider_name = rider_name;
              rideDetails.rider_phone = rider_phone;
              print("=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Information :: ");
              print(rideDetails.pickup_address);
              print(rideDetails.dropoff_address);
              print(rideDetails.rider_name);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ReceiveRide(rideDetails: rideDetails,)));
            }
          else
          print("don't say it!");
        });
  }
}