import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_management/controllers/product_controller.dart';
import 'package:store_management/models/product_model.dart';
import 'package:store_management/widgets/submit_button.dart';
import 'package:store_management/widgets/text_form_input.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final controller = Get.put(ProductController());

  // get item from arguments
  final item = Get.arguments as ProductModel;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    print(img);

    controller.onImageChanged(File(img!.path));

    setState(() {
      image = img;
    });
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
  void initState() {
    super.initState();

    final ProductModel product = Get.arguments as ProductModel;

    controller.onNameChanged(product.name);
    controller.onPriceChanged(product.price.toString());
    controller.onStockChanged(product.stock.toString());
    controller.onDescriptionChanged(product.description ?? '');
    controller.onIsDraftChanged(product.status == 2 ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ubah Produk',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                controller.onDeleteProduct(Get.arguments as ProductModel);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormInput(
                        labelText: 'Nama Produk',
                        hintText: 'Masukkan nama produk',
                        validator: (value) => controller.validateName(value),
                        onChanged: (value) {
                          controller.onNameChanged(value);
                        },
                        initialValue: controller.name.value,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormInput(
                        labelText: 'Harga',
                        hintText: 'Masukkan harga produk',
                        validator: (value) => controller.validatePrice(value),
                        initialValue: controller.price.value.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'[0-9]'),
                              allow: true),
                        ],
                        onChanged: (value) {
                          controller.onPriceChanged(value);
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormInput(
                        labelText: 'Stok',
                        hintText: 'Masukkan stok produk',
                        validator: (value) => controller.validateStock(value),
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'[0-9]'),
                              allow: true),
                        ],
                        initialValue: controller.stock.value.toString(),
                        onChanged: (value) {
                          controller.onStockChanged(value);
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormInput(
                        labelText: 'Deskripsi',
                        hintText: 'Masukkan deskripsi produk',
                        validator: (value) =>
                            controller.validateDescription(value),
                        onChanged: (value) {
                          controller.onDescriptionChanged(value);
                        },
                        initialValue: controller.description.value,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (item.status != 1)
                        Obx(
                          () => SwitchListTile(
                            title: Text('Draft'),
                            value: controller.isDraft.value,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              controller.onIsDraftChanged(value);
                            },
                          ),
                        ),
                      // make input to upload image
                      // image != null
                      //     ? Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 0),
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               image = null;
                      //             });
                      //             controller.onImageChanged(File(''));
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(16),
                      //             child: Image.file(
                      //               File(image!.path),
                      //               fit: BoxFit.cover,
                      //               width: 120,
                      //               height: 120,
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     : GestureDetector(
                      //         onTap: () {
                      //           _showPicker();
                      //         },
                      //         child: Container(
                      //           width: 92,
                      //           height: 92,
                      //           decoration: BoxDecoration(
                      //             color: Colors.grey[200],
                      //             borderRadius: BorderRadius.circular(16),
                      //           ),
                      //           child: Center(
                      //             child: Icon(
                      //               Icons.add_a_photo_outlined,
                      //               size: 28,
                      //               color: Colors.grey[400],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OverflowBar(
              spacing: 20,
              children: [
                Obx(
                  () => SubmitButton(
                    onPressed: () {
                      controller.onEditProduct(Get.arguments as ProductModel);
                    },
                    text: 'Simpan',
                    isLoading: controller.isLoading.value,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
