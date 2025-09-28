import 'package:flutter/material.dart';
import '../providers/blog_provider.dart';
import '../widgets/blog_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/category_chip.dart';
import 'blog_detail_page.dart';
import 'create_blog_page.dart';
import 'profile_page.dart';
import '../../core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlogProvider _blogProvider = BlogProvider();

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    await _blogProvider.loadBlogs();
    setState(() {});
  }

  void _likeBlog(String blogId) {
    _blogProvider.likeBlog(blogId);
    setState(() {});
  }

  void _setCategory(String category) {
    _blogProvider.setCategory(category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Blog App',
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBlogPage(blogProvider: _blogProvider),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_blogProvider.isLoading && _blogProvider.blogs.isEmpty) {
      return const LoadingIndicator(message: 'Loading blogs...');
    }

    if (_blogProvider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _blogProvider.error!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBlogs,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Categories Filter
        _buildCategoryFilter(),
        
        // Blogs List
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadBlogs,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: _blogProvider.filteredBlogs.length,
              itemBuilder: (context, index) {
                final blog = _blogProvider.filteredBlogs[index];
                return BlogCard(
                  blog: blog,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailPage(
                          blog: blog,
                          onLike: () => _likeBlog(blog.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CategoryChip(
            category: 'All',
            isSelected: _blogProvider.selectedCategory == 'All',
            onTap: () => _setCategory('All'),
          ),
          const SizedBox(width: 8),
          ...AppConstants.categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CategoryChip(
                category: category,
                isSelected: _blogProvider.selectedCategory == category,
                onTap: () => _setCategory(category),
              ),
            );
          }),
        ],
      ),
    );
  }
}