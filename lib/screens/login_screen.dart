import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/utilities/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingOverlay(
        isLoading: _showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                cursorColor: kColor1Light,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    kTextFieldType1.copyWith(hintText: 'Enter Your E-mail'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                cursorColor: kColor1Light,
                decoration:
                    kTextFieldType1.copyWith(hintText: 'Enter Your Password'),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            GradientButton(
              colors: kGradient1,
              inputText: 'Log In',
              animationTag: 'login',
              onPressed: () async {
                setState(() {
                  _showSpinner = true;
                });
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email!, password: password!);

                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  print(e);
                }
                setState(() {
                  _showSpinner = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
