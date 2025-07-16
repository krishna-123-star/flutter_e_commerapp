import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const _baseUrl = 'https://fakestoreapi.com';
  static const _userId = 1;

  static Future<void> _saveCartId(int cartId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartId', cartId);
  }

  static Future<int?> _getCartId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cartId');
  }

  static Future<bool> addToCart(int productId, {int quantity = 1}) async {
    final cartId = await _getCartId();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (cartId == null) {
      // First time: create new cart
      final response = await http.post(
        Uri.parse('$_baseUrl/carts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": _userId,
          "date": today,
          "products": [
            {"productId": productId, "quantity": quantity}
          ]
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _saveCartId(data['id']);
        return true;
      } else {
        return false;
      }
    } else {
      final response = await http.put(
        Uri.parse('$_baseUrl/carts/$cartId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": _userId,
          "date": today,
          "products": [
            {"productId": productId, "quantity": quantity}
          ]
        }),
      );

      return response.statusCode == 200;
    }
  }

static Future<List<int>> getCartProductIds({int userId = 1}) async {
  final response = await http.get(Uri.parse('$_baseUrl/carts/user/$userId'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    if (data.isEmpty) return [];

    // Get the latest cart (you could improve this to get most recent by date)
    final latestCart = data.last;
    final List<dynamic> products = latestCart['products'];
    return products.map<int>((p) => p['productId'] as int).toList();
  } else {
    return [];
  }
}

static Future<bool> removeFromCart(int productId) async {
  final cartId = await _getCartId();
  if (cartId == null) return false;

  // For simplicity, remove the product by re-sending cart without it.
  final response = await http.get(Uri.parse('$_baseUrl/carts/$cartId'));
  if (response.statusCode != 200) return false;

  final cartData = jsonDecode(response.body);
  final updatedProducts = (cartData['products'] as List)
      .where((p) => p['productId'] != productId)
      .toList();

  final today = DateTime.now().toIso8601String().substring(0, 10);

  final updateRes = await http.put(
    Uri.parse('$_baseUrl/carts/$cartId'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "userId": _userId,
      "date": today,
      "products": updatedProducts,
    }),
  );

  return updateRes.statusCode == 200;
}


  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartId');
  }
}
