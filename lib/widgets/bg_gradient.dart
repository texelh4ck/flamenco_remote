import 'package:flutter/material.dart';

class BgGradient extends StatelessWidget {
  final Widget child;

  const BgGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1, 1),
          colors: [
            Colors.deepPurple.withOpacity(0.2),
            Colors.blue.shade900.withOpacity(0.1),
          ],
        ),
      ),
      child: child,
    );
  }
}
