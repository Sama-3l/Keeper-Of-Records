import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key, required this.mobileBody}) : super(key: key);

  final Widget mobileBody;
  final Widget tabletBody = Container();
  final Widget desktopBody = Container();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return mobileBody;
    });
  }
}
