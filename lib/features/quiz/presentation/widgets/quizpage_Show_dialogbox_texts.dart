import 'package:flutter/material.dart';

class QuizpageShowDialogBoxTexts extends StatelessWidget {
  const QuizpageShowDialogBoxTexts({
    super.key,
    required this.points,
  });

  final int points;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const Text('All questions have been answered.'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text('Total Points: $points',
            style: points >= 0
                ? const TextStyle(fontSize: 20, color: Colors.lightGreen)
                : const TextStyle(fontSize: 20, color: Colors.red)),
      ],
    );
  }
}
