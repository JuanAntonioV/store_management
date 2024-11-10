import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/services/auth_service.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  var email = ''.obs;
  var password = ''.obs;

  final _auth = AuthService();

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Alamat email tidak valid';
    }
    return null;
  }

  validatePassword(String? password) {
    if (GetUtils.isNullOrBlank(password ?? '') == null) {
      return 'Password tidak boleh kosong';
    } else if (password!.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  onEmailChanged(String value) {
    email.value = value;
  }

  onPasswordChanged(String value) {
    password.value = value;
  }

  clearForm() {
    email.value = '';
    password.value = '';
  }

  Future onLogin() async {
    isLoading(true);

    if (formKey.currentState!.validate()) {
      final user =
          await _auth.signInWithEmailAndPassword(email.value, password.value);

      if (user != null) {
        Get.snackbar(
          'Berhasil',
          'Login berhasil',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        isLoading(false);
        clearForm();
        Get.toNamed(Routes.home);
        return;
      }
      isLoading(false);
      return;
    }

    Get.snackbar(
      'Gagal',
      'Periksa kembali email dan password Anda',
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
