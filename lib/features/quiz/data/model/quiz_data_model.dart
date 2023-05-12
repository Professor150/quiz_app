import 'package:equatable/equatable.dart';

class ExamModel extends Equatable {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
  String? userAnswer;
  String? selectedAnswer;

  ExamModel({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    this.userAnswer,
    this.selectedAnswer,
  });

  List<String> get options => [correctAnswer, ...incorrectAnswers];
  List<String> get selectedAnswers => [correctAnswer];

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      category: json['category'] ?? "",
      type: json['type'] ?? "",
      difficulty: json['difficulty'] ?? "",
      question: json['question'] ?? "",
      correctAnswer: json['correct_answer'] ?? "",
      incorrectAnswers: List.from(json['incorrect_answers'])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['type'] = type;
    data['difficulty'] = difficulty;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = incorrectAnswers;
    return data;
  }

  @override
  List<Object?> get props => [
        category,
        type,
        difficulty,
        question,
        correctAnswer,
        ...incorrectAnswers
      ];
}
