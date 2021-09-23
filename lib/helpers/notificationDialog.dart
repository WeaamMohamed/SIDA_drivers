import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_drivers_app/screens/going_to_pickup_location.dart';
import 'package:sida_drivers_app/globalvariables.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';
import 'package:sida_drivers_app/models/tripdetails.dart';
import 'package:sida_drivers_app/shared/componenents/progressDialog.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';
import 'package:sida_drivers_app/helpers/helpermethods.dart';
import 'mapkit_helper.dart';

class ReceiveRide extends StatefulWidget {

  final TripDetails tripDetails;

  ReceiveRide({this.tripDetails});
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<ReceiveRide> createState() => _ReceiveRideState();
}

class _ReceiveRideState extends State<ReceiveRide> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newRideGoogleMapController;
  Set<Marker> markersSet = Set <Marker>();
  Set<Circle> circlesSet = Set <Circle>();
  Set<Polyline> polyLineSet = Set <Polyline>();
  List <LatLng> polylineCoordinates=[];
  PolylinePoints polylinePoints = PolylinePoints();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Position myPosition;
  String status = "accepted";
  String durationRide="";
  String distanceRide='';
  String durationRide2="";
  String distanceRide2='';
  bool isRequestingDirection = false;
  int fareAmount=0;


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
       // icon: animatingMarkerIcon,
        rotation: rot,
        infoWindow: InfoWindow(title: 'Current Location'),
      );
      ///TODO: MOUNTED??
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
      updateRideDetails();

      String rideRequestId = widget.tripDetails.rideID;
      Map locMap =
      {
        "latitude": currentPosition.latitude.toString(),
        "longitude": currentPosition.longitude.toString(),
      };
      newRequest_ref.child(rideRequestId).child("driverLocation").set(locMap);
    });
  }

  @override
  Widget build(BuildContext context) {

    Size mqSize = MediaQuery.of(context).size;
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: HomeDrawer(),
      key: scaffoldKey,
      appBar:  AppBar(
        brightness:  Brightness.light,
        automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
        backgroundColor:  Colors.white ,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              scaffoldKey.currentState.openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SvgPicture.asset("assets/images/menu_iconn.svg",
                color: Colors.black,),
            ),),
          Spacer(),
          Center(
            child: Text(
               "Online"  ,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 10,),

          SizedBox(width: 15,),
        ],
      ),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
            children: [
              GoogleMap(
                padding: EdgeInsets.only(
                  bottom: mqSize.height / 4 ,
                  top: 10.0,
                ),
                markers: markersSet,
                circles: circlesSet,
                polylines: polyLineSet,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition:  ReceiveRide._kGooglePlex,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: false,
                onMapCreated: (GoogleMapController controller) async{

                  _controllerGoogleMap.complete(controller);
                  newRideGoogleMapController = controller;
                  var currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
                  var pickUpLatLng = widget.tripDetails.pickupLocation;
                  getRideLiveLocationUpdates();
                },
              ),
                Positioned(
                       left:0,
                    top: screenHeight*0.2,
                    child:
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 0.35*screenWidth,
                              height: 0.09* screenHeight,
                              decoration:BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color:Colors.white ),
                                borderRadius: BorderRadius.all(Radius.circular(60)),

                              ),

                              child: Row(
                                children: [
                                  SizedBox(width: 0.03 * screenWidth),
                                  SvgPicture.asset("assets/images/dollar.svg",width: 40,height: 40),
                                  SizedBox(width: 0.03 * screenWidth),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [

                                        Text(fareAmount.toString(),
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                        Text('EGP',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: .19 * screenWidth,),
                            Container(
                              width: 0.35*screenWidth,
                              height: 0.09* screenHeight,

                              decoration:BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color:Colors.white ),
                                borderRadius: BorderRadius.all(Radius.circular(60)),

                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 0.04 * screenWidth),
                                        Flexible(
                                          child: Text(distanceRide2,
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                        ),
                                    SizedBox(width: 0.03 * screenWidth),
                                    SvgPicture.asset("assets/images/travel_between_two_points.svg",width: 45,height: 45),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.05* screenHeight),
                        Container(
                          width: screenWidth,
                          height: screenHeight*0.56,
                          decoration:BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color:Colors.white ),
                            borderRadius: BorderRadius.only(topRight:(Radius.circular(30)),
                                topLeft: (Radius.circular(30)
                                )
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:   Text("about " +distanceRide+" ("+durationRide+")" ,style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0 )),

                                ),
                              ),
                              SizedBox(height: 0.03* screenHeight),
                              Row(
                                children: [
                                  SizedBox(width: 0.02 * screenWidth),
                                  SvgPicture.asset('assets/images/pickup_flag.svg',width:30,height:30),
                                  SizedBox(width: 0.03 * screenWidth),
                                  Flexible(
                                      child: Text( widget.tripDetails.pickupAddress,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 16.0 ))
                                  )
                                ],
                              ),
                              SizedBox(height: 0.03* screenHeight),

                              Row(
                                children: [
                                  SizedBox(width: 0.02 * screenWidth),
                                  //SvgPicture.asset('assets/images/TargetFlag.svg',width: 30,height: 30,),
                                  SizedBox(width: 0.03 * screenWidth),
                                  Flexible(
                                    child: Text(widget.tripDetails.dropoffAddress,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16.0 )),
                                  )
                                ],
                              ),
                              SizedBox(height: 0.03* screenHeight),
                              SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
                              SizedBox(height: 0.03* screenHeight),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Car Type',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 0.04* screenHeight),
                                        Text('Customer name',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 0.04* screenHeight),
                                        Text('Note',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 0.04* screenHeight),

                                      ],
                                    ),
                                    SizedBox(width: 0.3* screenWidth),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('AnySIDA',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0,fontWeight: FontWeight.bold )),
                                        SizedBox(height: 0.04* screenHeight),
                                        //Text(tripDetails.riderName,
                                        Text("Mohamed",
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0,fontWeight: FontWeight.bold )),
                                        SizedBox(height: 0.04* screenHeight),
                                        Text('Turn on AC',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0,fontWeight: FontWeight.bold )),

                                      ],
                                    )

                                  ],
                                ),
                              ),

                              customHomeButton(
                                context: context,
                                title: "Accept",
                                withIcon: false,
                                onTap: (){
                                  ///TODO:SOUND DOESN'T STOP!
                                  assetsAudioPlayer.stop();
                                  checkAvailabilityOfRide(context);

                                },
                              ),
                            ],
                          ),
                        )

                      ],
                    )
                ),

            ],
          ),
      ),
    );
  }

  void checkAvailabilityOfRide(context)
  {

    rideRef.once().then((DataSnapshot dataSnapShot){
      Navigator.pop(context);
      String theRideId = "";
      if(dataSnapShot.value != null)
      {
        theRideId = dataSnapShot.value.toString();
        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        print(theRideId);
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //content: Text("Ride doesn't exist."),
          content: Text("Ride doesn't exist1."),
        ));
      }
      if(theRideId == widget.tripDetails.rideID)
      {
        rideRef.set("accepted");
        HelperMethods.disableHomeLiveLocationUpdates();
       Navigator.push(context, MaterialPageRoute(builder: (context)=> NewRideScreen(tripDetails: widget.tripDetails)));
      }
      else if(theRideId == "cancelled")
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ride has been Cancelled."),
        ));
        print("ride doesn't exist222");

      }
      else if(theRideId == "timeout")
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ride has time out."),
        ));
        print("ride doesn't exist333");
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ride doesn't exist."),
        ));
        print("ride doesn't exist4");
      }
    });
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
        print("*********************accepted************************");

        destinationLatLng = widget.tripDetails.pickupLocation;
        print(destinationLatLng);
        print(posLatLng);
      }
      else
      {
        destinationLatLng = widget.tripDetails.dropoffLocation;
      }

      /// from driver location => pickup
      var directionDetails = await HelperMethods.obtainPlaceDirectionDetails(posLatLng, destinationLatLng);
      print("*********************************************");
      print(directionDetails);

      if(directionDetails != null)
      {
        setState(() {
          print("*********************************************");
          print(durationRide);
          durationRide = directionDetails.durationText;
          distanceRide = directionDetails.distanceText;
        });
      }
      /// from pickup=> dropOff
      var directionalDetails2 = await HelperMethods.obtainPlaceDirectionDetails(widget.tripDetails.pickupLocation, widget.tripDetails.dropoffLocation);
      if(directionalDetails2 != null)
      {
        setState(() {
          print("*********************************************");
          fareAmount = HelperMethods.calculateFares(directionalDetails2);
          print(durationRide);
          durationRide2 = directionalDetails2.durationText;
          distanceRide2 = directionalDetails2.distanceText;
        });
      }

      isRequestingDirection = false;
    }
  }
}
