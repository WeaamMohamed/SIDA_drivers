import 'package:firebase_database/firebase_database.dart';

class myHistory
{
  String paymentMethod;
  String createdAt;
  String status;
  String fares;
  String dropOff;
  String pickup;

  myHistory({this.paymentMethod, this.createdAt, this.status, this.fares, this.dropOff, this.pickup});

  myHistory.fromSnapshot(DataSnapshot snapshot)
  {
    paymentMethod = snapshot.value["payment_method"];
    createdAt = snapshot.value["created_at"];
    status = snapshot.value["status"];
    fares = snapshot.value["fare"];
    dropOff = snapshot.value["dropoff_address"];
    pickup = snapshot.value["pickup_address"];
  }
}