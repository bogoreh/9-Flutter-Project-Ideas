import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Or login with'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.g_translate,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.facebook,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.apple,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 24,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.blue,
      ),
    );
  }
}