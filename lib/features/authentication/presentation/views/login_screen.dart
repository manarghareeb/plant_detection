import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_detection/core/widgets/custom_buttom_widget.dart';
import 'package:plant_detection/core/widgets/custom_text_form_field.dart';
import 'package:plant_detection/features/authentication/presentation/views/register_screen.dart';
import 'package:plant_detection/features/authentication/presentation/views/forget_password_screen.dart';
import 'package:plant_detection/features/authentication/presentation/widgets/auth_navigation_text.dart';

import '../../../../core/Helper/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save login state
      await AuthService.setLoggedIn(true);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // ... (error handling remains the same)
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 55),

              // Email Field
              CustomTextFormField(
                textInputType: TextInputType.emailAddress,
                controller: _emailController, 
                hintText: 'Email', 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Field
              CustomTextFormField(
                obscureText: true,
                textInputType: TextInputType.text,
                controller: _passwordController, 
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Sign In Button
              CustomButtomWidget(
                text: 'Sign In', 
                isLoading: _isLoading,
                onTap: _isLoading ? null : _signIn,
              ),
              // Sign Up Option
              AuthNavigatorText(
                text: 'Don\'t have an account?',
                textButton: 'Sign Up',
                isLoading: _isLoading,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
