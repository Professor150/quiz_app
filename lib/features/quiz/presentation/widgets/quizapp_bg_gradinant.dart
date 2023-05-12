import 'package:flutter/material.dart';

class QuizBgColor extends StatelessWidget {
  final Widget child;
  const QuizBgColor({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: child,
    );
  }
}
