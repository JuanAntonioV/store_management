import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/profile_controller.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/services/auth_service.dart';
import 'package:store_management/widgets/password_form_field.dart';
// import 'package:store_management/widgets/submit_button.dart';
import 'package:store_management/widgets/text_form_input.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());

  // final _storage = StorageService();

  final _auth = AuthService();

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      controller.onChangePhoto(File(img.path));
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Akun Saya'),
          actions: [
            IconButton(
              onPressed: () {
                _auth.signOut();
                Get.offAllNamed(Routes.login);
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              StreamBuilder(
                stream: _auth.currentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('An error occurred: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text('No user found.');
                  } else {
                    final user = snapshot.data!;
                    return Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          // make input to upload image
                          // controller.photo.path.isNotEmpty
                          //     ? GestureDetector(
                          //         onTap: () => {
                          //           // remove image
                          //           controller.onChangePhoto(null)
                          //         },
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 20),
                          //           child: ClipRRect(
                          //             borderRadius: BorderRadius.circular(8),
                          //             child: Image.file(
                          //               File(controller.photo.path.toString()),
                          //               fit: BoxFit.cover,
                          //               width: 120,
                          //               height: 120,
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     : user.photo != null
                          //         ? FutureBuilder(
                          //             future: _storage
                          //                 .getImage(user.photo as String),
                          //             builder: (context, snapshot) {
                          //               if (snapshot.connectionState ==
                          //                   ConnectionState.waiting) {
                          //                 return Center(
                          //                   child:
                          //                       const CircularProgressIndicator(),
                          //                 );
                          //               } else if (snapshot.hasError) {
                          //                 return Center(
                          //                   child: Text(
                          //                       'An error occurred: ${snapshot.error}'),
                          //                 );
                          //               } else if (!snapshot.hasData ||
                          //                   snapshot.data == null) {
                          //                 return GestureDetector(
                          //                   onTap: () {
                          //                     _showPicker();
                          //                   },
                          //                   child: Container(
                          //                     width: 120,
                          //                     height: 120,
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.grey[200],
                          //                       borderRadius:
                          //                           BorderRadius.circular(100),
                          //                     ),
                          //                     child: Center(
                          //                       child: Icon(
                          //                         Icons.add_a_photo_outlined,
                          //                         size: 40,
                          //                         color: Colors.grey[400],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 );
                          //               } else {
                          //                 return Padding(
                          //                   padding: const EdgeInsets.symmetric(
                          //                       horizontal: 20),
                          //                   child: ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(8),
                          //                     child: Image.network(
                          //                       snapshot.data as String,
                          //                       fit: BoxFit.cover,
                          //                       width: 120,
                          //                       height: 120,
                          //                     ),
                          //                   ),
                          //                 );
                          //               }
                          //             })
                          //         : GestureDetector(
                          //             onTap: () {
                          //               _showPicker();
                          //             },
                          //             child: Container(
                          //               width: 120,
                          //               height: 120,
                          //               decoration: BoxDecoration(
                          //                 color: Colors.grey[200],
                          //                 borderRadius:
                          //                     BorderRadius.circular(100),
                          //               ),
                          //               child: Center(
                          //                 child: Icon(
                          //                   Icons.add_a_photo_outlined,
                          //                   size: 40,
                          //                   color: Colors.grey[400],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          TextFormInput(
                            labelText: 'Nama Lengkap',
                            hintText: 'Masukkan nama lengkap',
                            validator: (value) =>
                                controller.validateName(value),
                            initialValue: user.name,
                            onChanged: controller.onChangeName,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormInput(
                            hintText: 'Masukkan alamat email',
                            labelText: 'Alamat Email',
                            validator: (value) =>
                                controller.validateEmail(value),
                            initialValue: user.email,
                            onChanged: controller.onChangeEmail,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PasswordFormField(
                            hintText: 'Masukkan kata sandi baru',
                            labelText: 'Kata Sandi Baru',
                            validator: (value) =>
                                controller.validatePassword(value),
                            onChanged: controller.onChangePassword,
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: OverflowBar(
        //       spacing: 20,
        //       children: [
        //         Obx(
        //           () => SubmitButton(
        //             onPressed: controller.onSaveProfile,
        //             text: 'Simpan',
        //             isLoading: controller.isLoading.value,
        //             backgroundColor: Theme.of(context).primaryColor,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
