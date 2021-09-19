import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
User currentUser;
Position currentPosition;
final database = FirebaseDatabase.instance;
final drivers_ref = database.reference().child('Drivers');

DatabaseReference rideRequestRef=database.reference().child('Drivers').child(FirebaseAuth.instance.currentUser.uid).child('newRide');
/// newRide = s`earching => driver is available otherwise he os busy

DatabaseReference newRequestsRef = FirebaseDatabase.instance.reference().child("rideRequests");
const String MAP_API_KEY = "AIzaSyC8duRzIq6lUb6BuMVDIpV0vEMmdfHf0WQ";
StreamSubscription<Position> homeTabPositionStream;

final assetsAudioPlayer =AssetsAudioPlayer();
