import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: Validators.validateEmail,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: _obscurePassword,
            controller: _passwordController,
            validator: Validators.validatePassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Login',
            onPressed: _submitForm,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}