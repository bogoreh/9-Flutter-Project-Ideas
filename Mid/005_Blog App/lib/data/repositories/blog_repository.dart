import '../models/blog_model.dart';

class BlogRepository {
  // In a real app, this would connect to a backend API
  // For now, we'll use mock data
  
  Future<List<Blog>> getBlogs() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      Blog(
        id: '1',
        title: 'The Future of Flutter Development',
        content: '''
Flutter has revolutionized mobile app development with its cross-platform capabilities. 
In this article, we explore the latest trends and future prospects of Flutter development.

With the introduction of Flutter 3.0, developers can now build applications for six platforms 
from a single codebase. This includes mobile, web, desktop, and embedded devices.

The Flutter community continues to grow rapidly, with thousands of packages available 
on pub.dev. This ecosystem makes it easier than ever to add complex functionality 
to your applications.

Looking ahead, we expect to see more integration with AI and machine learning, 
better performance optimizations, and enhanced tooling support.
        ''',
        author: 'Sarah Johnson',
        authorImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150',
        imageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
        category: 'Technology',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        readTime: 5,
        likes: 42,
        tags: ['Flutter', 'Dart', 'Mobile', 'Development'],
      ),
      Blog(
        id: '2',
        title: 'Sustainable Travel: Exploring Eco-Friendly Destinations',
        content: '''
Sustainable travel is more important than ever in today's world. 
Discover how you can explore the world while minimizing your environmental impact.

From eco-lodges in Costa Rica to sustainable safaris in Kenya, there are countless 
opportunities to travel responsibly. This article highlights some of the best 
eco-friendly destinations and practices.

Learn about carbon offset programs, supporting local communities, and choosing 
accommodations that prioritize sustainability. Small changes in our travel habits 
can make a big difference for our planet.
        ''',
        author: 'Mike Chen',
        authorImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
        category: 'Travel',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        readTime: 7,
        likes: 28,
        tags: ['Travel', 'Sustainability', 'Eco-Friendly', 'Adventure'],
      ),
      Blog(
        id: '3',
        title: 'The Art of Home Cooking: Mastering Basic Techniques',
        content: '''
Great cooking starts with mastering the fundamentals. In this comprehensive guide, 
we cover essential techniques that every home cook should know.

From proper knife skills to understanding heat control, these basics will transform 
your cooking experience. Learn how to sauté, roast, braise, and grill like a pro.

We also include tips for meal planning, grocery shopping, and building a well-stocked 
pantry. Whether you're a beginner or looking to refine your skills, this guide has 
something for everyone.
        ''',
        author: 'Emma Rodriguez',
        authorImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
        imageUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800',
        category: 'Food',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        readTime: 8,
        likes: 35,
        tags: ['Cooking', 'Recipes', 'Food', 'Techniques'],
      ),
    ];
  }

  Future<void> addBlog(Blog blog) async {
    // In a real app, this would send data to backend
    await Future.delayed(const Duration(seconds: 1));
  }
}