import 'package:flutter/material.dart';
import 'package:sida_drivers_app/screens/criminal_records_and_taxi_application_file.dart';
import 'package:sida_drivers_app/screens/driver_license.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/screens/vehicle_registration_certificate.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: amberSwitchButton,
      ),
      home: CriminalRecordsAndTaxiApplicationFile(),
    );
  }
}
