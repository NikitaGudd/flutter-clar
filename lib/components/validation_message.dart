import 'package:flutter/material.dart';

class ValidationMessage extends StatelessWidget {
  final String message;
  final bool isValid;
  final bool isSubmitted;

  const ValidationMessage({
    super.key,
    required this.message,
    required this.isValid,
    required this.isSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (isValid) {
        return Colors.green;
      } else if (!isValid && isSubmitted) {
        return Colors.red;
      }
      return const Color.fromARGB(255, 74, 78, 113);
    }

    return Text(
      message,
      style: TextStyle(color: getColor(), fontSize: 13),
    );
  }
}
