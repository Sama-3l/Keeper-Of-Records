// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'elements/mainPageMobileBody.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:keeperofrecords/elements/appIntro.dart';

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
        home: CheckMainWidget());   //1. Checks if we the main widget needs to be an intro
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
    checkloading();                       //2. Waits for checkIntro which returns TRUE if we need intro pages, if the database doesn't
  }                                          //exists

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
            ? IntroPage()              //3.1 Intro pages which lead to MobileBody for database creation
            : MobileBody();           //3.2 Going to mobile body if the database exists
  }
}
