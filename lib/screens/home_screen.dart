import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_management/routes/routes.dart';
import 'package:store_management/services/auth_service.dart';
import 'package:store_management/themes/theme_provider.dart';
import 'package:store_management/widgets/all_product_list.dart';
import 'package:store_management/widgets/draft_product_list.dart';
import 'package:store_management/widgets/revenue_card.dart';
import 'package:store_management/widgets/search_section.dart';
import 'package:store_management/widgets/user_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Tab> tabs = [
    Tab(text: 'Produk Aktif'),
    Tab(text: 'Draft'),
  ];

  final _auth = AuthService();

  // theme mode
  ThemeProvider themeProvider = ThemeProvider();

  bool isDark = false;

  setPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);
  }

  @override
  void initState() {
    super.initState();
    checkUser();
    getPreference();
  }

  checkUser() async {
    final user = await _auth.currentUser;

    if (user == null) {
      Get.offAllNamed(Routes.login);
    }
  }

  getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isDark')) {
      setState(() {
        isDark = prefs.getBool('isDark')!;
      });
    }
  }

  onDarkModeChange() {
    setPreference(!isDark);
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: DefaultTabController(
          length: tabs.length,
          initialIndex: 0,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 370,
                  floating: true,
                  toolbarHeight: 0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserProfile(),
                              SizedBox(width: size.width * 0.02),
                              // dark mode button
                              IconButton(
                                onPressed: () {
                                  onDarkModeChange();
                                },
                                icon: Icon(
                                  isDark ? Icons.dark_mode : Icons.light_mode,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          RevenueCard(),
                          SizedBox(height: size.height * 0.03),
                          SearchSection(),
                        ],
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    tabs: tabs,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Theme.of(context).primaryColor,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                AllProductList(),
                DraftProductList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
