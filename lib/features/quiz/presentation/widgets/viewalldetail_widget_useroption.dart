import 'package:flutter/material.dart';

class UserOptionWidget extends StatelessWidget {
  const UserOptionWidget({
    Key? key,
    required this.mediaQuery,
    required this.userPressedOption,
    required this.correctAnswer,
  }) : super(key: key);

  final Size mediaQuery;
  final String userPressedOption;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: mediaQuery.height * 0.055,
      width: mediaQuery.width - 50,
      decoration: BoxDecoration(
        color: userPressedOption == correctAnswer ? Colors.green : Colors.red.shade400,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Your Chosen Option is:    $userPressedOption',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}