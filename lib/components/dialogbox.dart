import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';

DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(text: title, size: 20.0),
      actions: [
        MaterialButton(onPressed: () => Navigator.pop(context),
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: OpenSans(text: "OKAY", size: 20.0, color: Colors.white,),)
      ],
    ),
  );
}
