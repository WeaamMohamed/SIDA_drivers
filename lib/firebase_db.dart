import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
User currentUser;
final database = FirebaseDatabase.instance;
final drivers_ref = database.reference().child('Drivers');
final rideRequest_ref = database.reference().child('Drivers').child(FirebaseAuth.instance.currentUser.uid).child('newRide');
const String MAP_API_KEY = "AIzaSyC8duRzIq6lUb6BuMVDIpV0vEMmdfHf0WQ";
StreamSubscription<Position> homeTabPageStreamSubscription;