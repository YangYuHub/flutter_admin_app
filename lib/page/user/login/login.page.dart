import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Text('Login'),
    );
  }
}
