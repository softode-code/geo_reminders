import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrossButton extends StatelessWidget {
  const CrossButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: SvgPicture.asset('assets/cross.svg'),
        onPressed: ()=>Navigator.pop(context),
      ),
    );
  }
}