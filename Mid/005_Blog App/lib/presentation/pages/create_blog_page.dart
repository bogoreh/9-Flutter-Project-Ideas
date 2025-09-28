import 'package:flutter/material.dart';
import '../providers/blog_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../../data/models/blog_model.dart';
import '../../core/constants/app_constants.dart';

class CreateBlogPage extends StatefulWidget {
  final BlogProvider blogProvider;

  const CreateBlogPage({super.key, required this.blogProvider});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _readTimeController = TextEditingController();
  
  String _selectedCategory = 'Technology';
  String _imageUrl = '';

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _readTimeController.dispose();
    super.dispose();
  }

  void _submitBlog() {
    if (_formKey.currentState!.validate()) {
      final blog = Blog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        author: 'John Doe',
        authorImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        imageUrl: _imageUrl.isEmpty 
            ? 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800'
            : _imageUrl,
        category: _selectedCategory,
        createdAt: DateTime.now(),
        readTime: int.tryParse(_readTimeController.text) ?? 5,
        tags: _extractTags(_contentController.text),
      );

      widget.blogProvider.addBlog(blog).then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blog published successfully!')),
        );
      });
    }
  }

  List<String> _extractTags(String content) {
    final words = content.split(' ');
    return words
        .where((word) => word.startsWith('#') && word.length > 1)
        .map((tag) => tag.substring(1))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Blog',
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: _submitBlog,
            child: const Text('Publish'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Blog Title',
                hintText: 'Enter a catchy title...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: AppConstants.categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Read Time Field
            TextFormField(
              controller: _readTimeController,
              decoration: const InputDecoration(
                labelText: 'Read Time (minutes)',
                hintText: '5',
              ),
              keyboardType: TextInputType.number,
            ),
            
            const SizedBox(height: 16),
            
            // Image URL Field
            TextFormField(
              onChanged: (value) => _imageUrl = value,
              decoration: const InputDecoration(
                labelText: 'Image URL (optional)',
                hintText: 'https://example.com/image.jpg',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Content Field
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Blog Content',
                hintText: 'Write your blog content here...\n\nUse #hashtags for tags!',
                alignLabelWithHint: true,
              ),
              maxLines: 15,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter blog content';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}