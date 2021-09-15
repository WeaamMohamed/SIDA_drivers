import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier{

  GoogleMapController _newGoogleMapController;


  GoogleMapController get newGoogleMapController => _newGoogleMapController;

  set newGoogleMapController(GoogleMapController value) {
    _newGoogleMapController = value;
    notifyListeners();
  }
}