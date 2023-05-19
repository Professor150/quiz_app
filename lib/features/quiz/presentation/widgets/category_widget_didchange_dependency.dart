import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';

class QuizDataFetcher {
  final BuildContext context;

  QuizDataFetcher(this.context);

  Future<void> fetchQuizData() async {
    final quizProvider =
        Provider.of<FetchAllQuizProvider>(context, listen: false);

    if (quizProvider.exams.isEmpty) {
      try {
        await quizProvider.getQuiz();
      } catch (error) {}
    }
  }
}
