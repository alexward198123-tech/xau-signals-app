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

                const Text(
                  "XAUUSD",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Signals – clean, simple, professional",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),

                const Spacer(),

                _PrimaryButton(
                  onPressed: () {
                    // TODO: action
                  },
                  child: const Text("API-ready build"),
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
