import 'package:flutter/material.dart';

void main() {
  runApp(const XauSignalsApp());
}

/// APP ROOT
class XauSignalsApp extends StatelessWidget {
  const XauSignalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XAU Signals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: null,
      ),
      home: const HomeScreen(),
    );
  }
}

/// MODELS
class TradingSignal {
  final String side; // BUY / SELL
  final String entry; // e.g. "@ Market" or "2345.20"
  final String? sl;
  final String? tp1;
  final String? note;
  final DateTime createdAt;

  const TradingSignal({
    required this.side,
    required this.entry,
    this.sl,
    this.tp1,
    this.note,
    required this.createdAt,
  });
}

/// SIGNAL PROVIDER (swap this later for real API)
abstract class SignalProvider {
  Future<TradingSignal> fetchSignal();
}

/// MOCK PROVIDER (for now)
class MockSignalProvider implements SignalProvider {
  @override
  Future<TradingSignal> fetchSignal() async {
    await Future.delayed(const Duration(milliseconds: 700));
    // Clean “placeholder” signal. Later this will come from your logic/API.
    return TradingSignal(
      side: "BUY",
      entry: "@ Market",
      sl: "SL: 2338.0",
      tp1: "TP: 2372.0",
      note: "Demo signal (API next)",
      createdAt: DateTime.now(),
    );
  }
}

/// HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignalProvider _provider = MockSignalProvider();

  TradingSignal? _signal;
  bool _loading = false;

  Future<void> _getSignal() async {
    setState(() => _loading = true);
    try {
      final s = await _provider.fetchSignal();
      if (!mounted) return;
      setState(() => _signal = s);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Couldn’t fetch signal. Try again.")),
      );
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
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopBar(),
                  const SizedBox(height: 26),
                  Text(
                    "XAUUSD",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Signals — clean, simple, fast.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _SignalCard(signal: _signal),
                  const Spacer(),
                  _PrimaryButton(
                    text: _loading ? "Getting signal..." : "Get Signal",
                    onTap: _loading ? null : _getSignal,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "API-ready build
