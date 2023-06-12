import 'package:flutter/material.dart';

class QuizpagePointShowCorectIncorect extends StatelessWidget {
  const QuizpagePointShowCorectIncorect({
    super.key,
    required this.mediaQuery,
    required this.points,
    required this.showAnswerStatus,
    required this.isAnswerCorrect,
  });

  final Size mediaQuery;
  final int points;
  final bool showAnswerStatus;
  final bool isAnswerCorrect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          height: mediaQuery.height * 0.1,
          width: mediaQuery.width * 0.1,
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$points',
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (showAnswerStatus)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showAnswerStatus ? 1.0 : 0.0,
            child: Text(
              isAnswerCorrect ? 'Correct!' : 'Incorrect!',
              style: TextStyle(
                fontSize: 18,
                color: isAnswerCorrect ? Colors.lightGreen : Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
