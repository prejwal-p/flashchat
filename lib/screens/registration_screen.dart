import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/utilities/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _reenterPassword;
  bool _validate = true;
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
  }

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
                cursorColor: kColor2Light,
                decoration:
                    kTextFieldType2.copyWith(hintText: 'Enter Your E-mail'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                cursorColor: kColor2Light,
                decoration:
                    kTextFieldType2.copyWith(hintText: 'Enter Your Password'),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                onChanged: (value) {
                  _reenterPassword = value;
                },
                cursorColor: kColor2Light,
                decoration: kTextFieldType2.copyWith(
                  hintText: 'Re-Enter Your Password',
                  errorText: _validate ? null : 'Passwords Do Not Match',
                ),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
            ),
            GradientButton(
              animationTag: 'signup',
              colors: kGradient2,
              inputText: 'Sign Up',
              onPressed: () {
                setState(() {
                  _showSpinner = true;
                });
                setState(() async {
                  if (_reenterPassword == password) {
                    _validate = true;
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email!, password: password!);

                      Navigator.pushNamed(context, ChatScreen.id);
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    _validate = false;
                    _showSpinner = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
