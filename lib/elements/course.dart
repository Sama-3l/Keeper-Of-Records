// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseContainer extends StatefulWidget {
  const CourseContainer({Key? key}) : super(key: key);

  @override
  State<CourseContainer> createState() => _CourseContainerState();
}

class _CourseContainerState extends State<CourseContainer> {
  final bool checkAttendance = true;

  int count = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 377,
      decoration: BoxDecoration(
          border: Border.all(color: checkAttendance ? safe : danger),
          borderRadius: BorderRadius.all(Radius.circular(60))),
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(left: 20),
            child: CountContainer(count: count))
      ]),
    );
  }
}

class CountContainer extends StatelessWidget {
  const CountContainer({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 39,
      decoration: BoxDecoration(
          color: appAccent1,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Text("$count",
              style: GoogleFonts.poppins(
                  color: appBackground,
                  fontWeight: FontWeight.w700,
                  fontSize: 18))),
    );
  }
}
