// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'airportSearchScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String userName = "admin";
  static const String password = "psw";
  final unController = TextEditingController();
  final pswController = TextEditingController();

  static const loginScreenSnackbar = SnackBar(
    content: Text('Wrong user name or password...'),
  );

  void _checkCredentials(String uName, String psw) {
    if (uName == userName && psw == password) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AirPortPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(loginScreenSnackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
              width: size.width / 1.5,
              child: TextField(
                controller: unController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
              width: size.width / 1.5,
              child: TextField(
                controller: pswController,
                // ignore: prefer_const_constructors
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () =>
                    _checkCredentials(unController.text, pswController.text),
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
