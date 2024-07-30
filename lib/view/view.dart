import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cla_flutter/components/input_field.dart';
import 'package:cla_flutter/components/submit_button.dart';
import 'package:cla_flutter/components/success_dialog.dart';
import 'package:cla_flutter/components/validation_message.dart';
import 'package:cla_flutter/provider/setting_provider.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  final email = TextEditingController();
  final password = TextEditingController();
  final provider = SettingsProvider();
  String _password = '';
  String _email = '';
  bool _isSubmitted = false;
  final _formKey = GlobalKey<FormState>();

  bool get _isPasswordLengthValid =>
      _password.length >= 8 && _password.length <= 64;
  bool get _isPasswordUpperLowerValid =>
      _password.contains(RegExp(r'[A-Z]')) &&
      _password.contains(RegExp(r'[a-z]'));
  bool get _isPasswordDigitValid => _password.contains(RegExp(r'\d'));
  bool get _isEmailValid => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email);

  bool get _isValidPassword =>
      _isPasswordDigitValid &&
      _isPasswordLengthValid &&
      _isPasswordUpperLowerValid;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _password = '';
        _email = '';
        _isSubmitted = false;
      });
      email.clear();
      password.clear();
      _showSuccessDialog();
    } else {
      setState(() {
        _isSubmitted = true;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SuccessDialog();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    password.addListener(() {
      setState(() {
        _password = password.text;
      });
      email.addListener(() {
        setState(() {
          _email = email.text;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(167.96 * 3.14159 / 180),
            colors: [
              Color(0xFFF4F9FF),
              Color(0xFFE0EDFB),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 74, 78, 113)),
                    ),
                  ),
                  InputField(
                    placeholder: 'Email',
                    controller: email,
                    valid: _isEmailValid,
                    isSubmitted: _isSubmitted,
                    validator: (value) => provider.emailValidator(value),
                  ),
                  Consumer<SettingsProvider>(
                      builder: (context, notifier, child) {
                    return InputField(
                      placeholder: 'Create your password',
                      controller: password,
                      valid: _isValidPassword,
                      isVisible: !notifier.isVisible,
                      isSubmitted: _isSubmitted,
                      trailing: IconButton(
                        onPressed: () => notifier.hidePass(),
                        icon: Icon(notifier.isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        color: _isSubmitted
                            ? (_isValidPassword ? Colors.green : Colors.red)
                            : Colors.black,
                      ),
                      validator: (value) => provider.passwordValidator(value),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(right: 75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValidationMessage(
                          message: 'Minimum 8 characters, maximum 64',
                          isValid: _isPasswordLengthValid,
                          isSubmitted: _isSubmitted,
                        ),
                        const SizedBox(height: 4),
                        ValidationMessage(
                          message: 'Uppercase and lowercase letters',
                          isValid: _isPasswordUpperLowerValid,
                          isSubmitted: _isSubmitted,
                        ),
                        const SizedBox(height: 4),
                        ValidationMessage(
                          message: 'At least one digit',
                          isValid: _isPasswordDigitValid,
                          isSubmitted: _isSubmitted,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SubmitButton(
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
