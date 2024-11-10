import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/services/auth_service.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final _auth = AuthService();

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

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
    if (GetUtils.isNullOrBlank(password ?? '') == null) {
      return 'Password tidak boleh kosong';
    } else if (password!.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  onNameChanged(String value) {
    name.value = value;
  }

  onEmailChanged(String value) {
    email.value = value;
  }

  onPasswordChanged(String value) {
    password.value = value;
  }

  clearForm() {
    name.value = '';
    email.value = '';
    password.value = '';
  }

  Future onRegister() async {
    isLoading(true);

    if (formKey.currentState!.validate()) {
      final result = await _auth.signUpWithEmailAndPassword(
        name.value,
        email.value,
        password.value,
      );

      if (result != null) {
        Get.snackbar(
          'Berhasil',
          'Pendaftaran berhasil',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        isLoading(false);
        clearForm();
        Get.offAllNamed(Routes.login);
        return;
      }

      isLoading(false);
      return;
    }

    Get.snackbar(
      'Gagal',
      'Periksa kembali data Anda',
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
