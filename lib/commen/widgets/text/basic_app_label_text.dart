import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class BasicAppLabelText extends StatelessWidget {
  final String title;
  final Color textColor;
  final TapGestureRecognizer? recognizer;

  const BasicAppLabelText({
    super.key,
    required this.title,
    this.textColor = Colors.white,
    this.recognizer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: recognizer?.onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.55,
          color: textColor,
          decoration: recognizer != null ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}
