import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_webservice/directions.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:sida_drivers_app/helpers/helpermethods.dart';
import 'package:sida_drivers_app/shared/componenents/progressDialog.dart';
import 'package:sida_drivers_app/models/tripdetails.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';
import 'dart:async';
import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';
import 'package:sida_drivers_app/widgets/cancel_trip_container.dart';

class NewRideScreen extends StatefulWidget {

  final TripDetails tripDetails;

  NewRideScreen({this.tripDetails});
  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {

  Completer<GoogleMapController> _controllerGoogleMap;
  GoogleMapController newGoogleMapController;
  Set<Marker> markersSet = Set <Marker>();
  Set<Circle> circlesSet = Set <Circle>();
  Set<Polyline> polyLineSet = Set <Polyline>();
  List <LatLng> polylineCoordinates=[];
  PolylinePoints polylinePoints = PolylinePoints();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enabled = true;
  Color mColor = Colors.white;
  var geoLocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);

  void initState()
  {
    super.initState();
    acceptRideRequest();
  }

CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

  CameraPosition cameraPosition;

  Future<void> getCurrentPosition() async
  {
    Position position1 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position1;

    LatLng latLatPosition = LatLng(position1.latitude, position1.longitude);
    CameraPosition currentCameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    cameraPosition = currentCameraPosition;

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
  }
  ///-----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Size mqSize = MediaQuery.of(context).size;
    double mapPaddingFromBottom= mqSize.height / 4;
    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: HomeDrawer(),
      key: scaffoldKey,
      appBar:  AppBar(
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
                GoOnline();
                getLocationLiveUpdates();
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
                bottom:mapPaddingFromBottom ,
                top: 25.0,
              ),
              markers: markersSet,
              circles: circlesSet,
              polylines: polyLineSet,
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
              onMapCreated: (GoogleMapController controller) async{
                print("weaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam : onMapCreated");
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> go online");
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                setState(() {
                  mapPaddingFromBottom= 265.0;
                });
                //  mapProvider.newGoogleMapController = controller;
                getCurrentPosition().then((value)   {
                  GoOnline();
                  getLocationLiveUpdates();
                });
                var currentLatLng=LatLng(currentPosition.latitude,currentPosition.longitude);
                var pickupLatLng = widget.tripDetails.pickupLocation;
                print("############################################################################################################################");
                await getPlaceDirection(currentLatLng, pickupLatLng);
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
      )
          :  Container(
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
    // print("weaam: longitude form Go Online: " + currentPosition.longitude.toString());
    Geofire.setLocation(currentUser.uid, currentPosition.latitude, currentPosition.longitude);
    //print(widget.userID);
    //print(currentPosition.latitude);
    //print(currentPosition.longitude);
    //Geofire.setLocation(widget.userID), currentPosition.latitude, currentPosition.longitude);
    rideRef.set('Searching');
    rideRef.onValue.listen((event) {

    });
  }
  ///
  void getLocationLiveUpdates() async
  {
    homeTabPositionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1).listen((Position position) {
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

    print("))))))))))))))))))))))))))))))))))))))))");
    print(currentUser.uid);
    Geofire.removeLocation(currentUser.uid);
    rideRef.onDisconnect();
    rideRef.remove();
    rideRef = null;
  }

  Future<void> getPlaceDirection(LatLng pickUpLatLng, LatLng dropOffLatLng) async
  {
    print("4444444444444444444444444444444444444444444444444444444");
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Please wait...",)
    );

    var details = await HelperMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

    polylineCoordinates.clear();

    if(decodedPolyLinePointsResult.isNotEmpty)
    {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        polylineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polylineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > dropOffLatLng.latitude  &&  pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    }
    else if(pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if(pickUpLatLng.latitude > dropOffLatLng.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }
 void acceptRideRequest()
 {
   String rideReqId= widget.tripDetails.rideID;
   newRequest_ref.child(rideReqId).child('status').set('accepted');
   newRequest_ref.child(rideReqId).child('driverPhone').set(driversInfo.Phone);
   newRequest_ref.child(rideReqId).child('driverName').set(driversInfo.FirstName+' '+driversInfo.LastName);
   newRequest_ref.child(rideReqId).child('driverID').set(driversInfo.Key);
   newRequest_ref.child(rideReqId).child('carDetails').set('${driversInfo.carBrand} - ${driversInfo.carModel} - ${driversInfo.carColor}');

   Map locMap= {
     'latitude': currentPosition.latitude.toString(),
     'longitude' : currentPosition.longitude.toString()
   };
   newRequest_ref.child(rideReqId).child("driverLocation").set(locMap);

 }

}
