import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';

class Materialbutton extends StatelessWidget {
  final onpressFunction;
  final String buttontext;
  final textSize;
  final padding;
  const Materialbutton(
      {super.key,
      required this.onpressFunction,
      required this.buttontext,
      required this.textSize, this.padding});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressFunction,
      padding: padding,
      splashColor: Colors.grey,
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: OpenSans(
        text: buttontext,
        size: textSize,
        color: Colors.white,
      ),
    );
  }
}
