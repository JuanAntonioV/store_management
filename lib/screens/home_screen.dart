import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            Text('Home Screen'),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.login);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
