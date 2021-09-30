import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:sida_drivers_app/localization/localization_method.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/shared/componenents/my_components.dart';

class CancelDriverScreen extends StatefulWidget {
  @override
  _CancelDriverScreenState createState() => _CancelDriverScreenState();
}

class _CancelDriverScreenState extends State<CancelDriverScreen> {
  final double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAmberAppCar(context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          customContainerWithGradient(
            title: translate(context,'Please tell us the reason for the cancellation'),
          ),
          SizedBox(
            height: 10,
          ),
          _buildOptionColumn(),
        ],
      ),
    );
  }

  Widget _buildOptionItem({String text, Function onTap}) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Divider(
              thickness: 1.5,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
          ],
        ),
      );

  _buildOptionColumn() => Expanded(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //TODO: onTap(){}
              _buildOptionItem(
                  text: translate(context,'The trip was unintentionally accepted'), onTap: () {}),
              _buildOptionItem(
                  text: translate(context,'The pickup point is too far away'), onTap: () {}),
              _buildOptionItem(
                  text: translate(context,'The passenger asked for it'), onTap: () {}),
              _buildOptionItem(
                  text: translate(context,'The pickup point place is not safe'), onTap: () {}),
              _buildOptionItem(text: translate(context,'Others'), onTap: () {}),

            ],
          ),
        ),
      );
}
