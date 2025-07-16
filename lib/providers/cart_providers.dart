import 'package:ecommerceapp/database/cart_db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>(
  (ref) => CartNotifier(ref),
);

class CartNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  CartNotifier(this.ref) : super([]) {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    // print('[CartNotifier] Loading cart items...');
    final items = await CartDB.getAll();
    // print('[CartNotifier] Loaded ${items.length} items from DB');
    state = items;
  }

  Future<void> add(Product product) async {
    final index = state.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      final updated = product.copyWith(quantity: 1);
      state = [...state, updated];
      await CartDB.insert(updated);
    } else {
      increaseQuantity(product);
    }
  }

  Future<void> remove(Product product) async {
    state = state.where((p) => p.id != product.id).toList();
    await CartDB.delete(product.id);
  }

  Future<void> increaseQuantity(Product product) async {
    state = state.map((item) {
      if (item.id == product.id) {
        final updated = item.copyWith(quantity: item.quantity + 1);
        CartDB.insert(updated);
        return updated;
      }
      return item;
    }).toList();
  }

  Future<void> decreaseQuantity(Product product) async {
    if (product.quantity <= 1) {
      await remove(product);
    } else {
      state = state.map((item) {
        if (item.id == product.id) {
          final updated = item.copyWith(quantity: item.quantity - 1);
          CartDB.insert(updated);
          return updated;
        }
        return item;
      }).toList();
    }
  }

  void clear() {
    state = [];
  }

  bool isInCart(int id) => state.any((p) => p.id == id);
}
