import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors/colors.dart';

Widget customHomeButton({
  @required context,
  String title,
  bool withIcon = true,
  Function onTap,
 // double borderRadius = 8,
  bool circularBorder = false,

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
                margin: EdgeInsets.only(left: 15),
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
}) =>
    TextFormField(

      controller: textController,
      keyboardType: textInputType,
//labelText:"label",

      decoration: InputDecoration(

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
        fontSize: 15,
      ),
      validator: validator,
    );
// Widget customBlackButton({
//   String title = "Next",
//   Function onTap,
// }) =>
//     InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.black,
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//               onTap: () {},
//               child: Center(
//                 child: Text(title,
//                     style: TextStyle(
//                      // fontSize: 13,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     )),
//               )),
//         ),
//       ),
//     );
//
// Widget customTextFormField({
//   String label,
//   Function validator,
//   TextEditingController textController,
//   TextInputType textInputType,
// }) =>
//     TextFormField(
//       controller: textController,
//       keyboardType: textInputType,
// //labelText:"label",
//
//       decoration: InputDecoration(
//
//       //  contentPadding: EdgeInsets.symmetric(vertical: 15.0,),
//
//
//         errorStyle: TextStyle(
//           fontSize: 13,
//           color: Colors.red[700],
//         ),
//         labelText: label,
//         labelStyle: TextStyle(
//           fontSize: 13,
//           color: Color(0xffA9ACB6),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       cursorColor: Colors.black,
//       style: TextStyle(
//         fontSize: 15,
//       ),
//       validator: validator,
//     );

Widget customEditImage({@required context,
  String imagePath = "assets/images/certificate.svg",
  Function onTap,
}) => GestureDetector(
  onTap: onTap,
  child:   Container(

    height: MediaQuery.of(context).size.height * 0.2 ,

    width: MediaQuery.of(context).size.width * 0.7,

    //  color: Colors.white,

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(15),

    ),

    child: Stack(

      children: [

        Positioned(

          top: 0,

          left: 0,

          child: Container(



            decoration: BoxDecoration(

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

            child: Icon(Icons.edit, color: Colors.black,

              size: 30,),

          ),

        ),



      ],

    ),

    // child: SvgPicture.asset("assets/images/identity.svg",



    // fit: BoxFit.cover,

    // ),



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
BorderRadius customBorderRadius = BorderRadius.circular(8);