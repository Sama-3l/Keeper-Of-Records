// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/elements/mainPageMobileBody.dart';
import 'InputField.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({Key? key}) : super(key: key);

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  TextEditingController name = TextEditingController();
  TextEditingController max = TextEditingController();
  List<bool> errorTextField = [false, false];

  StringChecks test = StringChecks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      resizeToAvoidBottomInset: false,
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
                style: GoogleFonts.inter(
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
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: InputWidget(
                      text: "Course Name",
                      txt: name,
                      error: errorTextField[0],
                      hintColor: appBackground,
                      borderColorBlack: true,
                      opacityValue: 0.5,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: InputWidget(
                      text: "Maximum Attendance %",
                      txt: max,
                      error: errorTextField[1],
                      hintColor: appBackground,
                      borderColorBlack: true,
                      opacityValue: 0.5,
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment(0, 0.8),
                        child: SizedBox(
                            height: 70,
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    test.addCourse(
                                        name.text, 0, double.parse(max.text));
                                    name.clear();
                                    max.clear();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MobileBody()));
                                    /*errorTextField[0] = (await strMethods.check(
                                        username.text, "username"))!;
                                    errorTextField[1] = (await strMethods.check(
                                        branch.text, "branch"))!;*/
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: appBackground,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)))),
                                child: Text("Add Course",
                                    style: GoogleFonts.inter(
                                        color: appAccent1,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold))))))
              ]),
            )
          ],
        ))
      ]),
    );
  }
}
