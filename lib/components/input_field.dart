import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String placeholder;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final bool isSubmitted;
  final bool valid;
  final bool isVisible;
  final Widget? trailing;

  const InputField(
      {super.key,
      this.placeholder = 'Enter something',
      this.validator,
      this.controller,
      this.valid = false,
      this.isSubmitted = false,
      this.isVisible = false,
      this.trailing});

  Color get colorVariant =>
      isSubmitted ? (valid ? Colors.green : Colors.red) : Colors.transparent;
  Color get focusedBorderVariant => isSubmitted
      ? (valid ? Colors.green : Colors.red)
      : const Color.fromARGB(255, 111, 144, 188);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: SizedBox(
        width: 345,
        child: TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isVisible,
          style: TextStyle(
              color: isSubmitted
                  ? (valid ? Colors.green : Colors.red)
                  : Colors.black),
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: trailing,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorVariant,
                width: valid ? 1 : 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: focusedBorderVariant,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorVariant,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorVariant,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
