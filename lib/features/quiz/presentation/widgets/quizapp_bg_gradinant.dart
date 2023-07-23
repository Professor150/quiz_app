import 'package:flutter/material.dart';

class QuizBackGroundColor extends StatelessWidget {
  final Widget child;
  const QuizBackGroundColor({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade200, Colors.blue.shade200]),
        // color: Colors.deepPurple.shade100,
      ),
      child: child,
    );
  }
}

class QuizBackGroundColorForViewDetailPage extends StatelessWidget {
  final Widget child;
  const QuizBackGroundColorForViewDetailPage({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade100, Colors.blue.shade200]),
        // color: Colors.deepPurple.shade100,
      ),
      child: child,
    );
  }
}
