import 'package:flutter/material.dart';

void main() {
  runApp(const XauSignalsApp());
}

class XauSignalsApp extends StatelessWidget {
  const XauSignalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = 'No signal yet';

  void generateSignal() {
    setState(() {
      message = 'BUY XAUUSD @ Market 🚀';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XAU Signals'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateSignal,
              child: const Text('Get Signal'),
            ),
          ],
        ),
      ),
    );
  }
}
