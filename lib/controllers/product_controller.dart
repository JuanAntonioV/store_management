import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/api/product_api.dart';
import 'package:store_management/db/product_db.dart';
import 'package:store_management/models/product_model.dart';
import 'package:store_management/routes/routes.dart';

class ProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  RxString name = ''.obs;
  RxInt price = 0.obs;
  RxInt stock = 0.obs;
  RxBool isDraft = false.obs;
  RxString description = ''.obs;
  Rx<File> image = File('').obs;

  @override
  void onInit() {
    super.onInit();
    name.value = '';
    price.value = 0;
    stock.value = 0;
    description.value = '';
    image.value = File('');
  }

  validateName(String? name) {
    if (GetUtils.isNullOrBlank(name ?? '') == null) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

  validatePrice(String? price) {
    if (GetUtils.isNullOrBlank(price ?? '') == null) {
      return 'Harga tidak boleh kosong';
    }
    return null;
  }

  validateStock(String? stock) {
    if (GetUtils.isNullOrBlank(stock ?? '') == null) {
      return 'Stok tidak boleh kosong';
    }

    return null;
  }

  validateDescription(String? description) {
    if (GetUtils.isNullOrBlank(description ?? '') == null) {
      return 'Deskripsi tidak boleh kosong';
    }
    return null;
  }

  clearAll() {
    name.value = '';
    price.value = 0;
    stock.value = 0;
    description.value = '';
    isDraft.value = false;
    image.value = File('');
  }

  void onNameChanged(String value) {
    name.value = value;
  }

  void onPriceChanged(String value) {
    price.value = int.parse(value);
  }

  void onStockChanged(String value) {
    stock.value = int.parse(value);
  }

  void onDescriptionChanged(String value) {
    description.value = value;
  }

  void onIsDraftChanged(bool value) {
    isDraft.value = value;
  }

  void onImageChanged(File? value) {
    if (value != null) {
      image.value = value;
    } else {
      image.value = File('');
    }
  }

  Future onAddProduct() async {
    isLoading(true);

    if (formKey.currentState!.validate()) {
      if (isDraft.value == false) {
        try {
          final res = await createProduct(
            name.value,
            description.value,
            null,
            price.value,
            stock.value,
          );

          if (res != null) {
            Get.snackbar(
              'Berhasil',
              'Produk berhasil ditambahkan ke database',
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
              animationDuration: Duration(milliseconds: 300),
            );
            Get.toNamed(Routes.home);
          }
        } catch (e) {
          print(e);
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
        }
      } else {
        // save to local sqllite
        final productDb = ProductDB();

        final product = ProductModel(
          name: name.value,
          price: price.value,
          stock: stock.value,
          status: 2,
          description: description.value,
          image: null,
        );

        await productDb.insert(product);
        await productDb.getAll(null);

        Get.snackbar(
          'Berhasil',
          'Produk berhasil ditambahkan ke draft',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        Get.toNamed(Routes.home);
      }

      // clear all input
      clearAll();

      isLoading(false);
    }
  }

  Future onEditProduct(ProductModel product) async {
    isLoading(true);

    if (formKey.currentState!.validate()) {
      if (isDraft.value == false) {
        try {
          final productData = await getProductDetail(
            product.id,
          );

          if (productData != null) {
            final res = await updateProduct(
              product.id,
              name.value,
              description.value,
              null,
              price.value,
              stock.value,
            );

            if (res != null) {
              Get.snackbar(
                'Berhasil',
                'Produk berhasil diupdate',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(10),
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 2),
                animationDuration: Duration(milliseconds: 300),
              );
              Get.toNamed(Routes.home);
            }
          } else {
            // create product
            final res = await createProduct(
              name.value,
              description.value,
              null,
              price.value,
              stock.value,
            );

            if (res != null) {
              Get.snackbar(
                'Berhasil',
                'Produk berhasil ditambahkan ke database',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(10),
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 2),
                animationDuration: Duration(milliseconds: 300),
              );
              Get.toNamed(Routes.home);
            }
          }
        } catch (e) {
          print(e);
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
        }
      } else {
        // save to local sqllite
        final productDb = ProductDB();

        final productPayload = ProductModel(
          id: product.id,
          name: name.value,
          price: price.value,
          stock: stock.value,
          status: 2,
          description: description.value,
          image: null,
        );

        await productDb.update(productPayload);
        await productDb.getAll(null);

        Get.snackbar(
          'Berhasil',
          'Produk berhasil diupdate ke draft',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        Get.toNamed(Routes.home);
      }

      // clear all input
      clearAll();

      isLoading(false);
    }
  }

  Future onDeleteProduct(ProductModel product) async {
    isLoading(true);

    if (product.status == 2) {
      final productDb = ProductDB();
      await productDb.delete(product.id);
      await productDb.getAll(null);

      Get.snackbar(
        'Berhasil',
        'Produk berhasil dihapus dari draft',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 300),
      );
      Get.toNamed(Routes.home);
    } else {
      try {
        final res = await deleteProduct(product.id);

        if (res != null) {
          Get.snackbar(
            'Berhasil',
            'Produk berhasil dihapus',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(10),
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
            animationDuration: Duration(milliseconds: 300),
          );
          Get.toNamed(Routes.home);
        }
      } catch (e) {
        print(e);
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
      }
    }

    isLoading(false);
  }
}
