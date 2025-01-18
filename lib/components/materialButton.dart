import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';

class Materialbutton extends StatelessWidget {
  final onpressFunction;
  final String buttontext;
  final textSize;
  const Materialbutton({super.key, required this.onpressFunction, required this.buttontext, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressFunction,
      splashColor: Colors.grey,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),
        child: OpenSans(text: buttontext, size: textSize,color: Colors.white,),
      );
  }
}