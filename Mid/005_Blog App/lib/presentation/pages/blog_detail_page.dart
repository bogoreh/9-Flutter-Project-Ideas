import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../../data/models/blog_model.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;
  final VoidCallback? onLike;

  const BlogDetailPage({
    super.key,
    required this.blog,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Blog Post',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                blog.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Title
            Text(
              blog.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            const SizedBox(height: 16),
            
            // Author Info and Stats
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(blog.authorImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.author,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        '${blog.readTime} min read • ${_formatDate(blog.createdAt)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                
                // Like Button
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 28,
                      ),
                      onPressed: onLike,
                    ),
                    Text(
                      blog.likes.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Content
            Text(
              blog.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    fontSize: 16,
                  ),
            ),
            
            const SizedBox(height: 20),
            
            // Tags
            Wrap(
              spacing: 8,
              children: blog.tags.map((tag) {
                return Chip(
                  label: Text(
                    '#$tag',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}