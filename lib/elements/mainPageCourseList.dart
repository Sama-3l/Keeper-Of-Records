// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/elements/course.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => CourseListState();
}

class CourseListState extends State<CourseList> {
  List courseList = [];
  User? user;
  bool loading = true;

  Widget body = CircularProgressIndicator();

  final bool checkAttendance = true;
  double scale = 0.3;

  @override
  void initState() {
    super.initState();
    reFresh();
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
    print('course List $courseList');
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
                          child: Container(
                            height: 84,
                            width: 377,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: checkAttendance ? safe : danger),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: CountContainer(
                                      count: courseList[index]['absentCount'])),
                              Center(
                                  child: SizedBox(
                                      height: 40,
                                      width: 190,
                                      child: Center(
                                          child: Text(
                                              courseList[index]['courseName'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                  color: appAccent2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))))),
                              Center(
                                  child: SizedBox(
                                      height: 80 * scale,
                                      width: 80 * scale,
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .get()
                                              .then((QuerySnapshot snapShot) {
                                            for (var doc in snapShot.docs) {
                                              if (doc.id == user?.displayName) {
                                                setState(() {
                                                  var currentCourse =
                                                      doc['courses'];
                                                  currentCourse[index]
                                                          ['absentCount'] =
                                                      doc['courses'][index]
                                                              ['absentCount'] +
                                                          1;
                                                  FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(user?.displayName)
                                                      .update({
                                                    "courses": currentCourse
                                                  });
                                                });
                                              }
                                            }
                                            reFresh();
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Center(
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
                                                              ['absentCount'] -
                                                          1;
                                                      FirebaseFirestore.instance
                                                          .collection("Users")
                                                          .doc(
                                                              user?.displayName)
                                                          .update({
                                                        "courses": currentCourse
                                                      });
                                                    });
                                                  }
                                                }
                                              });
                                              reFresh();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                backgroundColor: appAccent2,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80 * scale))),
                                            child: Icon(Icons.remove,
                                                size: 39 * scale,
                                                color: appBackground),
                                          ))))
                            ]),
                          )

                          /*CourseContainer(
                            index: index,
                              count: courseList[index]['absentCount'],
                              courseName: courseList[index]['courseName'])*/
                          ));
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
