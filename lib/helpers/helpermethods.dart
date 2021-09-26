import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../globalvariables.dart';


class HelperMethods
{



  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async
  {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$MAP_API_KEY";

    var res = await RequestHelper.getRequest(directionUrl);

    if(res == "failed")
    {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print("Failed");
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static void disableHomeLiveLocationUpdates()
  {
    homeTabPositionStream.pause();
    Geofire.removeLocation(currentUser.uid);
  }
  static void enableHomeLiveLocationUpdates()
  {
    homeTabPositionStream.resume();
    Geofire.setLocation(currentUser.uid, currentPosition.latitude,currentPosition.longitude);
  }

  static void getRideDataForFare() async
  {

  }

  /// directionDetailsto calculate the actual time of the trip
  /// distance and time are the data stored in the database and the user confirmed it in the rider app
  static int calculateFares(DirectionDetails directionDetails ,String carType,String distance,String time)
  {

    double timeTraveledFare=0.0;
    double distancTraveledFare=0.0;
    double totalFareAmount;
    print("+____________________________");
    print(time);
    print(distance);
    print( directionDetails.durationValue );
    double tripTime= double.parse(time);
    double tripDistance= double.parse(distance);
    if (  carType == "Any SIDA")
      {
         if( directionDetails.durationValue > tripTime )
           {
             timeTraveledFare = ((directionDetails.durationValue - tripTime) / 60) * 0.36;
           }

         distancTraveledFare = (tripDistance/ 1000) * 2.61;
         totalFareAmount = timeTraveledFare + distancTraveledFare;
        if(totalFareAmount < 11)
          totalFareAmount=11;
      }
    else if (  carType == "SIDA Plus")
      {
        if( directionDetails.durationValue > tripTime )
        {
          timeTraveledFare = ((directionDetails.durationValue - tripTime) / 60) * 0.4;
        }
        distancTraveledFare = (tripDistance/ 1000) * 2.80;
        totalFareAmount = timeTraveledFare + distancTraveledFare;
        if(totalFareAmount < 12)
          totalFareAmount=12;
      }
      double result = (totalFareAmount.truncate()) * 1.0;
      return result.truncate();

  }
}
///-------------------------------------------------------------------------------------
class DirectionDetails
{
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  String encodedPoints;

  DirectionDetails({this.distanceValue, this.durationValue, this.distanceText, this.durationText, this.encodedPoints,});

}

class RequestHelper
{
  static Future<dynamic> getRequest(String url) async
  {
    http.Response response = await http.get(url);

    try
    {
      if(response.statusCode == 200)
      {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      }
      else
      {
        return "failed";
      }
    }
    catch(exp)
    {
      return "failed";
    }
  }
} 
