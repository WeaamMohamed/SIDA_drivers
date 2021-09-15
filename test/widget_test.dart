// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../firebase_db.dart';

// class PushNotificationService{

//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();


//   Future initialize(context) async {

//     if(Platform.isIOS){
//       firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
//     }

//     firebaseMessaging.configure(
//       /// the driver opened the app
//       onMessage: (Map<String, dynamic> message) async {

//         //fetchRideInfo(getRideRequestID(message), context);
//         getRideRequestID(message);
//       },
//       /// after click to the notification
//       onLaunch: (Map<String, dynamic> message) async {

//         //fetchRideInfo(getRideRequestID(message), context);
//         getRideRequestID(message);

//       },
//       /// get notifications if the app minimized
//       onResume: (Map<String, dynamic> message) async {

//         //fetchRideInfo(getRideRequestID(message), context);
//         getRideRequestID(message);

//       },

//     );

//   }

//   Future<String> getToken() async{

//     String token = await firebaseMessaging.getToken();
//     print('token: $token');

//     DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('Drivers/${currentUser.uid}/token');
//     tokenRef.set(token);

//     firebaseMessaging.subscribeToTopic('alldrivers');
//     firebaseMessaging.subscribeToTopic('allusers');

//   }

//   String getRideRequestID(Map<String, dynamic> message){

//     String rideRequestID = '';

//     if(Platform.isAndroid){
//       rideRequestID = message['data']['ride_request_id'];
//     }
//     else{
//      rideRequestID = message['ride_request_id'];
//       print('ride_request_id: $rideRequestID');
//     }

//     return rideRequestID;
//   }

//   // void fetchRideInfo(String rideRequestID, context){

//   //   //show please wait dialog
//   //   showDialog(
//   //     barrierDismissible: false,
//   //     context: context,
//   //     builder: (BuildContext context) => ProgressDialog(status: 'Fetching details',),
//   //   );

//   //   DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child('rideRequest/$rideRequestID');
//   //   rideRequestRef.once().then((DataSnapshot snapshot){

//   //     Navigator.pop(context);

//   //     if(snapshot.value != null){

//   //       assetsAudioPlayer.open(
//   //         Audio('sounds/alert.mp3'),
//   //       );
//   //       assetsAudioPlayer.play();

//   //       double pickupLat = double.parse(snapshot.value['location']['latitude'].toString());
//   //       double pickupLng = double.parse(snapshot.value['location']['longitude'].toString());
//   //       String pickupAddress = snapshot.value['pickup_address'].toString();

//   //       double destinationLat = double.parse(snapshot.value['destination']['latitude'].toString());
//   //       double destinationLng = double.parse(snapshot.value['destination']['longitude'].toString());
//   //       String destinationAddress = snapshot.value['destination_address'];
//   //       String paymentMethod = snapshot.value['payment_method'];
//   //       String riderName = snapshot.value['rider_name'];
//   //       String riderPhone = snapshot.value['rider_phone'];

//   //       TripDetails tripDetails = TripDetails();

//   //       tripDetails.rideRequestID = rideRequestID;
//   //       tripDetails.pickupAddress = pickupAddress;
//   //       tripDetails.destinationAddress = destinationAddress;
//   //       tripDetails.pickup = LatLng(pickupLat, pickupLng);
//   //       tripDetails.destination = LatLng(destinationLat, destinationLng);
//   //       tripDetails.paymentMethod = paymentMethod;
//   //       tripDetails.riderName = riderName;
//   //       tripDetails.riderPhone = riderPhone;

//   //       showDialog(
//   //         context: context,
//   //         barrierDismissible: false,
//   //         builder: (BuildContext context) => NotificationDialog(tripDetails: tripDetails,),
//   //       );

//   //     }

//   //   });
//   // }

// }