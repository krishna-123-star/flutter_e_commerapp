import 'package:ecommerceapp/providers/wishlist_provider.dart';
import 'package:ecommerceapp/screens/product/product_details.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/product_card.dart';
import '../../providers/product_provider.dart';

final isGridViewProvider = StateProvider<bool>(
  (ref) => false,
);

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final isGrid = ref.watch(isGridViewProvider); 

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.products),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              ref.read(isGridViewProvider.notifier).state = !isGrid;
            },
          ),
        ],
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (products) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: isGrid
                ? GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
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
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ProductCard(
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
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
