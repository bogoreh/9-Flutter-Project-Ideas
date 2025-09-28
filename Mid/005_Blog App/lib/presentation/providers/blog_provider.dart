import 'package:flutter/material.dart';
import '../../data/models/blog_model.dart';
import '../../data/repositories/blog_repository.dart';

class BlogProvider with ChangeNotifier {
  final BlogRepository _repository = BlogRepository();
  
  List<Blog> _blogs = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'All';

  List<Blog> get blogs => _blogs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  List<Blog> get filteredBlogs {
    if (_selectedCategory == 'All') {
      return _blogs;
    }
    return _blogs.where((blog) => blog.category == _selectedCategory).toList();
  }

  Future<void> loadBlogs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _blogs = await _repository.getBlogs();
    } catch (e) {
      _error = 'Failed to load blogs: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBlog(Blog blog) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.addBlog(blog);
      _blogs.insert(0, blog);
    } catch (e) {
      _error = 'Failed to add blog: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void likeBlog(String blogId) {
    final index = _blogs.indexWhere((blog) => blog.id == blogId);
    if (index != -1) {
      final blog = _blogs[index];
      _blogs[index] = blog.copyWith(likes: blog.likes + 1);
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}