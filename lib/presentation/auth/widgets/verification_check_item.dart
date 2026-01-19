import 'package:flutter/material.dart';

class VerificationCheckItem extends StatelessWidget {
  final String text;
  final bool valid;

  const VerificationCheckItem({
    super.key,
    required this.text,
    this.valid = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.cancel,
          color: valid ? Colors.green : Colors.red,
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
