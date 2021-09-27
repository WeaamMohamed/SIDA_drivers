import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_webservice/directions.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:sida_drivers_app/helpers/helpermethods.dart';
import 'package:sida_drivers_app/screens/payment_success.dart';
import 'package:sida_drivers_app/shared/componenents/progressDialog.dart';
import 'package:sida_drivers_app/models/tripdetails.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';
import 'dart:async';
import 'package:date_time_format/date_time_format.dart';
import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';
import 'package:sida_drivers_app/widgets/cancel_trip_container.dart';
import 'package:sida_drivers_app/helpers/mapkit_helper.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:time_formatter/time_formatter.dart';
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
  String status = "accepted";
  String durationRide="";
  bool isRequestingDirection = false;
  String btnTitle="I've arrived";
  double Slider = 15;
  Timer timer;
  int durationCounter = 0;
  var StartTime;
  var EndTime;

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

    LatLng oldPos = LatLng(0, 0);
    rideStreamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1).listen((Position position) {
      currentPosition = position;
      myPosition = position;
      LatLng mPosition = LatLng(position.latitude, position.longitude);

      var rot = MapKitHelper.getMarkerRotation(oldPos.latitude, oldPos.longitude, myPosition.latitude, myPosition.latitude);

      Marker animatingMarker = Marker(
        markerId: MarkerId('animating'),
        position: mPosition,
        icon: animatingMarkerIcon,
        rotation: rot,
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
      oldPos = mPosition;
   //   updateRideDetails();

      String rideRequestId = widget.tripDetails.rideID;
      Map locMap =
      {
        "latitude": currentPosition.latitude.toString(),
        "longitude": currentPosition.longitude.toString(),
      };
      newRequest_ref.child(rideRequestId).child("driverLocation").set(locMap);
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
             '400' ,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
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
                  slideDistance: Slider,
                  context: context,
                  title: btnTitle,
                  circularBorder: true,
                  onTap: () async{
                    if(status == "accepted")
                      {
                        ///start time
                         StartTime = DateTime.now().hour.toString()+':'+ DateTime.now().minute.toString();
                         database.reference().child('rideRequests').child(widget.tripDetails.rideID).update({'waitingTime' : '0'});
                         widget.tripDetails.waitingTime= '0';
                         print("+______________________time________________________________________");
                        print(StartTime.toString());
                        status="arrived";
                        newRequest_ref.child(widget.tripDetails.rideID).child('status').set(status);
                        if (!mounted) return;
                        setState(() {
                          Slider= 270;
                          btnTitle="Start the trip ";
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => ProgressDialog(message: "Please wait...",)
                        );
                        await getPlaceDirection(widget.tripDetails.pickupLocation, widget.tripDetails.dropoffLocation);
                        Navigator.pop(context);
                      }
                    else if( status == "arrived" )
                    {
                      ///end time
                      EndTime = DateTime.now().hour.toString()+':'+ DateTime.now().minute.toString();
                      print("+______________________time________________________________________");
                      print(EndTime.toString());
                      WaittingTimeCaluclation();
                      status="onRide";
                      newRequest_ref.child(widget.tripDetails.rideID).child('status').set(status);
                      if (!mounted) return;
                      setState(() {
                        btnTitle="End the trip";
                        Slider= 15;
                      });
                      initTimer();
                    }
                    else if( status == "onRide" )
                      {
                        endTheTrip();
                      }
                  },
                ),
              ),
            ),
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
        color: Colors.blue,
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

   drivers_ref.child(currentUser.uid).child('History').child(rideReqId).set(true);

 }
  void updateRideDetails() async
  {
    if(isRequestingDirection == false)
    {
      isRequestingDirection = true;

      if(myPosition == null)
      {
        return;
      }

      var posLatLng = LatLng(myPosition.latitude, myPosition.longitude);
      LatLng destinationLatLng;

      if(status == "accepted")
      {

        destinationLatLng = widget.tripDetails.pickupLocation;
        print(destinationLatLng);
        print(posLatLng);
      }
      else
      {
        destinationLatLng = widget.tripDetails.dropoffLocation;
      }

      var directionDetails = await HelperMethods.obtainPlaceDirectionDetails(posLatLng, destinationLatLng);
      if(directionDetails != null)
      {
        setState(() {
          durationRide = directionDetails.durationText;
        });


      }

      isRequestingDirection = false;
    }
  }
  void initTimer()
  {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter = durationCounter + 1;
    });
  }
  endTheTrip() async
  {
    timer.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)=> ProgressDialog(message: "Please wait...",),
    );

    ///TODO: THIS LINE IS MY ADDITION AS myPosition SOMETIMES IS NULL !
    myPosition= currentPosition;
    var currentLatLng = LatLng(myPosition.latitude, myPosition.longitude);


    var directionalDetails = await HelperMethods.obtainPlaceDirectionDetails(widget.tripDetails.pickupLocation, currentLatLng);
    Navigator.pop(context);

    String rideRequestId = widget.tripDetails.rideID;
    int fareAmount = HelperMethods.calculateFares(directionalDetails,widget.tripDetails.rideType,
        widget.tripDetails.tripDistance,widget.tripDetails.tripTime,widget.tripDetails.waitingTime,rideRequestId);
    newRequest_ref.child(rideRequestId).child("fare").set(fareAmount.toString());
    newRequest_ref.child(rideRequestId).child("status").set("ended");
    rideStreamSubscription.cancel();
   saveEarnings(fareAmount.toDouble() *0.8);
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => PaymentSuccessScreen(  tripDetails: widget.tripDetails, fareAmount: fareAmount,)));
  }


  void saveEarnings(double fareAmount)
  {
    drivers_ref.child(currentUser.uid).child("earnings").once().then((DataSnapshot dataSnapShot) {
      if(dataSnapShot.value != null)
      {
        double oldEarnings = double.parse(dataSnapShot.value.toString());
        double totalEarnings = fareAmount + oldEarnings;

        drivers_ref.child(currentUser.uid).child("earnings").set(totalEarnings.toStringAsFixed(2));
      }
      else
      {
        double totalEarnings = fareAmount.toDouble();
        drivers_ref.child(currentUser.uid).child("earnings").set(totalEarnings.toStringAsFixed(2));
      }
    });
  }


  void WaittingTimeCaluclation()
  {
   // String startTime = formatTime(StartTime); // or if '24:00'
    //String end_time = formatTime( EndTime);// or if '12:00


    var format = DateFormat("HH:mm");
   var start = format.parse(StartTime);
    var end = format.parse(EndTime);

    if(start.isAfter(end))
    {
      print("++++++++++++++++++++++++++++++++++++++++++++");
      print('start is big');
      print('difference = ${start.difference(end)}');
    }
    else if(start.isBefore(end))
    {
      print("++++++++++++++++++++++++++++++++++++++++++++");
      database.reference().child('rideRequests').child(widget.tripDetails.rideID).update({'waitingTime' : end.difference(start).inMinutes.toString()});
      widget.tripDetails.waitingTime=  end.difference(start).inMinutes.toString();
      print('end is big');
      print('difference = ${end.difference(start)}');
    }
    else
      {
        print("++++++++++++++++++++++++++++++++++++++++++++");
      print('difference = ${end.difference(start)}');
    }

  }
}
