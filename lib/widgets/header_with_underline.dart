import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class HeaderWithUnderline extends StatelessWidget {
  const HeaderWithUnderline({
    Key key, @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: primaryColor
              )
            ),
          ),
          Positioned(
            bottom:0,
            right:0,
            left:0,
            child: Container(
              margin: EdgeInsets.only(right: 8),
              height: 5,
              width: double.infinity,
              color: primaryColor.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}