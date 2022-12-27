// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/constants/colors.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                height: 200,
                child: Align(
                    alignment: Alignment(-0.8, 0),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      height: 50,
                      width: 300,
                      child: Text(
                        "Hi, <Username>",
                        style: GoogleFonts.poppins(
                            color: appAccent1,
                            fontWeight: FontWeight.w700,
                            fontSize: 33),
                      ),
                    )),
              ),
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text("${index}"));
                  })),
            ],
          ),
        ));
  }
}
