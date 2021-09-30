// import 'package:driver_demo_app/colors.dart';
// import 'package:driver_demo_app/my_components.dart';
// import 'package:driver_demo_app/widgets/home_drawer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:rolling_switch/rolling_switch.dart';
//
//
// class OfflineHome extends StatefulWidget {
//
//   @override
//   _OfflineHomeState createState() => _OfflineHomeState();
// }
//
// class _OfflineHomeState extends State<OfflineHome> {
//
//
//   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool _enabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//     final double appBarHeight = AppBar().preferredSize.height;
//
//
//     return Scaffold(
//
//       key: scaffoldKey,
//       drawer: HomeDrawer(),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//              begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: <Color>[Color(0xff2C2B69), Color(0xff121212)],
//           )
//         ),
//         padding: EdgeInsets.only(top: appBarHeight/2 + statusBarHeight,
//         left: 15, right: 15,
//           bottom: 20,
//         ),
//         child: Column(
//           children: [
//             Row(
//          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//
//                 GestureDetector(
//                   onTap: (){
//                     scaffoldKey.currentState.openDrawer();
//                   },
//                   child: SvgPicture.asset("assets/images/menu_iconn.svg"),),
//                 Spacer(),
//                 Text(
//                  _enabled? translate(context,'Online') : translate(context,'Offline'),
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 CupertinoSwitch(
//                   value: _enabled,
//                   activeColor: amberSwitchButton,
//                   trackColor: Colors.white70,
//                   onChanged: (value) {
//                     setState(() {
//                       _enabled = value;
//                     });
//                     print("current value : " + _enabled.toString());
//                   },
//                 ),
//               ],
//             ),
//             Spacer(),
//
//             Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               child: Text(translate(context,'You are currently not accepting orders. Please turn on the toggle button above to start receiving orders.'),
//               style: TextStyle(fontSize: 17,
//               color: Colors.white60),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Spacer(),
//             customHomeButton(
//               context: context,
//               title: translate(context,'Update Driver Information'),
//               onTap: (){},
//             ),
//
//
//           ],
//           //#2C2B69
//           //#121212
//
//         ),
//       ),
//
//     );
//   }
//
//   @override
//   void initState() {
//
//     // TODO: implement initState
//     //to hide app bar and status bar
//     // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
//           statusBarIconBrightness: Brightness.light,
//         ));
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIOverlays(
//         [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//
//     super.dispose();
//
//   }
//
// }
