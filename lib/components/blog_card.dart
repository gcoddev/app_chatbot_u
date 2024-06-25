import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/Blog.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.blog,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRatio;
  final Blog blog;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: GestureDetector(
          onTap: onPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    'http://192.168.0.12:3001/imagenes/${blog.imagen}',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text('Error loading Images'));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                blog.titulo,
                // style: Theme.of(context).textTheme.bodyMedium,
                style: TextStyle(fontSize: 12.0),
                maxLines: 3,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       blog.estado == '1' ? 'Activo' : 'Inactivo',
              //       style: const TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w600,
              //         color: kPrimaryColor,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ));
  }
}
