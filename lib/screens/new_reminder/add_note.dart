import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';


class AddNote extends StatelessWidget {
  const AddNote({
    Key key, this.onChange,
  }) : super(key: key);

  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note',
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width:15),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Icon(Icons.notes_outlined, color: hintColor, size: 26,),
            ),
            SizedBox(width:15),
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor
                ),
                maxLines: 5,
                onChanged: onChange,
                validator: (val) => null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Add a note',
                  hintStyle: Theme.of(context).textTheme.subtitle1
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}