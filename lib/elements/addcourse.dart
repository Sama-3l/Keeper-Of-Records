// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({Key? key}) : super(key: key);

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Icon(Icons.arrow_back_ios, color: appAccent1, size: 39)),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appBackground),
      body: Stack(children: [
        Align(
            alignment: Alignment(-0.6, -0.85),
            child: SizedBox(
              height: 50,
              width: 300,
              child: Text(
                "Course Stats",
                style: GoogleFonts.poppins(
                    color: appAccent1,
                    fontWeight: FontWeight.w600,
                    fontSize: 29),
              ),
            )),
        Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 500,
              width: 350,
              decoration: BoxDecoration(
                  color: appAccent1,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Column(children: [
                TextField(),
                TextField(),
              ]),
            )
          ],
        ))
      ]),
    );
  }
}
