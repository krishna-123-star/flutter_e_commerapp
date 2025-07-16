import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerceapp/screens/home/home_screen.dart';
import 'package:ecommerceapp/screens/onboarding/onboarding_screen.dart';
import 'package:ecommerceapp/screens/product/search_screen.dart';
import 'package:ecommerceapp/screens/splash/splash_screen.dart';
import 'package:ecommerceapp/screens/wishlist/wish_list_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const main = '/main';
  static const home = '/home';
  static const wishList = '/wishlist';
  static const search = '/search';
  static const profile = '/profile';
  static const cart = '/cart';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => SplashScreen(),
    onboarding: (_) => OnboardingScreen(),
    main: (_) => MainScreen(),
    home: (_) => HomePage(),
    wishList: (_) => WishlistScreen(),
    search: (_) => SearchScreen(),
    cart: (_) => CartScreen()
  };
}