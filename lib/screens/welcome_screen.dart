import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashchat/utilities/gradient_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    animation =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOutQuint);

    controller!.forward();

    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset(
                  'images/logo.png',
                  fit: BoxFit.cover,
                ),
                height: animation!.value * 500,
              ),
            ),
          ),
          GradientButton(
              colors: kGradient1,
              inputText: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              animationTag: 'login'),
          GradientButton(
            animationTag: 'signup',
            colors: kGradient2,
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            inputText: 'Sign Up',
          ),
        ],
      ),
    );
  }
}
