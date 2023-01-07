// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keeperofrecords/elements/mainPageMobileBody.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/elements/InputField.dart';
import 'package:carbon_icons/carbon_icons.dart';

User? userGlobal;

//Google log In page
class GoogleLogIn extends StatelessWidget {
  GoogleLogIn({Key? key}) : super(key: key);

  final account = AccountMethods();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = userGlobal;
  bool usernameExists = false;

  final userDocs = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackground,
        body: Column(children: [
          SizedBox(
              height: 300,
              child: Align(
                  alignment: Alignment(0.1, 0.5),
                  child: Text("Mark your\nattendance and\nenjoy life",
                      style: GoogleFonts.inter(
                          color: appAccent2,
                          fontWeight: FontWeight.bold,
                          fontSize: 45)))),
          SizedBox(
              height: 100,
              child: Align(
                  alignment: Alignment(-0.8, 0),
                  child: Text("Continue with",
                      style: GoogleFonts.inter(
                          color: appAccent2,
                          fontWeight: FontWeight.w600,
                          fontSize: 25)))),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  height: 80,
                  width: 330,
                  child: ElevatedButton(
                    onPressed: () async {
                      userGlobal = await account.signup(context, auth);
                      user = userGlobal;
                      DocumentSnapshot ds = await userDocs
                          .doc(user?.displayName)
                          .get(); // DOCUMENT NAMES ARE THE DISPLAY NAMES OF THE USERS, THAT WE GET FROM GOOGLE
                      if (user == null) {
                        return;
                      } else if (ds["username"] == "") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSignIn()));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileBody()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appAccent1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CarbonIcons.logo_google,
                              size: 39, color: appBackground),
                          Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: Text("Sign in with Google",
                                  style: GoogleFonts.inter(
                                      color: appBackground,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)))
                        ]),
                  )))
        ]));
  }
}

//For App Sign In
class AppSignIn extends StatefulWidget {
  const AppSignIn({super.key});

  @override
  State<AppSignIn> createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> {
  final TextEditingController username = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController semester = TextEditingController();

  List<bool> errorTextField = [false, false, false];

  final strMethods = StringChecks();
  final accounts = AccountMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackground,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width - 100),
                child: IconButton(
                    onPressed: () async {
                      userGlobal = await accounts.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleLogIn()));
                    },
                    padding: EdgeInsets.all(5),
                    icon: Icon(Icons.account_circle_outlined,
                        color: appAccent1, size: 39)))),
        body: Center(
            child: Container(
                height: 500,
                width: 350,
                color: Colors.transparent,
                child: SingleChildScrollView(
                    child: Column(children: [
                  InputWidget(
                      text: "Username",
                      txt: username,
                      error: errorTextField[0]),
                  Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: InputWidget(
                          text: "Branch",
                          txt: branch,
                          error: errorTextField[1])),
                  Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: InputWidget(
                          text: "Semester",
                          txt: semester,
                          error: errorTextField[2])),
                  Padding(
                      padding: EdgeInsets.only(top: 90, bottom: 20),
                      child: SizedBox(
                          height: 70,
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() async {
                                  errorTextField[0] = (await strMethods.check(
                                      username.text, "username"))!;
                                  errorTextField[1] = (await strMethods.check(
                                      branch.text, "branch"))!;
                                  errorTextField[2] = (await strMethods.check(
                                      semester.text, "semester"))!;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MobileBody()));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: appAccent1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60)))),
                              child: Text("Enter",
                                  style: GoogleFonts.inter(
                                      color: appBackground,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)))))
                ])))));
  }
}

