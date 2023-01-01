// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keeperofrecords/elements/mainPageMobileBody.dart';
import 'package:keeperofrecords/google_signin.dart/methods.dart';
import 'package:keeperofrecords/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperofrecords/elements/InputField.dart';

User? userGlobal = null;

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
    return Center(
        child: SizedBox(
            height: 80,
            width: 80,
            child: ElevatedButton(
              onPressed: () async {
                userGlobal = await account.signup(context, auth);
                user = userGlobal;
                DocumentSnapshot ds = await userDocs
                    .doc(user?.displayName)
                    .get(); // DOCUMENT NAMES ARE THE DISPLAY NAMES OF THE USERS, THAT WE GET FROM GOOGLE
                print(ds['username']);
                if (user == null) {
                  return;
                } else if (ds["username"] == "") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AppSignIn()));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: appAccent1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80))),
              child: Icon(Icons.add, size: 39, color: appBackground),
            )));
  }
}

//For App Sign In
class AppSignIn extends StatefulWidget {
  const AppSignIn({Key? key}) : super(key: key);

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
    return SafeArea(
        child: Scaffold(
      backgroundColor: appBackground,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          title: Padding(
              padding: EdgeInsets.only(
                  top: 30, left: MediaQuery.of(context).size.width - 100),
              child: IconButton(
                  onPressed: () async {
                    userGlobal = await accounts.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GoogleLogIn()));
                  },
                  padding: EdgeInsets.all(5),
                  icon: Icon(Icons.account_circle_outlined,
                      color: appAccent1, size: 39)))),
      body: Center(
          child: Container(
              height: 500,
              width: 350,
              color: Colors.transparent,
              child: Column(children: [
                Expanded(
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
                ])),
                SizedBox(
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
                            primary: appAccent1,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)))),
                        child: Text("Enter",
                            style: GoogleFonts.poppins(
                                color: appBackground,
                                fontSize: 22,
                                fontWeight: FontWeight.bold))))
              ]))),
    ));
  }
}

/*class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();

    if(googleUser == null ) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }
}*/
