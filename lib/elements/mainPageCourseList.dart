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
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  List courseList = [];
  User? user;
  bool loading = true;

  Widget body = CircularProgressIndicator();

  @override
  void initState() {
    // TODO: implement initState
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
        print(doc.id);
        print(user?.displayName);
        print(doc.id == user?.displayName);
        if (doc.id == user?.displayName) {
          setState(() {
            courseList = doc['courses'];
          });
        }
      }
    });
    print(courseList);
    setState(() {
      loading = false;
    });
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
                          child: CourseContainer(
                            index: index,
                              count: courseList[index]['absentCount'],
                              courseName: courseList[index]['courseName'])));
                }))
            : Align(
                alignment: Alignment(0, -0.5),
                child: Text("Nothing here",
                    style: GoogleFonts.poppins(
                        color: appAccent2,
                        fontWeight: FontWeight.w200,
                        fontSize: 20)));
  }
}
