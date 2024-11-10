import 'package:get/get.dart';
import 'package:store_management/screens/add_product_screen.dart';
import 'package:store_management/screens/home_screen.dart';
import 'package:store_management/screens/login_screen.dart';
import 'package:store_management/screens/not_found_screen.dart';
import 'package:store_management/screens/register_screen.dart';

class Routes {
  static String home = "/";
  static String login = "/login";
  static String register = "/register";
  static String notFound = "/not-found";
  static String profile = "/profile";
  static String addProduct = "/add-product";
  static String productDetail = "/product-detail";

  static String getHomeRoute() => home;

  static GetPage unknownRoute() {
    return GetPage(
      name: notFound,
      page: () => const NotFoundScreen(),
    );
  }

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    // GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: addProduct, page: () => AddProductScreen()),
    // GetPage(name: productDetail, page: () => ProductDetailScreen()),
  ];
}
