import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

/// =======================
/// APP
/// =======================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

/// =======================
/// HOME SCREEN (API-BACKED)
/// =======================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  String _signalLine = "Tap Get Signal";
  String _details = "";

  // ✅ EDIT THESE TWO LINES
  static const String apiUrl = "https://YOUR-WORKER.yourname.workers.dev/api/signal";
  static const String apiKey = "YOUR_SECRET_KEY";

  Future<void> _getSignal() async {
    setState(() {
      _loading = true;
      _details = "";
    });

    try {
      final res = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "x-api-key": apiKey,
          "accept": "application/json",
        },
      );

      if (res.statusCode != 200) {
        throw Exception("API error ${res.statusCode}: ${res.body}");
      }

      final data = jsonDecode(res.body) as Map<String, dynamic>;

      final symbol = (data["symbol"] ?? "XAUUSD").toString();
      final action = (data["action"] ?? "WAIT").toString();
      final entry = (data["entry"] ?? "MARKET").toString();
      final tf = (data["timeframe"] ?? "").toString();
      final reason = (data["reason"] ?? "").toString();

      final sl = data["sl"];
      final tp = data["tp"];
      final confidence = data["confidence"];

      setState(() {
        _signalLine = "$action $symbol @ $entry 🚀";
        _details = [
          if (tf.isNotEmpty) "TF: $tf",
          if (confidence != null) "Conf: $confidence",
          if (sl != null) "SL: $sl",
          if (tp != null) "TP: $tp",
          if (reason.isNotEmpty) "Why: $reason",
        ].join("   •   ");
      });
    } catch (e) {
      setState(() {
        _signalLine = "Couldn’t load signal";
        _details = e.toString();
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _ProBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopBar(),
                  const SizedBox(height: 24),

                  Text(
                    _signalLine,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _details,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),

                  const Spacer(),

                  _PrimaryButton(
                    onPressed: _loading ? null : _getSignal,
                    child: Text(_loading ? "Loading..." : "Get Signal"),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================
/// BUTTON
/// =======================
class _PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const _PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: child,
      ),
    );
  }
}

/// =======================
/// TOP BAR
/// =======================
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "XAU Signals",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Icon(Icons.menu, color: Colors.white),
      ],
    );
  }
}

/// =======================
/// BACKGROUND
/// =======================
class _ProBackground extends StatelessWidget {
  const _ProBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
