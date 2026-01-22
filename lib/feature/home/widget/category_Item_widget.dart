import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quomodo/feature/home/model/home_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CachedNetworkImage(
              imageUrl: "https://mamunuiux.com/flutter_task/${category.image}",
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            category.name,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
