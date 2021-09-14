import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
User currentUser;
Position currentPosition;
final database = FirebaseDatabase.instance;
final drivers_ref = database.reference().child('Drivers');
DatabaseReference rideRequest_ref;
const String MAP_API_KEY = "AIzaSyC8duRzIq6lUb6BuMVDIpV0vEMmdfHf0WQ";
StreamSubscription<Position> homeTabPositionStream;