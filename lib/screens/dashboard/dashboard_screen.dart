
import 'package:ecommerceapp/navigation/bottom_bar.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/home/home_screen.dart';
import 'package:ecommerceapp/screens/wishlist/wish_list_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    WishlistScreen(),
    CartScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
