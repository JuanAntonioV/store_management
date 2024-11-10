import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/db/product_db.dart';
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

  late StreamController<List<ProductModel>> _streamController;
  late Stream<List<ProductModel>> _stream;
  late StreamSubscription<String> _searchSubscription;
  final productDb = ProductDB();

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<ProductModel>>();
    _stream = _streamController.stream;

    fetchProducts(null);

    _searchSubscription = searchController.search.listen((search) {
      fetchProducts(search);
    });
  }

  @override
  void dispose() {
    _searchSubscription.cancel();
    _streamController.close();
    super.dispose();
  }

  void fetchProducts(String? search) async {
    try {
      final data = await productDb.getAll(search);
      print(data);
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
                  style: TextStyle(color: Colors.grey),
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
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
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
