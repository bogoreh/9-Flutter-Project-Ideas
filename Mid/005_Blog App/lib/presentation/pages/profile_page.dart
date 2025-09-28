import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Flutter Developer & Blogger',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildStatItem(context, '12', 'Posts'),
                            const SizedBox(width: 16),
                            _buildStatItem(context, '1.2K', 'Followers'),
                            const SizedBox(width: 16),
                            _buildStatItem(context, '356', 'Following'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Settings Options
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              _buildSettingsItem(
                context,
                Icons.person,
                'Edit Profile',
                Icons.arrow_forward_ios,
                () {},
              ),
              _buildSettingsItem(
                context,
                Icons.notifications,
                'Notifications',
                Icons.arrow_forward_ios,
                () {},
              ),
              _buildSettingsItem(
                context,
                Icons.security,
                'Privacy & Security',
                Icons.arrow_forward_ios,
                () {},
              ),
              _buildSettingsItem(
                context,
                Icons.help,
                'Help & Support',
                Icons.arrow_forward_ios,
                () {},
              ),
              _buildSettingsItem(
                context,
                Icons.info,
                'About',
                Icons.arrow_forward_ios,
                () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData leadingIcon,
    String title,
    IconData trailingIcon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: Icon(trailingIcon, size: 16),
      onTap: onTap,
    );
  }
}