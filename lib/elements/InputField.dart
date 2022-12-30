// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';

class InputWidget extends StatefulWidget {
  InputWidget(
      {Key? key, required this.text, required this.txt, required this.error})
      : super(key: key);

  String text;
  TextEditingController txt;
  bool error;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: widget.error ? Colors.transparent : appAccent1))),
        child: TextField(
          controller: widget.txt,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          style: GoogleFonts.poppins(
              color: appAccent2,
              fontWeight: FontWeight.bold,
              fontSize: 22),
          decoration: InputDecoration(
              hintText: widget.text,
              hintStyle: GoogleFonts.poppins(
                  color: appAccent2.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              errorText: widget.error ? "Check Input Bitch" : null,
              errorStyle: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ));
  }
}
