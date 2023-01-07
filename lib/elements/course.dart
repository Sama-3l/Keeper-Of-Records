// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keeperofrecords/elements/mainPageCourseList.dart';

class CourseContainer extends StatefulWidget {
  const CourseContainer(
      {Key? key,
      required this.count,
      required this.courseName,
      required this.index})
      : super(key: key);

  final int count;
  final String courseName;
  final int index;

  @override
  State<CourseContainer> createState() => _CourseContainerState();
}

class _CourseContainerState extends State<CourseContainer> {
  final bool checkAttendance = true;

  double scale = 0.3;
  User? user;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 377 / 84,
        child: Container(
          // height: 84,
          // width: 377,
          decoration: BoxDecoration(
              border: Border.all(color: checkAttendance ? safe : danger),
              borderRadius: BorderRadius.all(Radius.circular(60))),
          child: Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CountContainer(count: widget.count)),
            Center(
                child: SizedBox(
                    height: 40,
                    width: 190,
                    child: Center(
                        child: Text(widget.courseName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: appAccent2,
                                fontWeight: FontWeight.bold,
                                fontSize: 15))))),
            Center(
                child: SizedBox(
                    height: 80 * scale,
                    width: 80 * scale,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          user = FirebaseAuth.instance.currentUser!;
                          FirebaseFirestore.instance
                              .collection('Users')
                              .get()
                              .then((QuerySnapshot snapShot) {
                            for (var doc in snapShot.docs) {
                              if (doc.id == user?.displayName) {
                                setState(() {
                                  var currentCourse = doc['courses'];
                                  currentCourse[widget.index]['absentCount'] =
                                      doc['courses'][widget.index]
                                              ['absentCount'] +
                                          1;

                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(user?.displayName)
                                      .update({"courses": currentCourse});
                                });
                              }
                            }
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: appAccent1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80 * scale))),
                      child: Icon(Icons.add,
                          size: 39 * scale, color: appBackground),
                    ))),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Center(
                    child: SizedBox(
                        height: 80 * scale,
                        width: 80 * scale,
                        child: ElevatedButton(
                          onPressed: () {
                            user = FirebaseAuth.instance.currentUser!;
                            FirebaseFirestore.instance
                                .collection('Users')
                                .get()
                                .then((QuerySnapshot snapShot) {
                              for (var doc in snapShot.docs) {
                                if (doc.id == user?.displayName) {
                                  setState(() {
                                    var currentCourse = doc['courses'];
                                    currentCourse[widget.index]['absentCount'] =
                                        doc['courses'][widget.index]
                                                ['absentCount'] -
                                            1;
                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(user?.displayName)
                                        .update({"courses": currentCourse});
                                  });
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor: appAccent2,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(80 * scale))),
                          child: Icon(Icons.remove,
                              size: 39 * scale, color: appBackground),
                        ))))
          ]),
        ));
  }
}

class CountContainer extends StatefulWidget {
  const CountContainer({super.key, required this.count});

  final int count;

  @override
  State<CountContainer> createState() => _CountContainerState();
}

class _CountContainerState extends State<CountContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 39,
        width: 39,
        decoration: BoxDecoration(
            color: appAccent1,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Text("${widget.count}",
                style: GoogleFonts.inter(
                    color: appBackground,
                    fontWeight: FontWeight.w700,
                    fontSize: 18))));
  }
}
