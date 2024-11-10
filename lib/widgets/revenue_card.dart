import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_management/api/revenue_api.dart';

class RevenueCard extends StatefulWidget {
  const RevenueCard({
    super.key,
  });

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  late StreamController _streamController;
  late Stream _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;

    fetchTotalRevenue();

    Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchTotalRevenue();
    });
  }

  fetchTotalRevenue() async {
    try {
      final data = await getRevenue();
      _streamController.add(data);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'id_ID', name: 'Rp ', decimalDigits: 0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Error: ${snapshot.error}'),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Pendapatan',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            formatCurrency.format(snapshot.data),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Error: Undefined'),
                        ],
                      );
                    }
                  }),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
