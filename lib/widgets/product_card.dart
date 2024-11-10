import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_management/models/product_model.dart';
// import 'package:store_management/routes/routes.dart';

class ProductCard extends StatelessWidget {
  final ProductModel item;

  const ProductCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'id_ID', name: 'Rp ', decimalDigits: 0);

    return GestureDetector(
      onTap: () => {
        // Get.toNamed(Routes.productDetail),
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        borderOnForeground: true,
        color: Colors.white,
        shadowColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/images/no-image.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatCurrency.format(item.price),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.status.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    children: [
                      Badge(
                        label: Text(
                          item.stock > 0 ? '${item.stock} Tersedia' : 'Habis',
                        ),
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        backgroundColor: item.stock > 0
                            ? Colors.green
                            : item.stock <= 3
                                ? Colors.red
                                : Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      ),
                      const SizedBox(width: 6),
                      if (item.status == 2)
                        Badge(
                          label: Text('Draft'),
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                          backgroundColor: Colors.grey.shade400,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
