import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, color: Colors.red, size: 100),
            const SizedBox(height: 8),
            const Text("Home", style: TextStyle(fontSize: 30)),
            const SizedBox(height: 12),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                context.goNamed("subHome");
              },
              child: const Text(
                "Navigate To Sub Home View",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
