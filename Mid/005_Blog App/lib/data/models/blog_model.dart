class Blog {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorImage;
  final String imageUrl;
  final String category;
  final DateTime createdAt;
  final int readTime;
  final int likes;
  final List<String> tags;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorImage,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.readTime,
    this.likes = 0,
    this.tags = const [],
  });

  Blog copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    String? authorImage,
    String? imageUrl,
    String? category,
    DateTime? createdAt,
    int? readTime,
    int? likes,
    List<String>? tags,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      authorImage: authorImage ?? this.authorImage,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      readTime: readTime ?? this.readTime,
      likes: likes ?? this.likes,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'authorImage': authorImage,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'readTime': readTime,
      'likes': likes,
      'tags': tags,
    };
  }

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      authorImage: json['authorImage'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      readTime: json['readTime'],
      likes: json['likes'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}