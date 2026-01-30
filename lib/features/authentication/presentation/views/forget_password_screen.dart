import 'package:flutter/material.dart';
import 'package:plant_detection/core/widgets/custom_buttom_widget.dart';
import 'package:plant_detection/core/widgets/custom_text_form_field.dart';
import 'package:plant_detection/features/authentication/presentation/widgets/auth_navigation_text.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Forget Password',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'Enter your registered email address and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 30),

            // Email input
            CustomTextFormField(
              controller: emailController,
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            // Send button
            CustomButtomWidget(
              text: 'Send Reset Link',
              isLoading: false,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Back to Login
            AuthNavigatorText(
              isLoading: false,
              text: "Remember your password?",
              textButton: "Log In",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
