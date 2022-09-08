import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      @required this.colors,
      @required this.inputText,
      this.onPressed,
      @required this.animationTag})
      : super(key: key);

  final String? inputText;
  final List<Color>? colors;
  final void Function()? onPressed;
  final String? animationTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: animationTag!,
        child: Material(
          elevation: 5.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(colors: colors!)),
            child: MaterialButton(
              onPressed: onPressed!,
              minWidth: 200.0,
              height: 60.0,
              child: Text(
                inputText!,
                style: TextStyle(fontSize: kBodyText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
