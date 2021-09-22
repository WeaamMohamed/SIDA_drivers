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
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newRideGoogleMapController;
  Set<Marker> markersSet = Set <Marker>();
  Set<Circle> circlesSet = Set <Circle>();
  Set<Polyline> polyLineSet = Set <Polyline>();
  List <LatLng> polylineCoordinates=[];
  PolylinePoints polylinePoints = PolylinePoints();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enabled = true;
  Color mColor = Colors.black;
  var geoLocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
  BitmapDescriptor animatingMarkerIcon;
  Position myPosition;
  void initState()
  {
    super.initState();
    acceptRideRequest();
  }
  void createIconMarker()
  {
    if(animatingMarkerIcon == null)
    {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(0.5, 0.5));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "assets/images/car_android.png")
          .then((value)
      {
        animatingMarkerIcon = value;
      });
    }
  }

  void getRideLiveLocationUpdates() {
    rideStreamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1).listen((Position position) {
      currentPosition = position;
      myPosition = position;
      LatLng mPosition = LatLng(position.latitude, position.longitude);
      Marker animatingMarker = Marker(
        markerId: MarkerId('animating'),
        position: mPosition,
        icon: animatingMarkerIcon,
        infoWindow: InfoWindow(title: 'Current Location'),
      );
      setState(() {
        CameraPosition cameraPosition = new CameraPosition(
            target: mPosition, zoom: 17);
        newRideGoogleMapController.animateCamera(
            CameraUpdate.newCameraPosition(cameraPosition));
        markersSet.removeWhere((marker) =>
        marker.markerId.value == "animating");
        markersSet.add(animatingMarker);
      });
    });
  }

  ///-----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    createIconMarker();
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
            "Online"  ,
              style: TextStyle(
                fontSize: 18,
                color: mColor,
              ),
            ),
          ),
          SizedBox(width: 10,),

          SizedBox(width: 15,),
        ],
      ),
      body: Container(
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
              initialCameraPosition:  NewRideScreen._kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: false,
              compassEnabled: false,
              onMapCreated: (GoogleMapController controller) async{

                _controllerGoogleMap.complete(controller);
                newRideGoogleMapController = controller;

                setState(() {
                  mapPaddingFromBottom= 265.0;
                });
                var currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
                var pickUpLatLng = widget.tripDetails.pickupLocation;

                await getPlaceDirection(currentLatLng, pickUpLatLng);
                getRideLiveLocationUpdates();
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

    );
  }


  Future<void> getPlaceDirection(LatLng pickUpLatLng, LatLng dropOffLatLng) async
  {

    print("helllllllllllllllllllo");
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
    newRideGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

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

    setState(()
    {
      print("yaraaaaaaaaaaaaaaaaaaaaaaaab");
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
