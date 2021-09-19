import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

User currentUser;

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(30.033333, 31.233334),
  zoom: 14.4746,
);

const String MAP_API_KEY = "AIzaSyC8duRzIq6lUb6BuMVDIpV0vEMmdfHf0WQ";

StreamSubscription<Position> homeTabPositionStream;

final assetsAudioPlayer = AssetsAudioPlayer();

Position currentPosition;

DatabaseReference rideRef;

final database = FirebaseDatabase.instance;
final drivers_ref = database.reference().child('Drivers');

/// newRide = searching => driver is available otherwise he os busy
/// e7na 3aks el ragl
/// 
/// //DatabaseReference newRequest_ref= database.reference().child('Ride_Requests');


//rideRequestRef

// DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
// DatabaseReference driversRef = FirebaseDatabase.instance.reference().child("drivers");
// DatabaseReference newRequestsRef = FirebaseDatabase.instance.reference().child("Ride Requests");
// DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("drivers").child(currentfirebaseUser.uid).child("newRide");