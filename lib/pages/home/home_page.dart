import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/pages/account/account_page.dart';
import 'package:pet_care_app/pages/auth/sign_in_page.dart';
import 'package:pet_care_app/pages/auth/sign_up_page.dart';
import 'package:pet_care_app/pages/cart/cart_history.dart';
import 'package:pet_care_app/pages/home/main_food_page.dart';
import 'package:pet_care_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const label = "";
  List pages = [
    MainFoodPage(),
    SignInPage(),
    CartHistory(),
    AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: label,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
            ),
            label: label,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: label,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: label,
          ),
        ],
      ),
    );
  }
}
