import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_management/api/user_api.dart';
import 'package:store_management/models/user_model.dart';
import 'package:store_management/routes/routes.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var res = await createUser(UserModel(email: email, name: name));

      if (userCredential.user != null && res != null) {
        return userCredential.user;
      }

      return null;
    } catch (e) {
      print(e.toString());
      log(e.toString());
      Get.snackbar(
        'Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 300),
      );
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      print(e);
    }
  }

  Stream<User?> get user => _auth.authStateChanges();

  Future<UserModel?> get currentUser async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        var email = user.email;

        var res = await getUserByEmail(email!);

        if (res != null) {
          return res;
        }
      }

      return null;
    } catch (e) {
      print(e);
      log(e.toString());
      Get.snackbar(
        'Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 300),
      );
      return null;
    }
  }

  Stream<UserModel?> get currentUserStream {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        return await getUserByEmail(user.email!);
      } else {
        return null;
      }
    });
  }
}
