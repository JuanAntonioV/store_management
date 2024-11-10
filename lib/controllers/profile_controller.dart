import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:store_management/services/storage_service.dart';
// import 'package:store_management/themes/colors.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  // final _storageService = StorageService();
  final _auth = FirebaseAuth.instance;
  // final _db = FirebaseFirestore.instance;

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  File photo = File('');

  validateName(String? name) {
    if (GetUtils.isNullOrBlank(name ?? '') == null) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Alamat email tidak valid';
    }
    return null;
  }

  validatePassword(String? password) {
    if (password!.isNotEmpty && password.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  onChangeName(String value) {
    name.value = value;
  }

  onChangeEmail(String value) {
    email.value = value;
  }

  onChangePassword(String value) {
    password.value = value;
  }

  onChangePhoto(File? value) {
    if (value != null) {
      photo = value;
    } else {
      photo = File('');
    }
  }

  Future onSaveProfile() async {
    isLoading(true);

    if (formKey.currentState!.validate()) {
      // final user = await _db
      //     .collection('users')
      //     .where('email', isEqualTo: _auth.currentUser!.email)
      //     .get();

      // if (photo.path.isNotEmpty) {
      //   final imageUrl = await _storageService.uploadImage(photo);

      //   // final userData = UserModel(name: name.value, email: email.value);

      //   // final uploadApi = await updateUser(
      //   //   userData,
      //   // );

      //   if (imageUrl != null) {
      //     await _db.collection('users').doc(user.docs.first.id).update({
      //       'photo': imageUrl,
      //     });
      //   }
      // }

      if (password.value.isNotEmpty) {
        await _auth.currentUser!.updatePassword(password.value);
      }

      if (name.value.isNotEmpty) {
        await _auth.currentUser!.updateDisplayName(name.value);
        // await _db.collection('users').doc(user.docs.first.id).update({
        //   'name': name.value,
        // });
      }

      if (email.value.isNotEmpty) {
        await _auth.currentUser!.verifyBeforeUpdateEmail(email.value);
        // await _db.collection('users').doc(user.docs.first.id).update({
        //   'email': email.value,
        // });
      }

      Get.snackbar(
        'Berhasil',
        'Profil berhasil diperbarui!',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 300),
      );
      isLoading(false);
      return;
    }

    Get.snackbar(
      'Gagal',
      'Silahkan periksa kembali data yang dimasukkan',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      animationDuration: Duration(milliseconds: 300),
    );
    isLoading(false);
  }
}
