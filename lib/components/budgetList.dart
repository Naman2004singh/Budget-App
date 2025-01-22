import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';

class Budgetlist extends StatelessWidget {
  final String textHeading;
  final headingSize;
  final itemcountNumber;
  final budgetName;
  final budgetAmount;
  const Budgetlist(
      {super.key,
      required this.textHeading,
      required this.headingSize,
      required this.itemcountNumber,
      required this.budgetName,
      required this.budgetAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
      width: 200,
      height: 240.0,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          OpenSans(text: textHeading, size: headingSize),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 18.0,
          ),
          Container(
            width: 185.0,
            height: 210.0,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView.builder(
              itemCount: itemcountNumber,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Poppins(text: budgetName[index], size: 14.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Poppins(text: budgetAmount[index], size: 14.0),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
