class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final bool isOnline;
  final String lastSeen;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.isOnline,
    required this.lastSeen,
  });
}