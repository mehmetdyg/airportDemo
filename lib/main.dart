// ignore_for_file: prefer_const_constructors

import 'package:airport_app/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/airportSearchScreen.dart';
import './providers/airportprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airport App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Airport App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String userName = "admin";
  static const String password = "psw";
  final unController = TextEditingController();
  final pswController = TextEditingController();

  void _checkCredentials(String uName, String psw) {
    if (uName == userName && psw == password) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AirPortPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (ctx) => AirportProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Airport Demo',
        home: LoginScreen(),
      ),
    );
  }
}
