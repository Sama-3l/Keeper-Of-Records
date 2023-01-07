// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'mainPageMobileBody.dart';

List<String> pages = [
  'lib/elements/assets/undraw_certificate_re_yadi.svg',
  'lib/elements/assets/undraw_note_list_re_r4u9.svg',
  'lib/elements/assets/undraw_add_files_re_v09g.svg',
  'lib/elements/assets/undraw_working_re_ddwy.svg',
];

List<String> pagesTitle = [
  "Say goodbye to\ngood marks",
  "Record your attendance",
  "Just add your course details",
  "Stay away from the class"
];

List<String> body = [
  "Take control of your attendance and stay away\nfrom classes when you can",
  "Add to the list of beautiful days\nevery time you press '+'",
  "Save your course details and then\nfeel free to take a break whenever you wish to",
  "And work on shit that actually matters"
];

var pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(
        fontSize: 27.0, color: appAccent2, fontWeight: FontWeight.bold),
    bodyTextStyle: GoogleFonts.inter(
        color: appAccent2.withOpacity(0.7),
        fontWeight: FontWeight.bold,
        fontSize: 16),
    bodyPadding: EdgeInsets.only(top: 30),
    pageColor: appBackground,
    imagePadding: EdgeInsets.only(top: 140),
    imageFlex: 3,
    bodyFlex: 2);

List<PageViewModel> introductionScreens = [
  PageViewModel(
      title: pagesTitle[0],
      body: body[0],
      image: SvgPicture.asset(pages[0]),
      decoration: pageDecoration),
  PageViewModel(
      title: pagesTitle[1],
      body: body[1],
      image: SvgPicture.asset(pages[1]),
      decoration: pageDecoration),
  PageViewModel(
      title: pagesTitle[2],
      body: body[2],
      image: SvgPicture.asset(pages[2]),
      decoration: pageDecoration),
  PageViewModel(
      title: pagesTitle[3],
      body: body[3],
      image: SvgPicture.asset(pages[3]),
      decoration: pageDecoration),
];

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MobileBody()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: introductionScreens,
      globalBackgroundColor: appBackground,
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: true,
      done: Text("DONE",
          style: GoogleFonts.inter(
              color: appAccent1, fontSize: 20, fontWeight: FontWeight.bold)),
      skip: Text("SKIP",
          style: GoogleFonts.inter(
              color: appAccent1, fontSize: 20, fontWeight: FontWeight.bold)),
      next: Text("NEXT",
          style: GoogleFonts.inter(
              color: appAccent1, fontSize: 20, fontWeight: FontWeight.bold)),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      dotsDecorator: const DotsDecorator(
        size: Size(12.0, 12.0),
        color: Color(0xffD9D9D9),
        activeSize: Size(22.0, 12.0),
        activeColor: appAccent1,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}