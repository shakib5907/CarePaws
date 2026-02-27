import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home/home_page.dart';
import 'signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                const Upside(imgUrl : "Asset/login.png"),
                const PageTitleBar(title : "Login to your account"),
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
                              const rounderPasswordField(),
                              RoundedButton(
                                text: "LOGIN",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                              ),
                              const SizedBox(height: 10,),
                              UnderPart(title: "Don't have an account?", navigatorText: "Register here", onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const SignupScreen())
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
            color: Colors.grey,
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
      padding: const EdgeInsets.only(top: 260.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: Color(0xfffeeeee4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Color(0xfff575861),
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

class rounderInputField extends StatelessWidget{

  const rounderInputField({ Key? key,required this.hintText, this.icon = Icons.person }) : super(key : key);
  final String? hintText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: Color(0xfff1bb274),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xfff1bb274),
          ),
          hintText: hintText,
          border: InputBorder.none,
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
        color: Color(0xfffeeeee4),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class rounderPasswordField extends StatelessWidget{

  const rounderPasswordField({ Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        cursorColor: Color(0xFF0da86c),
        decoration: const InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Color(0xfff1bb274),
          ),
          hintText: "Password",
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF0da86c),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

}
