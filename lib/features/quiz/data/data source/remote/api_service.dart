import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

var baseUrl = "https://opentdb.com";

enum ApiResponseStatus { isLoading, hasData, hasError }

class FetchAllQuizProvider extends ChangeNotifier {
  List<ExamModel> _exams = [];
  ApiResponseStatus? apiResponseStatus;
  String? _errorMessage;
  int wrongAnswered = 0;
  List<ExamModel> get exams => _exams;
  int currentQuestionIndex = 0;
  String? get errorMessage => _errorMessage;

  Future<void> getQuiz() async {
    try {
      apiResponseStatus = ApiResponseStatus.isLoading;

      notifyListeners();
      http.Response res =
          await http.get(Uri.parse('$baseUrl/api.php?amount=3'));
      if (res.statusCode == 200) {
        print('data is load');
        final result = List.from(json.decode(res.body)["results"]);
        _exams = result.map((e) => ExamModel.fromJson(e)).toList();
        apiResponseStatus = ApiResponseStatus.hasData;
        notifyListeners();
      } else {
        _errorMessage = "Unable to fetch quiz";
        apiResponseStatus = ApiResponseStatus.hasError;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Unable to fetch quiz";
      apiResponseStatus = ApiResponseStatus.hasError;
    }
    notifyListeners();
  }
}
