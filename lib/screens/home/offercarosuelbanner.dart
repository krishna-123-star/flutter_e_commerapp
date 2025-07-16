import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/theme/app_colors.dart';

class OfferCarouselBanner extends StatefulWidget {
  const OfferCarouselBanner({super.key});

  @override
  State<OfferCarouselBanner> createState() => _OfferCarouselBannerState();
}

class _OfferCarouselBannerState extends State<OfferCarouselBanner> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _offers = [
    {
      'title': '50-40% OFF',
      'subtitle': 'Now in (product)',
      'desc': 'All colours',
      'image': 'images/home_1.jpg', 
    },
    {
      'title': 'Summer Sale',
      'subtitle': 'Upto 70% OFF',
      'desc': 'On selected items',
      'image': 'images/home_1.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: _offers.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final offer = _offers[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(offer['image']!),
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer['title']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer['subtitle']!,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    Text(
                      offer['desc']!,
                      style: const TextStyle(color: Colors.black45),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {Navigator.pushNamed(context, AppRoutes.search);},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.black),
                        foregroundColor: AppColors.black,
                      ),
                      child: const Text('Shop Now →'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_offers.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primary
                    : AppColors.pageIndicatorColor,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
