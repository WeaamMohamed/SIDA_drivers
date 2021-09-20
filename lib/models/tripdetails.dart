import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripDetails
{
  String pickupAddress;
  String dropoffAddress;
  LatLng pickupLocation;
  LatLng dropoffLocation;
  String rideID;
  String paymentMethod;
  String riderName;
  String riderPhone;

  TripDetails({
    this.pickupAddress, 
    this.dropoffAddress, 
    this.pickupLocation, 
    this.dropoffLocation, 
    this.rideID, 
    this.paymentMethod, 
    this.riderName, 
    this.riderPhone});
}