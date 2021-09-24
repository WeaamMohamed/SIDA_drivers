import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:sida_drivers_app/helpers/helpermethods.dart';
import 'package:sida_drivers_app/helpers/mapkit_helper.dart';
import 'package:sida_drivers_app/helpers/pushnotificationservice.dart';
import 'package:sida_drivers_app/models/drivers.dart';
import 'package:sida_drivers_app/screens/vehicle_info.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';
import 'dart:async';
import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';
import 'package:sida_drivers_app/shared/providers/map_provider.dart';
import 'package:sida_drivers_app/shared/providers/data_provider.dart';
import 'package:sida_drivers_app/widgets/cancel_trip_container.dart';

import 'driver_info.dart';
class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';

  HomeScreen();
  //final String userID;
  //HomeScreen(  this.userID,{Key key}):super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   var mapProvider;
   bool isRequestingDirection = false;
   Position myPosition;

//TODO:
  ///Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Completer<GoogleMapController> _controllerGoogleMap;
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enabled = false;
  Color mColor = Colors.white;
  var geoLocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);

  CameraPosition cameraPosition;

  Future<void> getCurrentPosition() async
  {
    ///

   //todo; weaam Position position1 = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position position1 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position1;
    print("weaam :CurrentPosition data: " + currentPosition.latitude.toString() +
        currentPosition.longitude.toString());

    print("weaam position1 : " + position1.latitude.toString() +
        position1.longitude.toString());


    LatLng latLatPosition = LatLng(position1.latitude, position1.longitude);
    //
    // CameraPosition cameraPosition =
    // new CameraPosition(target: userLatLangPosition, zoom: 17);
    //
    // mapProvider.newGoogleMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));


   CameraPosition currentCameraPosition = new CameraPosition(target: latLatPosition, zoom:20);
   cameraPosition = currentCameraPosition;
    // mapProvider.newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
    //     currentCameraPosition));

    //TODO:
    // setState(() {
    //   googlePlex = cameraPosition;
    // });


    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));

    ///

    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    // currentPosition = position;
    // LatLng userLatLangPosition = LatLng(position.latitude,position.longitude,);
    // //CameraPosition cameraPosition = new CameraPosition(target: userLatLangPosition, zoom: 17);
    // newGoogleMapController.animateCamera(CameraUpdate.newLatLng(userLatLangPosition));

    ///
    // mapProvider.newGoogleMapController
    //   .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //to get user's current address
    //String currentUserAddress =
    //await RequestHelper.getSearchCoordinateAddress(position: position, context: context);
    // print("this is your address: " + currentUserAddress);
  }

  void getCurrentDriverInfo() async
  {
    print("heeeeeeeeeeeeeeeey");
    currentUser = FirebaseAuth.instance.currentUser;

    drivers_ref.child(currentUser.uid).once().then((DataSnapshot dataSnapshot)
    {
            if (dataSnapshot != null)
              {
                driversInfo= Drivers.fromSnapshot(dataSnapshot);
              }
    });

    PushNotificationService pushNotificationService = PushNotificationService();
    pushNotificationService.initialize(context);
    pushNotificationService.getToken();
  }

  @override
  void initState()
  {
   /// getCurrentPosition();
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
   _checkPermission();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.light,
        ));
    super.initState();
    getCurrentDriverInfo();
  }


  @override
  Widget build(BuildContext context) {
    _controllerGoogleMap = Completer();

     mapProvider = Provider.of<MapProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);


    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarIconBrightness: _enabled? Brightness.dark: Brightness.light,
    //   statusBarColor: Colors.white.withOpacity(0.0),
    // ));
    Size mqSize = MediaQuery.of(context).size;
    //
    //
    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    // final double appBarHeight = AppBar().preferredSize.height;

    // Row(
    //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //
    //
    //     GestureDetector(
    //       onTap: (){
    //         scaffoldKey.currentState.openDrawer();
    //       },
    //       child: SvgPicture.asset("assets/images/menu_iconn.svg"),),
    //     //Spacer(),
    //     Text(
    //       _enabled? "Online" : "Offline",
    //       style: TextStyle(
    //         fontSize: 18,
    //         color: Colors.white,
    //       ),
    //     ),
    //     SizedBox(width: 10,),
    //     CupertinoSwitch(
    //       value: _enabled,
    //       activeColor: amberSwitchButton,
    //       trackColor: Colors.white70,
    //       onChanged: (value) {
    //         setState(() {
    //           _enabled = value;
    //         });
    //         print("current value : " + _enabled.toString());
    //       },
    //     ),
    //   ],
    // ),
    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: HomeDrawer(),
      key: scaffoldKey,
      appBar: AppBar(
        brightness: _enabled? Brightness.light: Brightness.dark,
        automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
        backgroundColor: _enabled? Colors.white: Color(0xff2C2B69),
        elevation: 0,
        actions: [


          // SizedBox(width: 15,),
          InkWell(
            onTap: (){
              scaffoldKey.currentState.openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SvgPicture.asset("assets/images/menu_iconn.svg",
                color: mColor,),
            ),),
          Spacer(),
          Center(
            child: Text(
              _enabled? "Online" : "Offline",
              style: TextStyle(
                fontSize: 18,
                color: mColor,
              ),
            ),
          ),
          SizedBox(width: 10,),
          CupertinoSwitch(
            value: _enabled,
            activeColor: amberSwitchButton,
            trackColor: Colors.white70,
            onChanged: (value) {
              setState(() {
                _enabled = value;
              });

              if(value)
              {

                /// online
                ///
                //     getCurrentPosition().then((value){
                //
                //       GoOnline();
                //       getLocationLiveUpdates();
                //     });
                    setState(() {
                      mColor = Colors.black;
                       // GoOnline();
                       //  getLocationLiveUpdates();
                      _enabled = true;
                    });
                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //content: Text("You're Online now!"),
                    //  ));
              }
              else
              {
                ///offline
                    setState(() {
                      mColor = Colors.white;

                      _enabled = false;
                    });
                    GoOffline();
                    //_enabled = false;
                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //content: Text("You're Offline now!"),
                  //  ));
              }
                // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle
                //   statusBarIconBrightness: value? Brightness.light: Brightness.dark ,
                // ));
                //print("current value : " + _enabled.toString());
              },
          ),
          SizedBox(width: 15,),
        ],
      ),

      body: _enabled? Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 0,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[customAmberColor1, customAmberColor2],
                ),
                borderRadius: BorderRadius.only(
                //  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  // bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(20.0),
                ),            ),
                child: Row(
                  children: [
                    Text("400.00", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    SizedBox(width: 5,),
                    Text("EGP", style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),),
                  ],
                ),
                ), ),
            GoogleMap(
              padding: EdgeInsets.only(
                bottom: mqSize.height / 4,
                top: 25.0,
              ),


              ///
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
             /// initialCameraPosition: (cameraPosition == null)? googlePlex: cameraPosition,
              initialCameraPosition: googlePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: false,
              compassEnabled: false,
           //   polylines: mapProvider.polylineSet,
              // markers: markersSet,
              // circles: circlesSet,
              onMapCreated: (GoogleMapController controller) {

                print("weaam : onMapCreated");
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> go online");

                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
              //  mapProvider.newGoogleMapController = controller;
                getCurrentPosition().then((value){
                  GoOnline();
                  getLocationLiveUpdates();
                });


            //    mapProvider.newGoogleMapController = controller;
              },
            ),

            Positioned(
              bottom: 20,
              left: 15,
              right: 15,

              child: Container(

               //padding: const EdgeInsets.all(15),
                child: customHomeButton(
                  context: context,
                  title: "I've arrived",
                  circularBorder: true,
                  onTap: () {},
                ),
              ),
            ),

            //TODO: Cancel Trip
           if(false) Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CancelTripContainer(),
            )

          ],
        ),
      ) : Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xff2C2B69), Color(0xff121212)],
            )
        ),
        padding: EdgeInsets.only(
          left: 15, right: 15,
          bottom: 20,
        ),
        child: Column(
          children: [
            Spacer(),
            Container(
              width: mqSize.width * 0.6,
              child: Text("You are currently not accepting orders. Please turn on the toggle button above to start receiving orders.",
                style: TextStyle(fontSize: 17,
                    color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            customHomeButton(
              context: context,
              title: "Update Driver Information",
              withIcon: false,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleInfoScreen()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleInfoScreen()));


              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied )
      {
        print("check permission called");
        return _checkPermission();
      }

      // return Future.error('Location permissions are denied');
      print('Location permissions are denied');
      ///  _checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   return Future.error('Location permissions are denied');
      // }
    }
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse)
    {
      print("permission accepted");
      return true;
    }

    if( permission == LocationPermission.deniedForever)
    {
      //TODO: show dialog that permission denied forever and ask user again
      // _showCustomDialog();
      _showCustomPlatformDialog();
      // Geolocator.openAppSettings();
      //openAppSettings();
      // return _checkPermission();
    }

    return true;

  }

  _showCustomPlatformDialog()=> showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Permission"),
      content:
      Text("Permission was denied forever. Do you want to open settings to change it?"),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK"),
          onPressed: () {
            Navigator.pop(context);

            Geolocator.openAppSettings().then((value) => _checkPermission());
          },
        ),
      ],
    ),
  );
  Future<void> checkGPS() async {
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showDialog();
      return Future.error('Location services are disabled.');
    }


  }
  _showDialog() => showDialog(context: context, builder: (_) => AlertDialog(
    title: Text("GPS disabled"),
    content: Text("Please open your GPS."),

  ),);

  void GoOnline() async
  {

    Geofire.initialize("availableDrivers");
    print("weaam: longitude form Go Online: " + currentPosition.longitude.toString());
    Geofire.setLocation(currentUser.uid, currentPosition.latitude, currentPosition.longitude);
    rideRef = FirebaseDatabase.instance.reference().child('Drivers/${currentUser.uid}/newRide');
    rideRef.set('Searching');

    rideRef.onValue.listen((event) {

    });
  }
   void getLocationLiveUpdates() async
   {

    // LatLng oldPos = LatLng(0, 0);
     //todo; weaam 55, 4:30
     //accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1
     homeTabPositionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation,
   distanceFilter: 1).listen((Position position) {
      currentPosition = position;
      myPosition = position;

      if(_enabled)
      {

      }



       LatLng latLng = LatLng(position.latitude, position.longitude);
      Geofire.setLocation(currentUser.uid, position.latitude, position.longitude);
      // var rot = MapKitHelper.getMarkerRotation(oldPos.latitude, oldPos.latitude,
      //     position.latitude, position.longitude);
      // Marker animatingMarker = Marker(markerId: MarkerId("animating"),
      // position: latLng,
      //  //todo; icon: animatingMarkerIcon,
      //   rotation: rot,
      //   infoWindow: InfoWindow(title: "current location"),
      //
      // );

       newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
       //todo; add marker set , zoom camera

     // Timer(Duration(milliseconds: 500), () async {
     //        await newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
     //  });
     ////// newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));

    });

   }
  void GoOffline() async
  {
    //Geofire.removeLocation(widget.userID);
    print("))))))))))))))))))))))))))))))))))))))))");
    print(currentUser.uid);
    Geofire.removeLocation(currentUser.uid);
    rideRef.onDisconnect();
    rideRef.remove();
    rideRef = null;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }

  // void updateRideDetails() async
  // {
  //   if(isRequestingDirection == false)
  //   {
  //     isRequestingDirection = true;
  //
  //     if(myPosition == null)
  //     {
  //       return;
  //     }
  //
  //     var posLatLng = LatLng(myPosition.latitude, myPosition.longitude);
  //     LatLng destinationLatLng;
  //
  //     if(status == "accepted")
  //     {
  //       destinationLatLng = ride.pickup;
  //     }
  //     else
  //     {
  //       destinationLatLng = widget.rideDetails.dropoff;
  //     }
  //
  //     var directionDetails = await HelperMethods.obtainPlaceDirectionDetails(posLatLng, destinationLatLng);
  //     if(directionDetails != null)
  //     {
  //       setState(() {
  //         durationRide = directionDetails.durationText;
  //       });
  //     }
  //
  //     isRequestingDirection = false;
  //   }
  // }
}
