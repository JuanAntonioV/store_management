import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/models/product_model.dart';
import 'package:store_management/controllers/search_controller.dart'
    as search_controller;
import 'package:store_management/widgets/product_card.dart';

class DraftProductList extends StatefulWidget {
  const DraftProductList({super.key});

  @override
  State<DraftProductList> createState() => _DraftProductListState();
}

class _DraftProductListState extends State<DraftProductList> {
  final searchController = Get.put(search_controller.SearchController());

  List<ProductModel> products = [
    ProductModel(name: 'Product 1', price: 10000, status: 2),
    ProductModel(name: 'Product 2', price: 20000, status: 2),
    ProductModel(name: 'Product 3', price: 30000, status: 2),
    ProductModel(name: 'Product 4', price: 40000, status: 2),
    ProductModel(name: 'Product 5', price: 50000, status: 2),
    ProductModel(name: 'Product 6', price: 60000, status: 2),
    ProductModel(name: 'Product 7', price: 70000, status: 2),
    ProductModel(name: 'Product 8', price: 80000, status: 2),
    ProductModel(name: 'Product 9', price: 90000, status: 2),
    ProductModel(name: 'Product 10', price: 100000, status: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (searchController.search.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Menampilkan hasil pencarian untuk "${searchController.search.value}"',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero, // Remove any padding from the ListView
              children: products
                  .map((product) => ProductCard(item: product))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
