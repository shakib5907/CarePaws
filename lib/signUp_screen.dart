import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'home/home_page.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.register(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = switch (e.code) {
        'email-already-in-use' => 'This email is already registered.',
        'invalid-email'        => 'Please enter a valid email address.',
        'weak-password'        => 'Password must be at least 6 characters.',
        _                      => 'Registration failed. Please try again.',
      };
      _showSnackBar(message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(imgUrl: "Asset/register.png"),
                const PageTitleBar(title: "Create New Account"),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              rounderInputField(
                                hintText: "Full Name",
                                icon: Icons.person,
                                controller: _nameController,
                                validator: (val) =>
                                val == null || val.trim().isEmpty
                                    ? 'Please enter your full name'
                                    : null,
                              ),
                              rounderInputField(
                                hintText: "Email",
                                icon: Icons.email,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) =>
                                val == null || !val.contains('@')
                                    ? 'Please enter a valid email'
                                    : null,
                              ),
                              rounderPasswordField(
                                controller: _passwordController,
                                validator: (val) =>
                                val == null || val.length < 6
                                    ? 'Password must be at least 6 characters'
                                    : null,
                              ),
                              _isLoading
                                  ? const CircularProgressIndicator(
                                  color: Color(0xFF0da86c))
                                  : RoundedButton(
                                text: "REGISTER",
                                press: _handleRegister,
                              ),
                              const SizedBox(height: 10),
                              UnderPart(
                                title: "Already have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginScreen()),
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}