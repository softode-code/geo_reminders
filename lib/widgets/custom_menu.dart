import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class CustomMenu extends StatefulWidget {

  final List<String> menuTitles;

  final List<IconData> menuIcons;



  final List<Function> onPressed;

  CustomMenu({Key key, this.menuTitles, this.menuIcons, this.onPressed}) : super(key: key);

  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(2,4),
          blurRadius: 15
        )],
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.menuTitles.length,
          (index) {
            return InkWell(
              onTap: widget.onPressed[index],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.menuIcons[index],
                      size: 26,
                      color:hintColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.menuTitles[index],
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}