import 'dart:ui';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/providers/cart_providers.dart';
import 'package:ecommerceapp/providers/wishlist_provider.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onWishlist;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onWishlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(wishlistProvider).any((item) => item.id == product.id);
    final isInCart = ref.watch(cartProvider).any((item) => item.id == product.id);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    product.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onWishlist,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withAlpha(26),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () async {
                      if (!isInCart) {
                        final success = await CartService.addToCart(product.id);
                        if (success) {
                          ref.read(cartProvider.notifier).add(product);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(AppStrings.addedToCart),
                                action: SnackBarAction(
                                  label: AppStrings.goToCart,
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.cart);
                                  },
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isInCart ? AppColors.white : AppColors.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withAlpha(26),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                        color: isInCart ? AppColors.black : AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
