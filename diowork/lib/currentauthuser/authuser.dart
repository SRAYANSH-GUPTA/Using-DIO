import 'package:flutter/material.dart';

class Authuser extends StatefulWidget {
  const Authuser({super.key});

  @override
  State<Authuser> createState() => _AuthuserState();
}

class _AuthuserState extends State<Authuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth user"),
      ),
    );
  }
}