import 'package:ecommerceapp/database/wishlist_db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) => WishlistNotifier(),
);
class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]) {
    // print("[WishlistNotifier] Constructor called");
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    // print("[WishlistNotifier] Loading wishlist from DB...");
    final items = await WishlistDB.getAll();
    // print("[WishlistNotifier] Loaded ${items.length} items from DB");
    for (var item in items) {
      print("[Wishlist Item] ${item.title} (ID: ${item.id})");
    }
    state = items;
  }

  void toggleWishlist(Product product) async {
    final exists = state.any((p) => p.id == product.id);
    if (exists) {
      //  print("[WishlistNotifier] Removing ${product.title} from wishlist");
      state = state.where((p) => p.id != product.id).toList();
      await WishlistDB.delete(product.id);
    } else {
      // print("[WishlistNotifier] Adding ${product.title} to wishlist");
      state = [...state, product];
      await WishlistDB.insert(product);
    }
  }

  bool isInWishlist(String id) => state.any((p) => p.id == id);
}
