// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';
import 'elements/responsive.dart';
import 'elements/mainPageMobileBody.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:keeperofrecords/elements/appIntro.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        color: appBackground,
        home:
            CheckMainWidget() //MobileBody() // MainPage(mobileBody: MobileBody()),
        );
  }
}

class CheckMainWidget extends StatefulWidget {
  const CheckMainWidget({super.key});

  @override
  State<CheckMainWidget> createState() => _CheckMainWidgetState();
}

class _CheckMainWidgetState extends State<CheckMainWidget> {
  AccountMethods obj = AccountMethods();
  bool introNeed = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    checkloading();
  }

  void checkloading() async {
    introNeed = await obj.checkIntro();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: SizedBox(
              height: 50,
              width: 50,
                child: CircularProgressIndicator(
            color: appAccent1,
          )))
        : introNeed
            ? IntroPage()
            : MobileBody();
  }
}
