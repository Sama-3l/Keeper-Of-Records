// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'course.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addcourse.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

  bool loading = false;

  CourseListState obj = CourseListState();

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;              //3.2.1 Gets the current user and
    getUsername();                               // checks for the username to set on top of the main page
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
        child: Scaffold(
      backgroundColor: Colors.black,
      body: user == null                                //3.2.2 After initState if the user is null
          ? GoogleLogIn()                               // we move to creating a log in and database 
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 300,
                                  child: TextButton(
                                      onPressed: () async {
                                        user = await account.signOut();               //(3.2.2:1) Allows signing out event
                                        Navigator.pushReplacement(                          // and pushing to Log in page
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GoogleLogIn()));
                                        // ROUTE TO ACCOUNTS PAGE TO CHANGE ACCOUNT DETAILS AND LOG OUT INFO.
                                      },
                                      child: Align(
                                          alignment: Alignment(-1, 0.5),
                                          child: AutoSizeText(
                                            "Hi, $username.",
                                            maxLines: 1,
                                            minFontSize: 33,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                                color: appAccent1,
                                                fontWeight: FontWeight.w700,
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

                //Use floating action button instead
                Expanded(
                    child: Stack(children: [
                  loading ? CourseList() : CourseList(),                      //(3.2.2:2) When the loading is completed, refreshes the list
                  Align(
                      alignment: Alignment(0.9, 0.9),
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(                                        //(3.2.2:3) Button to add a new entry       
                            onPressed: () async {
                              await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseForm()));
                              setState(() {
                                loading = !loading;
                              });
                            },
                            style: ElevatedButton.styleFrom(  
                                backgroundColor: appAccent1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80))),
                            child:
                                Icon(Icons.add, size: 39, color: appBackground),
                          ))),
                ])),
              ],
            ),
    ));
  }
}
