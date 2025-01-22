import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSans extends StatelessWidget {
  final String text;
  final size;
  final color;
  final fontWeight;
  const OpenSans(
      {super.key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: size,
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

class Pacifico extends StatelessWidget {
  final String text;
  final size;
  final color;
  const Pacifico(
      {super.key, required this.text, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.pacifico(fontSize: size, color: color ?? Colors.black),
    );
  }
}

class Poppins extends StatelessWidget {
  final String text;
  final size;
  final color;
  final fontWeight;
  const Poppins({super.key, required this.text, required this.size, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.poppins(fontSize: size,
    fontWeight: fontWeight??FontWeight.normal,
    color: color?? Colors.black),
    );
  }
}
