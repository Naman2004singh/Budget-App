import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';

class Totaloutput extends StatelessWidget {
  final deviceWidth;
  final text1;
  final text2;
  final text3;
  const Totaloutput({super.key, required this.deviceWidth, required this.text1, this.text2, required this.text3});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(25.0)),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      width: deviceWidth / 1.5,
      height: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poppins(
                text: "Budget left",
                size: 15,
                color: Colors.white,
              ),
              Poppins(
                text: "Total expense",
                size: 15,
                color: Colors.white,
              ),
              Poppins(
                text: "Total income",
                size: 15,
                color: Colors.white,
              )
            ],
          ),
          RotatedBox(
              quarterTurns: 1,
              child: Divider(
                indent: 40.0,
                endIndent: 40.0,
                color: Colors.grey,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poppins(
                text: text1,
                size: 15,
                color: Colors.white,
              ),
              Poppins(
                text: text2,
                size: 15,
                color: Colors.white,
              ),
              Poppins(
                text: text3,
                size: 15,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
