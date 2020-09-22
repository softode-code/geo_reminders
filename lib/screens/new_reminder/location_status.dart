import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class LocationStatus extends StatelessWidget {
  LocationStatus({
    Key key,
    @required int locationStatus, this.entering, this.at, this.leaving,
  }) : locationStatus = locationStatus, super(key: key);

  final int locationStatus;
  final Function entering;
  final Function at;
  final Function leaving;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: entering,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 1 ? BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(4), bottomLeft:Radius.circular(4))
                  ) : null ) : null,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Entering',
                    style: locationStatus != null ? ( 
                      locationStatus == 1 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 25,
                color: Colors.black.withOpacity(0.1),

              ),
              InkWell(
                onTap: at,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 2 ? BoxDecoration(
                      color: primaryLight,
                    ) : null ) : null,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'At',
                    style: locationStatus != null ? ( 
                      locationStatus == 2 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              ),
               Container(
                width: 1,
                height: 25,
                color: Colors.black.withOpacity(0.1),
                
              ),
              InkWell(
                onTap:leaving,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 3 ? BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(4), bottomRight:Radius.circular(4))
                    ) : null ) : null,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Leaving',
                    style: locationStatus != null ? ( 
                      locationStatus == 3 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              )
            ],
          )
        )
      ],
    );
  }
}