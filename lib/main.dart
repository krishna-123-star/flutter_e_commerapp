import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppEntry(),
    ),
  );
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.white,
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
