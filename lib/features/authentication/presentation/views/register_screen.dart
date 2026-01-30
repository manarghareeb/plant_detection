import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_detection/core/widgets/custom_buttom_widget.dart';
import 'package:plant_detection/core/widgets/custom_text_form_field.dart';
import 'package:plant_detection/features/authentication/presentation/widgets/auth_navigation_text.dart';
import 'package:plant_detection/features/home/presentation/views/bottom_navigation_bar_screen.dart';
import '../../../../core/Helper/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();
  final _countryController = TextEditingController();

  bool _isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // Add user details to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'dob': _dobController.text.trim(),
        'country': _countryController.text.trim(),
        'photoUrl': '', // You can add photo URL after uploading
        'createdAt': FieldValue.serverTimestamp(),
        'uid': userCredential.user?.uid, // Store user ID for reference
      });

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save login state
      await AuthService.setLoggedIn(true);

      if (!mounted) return;

      // Navigate directly to home screen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(),
        ),
      );

      // Show success message with verification reminder
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration successful! Please check your email for verification.',
          ),
          duration: Duration(seconds: 5),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'Password should be at least 6 characters.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage =
            'This email is already registered. Please login instead.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Email/password accounts are not enabled.';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An unexpected error occurred. Please try again.',
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                // Name
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  controller: _nameController,
                  hintText: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Email
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
                // Phone
                CustomTextFormField(
                  textInputType: TextInputType.phone,
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Date of Birth
                CustomTextFormField(
                  controller: _dobController,
                  hintText: 'Date of Birth',
                  textInputType: TextInputType.none,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  suffixIcon: Icons.calendar_today,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Country
                CustomTextFormField(
                  controller: _countryController,
                  hintText: 'Country',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Password
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                  obscureText: true,
                  validator:
                      (value) => value!.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 40),
                // Sign Up Button
                CustomButtomWidget(
                  text: 'Sign Up',
                  isLoading: _isLoading,
                  onTap: _isLoading ? null : _signUp,
                ),
                const SizedBox(height: 20),
                // Already have account
                AuthNavigatorText(
                  isLoading: _isLoading,
                  text: "Already have an account?",
                  textButton: "Log In",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
