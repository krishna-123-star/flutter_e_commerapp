import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/theme/app_colors.dart';
import 'package:ecommerceapp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? product;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final url = 'https://fakestoreapi.com/products/${widget.productId}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        product = Product.fromJson(json);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || product == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ),

            // Product Image
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product!.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product!.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(
                    '₹${product!.price.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: AppColors.subTextBlack,
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product!.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
              ),
            ),

            const Spacer(),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.cart);
                      },
                      child: const Text(AppStrings.goToCart),
                    ),
                  ),
                ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
