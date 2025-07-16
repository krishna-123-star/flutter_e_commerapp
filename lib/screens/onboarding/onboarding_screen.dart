import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}



class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'images/on1.png',
      'title': 'Choose Products',
      'description':
          'Browse and choose your favorite items from various categories.',
    },
    {
      'image': 'images/on2.png',
      'title': 'Make Payment',
      'description': 'Secure payment methods with just a few taps.',
    },
    {
      'image': 'images/on3.png',
      'title': 'Get Your Order',
      'description':
          'Fast delivery right at your doorstep. Track and receive your orders with ease.',
    },
  ];

void _nextPage() {
  if (_currentPage < _pages.length - 1) {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  } else {
    _completeOnboarding();
  }
}


  Future<void> _completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasSeenOnboarding', true);
  Navigator.pushReplacementNamed(context, AppRoutes.main);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page['image']!, height: 280),
                      const SizedBox(height: 40),
                      Text(
                        page['title']!,
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page['description']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: AppColors.subTextBlack,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Skip button
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: () =>
                    _completeOnboarding(),
                child: Text(
                  AppStrings.skip,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            // Page indicator and next/start button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.pageIndicatorColor
                              : AppColors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 24,
                        ),
                        child: TextButton(
                          onPressed: _nextPage,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            _currentPage == _pages.length - 1
                                ? AppStrings.getStarted
                                : AppStrings.next,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
