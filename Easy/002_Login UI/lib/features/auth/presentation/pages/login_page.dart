import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_buttons.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthProvider _authProvider = AuthProvider();
  bool _isLoading = false;

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    await _authProvider.login(email, password);

    setState(() {
      _isLoading = _authProvider.isLoading;
    });

    // Navigate to home page if login successful
    if (_authProvider.isLoggedIn) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Center(
              child: FlutterLogo(
                size: 80,
                style: FlutterLogoStyle.stacked,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue your journey',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 40),
            LoginForm(
              onLogin: _handleLogin,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 40),
            const SocialLoginButtons(),
            const SizedBox(height: 32),
            Center(
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}