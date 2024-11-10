import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/api/product_api.dart';
import 'package:store_management/models/product_model.dart';
import 'package:store_management/widgets/product_card.dart';
import 'package:store_management/controllers/search_controller.dart'
    as search_controller;

class AllProductList extends StatefulWidget {
  const AllProductList({super.key});

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {
  final searchController = Get.put(search_controller.SearchController());

  late StreamController<List<ProductModel>> _streamController;
  late Stream<List<ProductModel>> _stream;
  late StreamSubscription<String> _searchSubscription;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<ProductModel>>();
    _stream = _streamController.stream;

    fetchAllProduct(null);

    _searchSubscription = searchController.search.listen((search) {
      fetchAllProduct(search);
    });
  }

  @override
  void dispose() {
    _searchSubscription.cancel();
    _streamController.close();
    super.dispose();
  }

  fetchAllProduct(String? search) async {
    try {
      final data = await getAllProduct(search);
      _streamController.add(data);
    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
  }

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
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          Flexible(
            child: StreamBuilder<List<ProductModel>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    child: const Center(
                      child: Text(
                        'Error: Gagal memuat data',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView(
                    padding:
                        EdgeInsets.zero, // Remove any padding from the ListView
                    children: snapshot.data!
                        .map((product) => ProductCard(item: product))
                        .toList(),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Tidak ada data',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
