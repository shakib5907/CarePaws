import 'package:carepaws/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const CarePaws());
}

class CarePaws extends StatelessWidget{
  const CarePaws({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}