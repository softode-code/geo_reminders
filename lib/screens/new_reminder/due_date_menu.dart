import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class DueDateMenu extends StatelessWidget {

  List<String> menuTitles = [
    'Today',
    'Tomorrow',
    'Next Week',
    'Everyday',
    'Pick a date'
  ];

  List<Icon> menuIcons = [
    Icon(Icons.today_outlined),
    Icon(Icons.calendar_today_outlined),
    Icon(Icons.next_week_outlined),
    Icon(Icons.repeat_rounded),
    Icon(Icons.date_range_outlined)
  ];

  final int selectedIndex;

  DueDateMenu({Key key, this.selectedIndex}) : super(key: key);

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
      child: Theme(
        data: ThemeData(
          iconTheme: IconThemeData(
            color: hintColor,
            size: 26
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            menuTitles.length,
            (index) {
              return InkWell(
                onTap: ()=> print(menuTitles[index]),
                child: Container(
                  decoration: selectedIndex == index ? BoxDecoration(
                    color: primaryAccent,
                    borderRadius: BorderRadius.circular(4)
                  ): null,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      menuIcons[index],
                      SizedBox(width: 10),
                      Text(
                        menuTitles[index],
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
      ),
    );
  }
}