import 'package:flutter/material.dart';
import 'package:group_application/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 225, 225, 225),
          body: const SingleChildScrollView(child: Home()),
          appBar: AppBar(
            title: const Text(
              'Divide Into Groups',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          )),
    );
  }
}
