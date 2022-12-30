// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';
import 'elements/responsive.dart';
import 'elements/mainPageMobileBody.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
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
      home: MobileBody()// MainPage(mobileBody: MobileBody()),
    );
  }
}
