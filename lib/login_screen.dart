import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home/home_page.dart';
import 'signUp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.login(
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
        'user-not-found'   => 'No account found with this email.',
        'wrong-password'   => 'Incorrect password. Please try again.',
        'invalid-email'    => 'Please enter a valid email address.',
        'user-disabled'    => 'This account has been disabled.',
        _                  => 'Login failed. Please try again.',
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
                const Upside(imgUrl: "Asset/login.png"),
                const PageTitleBar(title: "Login to your account"),
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
                                text: "LOGIN",
                                press: _handleLogin,
                              ),
                              const SizedBox(height: 10),
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Register here",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SignupScreen()),
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
class UnderPart extends StatelessWidget{
  const UnderPart({ Key? key,required this.title, required this.navigatorText, required this.onTap }) : super(key : key);
  final String title;
  final String navigatorText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF0da86c),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 20,),
        InkWell(
          onTap: () {
            onTap!();
          },
          child: Text(navigatorText,
            style: TextStyle(
              color: Color(0xFF0da86c),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

}

class RoundedButton extends StatelessWidget{

  const RoundedButton({ Key? key,required this.press,this.textColor = Colors.white, required this.text }) : super(key : key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton () {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
        ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0da86c),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: TextStyle(
          letterSpacing: 2,
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,

        ),
      ),
    );
  }
}


class Upside extends StatelessWidget{
  const Upside({ Key? key,required this.imgUrl }) : super(key : key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: Color(0xFF0da86c),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 8,
            ),
          ),
        ),
      ],
    );
  }
}


class PageTitleBar extends StatelessWidget{
  const PageTitleBar({ Key? key,required this.title }) : super(key : key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 240.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0da86c),
            ),
          ),
        ),
      ),
    );
  }
}


class rounderIcon extends StatelessWidget{
  const rounderIcon({ Key? key,required this.imgUrl }) : super(key : key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 0.6,
            )
          ],
          image: DecorationImage(
            image: AssetImage(imgUrl),
          ),
        ),
      ),
    );
  }
}

class rounderInputField extends StatelessWidget {
  const rounderInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget{

  const TextFieldContainer({ Key? key,required this.child }) : super(key : key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width *0.8,
      decoration: BoxDecoration(
        color: Color(0xFF0da86c),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class rounderPasswordField extends StatefulWidget {
  const rounderPasswordField({Key? key, this.controller, this.validator})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<rounderPasswordField> createState() => _rounderPasswordFieldState();
}

class _rounderPasswordFieldState extends State<rounderPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscure,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock, color: Colors.white),
          hintText: "Password",
          hintStyle: const TextStyle(color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
