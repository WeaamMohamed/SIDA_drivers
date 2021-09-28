import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sida_drivers_app/shared/network/local/cache_helper.dart';
import 'package:sida_drivers_app/shared/componenents/constants.dart';
import 'package:sida_drivers_app/sign_up_in/phone_number_page.dart';
import '../globalvariables.dart';
import '../shared/colors/colors.dart';


class HomeDrawer extends StatefulWidget {

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  String _url='';
  String name='';
  String rating='0.0';
  @override
  void initState() {
    super.initState();
    loadImage();
    getData();

  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: Column(
          children: [

            Container(
              height: MediaQuery.of(context).size.height * 0.22,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [customAmberColor1, customAmberColor2],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                    //offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                //  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    backgroundImage: _url == null ?  AssetImage("assets/images/profile_pic.jpg",
                    ):
                    NetworkImage(_url),
                    minRadius: 43,
                    maxRadius: 43,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 5,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(name, style: TextStyle(
                            fontSize: 21,
                          ),),
                          SizedBox(height: 10,),

                          Row(
                            // mainAxisAlignment: MainAxisAlignment.s,
                            children: [
                              Text(rating, style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),),
                              SizedBox(width: 4,),
                              Icon(Icons.star, size: 18, color: Colors.black.withOpacity(0.5),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ),

            SizedBox(height: 20,),
            Container(

              height: MediaQuery.of(context).size.height * 0.14,

              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [customAmberColor1, customAmberColor2],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                    //offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Row(
                    children: [
                      Text("Balance", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      Spacer(),
                      Text("400.00", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      Text("EGP")
                    ],
                  ),
                  Row(
                    children: [
                      Text("Your Profit", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5),

                      ),),
                      Spacer(),
                      Text("300.00", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),

                    ],
                  ),
                  Row(
                    children: [
                      Text("Commission", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5),

                      ),),
                      Spacer(),
                      Text("-100.00", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),

                ],
              ),



            ),
            SizedBox(height: 10,),


            _buildDrawerItem(
                title: "Job History",
                imagePath: "assets/images/document.svg",
                onTap: (){}),

            _buildDrawerItem(
                title: "Inbox",
                imagePath: "assets/images/mail_inbox_app.svg",
                onTap: (){}),

            _buildDrawerItem(
              title: "Help Center",
              imagePath: "assets/images/call-center-agent.svg",
              onTap: (){},
            ),

            _buildDrawerItem(
              title: "Sign Out",
              imagePath: "assets/images/log_out_icon.svg",
              onTap:  () async{
                //TODO: sign out

                await FirebaseAuth.instance.signOut().then((value) {
                  print("singed out successfully");
                  CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: false);
                }).onError((error, stackTrace){
                  print(error.toString());
                }).catchError((error)=> print(error.toString()));

                //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)

                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => PhoneNumberPage(),
                  ),
                      (route) => false,//if you want to disable back feature set to false
                );

              },),



          ],
        )
    );
  }
  void loadImage() async {

    String myUrl='';
    try {
      await drivers_ref.child( currentUser.uid).child('Photos').child('ProfilePhoto').once().then((DataSnapshot snapshot) async {

        setState(() {
          myUrl = snapshot.value['URL'];
        });
      });
    }
    catch(e)
    { print("you got error: $e");
    _url=null;
    return;
    }

    setState(() {
      _url=myUrl;
      print(_url);
      // imageFile = File(path);
    });
  }
  void getData() async
  {
    //TODO:GET BALANCE,PROFIT....
    try {
      await drivers_ref.child( currentUser.uid).once().then((DataSnapshot snapshot) async {
        setState(() {
          name = snapshot.value['FirstName'] +' '+snapshot.value['LastName'];
        if (snapshot.value['ratings'] != null)
          rating= snapshot.value['ratings'];
        });
      });
    }
    catch(e)
    { print("you got error: $e");}

  }
}



Widget _buildDrawerItem({
  String imagePath,
  String title,
  Function onTap,

}) =>   Column(

  children: [

    InkWell(
      onTap: onTap,
      child: Row(

        children: [

          Container(

            width: 30,

            height: 30,

            margin: EdgeInsets.only(

                left: 10, top: 20, bottom: 15,

                right: 20

            ),

            // child: Icon(Icons.mark_as_unread,),

            child: SvgPicture.asset(imagePath),

          ),

          Text(title,

            style: TextStyle(fontSize: 15),),

        ],



      ),
    ),



    Container(

      //  width: 30,

      padding: EdgeInsets.only(left: 60),

      child: Divider(

        thickness: 2,

        color: Color(0xffE5E5E5),

      ),

    )

  ],

);