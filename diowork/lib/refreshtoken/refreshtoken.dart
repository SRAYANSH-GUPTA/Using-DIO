import 'package:flutter/material.dart';

class Refreshtoken extends StatefulWidget {
  const Refreshtoken({super.key});

  @override
  State<Refreshtoken> createState() => _RefreshtokenState();
}

class _RefreshtokenState extends State<Refreshtoken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refresh Token"),
      ),
    );
  }
}