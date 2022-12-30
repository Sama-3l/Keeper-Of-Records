// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';

var userr = {
  "index": 0,
  "uid": "",
  "photo": null,
  "username": "",
  "branch": "",
  "semester": 0,
  "email": "",
  "courses": "",
  "LAS": 0,
};

class AccountMethods {
  Future<User?> signup(BuildContext context, FirebaseAuth auth) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      userr["uid"] = user != null ? user.uid : "";
      userr["photo"] = user?.photoURL;
      userr["email"] = user?.email;

      //This is to get the current list of database
      final databaseList =
          await FirebaseFirestore.instance.collection('Users').get();
      int index = databaseList.docs.length;

      if (userr["index"] == 0) userr["index"] = index;

      final userDocs = FirebaseFirestore.instance.collection('Users');
      userDocs.doc(user?.displayName).set(userr);

      return user;
    }
  }

  Future<User?> signOut() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    return null;
  }
}

class StringChecks {
  Future<bool?> check(String text, String field) async {
    final userDocs = FirebaseFirestore.instance.collection('Users');

    print(text);
    if (text == "" || text == " ")
      return true;
    else {
      userDocs
          .doc(userGlobal?.displayName)
          .update({"${field.toLowerCase()}": text});
      return false;
    }
  }
}
