import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colors/colors.dart';

Widget customHomeButton({
  @required context,
  String title,
  bool withIcon = true,
  Function onTap,
 // double borderRadius = 8,
  bool circularBorder = false,
  double slideDistance=15

}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(circularBorder? 25: 8) ,

      ),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [

              Center(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(circularBorder? 25: 8) ,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[customAmberColor1, customAmberColor2],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      title ?? "location",
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              if(withIcon) Container(


                padding: EdgeInsets.symmetric(horizontal: 33),
                margin: EdgeInsets.only(left: slideDistance),
                height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xff010039),
                    borderRadius:BorderRadius.circular(40) ,

                  ),
                 child: SvgPicture.asset("assets/images/fast_forward.svg"),
              ),

            ],
          ),
        ),
      ),
    );


Widget customBlackButton({
  String title = "Next",
  Function onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Text(title,
                style: TextStyle(
                  // fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );

Widget customTextFormField({
  String label,
  Function validator,
  TextEditingController textController,
  TextInputType textInputType,
  String hint,
  Color textColor = Colors.black,
}) =>
    TextFormField(

      controller: textController,
      keyboardType: textInputType,
//labelText:"label",

      decoration: InputDecoration(

        focusColor: customAmberColor2,


        //  contentPadding: EdgeInsets.symmetric(vertical: 15.0,),

        hintText: hint,
        errorStyle: TextStyle(
          fontSize: 13,
          color: Colors.red[700],
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Color(0xffA9ACB6),
          fontWeight: FontWeight.bold,
        ),
      ),
      cursorColor: Colors.black,
      style: TextStyle(
        color: textColor,
        fontSize: 15,
      ),
      validator: validator,
    );

Widget customEditImage({@required context,
  String imagePath = "assets/images/certificate.svg",
  Function onTap,
  Function myOnpressed,
  String myUrl
}) => GestureDetector(
  onTap: onTap,
  child:   Container(

    height: MediaQuery.of(context).size.height * 0.2 ,

    width: MediaQuery.of(context).size.width * 0.7,

    //  color: Colors.white,

    decoration: BoxDecoration(
     // borderRadius: BorderRadius.circular(15),


    ),

    child: Stack(

      children: [

        Positioned(

          top: 0,

          left: 0,

          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:  myUrl == null
                    ? AssetImage(imagePath,
                ):
                NetworkImage(myUrl),
                fit: BoxFit.cover,
              ),

             color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(15),

            ),



            height: MediaQuery.of(context).size.height * 0.2  - 15,

            width: MediaQuery.of(context).size.width * 0.7 - 20,

            //child: SvgPicture.asset(imagePath,),



          ),

        ),

        Positioned(

          bottom: 5,

          right: 0,

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

            child: IconButton(icon: Icon(Icons.edit, color: Colors.black,size:30), onPressed: myOnpressed),

          ),

        ),



      ],

    ),

    // child: SvgPicture.asset("assets/images/identity.svg",



    // fit: BoxFit.cover,

    // ),



  ),
);

Widget customAmberAppCar({@required context}) => AppBar(
  elevation: 0,
  backgroundColor: customAmberColor1,
  leading: InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Icon(Icons.arrow_back, color: Colors.black,
    ),
  ),
);
Widget customAppBar({String title, @required context})=>   AppBar(
  //  backgroundColor: Colors.red,

  centerTitle: true,
  title: Text(title,
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
    child: Icon(Icons.arrow_back, color: Colors.black,
    ),
  ),
);

Widget customContainerWithGradient({double height, String title,})=>
    Container(
 // height:  height,
  decoration: BoxDecoration(
    color: customAmberColor2,
    gradient: LinearGradient(
      colors: [customAmberColor1, customAmberColor2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,

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
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,
    vertical: 25,),
    child: Center(
      child: Text(title, style: TextStyle(
        height: 1.5,
        fontSize: 22,
        fontWeight: FontWeight.bold,

      ),

      ),
    ),
  ),
);
BorderRadius customBorderRadius = BorderRadius.circular(8);

void defaultToast({
  @required message,
  @required ToastState state,
}) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0);
}

enum ToastState { ERROR, SUCCESSFUL, WARNING }

Color changeToastColor(ToastState state) {
  switch (state) {
    case ToastState.ERROR:
      return Colors.red[400];
      break;
    case ToastState.SUCCESSFUL:
      return Colors.green;
      break;
    case ToastState.WARNING:
      return Colors.orange;
      break;
    default:
      return null;
  }
}