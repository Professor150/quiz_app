import 'package:flutter/material.dart';

class QuestionPoints extends StatelessWidget {
  final int points;
  final int currentQuestionIndex;
  final List data;
  final VoidCallback onTap;

  const QuestionPoints({
    super.key,
    required this.points,
    required this.currentQuestionIndex,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        '$points',
        style: const TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }
}
