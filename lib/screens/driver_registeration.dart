import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/componenents/my_components.dart';

class DriverRegistration extends StatefulWidget {

  @override
  _DriverRegistrationState createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {

  double horizontalPadding = 15;
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      //  appBarHeight/2 + statusBarHeight

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:  Icon(Icons.arrow_back_outlined, color: Colors.black,),
      ),
      body:
     _buildRegistrationCheckList(statusBarHeight: statusBarHeight,
     appBarHeight: appBarHeight),

//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment:CrossAxisAlignment.start,
//           children: [
//             //
//             // InkWell(
//             //     onTap: (){
//             //   Navigator.pop(context);
//             //     },
//             // child: Padding(
//             //   padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
//             //   child: Icon(Icons.arrow_back_outlined, color: Colors.black,),
//             // ),),
//
//           SingleChildScrollView(child: _buildRegistrationCheckList()),
//
//             //  Spacer(),
//
//
//
//           ],
//         ),


    );
  }


  @override
  void initState() {

    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }

  Widget _buildRegistrationCheckItem({
  String title,
    String iconName,
    Function onTap,

})=> Column(
children: [InkWell(
  onTap: onTap,
  child:   Container(

    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 25),
    child: Row(
    children: [
      SvgPicture.asset("assets/images/$iconName.svg"),
       SizedBox(width: 10,),
       Text( title),
      Spacer(),
      Icon(Icons.arrow_forward_ios, color: Color(0xff5C6C7C),),


    ],



    ),

  ),
),

_divider()],
);


  Widget _buildRegistrationCheckList({statusBarHeight,
  appBarHeight})=> Container(

     height: MediaQuery.of(context).size.height - (statusBarHeight + appBarHeight),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

          children:
          [
            // SizedBox(height: 20,),


                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text("Driver Registration", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text("Complete the information below", style: TextStyle(
                    fontSize: 12,
                  ),),
                ),
                SizedBox(height: 40,),
                _divider(),
                SizedBox(
                  child: _buildRegistrationCheckItem(
                    title: "Driver information",
                    iconName: "check_icon",
                    onTap: (){
                      print("clicked");
                    },
                  ),
                ),
                _buildRegistrationCheckItem(
                  title: "Vehicle information",
                  iconName: "warning",
                  onTap: (){},
                ),
                _buildRegistrationCheckItem(
                  title: "Vehicle registration certificate",
                  iconName: "warning",
                  onTap: (){},
                ),
                _buildRegistrationCheckItem(
                  title: "Driver license",
                  iconName: "warning",
                  onTap: (){},
                ),
                _buildRegistrationCheckItem(
                  title: "Criminal Records/Taxi Application File",
                  iconName: "warning",
                  onTap: (){},
                ),
                _buildRegistrationCheckItem(
                  title: "Identity confirmation",
                  iconName: "warning",
                  onTap: (){},
                ),


              

              SizedBox(height: 40,),





  // _buildRegistrationCheckItem(
  // title: "Vehicle registration certificate",
  // iconName: "warning",
  // onTap: (){},
  // ),
  // _buildRegistrationCheckItem(
  // title: "Driver license",
  // iconName: "warning",
  // onTap: (){},
  // ),
  // _buildRegistrationCheckItem(
  // title: "Criminal Records/Taxi Application File",
  // iconName: "warning",
  // onTap: (){},
  // ),
  // _buildRegistrationCheckItem(
  // title: "Identity confirmation",
  // iconName: "warning",
  // onTap: (){},
  // ),


   // Spacer(),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: customBlackButton(
                  title: "Submit",onTap: (){}),
            ),




          ],


      ),
    ),
  );
  Widget _divider() => Divider(height: 1,
    thickness: 1,
    color: Color(0xffC2C9D9),);

}

