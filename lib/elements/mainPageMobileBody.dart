// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'course.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addcourse.dart';
import 'package:keeperofrecords/elements/mainPageCourseList.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  final account = AccountMethods();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  late String username = "";
  late var result;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    getUsername();
  }

  void getUsername() async {
    final ref = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.displayName)
        .get();
    setState(() {
      username = ref['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: user == null
                  ? GoogleLogIn()
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 13),
                          height: 250,
                          child: Align(
                              alignment: Alignment(-1, -0.9),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 55,
                                          width: 300,
                                          child: TextButton(
                                              onPressed: () async {
                                                user = await account.signOut();
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GoogleLogIn()));
                                                // ROUTE TO ACCOUNTS PAGE TO CHANGE ACCOUNT DETAILS AND LOG OUT INFO.
                                              },
                                              child: Align(
                                                  alignment: Alignment(-1, 0.5),
                                                  child: Text(
                                                    "Hi, $username.",
                                                    style: GoogleFonts.inter(
                                                        color: appAccent1,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 37),
                                                  ))),
                                        ),
                                        SizedBox(height: 70),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          height: 50,
                                          width: 300,
                                          child: Text(
                                            "Tasks",
                                            style: GoogleFonts.inter(
                                                color: appAccent1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 29),
                                          ),
                                        ),
                                      ]))),
                        ),
                        Expanded(
                            child: Stack(children: [
                          CourseList(),
                          Align(
                              alignment: Alignment(0.9, 0.9),
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseForm()));
                                      setState(() {
                                        result = "Hello";
                                        print('result');
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: appAccent1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80))),
                                    child: Icon(Icons.add,
                                        size: 39, color: appBackground),
                                  ))),
                        ])),
                      ],
                    ),
            )));
  }
}
