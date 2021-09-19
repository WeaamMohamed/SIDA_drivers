


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_drivers_app/firebase_db.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';
import 'package:sida_drivers_app/shared/helpers/ride_details.dart';

class ReceiveRide extends StatelessWidget {

  final RideDetails rideDetails;

  ReceiveRide({this.rideDetails});
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.green,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(

                top: screenHeight*0.35,
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
                                    SizedBox(height: 0.01* screenHeight),
                                    Text('22.00',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    Text('EGP',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
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
                                Column(
                                    children: [
                                      SizedBox(height: 0.01* screenHeight),
                                      Text('4.00',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                      Text('KM',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
                                    ],
                                  ),

                                SizedBox(width: 0.03 * screenWidth),
                                SvgPicture.asset("assets/images/distance.svg",width: 45,height: 45),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.05* screenHeight),
                    Container(
                      width: screenWidth,
                      height: screenHeight*0.7,
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
                          SizedBox(height: 0.03* screenHeight),
                          Row(
                            children: [
                              SizedBox(width: 0.02 * screenWidth),
                              SvgPicture.asset('assets/images/PickupFlag.svg',width:30,height:30),
                              SizedBox(width: 0.03 * screenWidth),
                              Flexible(
                                  child: Text( rideDetails.pickup_address,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.0 ))
                              )
                            ],
                          ),
                          SizedBox(height: 0.03* screenHeight),

                          Row(
                            children: [
                              SizedBox(width: 0.02 * screenWidth),
                              SvgPicture.asset('assets/images/TargetFlag.svg',width: 30,height: 30,),
                              SizedBox(width: 0.03 * screenWidth),
                              Flexible(
                                child: Text(rideDetails.dropoff_address,
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

    rideRequestRef.once().then((DataSnapshot dataSnapShot){
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
          content: Text("Ride doesn't exist1."),
        ));
        print("ride doesn't exist1");
      }
      if(theRideId == rideDetails.ride_request_id)
      {
        rideRequestRef.set("accepted");
       // AssistantMethods.disableHomeTabLiveLocationUpdates();
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> NewRideScreen(rideDetails: rideDetails)));
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
}
