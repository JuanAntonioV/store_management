import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/login_controller.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/widgets/password_form_field.dart';
import 'package:store_management/widgets/submit_button.dart';
import 'package:store_management/widgets/text_form_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top: -50,
              right: -100,
              child: Image.asset(
                'assets/images/inventory.png',
                width: 300,
                height: 300,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Text(
                            "back!",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "Ayo kelola produk dan stok dengan cepat dan mudah!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormInput(
                            hintText: 'Masukkan alamat email',
                            labelText: 'Alamat Email',
                            validator: (value) =>
                                controller.validateEmail(value),
                            onChanged: (value) {
                              controller.onEmailChanged(value);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PasswordFormField(
                            hintText: 'Masukkan kata sandi',
                            labelText: 'Kata Sandi',
                            validator: (value) =>
                                controller.validatePassword(value),
                            onChanged: (value) {
                              controller.onPasswordChanged(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Obx(() => SubmitButton(
                          onPressed: controller.onLogin,
                          text: 'Masuk',
                          isLoading: controller.isLoading.value,
                          backgroundColor: Theme.of(context).primaryColor,
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun? ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.register);
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
