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

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  final account = AccountMethods();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
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
                          padding: EdgeInsets.only(left: 20),
                          height: 250,
                          child: Align(
                              alignment: Alignment(-0.8, -0.9),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: Text(
                                            "Hi, <Username>",
                                            style: GoogleFonts.inter(
                                                color: appAccent1,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 33),
                                          ),
                                        ),
                                        SizedBox(height: 70),
                                        SizedBox(
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseForm()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: appAccent1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80))),
                                    child: Icon(Icons.add,
                                        size: 39, color: appBackground),
                                  ))),
                          Align(
                            alignment: Alignment(0.9, 0.5),
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  user = await account.signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GoogleLogIn()));
                                },
                                icon: Icon(Icons.add),
                                label: Text("Bye Boys")),
                          ),
                        ])),
                      ],
                    ),
            )));
  }
}
