import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

class OutlineInputFieldWithTitle extends StatelessWidget {
  const OutlineInputFieldWithTitle({
    Key key,
    @required this.validator,
    @required this.onChanged,
    @required this.title,
    @required this.hint,
  }) : super(key: key);

  final Function validator;
  final Function onChanged;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6
        ),
        SizedBox(height:10),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          maxLines: 1,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: hintColor,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1
              )
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: hintColor,
                width: 1
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 1
              ),
              borderRadius: BorderRadius.circular(4)
            )
          ),
        )
      ],
    );
  }
}