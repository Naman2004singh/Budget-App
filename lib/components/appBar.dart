import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 30.0),
      backgroundColor: Colors.black,
    );
  }
}
