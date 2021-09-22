import 'package:flutter/material.dart';

import '../shared/componenents/my_components.dart';

class DriverInfo extends StatefulWidget {

  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:  AppBar(
        //  backgroundColor: Colors.red,


        centerTitle: true,

        title: Text("Driver Information",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black,),),


      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height -  MediaQuery.of(context).padding.top ,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  mainAxisSize: MainAxisSize.max,

              children: [


                Container(
                  height: MediaQuery.of(context).size.height * 0.55,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Container(
                        //  color: Colors.grey.shade400,
                        height: MediaQuery.of(context).size.height * 0.15,

                        child: Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/profile_pic.jpg",
                                ),
                                minRadius: 43,
                                maxRadius: 43,
                              ),


                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.5,
                              top: MediaQuery.of(context).size.height * 0.085,

                              child: Container(

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: Offset(2,7),
                                    )]
                                ),

                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.edit, color: Colors.black,),
                              ),
                            )
                          ],
                        ),
                      ),

                      customTextFormField(
                        label: "Name (Registered)",
                        textController: nameController,
                        validator:  (value) {
                          if (value.isEmpty) {
                            return 'name must not be empty.';
                          }
                          return null;
                        },

                        textInputType: TextInputType.name,

                      ),

                      customTextFormField(
                        label: "Gender",
                        textController: genderController,
                        validator:  (value) {
                          if (value.isEmpty) {
                            return 'gender must not be empty.';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,

                      ),
                      customTextFormField(
                        label: "Age",
                        textController: ageController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Phone number must not be empty.';
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,

                      ),



                    ],
                  ),
                ),

                Spacer(),

                customBlackButton(
                    onTap: (){

                      if(formKey.currentState.validate())
                      {
                        print("updated.");

                      }

                    }),







              ],),),
        ),
      ) ,);
  }
}
