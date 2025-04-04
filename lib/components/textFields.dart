import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfields extends StatelessWidget {
  final TextInputType keyboardtype;
  final TextAlign textAlign;
  final Icon prefixIcon;
  final TextEditingController editingController;
  final String hintText;
  final bool isObstacle;
  final suffixIcon;
  const Textfields(
      {super.key,
      required this.keyboardtype,
      required this.textAlign,
      required this.editingController,
      required this.prefixIcon,
      required this.hintText,
      required this.isObstacle,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      textAlign: textAlign,
      obscureText: isObstacle,
      controller: editingController,
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 2.0)),
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: GoogleFonts.openSans()),
    );
  }
}
