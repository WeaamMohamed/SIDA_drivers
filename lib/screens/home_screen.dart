import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/firebase_db.dart';
import 'package:sida_drivers_app/shared/helpers/pushnotificationservice.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';
import 'dart:async';
import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';
import 'package:sida_drivers_app/shared/providers/map_provider.dart';
import 'package:sida_drivers_app/shared/providers/data_provider.dart';
import 'package:sida_drivers_app/widgets/cancel_trip_container.dart';
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

//TODO:
  ///Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Completer<GoogleMapController> _controllerGoogleMap;
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enabled = false;
  Color mColor = Colors.white;
  var geoLocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );


  CameraPosition cameraPosition;

  Future<void> getCurrentPosition() async
  {
    ///

    Position position1 = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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


   CameraPosition currentCameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
   cameraPosition = currentCameraPosition;
    // mapProvider.newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
    //     currentCameraPosition));

    //TODO:
    // setState(() {
    //   _kGooglePlex = cameraPosition;
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
    //await RequestAssistant.getSearchCoordinateAddress(position: position, context: context);
    // print("this is your address: " + currentUserAddress);
  }

  void getCurrentDriverInfo() async
  {
    currentUser = await FirebaseAuth.instance.currentUser;
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
                // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
             /// initialCameraPosition: (cameraPosition == null)? _kGooglePlex: cameraPosition,
              initialCameraPosition: _kGooglePlex,
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
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
  void GoOnline() async
  {

    print("weaam : GoOnline()");
  /// await getCurrentPosition();
    //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    //currentPosition = position;
    Geofire.initialize("availableDrivers");
    print("weaam: longitude form Go Online: " + currentPosition.longitude.toString());
    Geofire.setLocation(currentUser.uid, currentPosition.latitude, currentPosition.longitude);
    //print(widget.userID);
    //print(currentPosition.latitude);
    //print(currentPosition.longitude);
    //Geofire.setLocation(widget.userID), currentPosition.latitude, currentPosition.longitude);
    newRequest_ref.set('Searching');

    rideRequest_ref.onValue.listen((event) {

    });
  }
   void getLocationLiveUpdates() async
   {
     homeTabPositionStream = geoLocator.getPositionStream(locationOptions).listen((Position position) {
      currentPosition = position;

      if(_enabled)
      {
        Geofire.setLocation(currentUser.uid, position.latitude, position.longitude);
      }


      LatLng userLatLangPosition = LatLng(position.latitude, position.longitude);
      CameraPosition _newCameraPosition = CameraPosition(
        target: userLatLangPosition,
      //  zoom: 14.4746,
        zoom: 18,
      );
      // setState(() {
      //
      // });
      // setState(() {
      //
      //   _kGooglePlex = _newCameraPosition;
      //
      //
      // });
     /// newGoogleMapController.animateCamera(CameraUpdate.newLatLng(userLatLangPosition));
     Timer(Duration(milliseconds: 500), () async {
            await newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
      });
     ////// newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));

    });
    
    //  homeTabPositionStream = geoLocator.getPositionStream(locationOptions).listen((Position position) {
    //    currentPosition = position;
    //     if (_enabled)
    //      {
    //        Geofire.setLocation(currentUser.uid, currentPosition.latitude, currentPosition.longitude);
    //        //Geofire.setLocation( widget.userID, position.latitude, position.longitude);
    //      }
    //    LatLng userLatLangPosition = LatLng(position.latitude,position.longitude,);
    //     ///TODO:CHECK THIS LINE BELOW
    //   // final GoogleMapController mapController = await _controllerGoogleMap.future;
    //   newGoogleMapController.animateCamera(CameraUpdate.newLatLng(userLatLangPosition));
    //    //newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
     //});
   }
  void GoOffline() async
  {
    //Geofire.removeLocation(widget.userID);
    Geofire.removeLocation(currentUser.uid);
    rideRequest_ref.onDisconnect();
    rideRequest_ref.remove();
    rideRequest_ref = null;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }
}
