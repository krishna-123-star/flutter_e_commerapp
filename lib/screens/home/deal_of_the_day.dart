import 'package:ecommerceapp/screens/product/product_details.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:ecommerceapp/widgets/product_card.dart';
import 'package:ecommerceapp/providers/product_provider.dart';
import 'package:ecommerceapp/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealOfTheDay extends ConsumerWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider);

    return productAsync.when(
      loading: () => const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => const SizedBox(
        height: 250,
        child: Center(child: Text(AppStrings.errorLoading)),
      ),
      data: (products) {
        final dealProducts = products.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16)),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dealProducts.length,
                itemBuilder: (context, index) {
                  final product = dealProducts[index];
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
                      ref
                          .read(wishlistProvider.notifier)
                          .toggleWishlist(product);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
