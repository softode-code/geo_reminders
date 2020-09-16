import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class BottomRightButton extends StatelessWidget {
  const BottomRightButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.iconData,
    this.disabled = false,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final IconData iconData;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -1,
      right: 0,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 30, 20),
          decoration: BoxDecoration(
            color: disabled ? disabledColor :primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
          ),
          child: Row(
            children: [
              Icon(iconData, color: Colors.white, size: 30.0,),
              SizedBox(width:10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}