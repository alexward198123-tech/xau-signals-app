import 'package:flutter/material.dart';

void main() {
  runApp(const XauSignalsApp());
}

class XauSignalsApp extends StatelessWidget {
  const XauSignalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'XAU Signals App\nBuild Successful',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
