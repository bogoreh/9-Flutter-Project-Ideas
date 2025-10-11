import '../models/user_model.dart';

class DemoData {
  static final List<User> demoUsers = [
    const User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      isOnline: true,
      lastSeen: 'Just now',
    ),
    const User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      isOnline: false,
      lastSeen: '2 hours ago',
    ),
    const User(
      id: '3',
      name: 'Mike Johnson',
      email: 'mike@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?w=150&h=150&fit=crop&crop=face',
      isOnline: true,
      lastSeen: 'Online',
    ),
    const User(
      id: '4',
      name: 'Sarah Wilson',
      email: 'sarah@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      isOnline: false,
      lastSeen: '1 day ago',
    ),
    const User(
      id: '5',
      name: 'Alex Chen',
      email: 'alex@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      isOnline: true,
      lastSeen: 'Online',
    ),
  ];

  static final List<User> demoCalls = [
    const User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      isOnline: true,
      lastSeen: 'Just now',
    ),
    const User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      isOnline: false,
      lastSeen: '2 hours ago',
    ),
    const User(
      id: '3',
      name: 'Mike Johnson',
      email: 'mike@example.com',
      imageUrl: 'https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?w=150&h=150&fit=crop&crop=face',
      isOnline: true,
      lastSeen: 'Online',
    ),
  ];
}