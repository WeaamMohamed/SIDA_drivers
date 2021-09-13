
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_drivers_app/widgets/home_drawer.dart';

import '../shared/colors/colors.dart';
import '../shared/componenents/my_components.dart';

class HomeScreen extends StatefulWidget {
  final String userID;
  HomeScreen(  this.userID,{Key key}):super(key: key);
  @override
  _HomeScreenState createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enabled = false;
  Color mColor = Colors.white;

  @override
  Widget build(BuildContext context) {
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
                value?  mColor = Colors.black:  mColor = Colors.white;
                // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                //   statusBarIconBrightness: value? Brightness.light: Brightness.dark ,
                // ));

              });
              print("current value : " + _enabled.toString());
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

  @override
  void initState() {

    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.light,
        ));
    super.initState();
  }



  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }
}
