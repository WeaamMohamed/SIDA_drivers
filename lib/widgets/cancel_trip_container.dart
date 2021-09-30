import 'package:flutter/material.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';

class CancelTripContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15,),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),

          ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            //offset: Offset(0, 3), // changes position of shadow
          ),
        ],),
      child: Column(
        children: [
          Text(
            (translate(context,'Would you like to cancel this trip?')),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15,),
        _buildCancelButton(context: context,onTap: (){},),
          SizedBox(height: 10,),
          _buildBackButton(context: context,onTap: (){},),
        ],
      ),
    );
  }

  _buildCancelButton({@required context,Function onTap})=>  Container(
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.red.shade500,
    ),
    width: MediaQuery.of(context).size.width * 0.6,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
          translate(context,'Cancel'),
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
  _buildBackButton({@required context,Function onTap})=>  Container(
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      //color: Color(0xffF0EEF1),
      color: Colors.grey.shade300,
    ),
    width: MediaQuery.of(context).size.width * 0.6,

    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
          translate(context,'Back'),
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}
