import 'package:flutter/material.dart';
import 'otp_box.dart';

class OtpInput extends StatefulWidget {
  final Function(String otp) onCompleted;
  final GlobalKey<OtpInputState>? globalKey;

  const OtpInput({
    super.key,
    required this.onCompleted,
    this.globalKey,
  });

  @override
  State<OtpInput> createState() => OtpInputState();
}

class OtpInputState extends State<OtpInput> {
  static const int otpLength = 4; // ثابت تمامًا

  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void inputDigit(String digit) {
    if (currentIndex >= otpLength) return;

    controllers[currentIndex].text = digit;
    _updateOtp();

    if (currentIndex < otpLength - 1) {
      currentIndex++;
      focusNodes[currentIndex].requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void deleteDigit() {
    if (currentIndex == 0 && controllers[0].text.isEmpty) return;

    if (controllers[currentIndex].text.isNotEmpty) {
      controllers[currentIndex].clear();
    } else if (currentIndex > 0) {
      currentIndex--;
      controllers[currentIndex].clear();
      focusNodes[currentIndex].requestFocus();
    }

    _updateOtp();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      currentIndex = index + 1;
      if (currentIndex < otpLength) {
        focusNodes[currentIndex].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      currentIndex = index - 1;
      focusNodes[currentIndex].requestFocus();
    }

    _updateOtp();
  }

  void _updateOtp() {
  final otp = controllers.map((c) => c.text).join();

  if (otp.length == otpLength &&
      controllers.every((c) => c.text.isNotEmpty)) {
    widget.onCompleted(otp);
  }
}


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(otpLength, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: OtpBox(
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }
}