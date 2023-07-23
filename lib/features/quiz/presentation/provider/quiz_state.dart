import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

import '../../../../core/utils/constants/colors_constants.dart';

class QuizState extends ChangeNotifier {
  ValueNotifier<int> timerValue = ValueNotifier(30);
  int currentQuestionIndex = 0;
  Timer? timer;
  int points = 0;
  bool isLoaded = false;
  String currentQuestion = "";
  List<String> options = [];
  bool isFirstQuestion = true;
  bool isLoading = true;
  bool isOptionSelected = false;
  bool isAnswerCorrect = false;
  bool showAnswerStatus = false;
  int totalAnswered = 0;
  int userCorrectAnswer = 0;
  int wrongAnswer = 0;
  Map<int, List> questionOptions = {};
  List<String> correctAnsweredQuestions = [];
  List<String> wrongAnsweredQuestions = [];
  List<String> userTappedOption = [];
  List<ExamModel>? exams;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value = timerValue.value - 1;
      } else {
        gotoNextQuestion();
      }
    });
  }

  void gotoNextQuestion() {
    if (currentQuestionIndex < exams!.length - 1) {
      isLoaded = false;
      currentQuestionIndex++;
      resetColors();
      timer!.cancel();
      timerValue.value = 30;
      startTimer();
    } else {
      timer?.cancel();
    }
    notifyListeners();
  }

  void addOptionToMap(int i, opt, int length) {
    questionOptions[i] = List.from(opt);
  }

  void resetState() {
    // Reset all state variables to their initial values
    timerValue.value = 30;
    currentQuestionIndex = 0;
    timer?.cancel();
    points = 0;
    isLoaded = false;
    currentQuestion = "";
    options.clear();
    isFirstQuestion = true;
    isLoading = true;
    isOptionSelected = false;
    isAnswerCorrect = false;
    showAnswerStatus = false;
    totalAnswered = 0;
    userCorrectAnswer = 0;
    wrongAnswer = 0;
    questionOptions.clear();
    correctAnsweredQuestions.clear();
    wrongAnsweredQuestions.clear();
    userTappedOption.clear();
  }
}
