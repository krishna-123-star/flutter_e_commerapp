import 'package:ecommerceapp/screens/product/product_details.dart';
import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:ecommerceapp/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/wishlist_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    // print("[WishlistScreen] Wishlist length: ${wishlist.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlist),
        backgroundColor: AppColors.white,
        elevation: 1,
      ),
      body: wishlist.isEmpty
          ? const Center(child: Text(AppStrings.noWishlist))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7, 
              ),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailScreen(productId: product.id),
                      ),
                    );
                  },
                  onWishlist: () {
                    ref.read(wishlistProvider.notifier).toggleWishlist(product);
                  },
                );
              },
            ),
    );
  }
}
