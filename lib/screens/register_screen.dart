import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/register_controller.dart';
import 'package:store_management/widgets/password_form_field.dart';
import 'package:store_management/widgets/submit_button.dart';
import 'package:store_management/widgets/text_form_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(RegisterController());

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
        appBar: AppBar(),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Customize color as needed
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "Silahkan daftar untuk melanjutkan",
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
                            hintText: 'Masukkan nama lengkap',
                            labelText: 'Nama Lengkap',
                            validator: (value) =>
                                controller.validateName(value),
                            onChanged: (value) {
                              controller.onNameChanged(value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormInput(
                            hintText: 'Masukkan alamat email',
                            labelText: 'Alamat Email',
                            validator: (value) =>
                                controller.validateEmail(value),
                            onChanged: (value) {
                              controller.onEmailChanged(value);
                            },
                          ),
                          const SizedBox(
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
                          onPressed: () {
                            controller.onRegister();
                          },
                          text: 'Daftar',
                          isLoading: controller.isLoading.value,
                          backgroundColor: Theme.of(context).primaryColor,
                        )),
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
