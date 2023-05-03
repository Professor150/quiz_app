import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/constants/text_style.dart';

class QuestionPoints extends StatelessWidget {
  final int points;
  final int currentQuestionIndex;
  final List data;
  const QuestionPoints( {super.key,required this.points,required this.currentQuestionIndex,required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        normalText(
            color: Colors.white,
            size: 18,
            text: "Question ${currentQuestionIndex + 1} of ${data.length}"),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$points',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
