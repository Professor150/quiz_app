import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

class ViewDetailProvider extends ChangeNotifier {
  List<ExamModel> _exams;
  int _currentQuestionIndex;
  int _points;
  int _totalAnswered;
  int _correctAnswer;
  int _wrongAnswer;
  List<UserPreference> _userPreference;
  List<String> _correctAnsweredQuestions;
  List<String> _wrongQuestions;
  List<String> _userTappedOption;
  List<String> _options;
  List<String> _alloptions;
  Map<int, List> _questionOptions;

  ViewDetailProvider({
    required List<ExamModel> exams,
    required int currentQuestionIndex,
    required int points,
    required int totalAnswered,
    required int correctAnswer,
    required int wrongAnswer,
    required List<UserPreference> userPreference,
    required List<String> correctAnsweredQuestions,
    required List<String> wrongQuestions,
    required List<String> userTappedOption,
    required List<String> options,
    required List<String> alloptions,
    required Map<int, List> questionOptions,
  })  : _exams = exams,
        _currentQuestionIndex = currentQuestionIndex,
        _points = points,
        _totalAnswered = totalAnswered,
        _correctAnswer = correctAnswer,
        _wrongAnswer = wrongAnswer,
        _userPreference = userPreference,
        _correctAnsweredQuestions = correctAnsweredQuestions,
        _wrongQuestions = wrongQuestions,
        _userTappedOption = userTappedOption,
        _options = options,
        _alloptions = alloptions,
        _questionOptions = questionOptions;

  List<ExamModel> get exams => _exams;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get points => _points;
  int get totalAnswered => _totalAnswered;
  int get correctAnswer => _correctAnswer;
  int get wrongAnswer => _wrongAnswer;
  List<UserPreference> get userPreference => _userPreference;
  List<String> get correctAnsweredQuestions => _correctAnsweredQuestions;
  List<String> get wrongQuestions => _wrongQuestions;
  List<String> get userTappedOption => _userTappedOption;
  List<String> get options => _options;
  List<String> get alloptions => _alloptions;
  Map<int, List> get questionOptions => _questionOptions;

  void setExams(List<ExamModel> exams) {
    _exams = exams;
    notifyListeners();
  }

  void setCurrentQuestionIndex(int currentQuestionIndex) {
    _currentQuestionIndex = currentQuestionIndex;
    notifyListeners();
  }

  void setPoints(int points) {
    _points = points;
    notifyListeners();
  }

  void setTotalAnswered(int totalAnswered) {
    _totalAnswered = totalAnswered;
    notifyListeners();
  }

  void setCorrectAnswer(int correctAnswer) {
    _correctAnswer = correctAnswer;
    notifyListeners();
  }

  void setWrongAnswer(int wrongAnswer) {
    _wrongAnswer = wrongAnswer;
    notifyListeners();
  }

  void setUserPreference(List<UserPreference> userPreference) {
    _userPreference = userPreference;
    notifyListeners();
  }

  void setCorrectAnsweredQuestions(List<String> correctAnsweredQuestions) {
    _correctAnsweredQuestions = correctAnsweredQuestions;
    notifyListeners();
  }

  void setWrongQuestions(List<String> wrongQuestions) {
    _wrongQuestions = wrongQuestions;
    notifyListeners();
  }

  void setUserTappedOption(List<String> userTappedOption) {
    _userTappedOption = userTappedOption;
    notifyListeners();
  }

  void setOptions(List<String> options) {
    _options = options;
    notifyListeners();
  }

  void setAllOptions(List<String> alloptions) {
    _alloptions = alloptions;
    notifyListeners();
  }

  void setQuestionOptions(Map<int, List> questionOptions) {
    _questionOptions = questionOptions;
    notifyListeners();
  }
}
