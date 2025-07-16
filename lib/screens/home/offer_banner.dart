import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/home/deal_of_the_day.dart';
import 'package:ecommerceapp/screens/home/offercarosuelbanner.dart';
import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: OfferCarouselBanner(),
        ),

        const SizedBox(height: 24),

        // Deal of the Day
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    AppStrings.dealOfDay,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),

                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.white),
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    onPressed: () { Navigator.pushNamed(context, AppRoutes.search);},
                    child: Text(
                      AppStrings.viewAll,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Product List
        DealOfTheDay(),
        const SizedBox(height: 24),
      ],
    );
  }
}
