import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                const Upside(imgUrl : "Asset/register.png"),
                const PageTitleBar(title : "Create New Account"),
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
                        const SizedBox(height: 15),
                        const SizedBox(height: 20,),
                        Form(
                          child: Column(
                            children: [
                              const rounderInputField(
                                hintText : "Email",
                                icon : Icons.email,
                              ),
                              const rounderInputField(
                                hintText : "Phone",
                                icon : Icons.phone,
                              ),
                              const rounderPasswordField(),
                              RoundedButton(
                                text: "REGISTER",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                              ),
                              const SizedBox(height: 10,),
                              UnderPart(title: "Already have an account?", navigatorText: "Login here", onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen())
                                );
                              },
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
