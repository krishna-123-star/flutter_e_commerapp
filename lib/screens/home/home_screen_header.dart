import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Row(
                  children: [
                    Image.asset(
                      'images/splash_logo.png',
                      height: 32,
                    ), 
                    const SizedBox(width: 8),
                  ],
                ),

                // Profile avatar
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://i.pravatar.cc/150?img=3',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

