import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0),
          //Scaffold inside another scaffold because needed that extra padding from top
          //and with single scaffold there was sommething weird when the notification panel was pulled down
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                controller: _controller,
                tabs: [
                  Tab(text: 'Reminders',),
                  Tab(text: 'Locations',),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(right:10, left: -10, top: -10),
                labelColor: primaryColor,
                unselectedLabelColor: Color(0xFFB0B0B0),
                labelStyle: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24.0
                ),
                indicatorColor: primaryColor.withOpacity(0.5),
                indicatorWeight: 5,
                labelPadding: EdgeInsets.only(top:10)
              ),
              body: TabBarView(
                controller: _controller,
                children: [
                  Center(child: Text('Reminders')),
                  Center(child: Text('Locations')),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}