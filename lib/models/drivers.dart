import 'package:firebase_database/firebase_database.dart';
class Drivers
{
  String Key;
  String FirstName;
  String LastName;
  String Phone;
  String newRide;
  String carModel;
  String carBrand;
  String carColor;
  String carLicensePlate;
  Drivers(
  {
    this.FirstName,this.LastName, this.Phone,this.Key,
    this.carBrand,this.carModel,this.newRide,this.carColor

 }
 );
  Drivers.fromSnapshot(DataSnapshot dataSnapshot)
  {
    Key= dataSnapshot.key;
    Phone = dataSnapshot.value['Phone'];
    FirstName = dataSnapshot.value['FirstName'];
    LastName = dataSnapshot.value['LastName'];
     carModel= dataSnapshot.value['carDetails']['carModel'];
    carBrand = dataSnapshot.value['carDetails']['carBrand'];
    carColor = dataSnapshot.value['carDetails']['carColor'];
    carLicensePlate = dataSnapshot.value['carDetails']['carLicensePlate'];
  }


}