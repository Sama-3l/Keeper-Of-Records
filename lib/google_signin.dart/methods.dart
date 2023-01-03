// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keeperofrecords/google_signin.dart/signin.dart';

List courseList = [];

var userr = {
  "index": 0,
  "uid": "",
  "photo": null,
  "username": "",
  "branch": "",
  "semester": 0,
  "email": "",
  "courses": courseList,
  "LAS": 0,
};


late bool docNotExists;

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

      var collectionRef = FirebaseFirestore.instance.collection('Users');
      var doc = await collectionRef.doc(user?.displayName).get();
      docNotExists = !doc.exists;

      if (docNotExists) {
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
      }
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
      userDocs.doc(userGlobal?.displayName).update({field.toLowerCase(): text});
      return false;
    }
  }

  Future<void> addCourse(
      String courseName, int absent_count, double max) async {
    userGlobal = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot snapShot) {
      for (var doc in snapShot.docs) {
        print(doc.id);
        print(userGlobal?.displayName);
        print(doc.id == userGlobal?.displayName);
        if (doc.id == userGlobal?.displayName) {
          courseList = doc['courses'];
        }
      }
    });

    Course obj = Course(courseName, absent_count, max);
    final objJSON = obj.toJson();
    print(objJSON);
    courseList.add(objJSON);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userGlobal?.displayName)
        .update({"courses": courseList});
  }
}

class Course {
  late String name;
  late int absent_count;
  late double max;

  Course(this.name, this.absent_count, this.max);

  Map toJson() =>
      {"courseName": name, "absentCount": absent_count, "maxAttendance": max};
}
