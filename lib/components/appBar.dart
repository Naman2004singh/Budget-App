import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  final title;
  const MyAppbar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 30.0),
      backgroundColor: Colors.black,
      centerTitle: true,
      title: title,
      actions: [
        IconButton(onPressed: () async{
          ///reset function
        },
         icon: Icon(Icons.refresh))
      ],
    );
  }
}
