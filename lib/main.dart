// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'elements/responsive.dart';
import 'elements/mainPageMobileBody.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(mobileBody: MobileBody()),
    );
  }
}
