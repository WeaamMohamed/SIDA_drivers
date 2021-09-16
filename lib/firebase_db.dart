import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
User currentUser;
Position currentPosition;
final database = FirebaseDatabase.instance;
final drivers_ref = database.reference().child('Drivers');
DatabaseReference rideRequest_ref=database.reference().child('Drivers');

/// newRide = searching => driver is available otherwise he os busy
/// e7na 3aks el ragl
DatabaseReference newRequest_ref= database.reference().child('Ride_Requests').child(FirebaseAuth.instance.currentUser.uid).child('newRide');

const String MAP_API_KEY = "AIzaSyC8duRzIq6lUb6BuMVDIpV0vEMmdfHf0WQ";
StreamSubscription<Position> homeTabPositionStream;

final assetsAudioPlayer =AssetsAudioPlayer();