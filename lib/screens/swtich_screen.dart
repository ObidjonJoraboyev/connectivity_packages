import 'package:connectivity_packages/screens/currencies_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CurrenciesScreen()));
                },
                child: const Text("With Bloc")),
            TextButton(
                onPressed: () {}, child: const Text("With Cubit (single)")),
            TextButton(
                onPressed: () {}, child: const Text("With Cubit (multi)")),
          ],
        ),
      ),
    );
  }
}
