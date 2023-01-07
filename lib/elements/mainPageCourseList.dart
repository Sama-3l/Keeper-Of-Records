// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/elements/course.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:keeperofrecords/constants/appConstants.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => CourseListState();
}

class CourseListState extends State<CourseList> {
  List courseList = [];
  User? user;
  bool loading = true;
  List<Color> borderColors = [];

  Widget body = CircularProgressIndicator();
  CheckingMethods caller = CheckingMethods();

  double scale = 0.3;

  @override
  void initState() {
    super.initState();
    reFresh();
    setBoundaryColors();
  }

  void setBoundaryColors() async {
    borderColors = await caller.addBackgroundColor();
  }

  void reFresh() async {
    user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot snapShot) {
      for (var doc in snapShot.docs) {
        if (doc.id == user?.displayName) {
          setState(() {
            courseList = doc['courses'];
          });
        }
      }
    });
    if (loading == true) {
      setState(() {
        loading = false;
      });
    }
  }

  void changeCount(int index) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot snapShot) {
      for (var doc in snapShot.docs) {
        if (doc.id == user?.displayName) {
          setState(() {
            var currentCourse = doc['courses'];
            currentCourse[index]['absentCount'] =
                doc['courses'][index]['absentCount'] + 1;
            FirebaseFirestore.instance
                .collection("Users")
                .doc(user?.displayName)
                .update({"courses": currentCourse});
          });
        }
      }
    });
    reFresh();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Align(
            alignment: Alignment(0, -0.5),
            child: CircularProgressIndicator(
              color: appAccent1,
            ))
        : courseList.isNotEmpty
            ? ListView.builder(
                itemCount: courseList.length,
                itemBuilder: ((context, index) {
                  return Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding:
                              EdgeInsets.only(bottom: 16, left: 34, right: 34),
                          child: AspectRatio(
                              aspectRatio: 377 / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: borderColors[index]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60))),
                                child: Row(children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: CountContainer(
                                          count: courseList[index]
                                              ['absentCount'])),
                                  Spacer(),
                                  Center(
                                      child: Center(
                                          child: Text(
                                              courseList[index]['courseName'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                  color: appAccent2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)))),
                                  Spacer(),
                                  Center(
                                      child: SizedBox(
                                          height: 80 * scale,
                                          width: 80 * scale,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .get()
                                                  .then(
                                                      (QuerySnapshot snapShot) {
                                                for (var doc in snapShot.docs) {
                                                  if (doc.id ==
                                                      user?.displayName) {
                                                    setState(() {
                                                      var currentCourse =
                                                          doc['courses'];
                                                      currentCourse[index]
                                                          ['absentCount'] = doc[
                                                                      'courses']
                                                                  [index]
                                                              ['absentCount'] +
                                                          1;
                                                      FirebaseFirestore.instance
                                                          .collection("Users")
                                                          .doc(
                                                              user?.displayName)
                                                          .update({
                                                        "courses": currentCourse
                                                      });
                                                      reFresh();
                                                    });
                                                  }
                                                }
                                              });

                                              setState(() {
                                                setBoundaryColors();
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                backgroundColor: appAccent1,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80 * scale))),
                                            child: Icon(Icons.add,
                                                size: 39 * scale,
                                                color: appBackground),
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 20),
                                      child: Center(
                                          child: SizedBox(
                                              height: 80 * scale,
                                              width: 80 * scale,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Users')
                                                      .get()
                                                      .then((QuerySnapshot
                                                          snapShot) {
                                                    for (var doc
                                                        in snapShot.docs) {
                                                      if (doc.id ==
                                                          user?.displayName) {
                                                        if (doc['courses']
                                                                        [index][
                                                                    'absentCount'] -
                                                                1 >=
                                                            0) {
                                                          setState(() {
                                                            var currentCourse =
                                                                doc['courses'];
                                                            currentCourse[index]
                                                                    [
                                                                    'absentCount'] =
                                                                doc['courses']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'absentCount'] -
                                                                    1;
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Users")
                                                                .doc(user
                                                                    ?.displayName)
                                                                .update({
                                                              "courses":
                                                                  currentCourse
                                                            });
                                                            reFresh();
                                                          });
                                                        }
                                                      }
                                                    }
                                                  });
                                                  setState(() {
                                                    setBoundaryColors();
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor: appAccent2,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80 *
                                                                    scale))),
                                                child: Icon(Icons.remove,
                                                    size: 39 * scale,
                                                    color: appBackground),
                                              )))),
                                ]),
                              ))));
                }))
            : Align(
                alignment: Alignment(0, -0.5),
                child: Text("Nothing here",
                    style: GoogleFonts.inter(
                        color: appAccent2,
                        fontWeight: FontWeight.w200,
                        fontSize: 20)));
  }
}

class CheckingMethods {
  Future<List<Color>> addBackgroundColor() async {
    List<Color> borderColors = [];
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot snapShot) {
      for (var doc in snapShot.docs) {
        if (doc.id == user.displayName) {
          for (int i = 0; i < doc['courses'].length; i++) {
            borderColors = checkAttendance(doc['courses'][i], borderColors);
          }
        }
      }
    });
    return borderColors;
  }

  List<Color> checkAttendance(var courses, List<Color> borderColors) {
    if (courses['absentCount'] >=
        numberOfClasses -
            (0.01 * courses['maxAttendance'] * numberOfClasses).round()) {
      borderColors.add(danger);
    } else if (courses['absentCount'] >
        numberOfClasses -
            (0.01 * courses['maxAttendance'] * numberOfClasses) -
            3.round()) {
      borderColors.add(appAccent1);
    } else {
      borderColors.add(safe);
    }
    return borderColors;
  }
}
