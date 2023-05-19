import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/constants/text_style.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

class QuizPageQuestions extends StatelessWidget {
  const QuizPageQuestions({
    super.key,
    required this.mediaQuery,
    required this.currentQuestionIndex,
    required this.exams,
  });

  final Size mediaQuery;
  final int currentQuestionIndex;
  final List<ExamModel> exams;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: mediaQuery.height * 0.14,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.blue,
            offset: Offset(-1, 2),
          ),
        ],
        color: const Color.fromRGBO(211, 238, 240, 0.898),
        borderRadius: BorderRadius.circular(12),
      ),
      child: normalText(
        color: Colors.black,
        size: 20,
        text: exams[currentQuestionIndex].question,
      ),
    );
  }
}
