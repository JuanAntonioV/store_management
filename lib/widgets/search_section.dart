import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/widgets/search_input.dart';
import 'package:store_management/controllers/search_controller.dart'
    as search_controller;

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final searchController = Get.put(search_controller.SearchController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Semua Produk',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.addProduct);
              },
              child: Text(
                'Tambahkan',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        SearchInput(
          hintText: 'Cari mainan mobil, pesawat, bantal...',
          onSearch: (value) {
            searchController.onSearch(value);
          },
        ),
      ],
    );
  }
}
