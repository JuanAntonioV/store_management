import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/themes/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: kReleaseMode ? '.env.production' : '.env');
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store Management App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      theme: Provider.of<ThemeProvider>(context).themeData,
      getPages: Routes.routes,
      unknownRoute: Routes.unknownRoute(),
    );
  }
}
