import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  final  void Function()? onpress;
  final title;
  const MyAppbar({super.key, this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 30.0),
      backgroundColor: Colors.black,
      centerTitle: true,
      title: title,
      actions: [
        IconButton(onPressed: onpress,
         icon: Icon(Icons.refresh))
      ],
    );
  }
}
